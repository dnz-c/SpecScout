// Report.h — the Finding type and output (human text + JSON).
#pragma once

#include "Common.h"

#include <cstdio>
#include <string>
#include <vector>

namespace specscout {

enum class SinkKind {
    DependentLoad,   // S1:  a[b[i]]   — attacker index -> load -> dependent load
    IndirectBranch   // S2:  b[i]()    — attacker index -> indirect call/jump target
};

const char* sink_kind_name(SinkKind k);

struct Finding {
    SinkKind    kind = SinkKind::DependentLoad;
    va_t        func_va = 0;         // enclosing function
    va_t        guard_va = 0;        // the mistrainable conditional branch
    va_t        sink_va = 0;         // speculative load / indirect branch
    va_t        source_call_va = 0;  // where attacker data entered
    std::string source_api;          // taint origin (e.g. "fread")
    std::string guard_text;
    std::string sink_text;
    int         spec_distance = 0;   // instructions from guard to sink
    int         confidence = 0;      // 0..100
    std::string reason;              // why it is a /Qspectre residual

    bool operator<(const Finding& o) const { return confidence > o.confidence; }  // high first
};

class Report {
public:
    static void write_text(std::FILE* out, const std::string& target,
                           const std::vector<Finding>& findings);
    static bool write_json(const std::string& path, const std::string& target,
                           const std::vector<Finding>& findings);
};

} // namespace specscout
