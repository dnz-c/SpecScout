// report_json.h - minimal, dependency-free reader for SpecScout's own JSON
// report format (flat finding objects of string/number values). Shared by the
// user-mode harness and the kernel-mode confirmation client. Not a general JSON
// parser; it only has to read what src/Report.cpp writes.
#pragma once

#include <cctype>
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>

namespace ssconfirm {

struct Finding {
    std::string kind, guard_text, sink_text, source_api;
    uint64_t    function = 0, guard = 0, sink = 0;
    int         confidence = 0, spec_distance = 0;
    bool        is_s2() const { return kind.rfind("S2", 0) == 0; }
};

// Pull the value for `key` out of one finding object's text. String values are
// returned unescaped; numeric/other tokens are returned verbatim.
inline bool json_field(const std::string& obj, const char* key, std::string& out) {
    std::string pat = std::string("\"") + key + "\"";
    size_t p = 0;
    while ((p = obj.find(pat, p)) != std::string::npos) {
        size_t q = p + pat.size();
        while (q < obj.size() && std::isspace((unsigned char)obj[q])) q++;
        if (q >= obj.size() || obj[q] != ':') { p += pat.size(); continue; }  // key inside a value
        q++;
        while (q < obj.size() && std::isspace((unsigned char)obj[q])) q++;
        if (q >= obj.size()) return false;
        if (obj[q] == '"') {
            std::string v;
            for (++q; q < obj.size() && obj[q] != '"'; ++q) {
                if (obj[q] == '\\' && q + 1 < obj.size()) {
                    char c = obj[++q];
                    v += (c == 'n') ? '\n' : c;
                } else {
                    v += obj[q];
                }
            }
            out.swap(v);
        } else {
            size_t s = q;
            while (q < obj.size() && obj[q] != ',' && obj[q] != '}' &&
                   !std::isspace((unsigned char)obj[q])) q++;
            out = obj.substr(s, q - s);
        }
        return true;
    }
    return false;
}

inline uint64_t json_u64(const std::string& obj, const char* key) {
    std::string v;  // VAs are stored as "0x..." strings; base 0 handles the prefix
    return json_field(obj, key, v) ? std::strtoull(v.c_str(), nullptr, 0) : 0;
}
inline int json_int(const std::string& obj, const char* key) {
    std::string v;
    return json_field(obj, key, v) ? std::atoi(v.c_str()) : 0;
}

// Split the "findings" array into its top-level object substrings.
inline std::vector<std::string> json_split_findings(const std::string& text) {
    std::vector<std::string> objs;
    size_t fp = text.find("\"findings\"");
    size_t lb = text.find('[', fp == std::string::npos ? 0 : fp);
    if (lb == std::string::npos) return objs;
    int depth = 0; bool instr = false; size_t start = 0;
    for (size_t i = lb; i < text.size(); ++i) {
        char c = text[i];
        if (instr) {
            if (c == '\\') { ++i; continue; }
            if (c == '"') instr = false;
            continue;
        }
        if (c == '"') { instr = true; continue; }
        if (c == '{') { if (depth++ == 0) start = i; }
        else if (c == '}') { if (--depth == 0) objs.push_back(text.substr(start, i - start + 1)); }
        else if (c == ']' && depth == 0) break;
    }
    return objs;
}

// Read a SpecScout JSON report. Returns false if the file cannot be opened.
inline bool load_report(const std::string& path, std::string& target,
                        std::vector<Finding>& out) {
    std::ifstream in(path, std::ios::binary);
    if (!in) return false;
    std::stringstream ss; ss << in.rdbuf();
    std::string text = ss.str();

    size_t tp = text.find("\"target\"");
    if (tp != std::string::npos) {
        size_t nl = text.find('\n', tp);
        json_field(text.substr(tp, nl == std::string::npos ? text.size() - tp : nl - tp + 1),
                   "target", target);
    }

    for (const std::string& o : json_split_findings(text)) {
        Finding f;
        json_field(o, "kind", f.kind);
        json_field(o, "guard_text", f.guard_text);
        json_field(o, "sink_text", f.sink_text);
        json_field(o, "source_api", f.source_api);
        f.function      = json_u64(o, "function");
        f.guard         = json_u64(o, "guard");
        f.sink          = json_u64(o, "sink");
        f.confidence    = json_int(o, "confidence");
        f.spec_distance = json_int(o, "spec_distance");
        out.push_back(std::move(f));
    }
    return true;
}

}  // namespace ssconfirm
