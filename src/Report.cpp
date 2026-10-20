#include "Report.h"

#include <algorithm>
#include <cstdio>

namespace specscout {

const char* sink_kind_name(SinkKind k) {
    switch (k) {
        case SinkKind::DependentLoad:  return "S1:a[b[i]]";
        case SinkKind::IndirectBranch: return "S2:b[i]()";
    }
    return "?";
}

void Report::write_text(std::FILE* out, const std::string& target,
                        const std::vector<Finding>& findings) {
    std::fprintf(out, "\n=== SpecScout: %zu residual Spectre-v1 gadget(s) in %s ===\n\n",
                 findings.size(), target.c_str());
    int idx = 0;
    for (const Finding& f : findings) {
        std::fprintf(out, "[#%d] %-12s  confidence %d%%\n", idx++,
                     sink_kind_name(f.kind), f.confidence);
        std::fprintf(out, "     function   : 0x%llx\n", (unsigned long long)f.func_va);
        std::fprintf(out, "     taint src  : %s @ call 0x%llx\n",
                     f.source_api.c_str(), (unsigned long long)f.source_call_va);
        std::fprintf(out, "     guard (br) : 0x%llx  %s\n",
                     (unsigned long long)f.guard_va, f.guard_text.c_str());
        std::fprintf(out, "     sink       : 0x%llx  %s   (+%d insn speculative)\n",
                     (unsigned long long)f.sink_va, f.sink_text.c_str(), f.spec_distance);
        std::fprintf(out, "     why        : %s\n\n", f.reason.c_str());
    }
    if (findings.empty())
        std::fprintf(out, "  (no residual gadgets found)\n\n");
}

static void json_escape(std::string& s) {
    std::string o;
    for (char c : s) {
        switch (c) {
            case '"':  o += "\\\""; break;
            case '\\': o += "\\\\"; break;
            case '\n': o += "\\n";  break;
            default:   o += c;      break;
        }
    }
    s.swap(o);
}

bool Report::write_json(const std::string& path, const std::string& target,
                        const std::vector<Finding>& findings) {
    std::FILE* f = std::fopen(path.c_str(), "wb");
    if (!f) return false;
    std::string tgt = target; json_escape(tgt);
    std::fprintf(f, "{\n  \"target\": \"%s\",\n  \"findings\": [\n", tgt.c_str());
    for (size_t i = 0; i < findings.size(); ++i) {
        const Finding& fi = findings[i];
        std::string api = fi.source_api, gt = fi.guard_text, st = fi.sink_text, rs = fi.reason;
        json_escape(api); json_escape(gt); json_escape(st); json_escape(rs);
        std::fprintf(f,
            "    {\n"
            "      \"kind\": \"%s\",\n"
            "      \"confidence\": %d,\n"
            "      \"function\": \"0x%llx\",\n"
            "      \"source_api\": \"%s\",\n"
            "      \"source_call\": \"0x%llx\",\n"
            "      \"guard\": \"0x%llx\",\n"
            "      \"guard_text\": \"%s\",\n"
            "      \"sink\": \"0x%llx\",\n"
            "      \"sink_text\": \"%s\",\n"
            "      \"spec_distance\": %d,\n"
            "      \"reason\": \"%s\"\n"
            "    }%s\n",
            sink_kind_name(fi.kind), fi.confidence,
            (unsigned long long)fi.func_va, api.c_str(),
            (unsigned long long)fi.source_call_va,
            (unsigned long long)fi.guard_va, gt.c_str(),
            (unsigned long long)fi.sink_va, st.c_str(),
            fi.spec_distance, rs.c_str(),
            (i + 1 < findings.size()) ? "," : "");
    }
    std::fprintf(f, "  ]\n}\n");
    std::fclose(f);
    return true;
}

} // namespace specscout
