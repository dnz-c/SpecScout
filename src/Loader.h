// Loader.h - PE parsing via LIEF.
//
// Responsibilities:
//   * map sections (with raw bytes) and record image base / entry point
//   * build an IAT map: absolute VA of each import thunk -> symbol name
//   * recover function ranges from the .pdata (x64 exception) table
//
// .pdata is parsed directly from raw section bytes (three uint32 RVAs per
// RUNTIME_FUNCTION), which is independent of the installed LIEF version.
#pragma once

#include "Common.h"

#include <map>
#include <memory>
#include <optional>
#include <string>
#include <vector>

namespace specscout {

class LoadedImage {
public:
    va_t image_base = 0;
    va_t entry_point_va = 0;
    std::vector<Section>    sections;
    std::vector<ImportRef>  imports;       // one per IAT slot
    std::vector<FunctionRange> functions;  // from .pdata (+ entry/exports)
    std::vector<std::pair<std::string, va_t>> exports;  // name -> absolute VA

    // Absolute VA of an export by name (exact match), or 0 if absent.
    va_t export_va(const std::string& name) const;

    // Return a pointer into the mapped bytes for `va`, and how many
    // contiguous bytes are available from there. Null if `va` is unmapped.
    const uint8_t* bytes_at(va_t va, size_t& avail) const;

    bool is_executable(va_t va) const;

    // Name of the import whose IAT slot is at `va`, or "" if none.
    // Used to resolve `call qword ptr [rip+disp]` / `call [iat]` targets.
    const std::string* import_name_at(va_t va) const;

private:
    mutable std::map<va_t, const std::string*> iat_index_;  // lazy
    void build_iat_index() const;
};

class Loader {
public:
    // Parse `path` (an x86-64 PE). Returns std::nullopt on failure; `err` is
    // filled with a human-readable reason.
    static std::optional<LoadedImage> load(const std::string& path, std::string& err);
};

} // namespace specscout
