// Cfg.h — per-function control-flow recovery via Capstone.
//
// Recursive-descent disassembly from a function start, bounded by the .pdata
// range when known. Produces basic blocks plus per-instruction control-flow
// classification that the speculative engine and sink detectors consume.
#pragma once

#include "Common.h"
#include "Loader.h"

#include <map>
#include <vector>

namespace specscout {

struct Insn {
    va_t        va = 0;
    uint8_t     size = 0;
    unsigned    id = 0;        // capstone x86 instruction id
    std::string mnemonic;
    std::string text;          // "mnemonic  operands"

    bool is_cond_branch = false;  // Jcc
    bool is_uncond_jmp  = false;  // jmp
    bool is_call        = false;  // call
    bool is_ret         = false;  // ret
    bool is_indirect    = false;  // branch/call target is reg or memory
    bool is_serializing = false;  // lfence / mfence / cpuid

    va_t direct_target  = 0;   // resolved target of a direct branch/call (else 0)
    va_t mem_target_slot = 0;  // RIP-relative [mem] slot VA (e.g. IAT) for calls/jmps
    va_t fallthrough    = 0;   // va + size
};

enum class TermKind {
    Fallthrough,   // no terminator; flows into the next block
    CondBranch,    // Jcc: two successors
    DirectJmp,
    IndirectJmp,
    Ret,
    Unknown
};

struct BasicBlock {
    va_t              start = 0;
    std::vector<Insn> insns;
    std::vector<va_t> succs;
    TermKind          term = TermKind::Unknown;
};

struct Function {
    va_t start = 0;
    va_t end   = 0;   // exclusive; == start when unknown
    std::map<va_t, BasicBlock> blocks;         // keyed by block start VA
    const BasicBlock* block_at(va_t va) const; // block whose start == va
};

class Cfg {
public:
    Cfg();
    ~Cfg();
    Cfg(const Cfg&) = delete;
    Cfg& operator=(const Cfg&) = delete;

    bool ok() const { return handle_ != 0; }

    // Build the CFG for the function starting at `func_start`. `range_end`
    // bounds disassembly (0 = discover until ret/invalid, capped).
    Function build(const LoadedImage& img, va_t func_start, va_t range_end = 0);

    // Decode a single instruction at `addr`. Returns false if `addr` is
    // unmapped or decoding fails.
    bool decode_at(const LoadedImage& img, va_t addr, Insn& out) const;

    // If `addr` is an import thunk (`jmp qword ptr [rip+disp]`), return the
    // imported symbol name it jumps to; otherwise "".
    std::string resolve_thunk(const LoadedImage& img, va_t addr) const;

private:
    size_t handle_ = 0;  // csh
};

} // namespace specscout
