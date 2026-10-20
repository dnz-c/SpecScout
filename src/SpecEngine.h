// SpecEngine.h — Triton-driven speculative taint exploration.
//
// For each taint-source call site we:
//   1. set up a fresh Triton x86-64 context, map the image, pin a sandbox stack
//   2. step the enclosing function on its concrete path, tainting the API's
//      output buffer, and record conditional branches whose condition is
//      attacker-tainted (the mistrainable guards)
//   3. for each such guard, replay to it then execute the *mispredicted* path
//      for a bounded window, reporting dependent-load (S1) and tainted
//      indirect-branch (S2) sinks reached before any serializing instruction.
#pragma once

#include "Cfg.h"
#include "Common.h"
#include "Loader.h"
#include "Report.h"
#include "TaintSources.h"

#include <vector>

namespace specscout {

struct EngineConfig {
    int      spec_window = 250;       // max instructions explored per misprediction
    int      max_normal_steps = 20000;// cap on the concrete discovery/replay walk
    int      source_taint_bytes = 64; // buffer bytes tainted at a source call
    uint64_t stack_top = 0x00007fffffff0000ULL;
    size_t   max_map_per_section = 16u * 1024 * 1024;  // cap bytes mapped per section
};

class SpecEngine {
public:
    SpecEngine(const LoadedImage& img, EngineConfig cfg = {});

    std::vector<Finding> scan(const std::vector<TaintSourceSite>& sites);

private:
    const LoadedImage& img_;
    EngineConfig cfg_;
    Cfg cfg_dis_;  // for single-instruction decode / classification

    // Implementation detail lives in the .cpp (per-site Session over a Triton
    // Context); kept out of the header to avoid leaking Triton types.
    void analyze_site(const TaintSourceSite& site, std::vector<Finding>& out);
};

} // namespace specscout
