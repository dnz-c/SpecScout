#include "TaintSources.h"

#include <capstone/capstone.h>

#include <algorithm>
#include <cctype>
#include <map>
#include <set>

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
                s.model = SourceModel::InputApi;
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

std::vector<TaintSourceSite> TaintSources::driver_sites(
    const std::vector<va_t>& entries) const {
    std::vector<TaintSourceSite> v;
    for (va_t e : entries) {
        TaintSourceSite s;
        s.model = SourceModel::DriverIrp;
        s.func_va = s.call_va = s.return_va = e;
        s.spec.api = "IRP";
        s.spec.buf_arg = -1;
        s.spec.len_bytes = 64;
        v.push_back(s);
    }
    return v;
}

std::vector<TaintSourceSite> TaintSources::param_sites(
    const std::vector<va_t>& entries) const {
    std::vector<TaintSourceSite> v;
    for (va_t e : entries) {
        TaintSourceSite s;
        s.model = SourceModel::Params;
        s.func_va = s.call_va = s.return_va = e;
        s.spec.api = "param";
        s.spec.buf_arg = -1;
        s.spec.len_bytes = 0;
        v.push_back(s);
    }
    return v;
}

std::vector<va_t> TaintSources::find_ioctl_dispatch(const LoadedImage& img,
                                                    Cfg& /*cfg*/) const {
    // Linearly decode DriverEntry looking for `lea reg,[rip+X]` followed by a
    // store into DriverObject->MajorFunction[] (x64 offset 0x70 + k*8). The
    // lea'd target is the installed dispatch routine.
    std::vector<va_t> out;
    csh h;
    if (cs_open(CS_ARCH_X86, CS_MODE_64, &h) != CS_ERR_OK) return out;
    cs_option(h, CS_OPT_DETAIL, CS_OPT_ON);
    cs_insn* ci = cs_malloc(h);

    std::map<unsigned, va_t> lea_targets;  // reg id -> rip-relative target VA
    std::set<va_t> seen;

    size_t avail = 0;
    const uint8_t* code = img.bytes_at(img.entry_point_va, avail);
    uint64_t cur = img.entry_point_va;
    int budget = 1500;
    while (code && avail > 0 && budget-- > 0) {
        if (!cs_disasm_iter(h, &code, &avail, &cur, ci)) break;
        const cs_x86& x = ci->detail->x86;
        if (ci->id == X86_INS_LEA && x.op_count == 2 &&
            x.operands[0].type == X86_OP_REG && x.operands[1].type == X86_OP_MEM &&
            x.operands[1].mem.base == X86_REG_RIP) {
            va_t tgt = static_cast<va_t>(ci->address + ci->size +
                                         x.operands[1].mem.disp);
            lea_targets[x.operands[0].reg] = tgt;
        } else if (ci->id == X86_INS_MOV && x.op_count == 2 &&
                   x.operands[0].type == X86_OP_MEM &&
                   x.operands[1].type == X86_OP_REG) {
            int64_t disp = x.operands[0].mem.disp;
            if (disp >= 0x70 && disp < 0x160) {  // MajorFunction[0..27]
                auto it = lea_targets.find(x.operands[1].reg);
                if (it != lea_targets.end() && img.is_executable(it->second) &&
                    seen.insert(it->second).second) {
                    out.push_back(it->second);
                }
            }
        } else if (cs_insn_group(h, ci, X86_GRP_RET)) {
            break;
        }
    }
    cs_free(ci, 1);
    cs_close(&h);
    return out;
}

} // namespace specscout
