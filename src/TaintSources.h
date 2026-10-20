// TaintSources.h — "known input API" taint model.
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

struct SourceSpec {
    std::string api;    // canonical name
    int         buf_arg;    // 0-based arg index holding the OUT buffer pointer
    int         len_bytes;  // how many bytes of that buffer to treat as tainted
};

struct TaintSourceSite {
    va_t        call_va = 0;   // the call instruction
    va_t        return_va = 0; // instruction after the call
    va_t        func_va = 0;   // enclosing function start
    SourceSpec  spec;
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

private:
    std::vector<SourceSpec> table_;
};

} // namespace specscout
