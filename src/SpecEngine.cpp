#include "SpecEngine.h"

#include "QspectreClassifier.h"
#include "Sinks.h"

#include <triton/archEnums.hpp>
#include <triton/context.hpp>
#include <triton/instruction.hpp>
#include <triton/memoryAccess.hpp>
#include <triton/modesEnums.hpp>
#include <triton/register.hpp>
#include <triton/symbolicVariable.hpp>

#include <algorithm>
#include <cstdlib>
#include <set>
#include <string>
#include <tuple>
#include <unordered_set>

namespace specscout {

namespace {

bool dbg() {
    static bool v = (std::getenv("SPECSCOUT_DEBUG") != nullptr);
    return v;
}

struct Guard {
    va_t        guard_va = 0;
    va_t        mispredict_va = 0;
    std::string text;
};

// One analysis context for a single taint-source site. Owns a fresh Triton
// Context; cheap to rebuild per replay.
struct Session {
    const LoadedImage&     img;
    const EngineConfig&    cfg;
    Cfg&                   dis;
    const TaintSourceSite& site;
    triton::Context        ctx;

    std::unordered_set<triton::usize> input_vars;  // symbolic vars = attacker input
    std::unordered_set<triton::usize> load_vars;   // vars minted for load results

    Session(const LoadedImage& i, const EngineConfig& c, Cfg& d, const TaintSourceSite& s)
        : img(i), cfg(c), dis(d), site(s) {
        setup();
    }

    // Registers worth tracking as load results: data GPRs, not flags / ip /
    // stack-frame pointers.
    static bool trackable_reg(const triton::arch::Register& reg) {
        static const std::set<std::string> skip = {
            "rip", "eip",  "rsp", "esp", "sp", "rbp", "ebp", "bp",
            "zf",  "cf",   "of",  "sf",  "pf", "af",  "df",  "if", "tf"};
        if (skip.count(reg.getName())) return false;
        return reg.getSize() >= 2;
    }

    Finding make_finding(SinkKind kind, const Guard& g, va_t sink_pc,
                         const std::string& sink_text, int steps) {
        qspectre::RawHit h;
        h.kind = kind;
        h.func_va = site.func_va;
        h.guard_va = g.guard_va;
        h.sink_va = sink_pc;
        h.source_call_va = site.call_va;
        h.source_api = site.spec.api;
        h.guard_text = g.text;
        h.sink_text = sink_text;
        h.spec_distance = steps;
        h.guard_tainted = true;
        h.strong_sink = true;
        return qspectre::classify(h);
    }

    uint64_t rd(const char* name) {
        return static_cast<uint64_t>(ctx.getConcreteRegisterValue(ctx.getRegister(name)));
    }
    void wr(const char* name, uint64_t v) {
        ctx.setConcreteRegisterValue(ctx.getRegister(name), triton::uint512(v));
    }

    void setup() {
        ctx.setArchitecture(triton::arch::ARCH_X86_64);
        // NOTE: ONLY_ON_SYMBOLIZED is intentionally OFF. It skips full
        // semantics (and getLoadAccess recording) for loads it deems
        // non-symbolized, which hides the dependent-load sink.
        ctx.setMode(triton::modes::ALIGNED_MEMORY, true);
        ctx.setMode(triton::modes::TAINT_THROUGH_POINTERS, true);
        ctx.setMode(triton::modes::CONSTANT_FOLDING, true);

        for (const Section& s : img.sections) {
            if (s.bytes.empty()) continue;
            if (s.bytes.size() <= cfg.max_map_per_section) {
                ctx.setConcreteMemoryAreaValue(s.va, s.bytes);
            } else {
                std::vector<uint8_t> head(s.bytes.begin(),
                                          s.bytes.begin() + cfg.max_map_per_section);
                ctx.setConcreteMemoryAreaValue(s.va, head);
            }
        }
        wr("rsp", cfg.stack_top);
        wr("rbp", cfg.stack_top);
    }

