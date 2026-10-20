#include "TaintSources.h"

#include <algorithm>
#include <cctype>

namespace specscout {

TaintSources::TaintSources() {
    // api, buf_arg (0-based), len_bytes
    table_ = {
        {"recv",                   1, 64},
        {"recvfrom",               1, 64},
        {"ReadFile",               1, 64},
        {"ReadFileEx",             1, 64},
        {"InternetReadFile",       1, 64},
        {"fread",                  0, 64},
        {"fgets",                  0, 64},
        {"gets",                   0, 64},
        {"gets_s",                 0, 64},
        {"read",                   1, 64},
        {"_read",                  1, 64},
        {"GetEnvironmentVariableA", 1, 64},
        {"GetEnvironmentVariableW", 1, 64},
    };
}

const char* TaintSources::arg_reg(int idx) {
    switch (idx) {
        case 0: return "rcx";
        case 1: return "rdx";
        case 2: return "r8";
        case 3: return "r9";
        default: return "";
    }
}

// Normalize an import symbol: lowercase, strip a leading "__imp_" / underscores
// and any trailing "@N" stdcall decoration.
static std::string normalize(std::string s) {
    const std::string imp = "__imp_";
    if (s.rfind(imp, 0) == 0) s = s.substr(imp.size());
    size_t b = 0;
    while (b < s.size() && s[b] == '_') ++b;   // leading underscores
    s = s.substr(b);
    size_t at = s.find('@');
    if (at != std::string::npos) s = s.substr(0, at);
    std::transform(s.begin(), s.end(), s.begin(),
                   [](unsigned char c) { return (char)std::tolower(c); });
    return s;
}

const SourceSpec* TaintSources::match(const std::string& import_name) const {
    const std::string n = normalize(import_name);
    for (const SourceSpec& s : table_) {
        if (normalize(s.api) == n) return &s;
    }
    return nullptr;
}

std::vector<TaintSourceSite> TaintSources::find_sites(
    const LoadedImage& img, Cfg& cfg, const std::vector<FunctionRange>& funcs) const {
    std::vector<TaintSourceSite> sites;

    for (const FunctionRange& fr : funcs) {
        Function fn = cfg.build(img, fr.start_va, fr.end_va);
        for (const auto& [bva, bb] : fn.blocks) {
            for (const Insn& in : bb.insns) {
                if (!in.is_call) continue;

                std::string name;
                if (in.is_indirect && in.mem_target_slot) {
                    if (const std::string* nm = img.import_name_at(in.mem_target_slot))
                        name = *nm;
                } else if (!in.is_indirect && in.direct_target) {
                    name = cfg.resolve_thunk(img, in.direct_target);  // call -> jmp [iat]
                }
                if (name.empty()) continue;

                const SourceSpec* spec = match(name);
                if (!spec) continue;

                TaintSourceSite s;
                s.call_va = in.va;
                s.return_va = in.fallthrough;
                s.func_va = fr.start_va;
                s.spec = *spec;
                s.spec.api = name;  // report the actual symbol
                sites.push_back(std::move(s));
            }
        }
    }
    return sites;
}

} // namespace specscout
