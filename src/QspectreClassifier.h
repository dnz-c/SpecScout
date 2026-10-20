// QspectreClassifier.h — turn a raw speculative sink hit into a scored,
// explained /Qspectre-residual Finding.
//
// A candidate reaches the classifier only when the speculative walk reached the
// sink WITHOUT crossing a serializing instruction (lfence/mfence/cpuid). That
// absence is the whole point: had /Qspectre mitigated this path it would have
// inserted an LFENCE, so a fence-free tainted speculative sink is exactly what
// the compiler left behind.
#pragma once

#include "Report.h"

#include <string>

namespace specscout::qspectre {

// True for instructions that end a speculation window.
bool is_serializing(unsigned capstone_insn_id);

struct RawHit {
    SinkKind    kind;
    va_t        func_va;
    va_t        guard_va;
    va_t        sink_va;
    va_t        source_call_va;
    std::string source_api;
    std::string guard_text;
    std::string sink_text;
    int         spec_distance;
    bool        guard_tainted;   // the bounds check depends on attacker input
    bool        strong_sink;     // S1: dependent load proven; S2: target tainted
};

Finding classify(const RawHit& h);

} // namespace specscout::qspectre