    // Taint the API output buffer at a source call: the buffer pointer is in an
    // x64 argument register; mark `source_taint_bytes` of that region symbolic
    // and tainted.
    void apply_source() {
        const char* reg = TaintSources::arg_reg(site.spec.buf_arg);
        if (!reg || !reg[0]) return;
        uint64_t ptr = rd(reg);
        if (ptr == 0) return;
        int n = cfg.source_taint_bytes;
        for (int i = 0; i < n; ++i) {
            // Seed the concrete value out-of-bounds (0xFF) so bounds checks on
            // this data concretely FAIL: the concrete walk then skips the
            // guarded body, making that body the *mispredicted* path we must
            // speculate — the bounds-check-bypass direction.
            ctx.setConcreteMemoryValue(ptr + i, 0xFF);
            triton::arch::MemoryAccess m(ptr + i, 1);
            auto sv = ctx.symbolizeMemory(m);
            if (sv) input_vars.insert(sv->getId());
            ctx.taintMemory(m);
        }
    }

    // Concrete walk from `start_pc`. If `collect`, record attacker-tainted
    // conditional branches. If `stop_at`, stop right after processing the
    // instruction at that address (so the caller can diverge). `reached` is set
    // to the pc we stopped processing at.
    void run_concrete(va_t start_pc, std::vector<Guard>* collect, va_t stop_at,
                       va_t& reached) {
        reached = 0;
        va_t pc = start_pc;
        for (int steps = 0; steps < cfg.max_normal_steps; ++steps) {
            if (!img.is_executable(pc)) break;
            Insn insn;
            if (!dis.decode_at(img, pc, insn)) break;
            size_t avail = 0;
            const uint8_t* code = img.bytes_at(pc, avail);
            if (!code) break;

            uint64_t rsp0 = insn.is_call ? rd("rsp") : 0;

            triton::arch::Instruction tinst(pc, code, insn.size);
            ctx.processing(tinst);

            if (dbg() && collect && insn.is_cond_branch) {
                std::fprintf(stderr, "    [cond] 0x%llx tainted=%d  %s\n",
                             (unsigned long long)pc, (int)tinst.isTainted(),
                             tinst.getDisassembly().c_str());
            }
            if (collect && insn.is_cond_branch && tinst.isTainted()) {
                uint64_t cnext = rd("rip");
                va_t mispredict = (cnext == insn.direct_target) ? insn.fallthrough
                                                                : insn.direct_target;
                if (insn.direct_target && img.is_executable(mispredict)) {
                    Guard g;
                    g.guard_va = pc;
                    g.mispredict_va = mispredict;
                    g.text = tinst.getDisassembly();
                    collect->push_back(std::move(g));
                }
            }

            if (pc == stop_at) { reached = pc; return; }

            // compute next pc
            va_t next;
            if (insn.is_ret) {
                break;
            } else if (insn.is_call) {
                if (pc == site.call_va) apply_source();
                wr("rsp", rsp0);                 // undo the pushed return address
                next = insn.fallthrough;         // model: callee returns immediately
            } else {
                next = static_cast<va_t>(rd("rip"));
            }
            pc = next;
        }
    }

