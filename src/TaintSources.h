// TaintSources.h - "known input API" taint model.
//
// Attacker-controlled data is assumed to enter through a fixed set of input
// APIs (recv/read/ReadFile/fread/...). We find call sites to those imports and
// record where the attacker-controlled buffer pointer lives at the call (an
// x64 argument register), so the engine can taint that buffer.
#pragma once

#include "Cfg.h"
#include "Common.h"
#include "Loader.h"

#include <string>
#include <vector>

namespace specscout {

// How attacker-controlled data enters at a site.
enum class SourceModel {
    InputApi,    // user-mode: a buffer written by an imported input API
    DriverIrp,   // kernel: the IRP SystemBuffer/Type3InputBuffer of a dispatch routine
    Params,      // generic: the integer parameter registers at a function entry
    CalleeEntry  // interproc: a callee entered from a call site carrying taint
};

struct SourceSpec {
    std::string api;    // canonical name / label
    int         buf_arg;    // 0-based arg index holding the OUT buffer pointer
    int         len_bytes;  // how many bytes of that buffer to treat as tainted
};

struct TaintSourceSite {
    SourceModel model = SourceModel::InputApi;
    va_t        call_va = 0;   // InputApi: the call instruction; else == func_va
    va_t        return_va = 0; // instruction after the call
    va_t        func_va = 0;   // function to start the walk at
    SourceSpec  spec;
    SourceModel base = SourceModel::InputApi; // CalleeEntry: sandbox model inherited
                                              // from the root site
    uint64_t    ioctl_code = 0;      // DriverIrp: concrete IoControlCode for the walk
    bool        ioctl_expanded = false; // DriverIrp: control-code probe already done
    unsigned    arg_taint_mask = 0;  // CalleeEntry: bit i = arg reg i tainted
    uint64_t    arg_vals[4] = {0, 0, 0, 0};  // CalleeEntry: concrete arg values
    int         depth = 0;   // CalleeEntry: distance from the root site
};

class TaintSources {
public:
    TaintSources();

    // x64 integer argument register name for a 0-based argument index
    // (RCX, RDX, R8, R9). Returns "" for index >= 4 (stack-passed).
    static const char* arg_reg(int idx);

    // Match an import symbol name against the input-API table.
    const SourceSpec* match(const std::string& import_name) const;

    // Scan every function for call sites to input APIs (direct `call [iat]`,
    // or `call thunk` where the thunk is `jmp [iat]`).
    std::vector<TaintSourceSite> find_sites(const LoadedImage& img, Cfg& cfg,
                                            const std::vector<FunctionRange>& funcs) const;

    // Build DriverIrp sites: each entry VA is treated as an IOCTL dispatch
    // routine whose IRP (2nd parameter) carries attacker-controlled buffers.
    std::vector<TaintSourceSite> driver_sites(const std::vector<va_t>& entries) const;

    // Build Params sites: each entry VA's integer parameter registers are
    // treated as attacker-controlled (syscall / exported-function surface).
    std::vector<TaintSourceSite> param_sites(const std::vector<va_t>& entries) const;

    // Best-effort: scan DriverEntry for stores into
    // DriverObject->MajorFunction[] (offset 0x70..0xE0 on x64) and return the
    // dispatch routine addresses they install.
    std::vector<va_t> find_ioctl_dispatch(const LoadedImage& img, Cfg& cfg) const;

private:
    std::vector<SourceSpec> table_;
};

} // namespace specscout
