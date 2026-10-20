// kc_common.h - IOCTL contract shared between the kernel driver (driver.c) and
// the user-mode client (client.cpp) of the SpecScout kernel confirmer.
//
// The driver hosts a Spectre-v1 S1 gadget (a[b[i]] behind a bounds check) in
// KERNEL context, over kernel-resident data (array1 / array1_size / secret), and
// exposes a reload buffer (array2) mapped into the caller's user address space
// through an MDL so a user-mode attacker and the kernel victim share the same
// physical cache lines. The client mistrains the guard and recovers the kernel
// secret through Flush+Reload on that shared buffer.
#pragma once

#ifndef CTL_CODE
#include <winioctl.h>
#endif

#define SSKC_STRIDE 512     // bytes between reload lines (defeats the prefetcher)
#define SSKC_LINES  256     // one line per possible leaked byte value

// \\.\SpecScoutKC : symbolic link the client opens.
#define SSKC_DOS_NAME   L"\\DosDevices\\SpecScoutKC"
#define SSKC_NT_NAME    L"\\Device\\SpecScoutKC"
#define SSKC_WIN32_NAME "\\\\.\\SpecScoutKC"

#define SSKC_DEVICE_TYPE 0x8123

#define IOCTL_SSKC_INFO  CTL_CODE(SSKC_DEVICE_TYPE, 0x800, METHOD_BUFFERED,     FILE_ANY_ACCESS)
#define IOCTL_SSKC_MAP   CTL_CODE(SSKC_DEVICE_TYPE, 0x801, METHOD_BUFFERED,     FILE_ANY_ACCESS)
#define IOCTL_SSKC_SETUP CTL_CODE(SSKC_DEVICE_TYPE, 0x802, METHOD_BUFFERED,     FILE_ANY_ACCESS)
#define IOCTL_SSKC_RUN   CTL_CODE(SSKC_DEVICE_TYPE, 0x803, METHOD_BUFFERED,     FILE_ANY_ACCESS)

// IOCTL_SSKC_INFO output: geometry of the gadget plus the driver's own planted
// secret (so the client can score Flush+Reload recovery against the truth). The
// secret is the driver's, not real kernel data; this is a confirmer, not a leak
// of live OS state.
typedef struct _SSKC_INFO {
    unsigned int   stride;        // == SSKC_STRIDE
    unsigned int   lines;         // == SSKC_LINES
    unsigned int   probe_bytes;   // stride * lines
    unsigned int   secret_len;    // bytes of secret to recover
    long long      secret_delta;  // (secret - array1) in bytes: malicious_x = secret_delta + k
    unsigned long  array1_size;   // in-bounds limit (train with x < array1_size)
    unsigned char  array1[16];    // in-bounds values (exclude array1[train_x]'s line when probing)
    unsigned char  secret[64];    // the planted secret (truth for scoring)
} SSKC_INFO;

// IOCTL_SSKC_MAP output: the user-mode virtual address of the shared reload
// buffer (SSKC_LINES * SSKC_STRIDE bytes). The client flushes and times it.
typedef struct _SSKC_MAP {
    unsigned long long user_addr;
} SSKC_MAP;

// IOCTL_SSKC_SETUP input: speculative distance to model (filler ops between the
// inner load and the transmit), taken from the finding's spec_distance.
typedef struct _SSKC_SETUP {
    unsigned int fill;
} SSKC_SETUP;

// IOCTL_SSKC_RUN input: one batch of (train x rounds; mispredict) sequences for
// a single target index. The driver does NOT touch the reload buffer's cache
// state other than via the speculative access, so the client owns flush+probe.
typedef struct _SSKC_RUN {
    unsigned long long malicious_x;  // out-of-bounds index -> secret[k]
    unsigned long long train_x;      // in-bounds index used to mistrain the guard
    unsigned int       rounds;       // train/mispredict sequences this call
} SSKC_RUN;
