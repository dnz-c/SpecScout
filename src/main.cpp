// SpecScout - static Spectre-v1 gadget scanner for x86-64 PE binaries.
//
// Usage:
//   specscout <target.exe> [options]
//     --dump            print recovered functions, imports, and CFG summary
//     --json <file>     write findings as JSON
//     --confirm         emit/run dynamic Flush+Reload confirmation (phase 2)
//
// This translation unit is intentionally thin: it wires the stages together
// and owns argument parsing and top-level reporting.
#include "Cfg.h"
#include "Loader.h"

#if SPECSCOUT_WITH_TRITON
#include "Report.h"
#include "SpecEngine.h"
#include "TaintSources.h"
#endif

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

using namespace specscout;

namespace {

void print_usage(const char* argv0) {
    std::printf(
        "SpecScout - static Spectre-v1 /Qspectre-residual gadget scanner\n"
        "usage: %s <target> [options]\n"
        "  taint model (pick one; default --api):\n"
        "    --api            attacker data from imported input APIs (user-mode)\n"
        "    --driver         attacker data from IRP buffers of IOCTL dispatch routines (.sys)\n"
        "    --params         attacker-controlled integer parameters (syscalls / exports)\n"
        "  entry selection (for --driver/--params):\n"
        "    --function <n>   restrict to one function: export name or 0xVA\n"
        "    --exports        use every exported function as an entry\n"
        "    --max-funcs <n>  cap functions scanned (default 1000)\n"
        "  output:\n"
        "    --dump           print functions, imports, exports, CFG summary\n"
        "    --json <file>    write findings as JSON\n"
        "    --confirm        note the dynamic Flush+Reload confirmer\n",
        argv0);
}

enum class Mode { Api, Driver, Params };

const char* term_name(TermKind t) {
    switch (t) {
        case TermKind::Fallthrough: return "fallthrough";
        case TermKind::CondBranch:  return "cond-branch";
        case TermKind::DirectJmp:   return "jmp";
        case TermKind::IndirectJmp: return "jmp*";
        case TermKind::Ret:         return "ret";
        default:                    return "?";
    }
}

int run_dump(const LoadedImage& img) {
    std::printf("image base : 0x%llx\n", (unsigned long long)img.image_base);
    std::printf("entry      : 0x%llx\n", (unsigned long long)img.entry_point_va);
    std::printf("sections   : %zu\n", img.sections.size());
    for (const Section& s : img.sections)
        std::printf("  %-10s va=0x%llx size=0x%llx %s%s\n", s.name.c_str(),
                    (unsigned long long)s.va, (unsigned long long)s.vsize,
                    s.executable ? "X" : "-", s.writable ? "W" : "-");
    std::printf("imports    : %zu\n", img.imports.size());
    std::printf("exports    : %zu\n", img.exports.size());
    std::printf("functions  : %zu (from .pdata + entry + exports)\n", img.functions.size());

    Cfg cfg;
    if (!cfg.ok()) {
        std::fprintf(stderr, "error: Capstone failed to initialize\n");
        return 2;
    }

    size_t total_blocks = 0, cond_branches = 0, indirect_calls = 0, fences = 0;
    for (const FunctionRange& fr : img.functions) {
        Function fn = cfg.build(img, fr.start_va, fr.end_va);
        total_blocks += fn.blocks.size();
        for (const auto& [va, bb] : fn.blocks) {
            if (bb.term == TermKind::CondBranch) ++cond_branches;
            for (const Insn& in : bb.insns) {
                if (in.is_call && in.is_indirect) ++indirect_calls;
                if (in.is_serializing) ++fences;
            }
        }
    }
    std::printf("\nCFG summary across functions:\n");
    std::printf("  basic blocks    : %zu\n", total_blocks);
    std::printf("  cond branches   : %zu  (candidate guards)\n", cond_branches);
    std::printf("  indirect calls  : %zu  (candidate S2 sinks)\n", indirect_calls);
    std::printf("  serializing ops : %zu  (lfence/mfence/cpuid)\n", fences);
    return 0;
}

}  // namespace

