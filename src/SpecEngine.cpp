#include "SpecEngine.h"

#include "QspectreClassifier.h"
#include "Sinks.h"

#include <triton/archEnums.hpp>
#include <triton/callbacks.hpp>
#include <triton/callbacksEnums.hpp>
#include <triton/context.hpp>
#include <triton/instruction.hpp>
#include <triton/memoryAccess.hpp>
#include <triton/modesEnums.hpp>
#include <triton/register.hpp>
#include <triton/symbolicVariable.hpp>

#include <algorithm>
#include <cstdlib>
#include <deque>
#include <functional>
#include <set>
#include <string>
#include <tuple>
#include <unordered_map>
#include <unordered_set>

namespace specscout {

namespace {

bool dbg() {
    static bool v = (std::getenv("SPECSCOUT_DEBUG") != nullptr);
    return v;
}

// DriverIrp sandbox layout (shared by seed_driver_irp and the call-site
// capture below): pointer arguments landing in these ranges carry taint even
// though the pointer value itself is attacker-independent.
constexpr uint64_t SB_SYSBUF  = 0x0000200000200000ull;  // Irp->AssociatedIrp.SystemBuffer
constexpr uint64_t SB_TYPE3   = 0x0000200000400000ull;  // Parameters.DeviceIoControl.Type3InputBuffer
constexpr uint64_t SB_IRP     = 0x0000200000000000ull;  // sandbox _IRP itself
constexpr uint64_t SB_STACKL  = 0x0000200000300000ull;  // Irp->Tail.Overlay.CurrentStackLocation
constexpr uint64_t SB_RANGE   = 64;
// IoControlCode sits at CurrentStackLocation + 0x18 on x64.
constexpr uint64_t IOCTL_SLOT = SB_STACKL + 0x18;

// A captured callee entry: the callee VA, the argument registers that carried
// taint (or pointed into a tainted sandbox region) at the call, and their
// concrete values so the re-entry session preserves data flow.
struct CalleeEntry {
    va_t     func_va = 0;
    unsigned mask = 0;
    uint64_t vals[4] = {0, 0, 0, 0};
};

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

    // Sandbox model that a CalleeEntry site inherits from its root site.
    SourceModel base_model() const {
        return site.model == SourceModel::CalleeEntry ? site.base : site.model;
    }

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

        // Lazy memory: serve image bytes on demand via a callback rather than
        // mapping whole sections up front. This is what makes scanning a 12 MB
        // image like ntoskrnl.exe tractable (map-on-read, O(bytes touched)).
        ctx.addCallback(
            triton::callbacks::GET_CONCRETE_MEMORY_VALUE,
            triton::callbacks::getConcreteMemoryValueCallback(
                [this](triton::Context& c, const triton::arch::MemoryAccess& ma) {
                    fill_mem(c, ma);
                },
                this));

        wr("rsp", cfg.stack_top);
        wr("rbp", cfg.stack_top);
    }

    // GET_CONCRETE_MEMORY_VALUE callback: back the accessed range with the real
    // image bytes if it falls in a mapped section. Sandbox addresses (stack,
    // IRP) are not in the image, so their symbolic/tainted state is preserved.
    void fill_mem(triton::Context& c, const triton::arch::MemoryAccess& ma) {
        uint64_t a = ma.getAddress();
        uint32_t sz = ma.getSize();
        if (sz == 0 || sz > 4096) return;
        size_t avail = 0;
        const uint8_t* p = img.bytes_at(a, avail);
        if (!p || avail == 0) return;
        size_t n = sz < avail ? sz : avail;
        std::vector<triton::uint8> v(p, p + n);
        c.setConcreteMemoryAreaValue(a, v, false);  // execCallbacks=false: no recursion
    }

    // Params model: the integer parameter registers are attacker-controlled.
    void seed_params() {
        static const char* regs[4] = {"rcx", "rdx", "r8", "r9"};
        for (const char* r : regs) {
            wr(r, 0x41414141);  // out-of-bounds concrete FIRST (symbolize must come
                                // last; setConcreteRegisterValue clears the symbol)
            auto sv = ctx.symbolizeRegister(ctx.getRegister(r));
            if (sv) input_vars.insert(sv->getId());
            ctx.taintRegister(ctx.getRegister(r));
        }
    }