    // Execute the mispredicted path for a bounded window, reporting S1/S2 sinks
    // reached before any serializing instruction.
    void speculate(const Guard& g, std::vector<Finding>& out) {
        va_t pc = g.mispredict_va;
        if (dbg())
            std::fprintf(stderr, "  [spec-enter] rax_tainted=%d rcx_tainted=%d\n",
                         (int)ctx.isRegisterTainted(ctx.getRegister("rax")),
                         (int)ctx.isRegisterTainted(ctx.getRegister("rcx")));
        for (int steps = 0; steps < cfg.spec_window; ++steps) {
            if (!img.is_executable(pc)) break;
            Insn insn;
            if (!dis.decode_at(img, pc, insn)) break;
            size_t avail = 0;
            const uint8_t* code = img.bytes_at(pc, avail);
            if (!code) break;

            uint64_t rsp0 = insn.is_call ? rd("rsp") : 0;
            triton::arch::Instruction tinst(pc, code, insn.size);
            auto fault = ctx.processing(tinst);
            if (std::getenv("SPECSCOUT_TRACE"))
                std::fprintf(stderr, "    [t] 0x%llx fault=%d tainted=%d loads=%zu  %s\n",
                             (unsigned long long)pc, (int)fault, (int)tinst.isTainted(),
                             tinst.getLoadAccess().size(), tinst.getDisassembly().c_str());

            // S1: a load whose address derives from a prior attacker-addressed
            // load (a[b[i]]). The inner load b[i] references an *input* var; the
            // outer load references a *load* var we minted for the inner result.
            bool attacker_load = false;
            for (auto& acc : tinst.getLoadAccess()) {
                triton::ast::SharedAbstractNode lea = acc.first.getLeaAst();
                if (!lea) continue;
                bool refs_input = sinks::ast_references_var(lea, input_vars);
                bool refs_load = sinks::ast_references_var(lea, load_vars);
                if (refs_input || refs_load) attacker_load = true;
                if (dbg() && (refs_input || refs_load))
                    std::fprintf(stderr, "    [spec] 0x%llx in=%d load=%d  %s\n",
                                 (unsigned long long)pc, (int)refs_input, (int)refs_load,
                                 tinst.getDisassembly().c_str());
                if (refs_load) {
                    out.push_back(make_finding(SinkKind::DependentLoad, g, pc,
                                               tinst.getDisassembly(), steps));
                    break;
                }
            }

            // S2: indirect branch whose target is attacker-derived (b[i]())
            if (insn.is_indirect && (insn.is_call || insn.is_uncond_jmp) &&
                tinst.isTainted()) {
                out.push_back(make_finding(SinkKind::IndirectBranch, g, pc,
                                           tinst.getDisassembly(), steps));
            }

            // Mint a "load variable" for the result of any attacker-addressed
            // load so the dependent outer load is recognised a few instructions
            // later (after intervening shifts / adds propagate the variable).
            if (attacker_load) {
                for (auto& wreg : tinst.getWrittenRegisters()) {
                    if (!trackable_reg(wreg.first)) continue;
                    auto sv = ctx.symbolizeRegister(wreg.first);
                    if (sv) load_vars.insert(sv->getId());
                }
            }

            if (insn.is_serializing) break;   // /Qspectre would fence here
            if (insn.is_ret) break;

            // advance the speculative path (no nested misprediction)
            if (insn.is_call) {
                wr("rsp", rsp0);
                pc = insn.fallthrough;
            } else if (insn.is_uncond_jmp) {
                if (insn.direct_target) pc = insn.direct_target;
                else break;  // indirect jmp target unknown (already reported if tainted)
            } else {
                pc = insn.fallthrough;  // Jcc follows fall-through; others sequential
            }
        }
    }
};

}  // namespace

SpecEngine::SpecEngine(const LoadedImage& img, EngineConfig cfg)
    : img_(img), cfg_(cfg) {}

void SpecEngine::analyze_site(const TaintSourceSite& site, std::vector<Finding>& out) {
    if (dbg())
        std::fprintf(stderr, "[site] api=%s call=0x%llx func=0x%llx buf_arg=%d\n",
                     site.spec.api.c_str(), (unsigned long long)site.call_va,
                     (unsigned long long)site.func_va, site.spec.buf_arg);
    std::vector<Guard> guards;
    {
        Session s(img_, cfg_, cfg_dis_, site);
        va_t reached = 0;
        s.run_concrete(site.func_va, &guards, 0, reached);
    }
    // dedupe guards by address (loops revisit the same branch)
    std::sort(guards.begin(), guards.end(),
              [](const Guard& a, const Guard& b) { return a.guard_va < b.guard_va; });
    guards.erase(std::unique(guards.begin(), guards.end(),
                             [](const Guard& a, const Guard& b) {
                                 return a.guard_va == b.guard_va;
                             }),
                 guards.end());

    if (dbg())
        std::fprintf(stderr, "[site] tainted guards: %zu\n", guards.size());
    for (const Guard& g : guards) {
        Session s(img_, cfg_, cfg_dis_, site);
        va_t reached = 0;
        s.run_concrete(site.func_va, nullptr, g.guard_va, reached);
        if (dbg())
            std::fprintf(stderr, "  [guard] 0x%llx mispredict=0x%llx reached=%d\n",
                         (unsigned long long)g.guard_va,
                         (unsigned long long)g.mispredict_va,
                         (int)(reached == g.guard_va));
        if (reached == g.guard_va) s.speculate(g, out);
    }
}

std::vector<Finding> SpecEngine::scan(const std::vector<TaintSourceSite>& sites) {
    std::vector<Finding> out;
    for (const TaintSourceSite& site : sites)
        analyze_site(site, out);

    // dedupe identical (kind, guard, sink) hits
    std::set<std::tuple<int, va_t, va_t>> seen;
    std::vector<Finding> uniq;
    for (Finding& f : out) {
        auto key = std::make_tuple((int)f.kind, f.guard_va, f.sink_va);
        if (seen.insert(key).second) uniq.push_back(std::move(f));
    }
    std::sort(uniq.begin(), uniq.end());  // Finding::operator< => high confidence first
    return uniq;
}

} // namespace specscout