int main(int argc, char** argv) {
    if (argc < 2) {
        print_usage(argv[0]);
        return 1;
    }

    std::string target;
    bool dump = false, confirm = false, use_exports = false;
    std::string json_out, func_target;
    Mode mode = Mode::Api;
    int max_funcs = 1000;

    for (int i = 1; i < argc; ++i) {
        const char* a = argv[i];
        if (std::strcmp(a, "--dump") == 0) dump = true;
        else if (std::strcmp(a, "--confirm") == 0) confirm = true;
        else if (std::strcmp(a, "--api") == 0) mode = Mode::Api;
        else if (std::strcmp(a, "--driver") == 0) mode = Mode::Driver;
        else if (std::strcmp(a, "--params") == 0) mode = Mode::Params;
        else if (std::strcmp(a, "--exports") == 0) use_exports = true;
        else if (std::strcmp(a, "--function") == 0 && i + 1 < argc) func_target = argv[++i];
        else if (std::strcmp(a, "--max-funcs") == 0 && i + 1 < argc) max_funcs = std::atoi(argv[++i]);
        else if (std::strcmp(a, "--json") == 0 && i + 1 < argc) json_out = argv[++i];
        else if (a[0] == '-') { std::fprintf(stderr, "unknown option: %s\n", a); return 1; }
        else target = a;
    }
    (void)confirm;
    (void)json_out;

    if (target.empty()) {
        print_usage(argv[0]);
        return 1;
    }

    std::string err;
    auto img = Loader::load(target, err);
    if (!img) {
        std::fprintf(stderr, "error: %s\n", err.c_str());
        return 2;
    }

    if (dump) return run_dump(*img);

#if SPECSCOUT_WITH_TRITON
    TaintSources sources;
    Cfg cfg;
    if (!cfg.ok()) {
        std::fprintf(stderr, "error: Capstone failed to initialize\n");
        return 2;
    }
    std::vector<TaintSourceSite> sites;
    if (mode == Mode::Api) {
        sites = sources.find_sites(*img, cfg, img->functions);
        std::printf("taint model: input APIs - %zu source site(s)\n", sites.size());
    } else {
        std::vector<va_t> entries;
        if (!func_target.empty()) {
            va_t v = (func_target.rfind("0x", 0) == 0 || func_target.rfind("0X", 0) == 0)
                         ? (va_t)std::strtoull(func_target.c_str(), nullptr, 16)
                         : img->export_va(func_target);
            if (!v) {
                std::fprintf(stderr, "error: could not resolve --function %s\n",
                             func_target.c_str());
                return 2;
            }
            entries.push_back(v);
        } else if (use_exports) {
            for (auto& [n, va] : img->exports) { (void)n; entries.push_back(va); }
        } else if (mode == Mode::Driver) {
            entries = sources.find_ioctl_dispatch(*img, cfg);
            std::printf("discovered %zu IOCTL dispatch routine(s) from DriverEntry\n",
                        entries.size());
        } else {  // Params, no target: every function (capped)
            for (auto& fr : img->functions) entries.push_back(fr.start_va);
        }
        if ((int)entries.size() > max_funcs) entries.resize(max_funcs);
        sites = (mode == Mode::Driver) ? sources.driver_sites(entries)
                                       : sources.param_sites(entries);
        std::printf("taint model: %s - %zu entry function(s)\n",
                    mode == Mode::Driver ? "driver IRP" : "parameters", sites.size());
    }

    SpecEngine engine(*img);
    auto findings = engine.scan(sites);
    Report::write_text(stdout, target, findings);
    if (!json_out.empty()) {
        if (Report::write_json(json_out, target, findings))
            std::printf("wrote JSON report -> %s\n", json_out.c_str());
        else
            std::fprintf(stderr, "error: could not write JSON to %s\n", json_out.c_str());
    }
    if (confirm)
        std::printf("note: write a JSON report (--json) and pass it to specscout_confirm "
                    "to dynamically confirm S1 findings via Flush+Reload.\n");
    return 0;
#else
    std::printf("loaded %s: %zu functions, %zu imports. "
                "(built without Triton; configure with -DSPECSCOUT_WITH_TRITON=ON "
                "to enable scanning; --dump works now)\n",
                target.c_str(), img->functions.size(), img->imports.size());
    return 0;
#endif
}