    // CalleeEntry model: re-enter a callee with the argument registers that
    // carried taint at the parent call site. Each tainted arg keeps its
    // captured concrete value (so pointer args still land in the sandbox IRP
    // buffers) and is symbolized + tainted; for pointer args whose target is
    // NOT image-backed (sandbox stack / IRP / heap), `source_taint_bytes` of
    // the pointee are also tainted (mirrors apply_source), covering
    // `copy-from-SystemBuffer` helpers.
    void seed_callee(unsigned mask, const uint64_t vals[4]) {
        static const char* regs[4] = {"rcx", "rdx", "r8", "r9"};
        for (int i = 0; i < 4; ++i) {
            if (!(mask & (1u << i))) continue;
            const char* r = regs[i];
            wr(r, vals[i]);
            auto sv = ctx.symbolizeRegister(ctx.getRegister(r));
            if (sv) input_vars.insert(sv->getId());
            ctx.taintRegister(ctx.getRegister(r));
            uint64_t ptr = vals[i];
            if (!ptr) continue;
            size_t avail = 0;
            bool image_backed = img.bytes_at(ptr, avail) != nullptr;
            if (image_backed) continue;  // do not taint .text/.data
            for (int k = 0; k < cfg.source_taint_bytes; ++k) {
                ctx.setConcreteMemoryValue(ptr + k, 0xFF);
                triton::arch::MemoryAccess m(ptr + k, 1);
                auto msv = ctx.symbolizeMemory(m);
                if (msv) input_vars.insert(msv->getId());
                ctx.taintMemory(m);
            }
        }
    }

