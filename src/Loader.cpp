#include "Loader.h"

#include <LIEF/PE.hpp>

#include <algorithm>

namespace specscout {

const uint8_t* LoadedImage::bytes_at(va_t va, size_t& avail) const {
    for (const Section& s : sections) {
        if (va >= s.va && va < s.va + s.bytes.size()) {
            size_t off = static_cast<size_t>(va - s.va);
            avail = s.bytes.size() - off;
            return s.bytes.data() + off;
        }
    }
    avail = 0;
    return nullptr;
}

bool LoadedImage::is_executable(va_t va) const {
    for (const Section& s : sections) {
        if (va >= s.va && va < s.va + s.vsize)
            return s.executable;
    }
    return false;
}

void LoadedImage::build_iat_index() const {
    if (!iat_index_.empty()) return;
    for (const ImportRef& i : imports)
        iat_index_[i.iat_va] = &i.name;
}

const std::string* LoadedImage::import_name_at(va_t va) const {
    build_iat_index();
    auto it = iat_index_.find(va);
    return it == iat_index_.end() ? nullptr : it->second;
}

std::optional<LoadedImage> Loader::load(const std::string& path, std::string& err) {
    std::unique_ptr<LIEF::PE::Binary> bin;
    try {
        bin = LIEF::PE::Parser::parse(path);
    } catch (const std::exception& e) {
        err = std::string("LIEF parse exception: ") + e.what();
        return std::nullopt;
    }
    if (!bin) {
        err = "LIEF could not parse the file as a PE";
        return std::nullopt;
    }

    const auto machine = bin->header().machine();
    if (machine != LIEF::PE::Header::MACHINE_TYPES::AMD64) {
        err = "target is not an x86-64 (AMD64) PE";
        return std::nullopt;
    }

    LoadedImage img;
    img.image_base = bin->optional_header().imagebase();
    img.entry_point_va = img.image_base + bin->optional_header().addressof_entrypoint();

    // --- sections -----------------------------------------------------------
    for (const LIEF::PE::Section& s : bin->sections()) {
        Section out;
        out.name = s.name();
        out.va = img.image_base + s.virtual_address();
        out.vsize = s.virtual_size();
        out.executable =
            s.has_characteristic(LIEF::PE::Section::CHARACTERISTICS::MEM_EXECUTE);
        out.writable =
            s.has_characteristic(LIEF::PE::Section::CHARACTERISTICS::MEM_WRITE);
        auto content = s.content();  // span<const uint8_t>
        out.bytes.assign(content.begin(), content.end());
        img.sections.push_back(std::move(out));
    }

    // --- imports (IAT) ------------------------------------------------------
    if (bin->has_imports()) {
        for (const LIEF::PE::Import& imp : bin->imports()) {
            const std::string dll = imp.name();
            for (const LIEF::PE::ImportEntry& e : imp.entries()) {
                ImportRef ref;
                ref.dll = dll;
                ref.name = e.is_ordinal()
                               ? (dll + "#ord" + std::to_string(e.ordinal()))
                               : e.name();
                ref.iat_va = img.image_base + static_cast<va_t>(e.iat_address());
                img.imports.push_back(std::move(ref));
            }
        }
    }

    // --- function ranges from .pdata (RUNTIME_FUNCTION[]) -------------------
    // Each entry is { uint32 begin_rva; uint32 end_rva; uint32 unwind_rva; }.
    // A chained entry has (unwind_rva & 1) set in its unwind info; we keep the
    // range anyway (it is still executable code worth scanning).
    for (const Section& s : img.sections) {
        if (s.name != ".pdata") continue;
        const size_t n = s.bytes.size() / 12;
        for (size_t k = 0; k < n; ++k) {
            const uint8_t* p = s.bytes.data() + k * 12;
            auto rd = [&](int o) {
                return static_cast<uint32_t>(p[o]) | (static_cast<uint32_t>(p[o + 1]) << 8) |
                       (static_cast<uint32_t>(p[o + 2]) << 16) |
                       (static_cast<uint32_t>(p[o + 3]) << 24);
            };
            uint32_t begin = rd(0), end = rd(4);
            if (begin == 0 || end <= begin) continue;
            img.functions.push_back({img.image_base + begin, img.image_base + end});
        }
        break;
    }

    // Always include the entry point as a function start (may be absent from
    // .pdata if it is a leaf/non-unwinding thunk).
    img.functions.push_back({img.entry_point_va, img.entry_point_va});

    // Deduplicate by start VA.
    std::sort(img.functions.begin(), img.functions.end(),
              [](const FunctionRange& a, const FunctionRange& b) {
                  return a.start_va < b.start_va;
              });
    img.functions.erase(
        std::unique(img.functions.begin(), img.functions.end(),
                    [](const FunctionRange& a, const FunctionRange& b) {
                        return a.start_va == b.start_va;
                    }),
        img.functions.end());

    err.clear();
    return img;
}

} // namespace specscout
