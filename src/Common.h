// Common.h - shared value types for SpecScout.
//
// SpecScout is a static Spectre-v1 gadget scanner for x86-64 PE binaries.
// It reports the bounds-check-bypass gadgets that MSVC's /Qspectre mitigation
// leaves behind: an attacker-controlled index that reaches, speculatively, a
// dependent load (a[b[i]]) or an indirect branch target (b[i]()).
#pragma once

#include <cstdint>
#include <string>
#include <vector>

namespace specscout {

using va_t = uint64_t;   // absolute virtual address (image_base + rva)
using rva_t = uint32_t;  // image-relative address

// A mapped PE section with its raw bytes.
struct Section {
    std::string name;
    va_t        va = 0;      // virtual address (absolute)
    uint64_t    vsize = 0;   // virtual size
    bool        executable = false;
    bool        writable = false;
    std::vector<uint8_t> bytes;  // raw content, indexed [0, bytes.size())
};

// One resolved import (an IAT slot and the symbol it points at).
struct ImportRef {
    va_t        iat_va = 0;   // absolute VA of the IAT thunk slot
    std::string dll;
    std::string name;
};

// A function body range, typically recovered from .pdata (x64 unwind table).
struct FunctionRange {
    va_t start_va = 0;
    va_t end_va = 0;   // exclusive
};

} // namespace specscout
