#include "QspectreClassifier.h"

#include <capstone/capstone.h>

namespace specscout::qspectre {

bool is_serializing(unsigned id) {
    return id == X86_INS_LFENCE || id == X86_INS_MFENCE || id == X86_INS_CPUID;
}

Finding classify(const RawHit& h) {
    Finding f;
    f.kind = h.kind;
    f.func_va = h.func_va;
    f.guard_va = h.guard_va;
    f.sink_va = h.sink_va;
    f.source_call_va = h.source_call_va;
    f.source_api = h.source_api;
    f.guard_text = h.guard_text;
    f.sink_text = h.sink_text;
    f.spec_distance = h.spec_distance;

    int score = 40;
    if (h.guard_tainted) score += 30;   // attacker controls the mistrainable branch
    if (h.strong_sink)   score += 25;   // dependent-load / tainted target confirmed
    if (h.spec_distance <= 60) score += 5;  // well inside a realistic ROB window
    if (score > 100) score = 100;
    f.confidence = score;

    const char* shape = (h.kind == SinkKind::DependentLoad)
                            ? "attacker index -> load -> dependent load (a[b[i]])"
                            : "attacker index -> indirect branch target (b[i]())";
    f.reason = std::string("reachable speculatively past a tainted bounds check with no "
                           "lfence/mfence/cpuid on the path; ") + shape +
               "; taint originates at " + h.source_api + ".";
    return f;
}

} // namespace specscout::qspectre