    // DriverIrp model: build a sandbox _IRP (2nd parameter) with attacker-
    // controlled SystemBuffer / Type3InputBuffer and input length. x64 offsets.
    void seed_driver_irp() {
        const uint64_t DEVOBJ = 0x0000200000100000ull;
        auto wptr = [&](uint64_t at, uint64_t val) {
            ctx.setConcreteMemoryValue(triton::arch::MemoryAccess(at, 8),
                                       triton::uint512(val));
        };
        wr("rcx", DEVOBJ);
        wr("rdx", SB_IRP);
        wptr(SB_IRP + 0x18, SB_SYSBUF);    // Irp->AssociatedIrp.SystemBuffer
        wptr(SB_IRP + 0x70, SB_TYPE3);     // Irp->UserBuffer
        wptr(SB_IRP + 0xB8, SB_STACKL);    // Irp->Tail.Overlay.CurrentStackLocation
        wptr(SB_STACKL + 0x20, SB_TYPE3);  // Parameters.DeviceIoControl.Type3InputBuffer
        wptr(SB_STACKL + 0x18, site.ioctl_code);  // IoControlCode (attacker-chosen)
        {   // Mark pointers INTO the sandbox tainted: dispatch code dereferences
            // them, and loads *through* a tainted pointer carry taint. This is
            // what propagates the taint past `[rdx+0xB8] -> [rbp+0x18]`.
            for (uint64_t slot : {SB_IRP + 0x18, SB_IRP + 0x70, SB_IRP + 0xB8,
                                  SB_STACKL + 0x20, SB_STACKL + 0x18}) {
                triton::arch::MemoryAccess pm(slot, 8);
                auto psv = ctx.symbolizeMemory(pm);
                if (psv) input_vars.insert(psv->getId());
                ctx.taintMemory(pm);
            }
        }
        {   // Parameters.DeviceIoControl.InputBufferLength (attacker-controlled)
            triton::arch::MemoryAccess lenm(SB_STACKL + 0x10, 4);
            ctx.setConcreteMemoryValue(lenm, triton::uint512(0x41414141));
            auto sv = ctx.symbolizeMemory(lenm);
            if (sv) input_vars.insert(sv->getId());
            ctx.taintMemory(lenm);
        }
        for (int i = 0; i < cfg.source_taint_bytes; ++i) {
            for (uint64_t base : {SB_SYSBUF, SB_TYPE3}) {
                ctx.setConcreteMemoryValue(base + i, 0xFF);
                triton::arch::MemoryAccess m(base + i, 1);
                auto sv = ctx.symbolizeMemory(m);
                if (sv) input_vars.insert(sv->getId());
                ctx.taintMemory(m);
            }
        }
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
            // speculate - the bounds-check-bypass direction.
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
    // to the pc we stopped processing at. If `callees`, record callees entered
    // with attacker-tainted argument registers (interproc taint following).
    void run_concrete(va_t start_pc, std::vector<Guard>* collect, va_t stop_at,
                      va_t& reached, std::vector<TaintSourceSite>* callees = nullptr) {
        reached = 0;
        SourceModel base = base_model();
        if (base == SourceModel::Params) seed_params();
        else if (base == SourceModel::DriverIrp) seed_driver_irp();
        if (site.model == SourceModel::CalleeEntry)
            seed_callee(site.arg_taint_mask, site.arg_vals);
        if (dbg() && std::getenv("SPECSCOUT_TRACE3")) {
            uint64_t st = rd("rdx");
            std::fprintf(stderr, "    [seed] rdx=0x%llx  [rdx+0xb8]=0x%llx\n",
                         (unsigned long long)st,
                         (unsigned long long)ctx.getConcreteMemoryValue(
                             triton::arch::MemoryAccess(st + 0xb8, 8)));
        }
        va_t pc = start_pc;
        std::unordered_map<va_t, int> visits;
        for (int steps = 0; steps < cfg.max_normal_steps; ++steps) {
            if (!img.is_executable(pc)) break;
            // Cap re-executions of one address. A tight loop (or a faulting /
            // self-parking instruction) otherwise re-symbolizes the same
            // registers every step, nesting one AST node per iteration until the
            // recursive node destructor overflows the stack. Guards are deduped
            // by address, so a handful of visits loses no discovery coverage.
            if (++visits[pc] > cfg.max_visits_per_pc) break;
            Insn insn;
            if (!dis.decode_at(img, pc, insn)) break;
            size_t avail = 0;
            const uint8_t* code = img.bytes_at(pc, avail);
            if (!code) break;

            uint64_t rsp0 = insn.is_call ? rd("rsp") : 0;

            triton::arch::Instruction tinst(pc, code, insn.size);
            auto fault = ctx.processing(tinst);
            if (dbg() && std::getenv("SPECSCOUT_TRACE2"))
                std::fprintf(stderr, "    [walk] 0x%llx fault=%d tainted=%d loads=%zu  %s\n",
                             (unsigned long long)pc, (int)fault, (int)tinst.isTainted(),
                             tinst.getLoadAccess().size(), tinst.getDisassembly().c_str());

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
                if (site.model == SourceModel::InputApi && pc == site.call_va)
                    apply_source();
                // Interproc taint following: a direct call into the image while
                // an argument register carries taint (or points into a tainted
                // sandbox buffer) re-enters that callee with the tainted args
                // recorded (import thunks excluded).
                if (callees && insn.direct_target &&
                    img.is_executable(insn.direct_target) &&
                    dis.resolve_thunk(img, insn.direct_target).empty()) {
                    static const char* arg_regs[4] = {"rcx", "rdx", "r8", "r9"};
                    unsigned mask = 0;
                    uint64_t vals[4] = {0, 0, 0, 0};
                    for (int i = 0; i < 4; ++i) {
                        uint64_t v = rd(arg_regs[i]);
                        bool tainted = ctx.isRegisterTainted(ctx.getRegister(arg_regs[i]));
                        bool into_sandbox =
                            (v >= SB_SYSBUF && v < SB_SYSBUF + SB_RANGE) ||
                            (v >= SB_TYPE3 && v < SB_TYPE3 + SB_RANGE);
                        if (tainted || into_sandbox) {
                            mask |= 1u << i;
                            vals[i] = v;
                        }
                    }
                    if (mask) {
                        TaintSourceSite cs;
                        cs.model = SourceModel::CalleeEntry;
                        cs.call_va = pc;
                        cs.return_va = insn.fallthrough;
                        cs.func_va = insn.direct_target;
                        cs.spec = site.spec;           // report label + taint bytes
                        cs.spec.api = site.spec.api;   // propagate origin label
                        cs.base = base;                // sandbox from the root walk
                        cs.arg_taint_mask = mask;
                        cs.arg_vals[0] = vals[0];
                        cs.arg_vals[1] = vals[1];
                        cs.arg_vals[2] = vals[2];
                        cs.arg_vals[3] = vals[3];
                        cs.ioctl_code = site.ioctl_code;  // keep the sandbox coherent
                        cs.depth = site.depth + 1;
                        callees->push_back(std::move(cs));
                    }
                }
                wr("rsp", rsp0);                 // undo the pushed return address
                next = insn.fallthrough;         // model: callee returns immediately
            } else {
                next = static_cast<va_t>(rd("rip"));
                // A faulting instruction does not advance rip in Triton's
                // semantics (e.g. `div` by an unmapped/zero divisor under our
                // synthetic seeds sets FAULT_DE and returns before controlFlow).
                // A rep-prefixed string op likewise parks rip until its (here
                // attacker-garbage) counter drains. Either way, trusting rip
                // reprocesses the same instruction up to max_normal_steps times,
                // nesting one AST node per step until the recursive teardown
                // overflows the stack. Step over any instruction that made no
                // forward progress.
                if (fault != triton::arch::NO_FAULT || next == pc)
                    next = insn.fallthrough;
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
                // Sink only when a prior load's result is used as a SCALED index
                // (the cache-transmitter shape), not plain pointer chasing.
                bool sink = sinks::ast_references_var_scaled(lea, load_vars);
                if (dbg() && (refs_input || refs_load))
                    std::fprintf(stderr, "    [spec] 0x%llx in=%d load=%d scaled=%d  %s\n",
                                 (unsigned long long)pc, (int)refs_input, (int)refs_load,
                                 (int)sink, tinst.getDisassembly().c_str());
                if (sink) {
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

void SpecEngine::analyze_site(const TaintSourceSite& site, std::vector<Finding>& out,
                              std::vector<TaintSourceSite>* discovered) {
    if (dbg())
        std::fprintf(stderr, "[site] api=%s call=0x%llx func=0x%llx buf_arg=%d depth=%d\n",
                     site.spec.api.c_str(), (unsigned long long)site.call_va,
                     (unsigned long long)site.func_va, site.spec.buf_arg, site.depth);

    // DriverIrp probe: a dispatch routine gates every interesting arm on the
    // IoControlCode compare chain. Walk each candidate control code separately;
    // with no constants found, walk the (0-valued) default arm as before.
    if (site.model == SourceModel::DriverIrp && !site.ioctl_expanded && discovered) {
        std::set<uint64_t> codes;
        collect_ioctl_codes(site.func_va, codes);
        if (dbg())
            std::fprintf(stderr, "[probe] codes found: %zu\n", codes.size());
        for (uint64_t code : codes) {
            TaintSourceSite s2 = site;
            s2.ioctl_code = code;
            s2.ioctl_expanded = true;
            discovered->push_back(std::move(s2));
        }
        if (!codes.empty()) return;
    }

    std::vector<Guard> guards;
    {
        Session s(img_, cfg_, cfg_dis_, site);
        va_t reached = 0;
        s.run_concrete(site.func_va, &guards, 0, reached, discovered);
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

// DriverIrp probe: statically collect plausible IoControlCode constants from
// the dispatch routine's `cmp reg, imm` / `test reg, imm` sequences. The
// dispatch's own switch reveals the valid control codes; seeding the sandbox
// with each one lets the concrete walk enter the real handling arms instead of
// the invalid-IOCTL default.
void SpecEngine::collect_ioctl_codes(va_t func, std::set<uint64_t>& out) {
    Function fn = cfg_dis_.build(img_, func, 0);
    if (dbg())
        std::fprintf(stderr, "[probe] 0x%llx -> %zu blocks\n",
                     (unsigned long long)func, fn.blocks.size());
    for (const auto& [bva, bb] : fn.blocks) {
        for (const Insn& in : bb.insns) {
            if (in.mnemonic != "cmp" && in.mnemonic != "test") continue;
            size_t c = in.text.find(',');
            if (c == std::string::npos) continue;
            std::string imm = in.text.substr(c + 1);
            size_t b = imm.find_first_not_of(" \t");
            if (b == std::string::npos) continue;
            imm = imm.substr(b);
            char* end = nullptr;
            uint64_t v = std::strtoull(imm.c_str(), &end, 0);
            if (end == imm.c_str()) continue;          // not an immediate
            if (v < 0x800 || v > 0xffffffffull) continue;  // majors / trivial
            out.insert(v);
        }
    }
}

std::vector<Finding> SpecEngine::scan(const std::vector<TaintSourceSite>& sites) {
    std::vector<Finding> out;

    // Interproc worklist: roots are the caller-provided sites; every concrete
    // walk records callees entered with tainted (or sandbox-pointing) argument
    // registers, which are re-analyzed as CalleeEntry sites up to
    // interproc_max_depth. Dedup keyed on (callee, arg mask).
    std::deque<TaintSourceSite> work(sites.begin(), sites.end());
    std::set<std::pair<va_t, unsigned>> processed;
    for (const TaintSourceSite& s : sites)
        processed.insert({s.func_va, 0});
    int budget = (int)sites.size() * cfg_.interproc_max_sites;

    while (!work.empty()) {
        TaintSourceSite site = std::move(work.front());
        work.pop_front();
        if (--budget < 0) break;

        std::vector<TaintSourceSite> callees;
        analyze_site(site, out, &callees);
        std::sort(callees.begin(), callees.end(), [](const TaintSourceSite& a,
                                                     const TaintSourceSite& b) {
            return std::make_pair(a.func_va, a.arg_taint_mask) <
                   std::make_pair(b.func_va, b.arg_taint_mask);
        });
        for (TaintSourceSite& c : callees) {
            auto key = std::make_pair(c.func_va, c.arg_taint_mask);
            if (!processed.insert(key).second) continue;
            if (c.depth > cfg_.interproc_max_depth) continue;
            work.push_back(std::move(c));
        }
    }

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
