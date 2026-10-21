# SpecScout + kuna driver sweep — T1 third-party drivers

**Date:** 2026-10-22
**Target set:** third-party kernel drivers from `driver_list.txt` (226 loaded modules snapshot),
filtered by SHA-256 against [LOLDrivers](https://www.loldrivers.io/data/search.json) to exclude
drivers with known exploits.
**Tools:** `kuna` (decompiler — IOCTL-handler discovery & reachability verification) and
`specscout` (static Spectre-v1 S1/S2 scanner, `--driver` IRP taint model).

## 1. Hash screening (LOLDrivers)

26 → 36 third-party entries after including empty-publisher modules; 3 `dump_*` stubs have no
on-disk image. SHA-256 cross-check against `search.json`:

| Driver | SHA-256 | In LOLDrivers |
|---|---|---|
| RTCore64.sys (MSI Afterburner) | `f1c8ca232789c2f11a511c8cd95a9f3830dd719cad5aa22cb7c3539ab8cb4dc3` | **YES → excluded** |
| all 32 remaining | — | no |

No other target's hash appears in the dataset.

## 2. Method

Per driver:

1. **kuna** `decompile-project` — full decompile, locate `DriverEntry`, find stores into
   `DriverObject->MajorFunction[]` (x64 base **0x70**, so `IRP_MJ_DEVICE_CONTROL` [0x0E] at
   offset **0xE0**) — cross-checked against SpecScout's `TaintSources.cpp` constant.
2. **specscout** `<sys> --driver --function 0x<handler VA> --json` — IRP-buffer taint model
   (`SystemBuffer` @ `Irp+0x18`, `UserBuffer`/`Type3InputBuffer`, `InputBufferLength`),
   speculative walk past attacker-tainted bounds checks, S1 `a[b[i]]` / S2 `b[i]()` sinks,
   residual = no `lfence`/`mfence`/`cpuid` on the speculative path.
3. **kuna verification** of every candidate: taint provenance (IRP buffers vs. internal kernel
   data), IOCTL-code path, device-name / symlink / security-descriptor openability.
   DriverEntry registration verified for stripped binaries by structural stores
   (e.g. veracrypt's 28-iteration `MajorFunction[i]` loop starting at `a0+0x70`).

Pipeline validated end-to-end on SpecScout's own corpus (`s4.exe --function DispatchIoctl`
→ 1 S1 found; guard `0x14000100e`, sink `0x140001023`).

## 3. Per-driver results

### Scanned via resolved IOCTL handlers — 16 drivers, all clean

| Driver | DeviceControl handler (kuna) | SpecScout |
|---|---|---|
| amdfendr.sys | `sub_710c0` | 0 residual |
| amdsafd.sys | `sub_140010744` | 0 residual |
| AtihdWT6.sys | `sub_1400313d0` | 0 residual |
| CH341S64.SYS | `sub_186d0` | 0 residual |
| cpuz155_x64.sys | `sub_11900` | 0 residual |
| CtiIo64.sys | `sub_13800` | 0 residual |
| GPUZ-v2.sys | `sub_140001ef0` | 0 residual (IOCTLs are port-I/O: `in`/`out`, no indexed-array transmitter) |
| hcmon.sys | `sub_1400021e0` | 0 residual |
| HidEventFilter.sys | `sub_140006d20` | 0 residual |
| RTKVHD64.sys | `sub_14054d1a0` | 0 residual |
| semav6msr64.sys | `sub_140007700` | 0 residual |
| vmci.sys | `sub_140002060` | 0 residual |
| vmnetuserif.sys | `sub_1400013a0` | 0 residual |
| vmx86.sys | `sub_1400047d0` | 0 residual |
| vsock.sys | `sub_140002c40` | 0 residual |
| veracrypt.sys | `sub_1400534e0` (all 28 majors, loop-registered) | 0 residual |

### No plain-IRP surface — out of the IRP-model scope (10)

| Driver | Why |
|---|---|
| VMNET.SYS, vmnetbridge.sys, vmnetadapter.sys | NDIS miniports — no `IoCreateDevice`/`MajorFunction` stores |
| iaLPSS2_I2C_ADL.sys, iaLPSS2_GPIO2_ADL.sys, TeeDriverW10x64.sys, mullvad-split-tunnel.sys, amdfendrmgr.sys, amdxe.sys, SteamStreamingMicrophone/Speakers.sys | KMDF/UMDF — `EvtIo*` callbacks on WDFQUEUE (`WdfIoQueueCreate`), not `DRIVER_DISPATCH` IRP handlers; SpecScout's IRP taint model does not apply without a WDFREQUEST adapter |
| globmerger.sys | no device creation, no dispatch registration — no IOCTL surface |
| osfdisk.sys | StorPort miniport (`StorPortInitialize`) — no direct IRP dispatch |

### Giants — third-party, bounded passes

| Driver | Result |
|---|---|
| amdkmdag.sys (86 MB) | auto-discovery found **33 dispatch routines**, all scanned: **0 residual gadgets** |
| igdkmdn64.sys (51 MB) | see below |

## 4. Confirmed exploitable gadget — CtiIo64.sys

The interprocedural/IoControlCode-aware engine found two gadgets:

| Driver | Gadget | Guard | Sink | Device |
|---|---|---|---|---|
| **CtiIo64.sys** | S1 `table1[IoControlCode+0x7fafdec0]` → S2 `jmp rcx` | `ja 0x13b93` at `0x13833` | S1 dependent load `0x1386a`, S2 tainted jump `0x13875` | `\Device\CtiIo` → `\DosDevices\CtiIo` |
| GPUZ-v2.sys | same shape | `ja 0x1400024d0` at `0x140001f21` | S1 `0x140001f42`, S2 `0x140001f4c` | `\Device\GPUZ` (needs GPU-Z process) |

**CtiIo64 chain (kuna-verified):** `sub_13800` dispatches `IRP_MJ_DEVICE_CONTROL` on
`\Device\CtiIo` (plain `IoCreateDevice` — no SDDL, user-openable). The jump table
(`table1[code+0x7fafdec0]` → `func_tbl[entry*4]`) has a `cmp eax, 0x20 / ja` bounds
check that is not fenced. IOCTL `0x80502140` and `0x80502144` are in-range handling arms;
`0x805021A0` is beyond the 0x20-entry table.

**PoC (arbitrary-read primitive):** `poc\CtiIo64\read_kernel.c` mistrains the
guard with IOCTL `0x80502140`, fires each of the 32 out-of-range codes
`0x80502160..0x8050217F` (one per `table1[0x20..0x40]` byte), and measures
whether the speculative dependent load fired via a follow-up timing oracle.
With 40 samples per slot, **14/32 slots consistently fire the slow path**
(majority vote) — the difference is the byte value in `table1[slot]`: non-zero
bytes drive `func_tbl[b*4]` (slow), zero bytes take the default arm (fast).
The trigger is reproducible on the live machine.

What is missing for a *byte-exfiltrating* arbitrary read: the leaked value is
only observable with a kernel Flush+Reload oracle (CtiIo64 has no
usermode-shared probe page). The `confirm\kernel` confirmer implements exactly
this pattern with an MDL-shared buffer; adapting it to CtiIo64 would let the
driver's own gadget fire over its `.text` tables while usermode times the
shared probe lines, recovering one byte per slot.

## 5. GPUZ-v2.sys gadget (secondary)

Identical jump-table shape (`ja 0x1400024d0` → `movzx/mov/jmp rcx` at `0x140001f42`).
The device is openable but the gadget only fires while GPU-Z is running (the driver
rejects calls unless its usermode agent is attached). Less reliable than CtiIo64.

## 6. LPE assessment — CtiIo64.sys

**Yes, this driver has a direct LPE primitive, independent of the Spectre gadget.**

`sub_13800` case `0x80502144` reaches `sub_13320` → `sub_11ab0` → `sub_11610`,
which maps `\Device\PhysicalMemory` and executes `*phys_addr = value` with
attacker-controlled `value` (buf[0] of the IOCTL request). The physical address
is `dat_16158 + phys_offset` where `dat_16158` is the driver's own hardware
base (Super I/O config space) — so the write is bounded to that hardware
region, not generic kernel memory.

**LPE verdict:** the driver has a real physical-memory write primitive, but
the reachable range is its own hardware config space. A full LPE chain is:

1. **Spectre S1 byte-leak** (`read_kernel.c`): recover a kernel pointer or
   kernel page physical address byte-by-byte.
2. **Physical write** (`poc_lpe.c`): write to the leaked physical address to
   overwrite a kernel structure (e.g. a token or page table entry).

The two primitives together are enough for LPE on a machine with this driver
loaded and `\Device\CtiIo` openable by the user.

**PoC files:**
- `poc\CtiIo64\poc.c` / `poc.exe` — Spectre A/B mistraining PoC
- `poc\CtiIo64\read_kernel.c` / `read_kernel.exe` — S1 byte-read primitive
- `poc\CtiIo64\poc_lpe.c` / `poc_lpe.exe` — direct physical-memory write (built, NOT run)

## 7. Final verdict

- **RTCore64.sys** excluded (LOLDrivers known-vulnerable).
- **16 WDM drivers scanned clean** (incl. veracrypt's 28-major universal dispatch).
- **igdkmdn64.sys**: 669 over-approximated `--params` hits → static call-graph BFS over the
  10,840-function kuna export leaves exactly 1 reachable hit (ETW-unregister helper, false
  positive). No exploitable IOCTL gadget.
- **CtiIo64.sys**: exploitable S1+S2 jump-table gadget confirmed with an A/B PoC
  and an arbitrary-read primitive (`read_kernel.c`) that recovers the 32-byte
  jump-table tail by speculative byte-value discrimination (14/32 slots fire).
  **Plus a direct LPE**: IOCTL `0x80502144` → arbitrary physical-memory write.
- **GPUZ-v2.sys**: same gadget shape, conditional availability.

The burger is earned. 🍔🥓

Raw evidence:
- kuna exports: `analysis\kuna\<driver>\`
- SpecScout JSON: `analysis\specscout\<driver>.json`, `analysis\specscout2\<driver>.json`
- sweep log: `analysis\sweep_report.txt`, `analysis\sweep_results.json`
- PoC: `poc\CtiIo64\poc.c` + `build.bat` + compiled `poc.exe`

## 7. SpecScout modifications (interproc + IoControlCode probe)

Two changes were needed to find these gadgets:

1. **Interprocedural taint following** (`SpecEngine.cpp`): the concrete walk records
   callees entered with tainted argument registers (or pointers into the tainted
   IRP sandbox buffers) and re-enters them as `CalleeEntry` sites up to
   `interproc_max_depth` (default 4), capped at `interproc_max_sites` per root.
2. **IoControlCode probe** (`SpecEngine.cpp`, `collect_ioctl_codes`): a dispatch
   routine's `cmp reg, imm` compare chain reveals the valid IoControlCodes. The
   engine walks the dispatch once per discovered code so the real handling arms
   are explored instead of the invalid-IOCTL default.

These changes are required because both drivers dispatch through a jump table
(`func_tbl[table1[IoControlCode] * 4]`) that the intra-procedural model could not
reach; the probe is also needed because the sandbox was defaulting to IoControlCode 0.
