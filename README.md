# SpecScout

A static **Spectre-v1 gadget scanner** for x86-64 PE binaries. It finds the
bounds-check-bypass gadgets that MSVC's `/Qspectre` mitigation leaves behind —
the two shapes that actually transmit secrets:

- **S1 `a[b[i]]`** — an attacker-controlled index drives a load whose result
  addresses a second (dependent) load: the classic Flush+Reload transmitter.
- **S2 `b[i]()`** — an attacker-controlled index selects an indirect call/jump
  target.

`/Qspectre` only fences one narrow pattern and Microsoft states plainly that
"there is no guarantee that all possible instances of variant 1 will be
instrumented." SpecScout scans the **already-`/Qspectre`-compiled** binary and
reports any attacker-tainted speculative sink with **no serializing barrier**
(`lfence`/`mfence`/`cpuid`) between the guarding branch and the sink — i.e.
exactly the gadgets the compiler missed.

It is modelled on academic work (teapot/Kasper, oo7, Spectector) but is static,
written in C++, and uses the [Triton](https://github.com/JonathanSalwan/Triton)
DBA engine for precise taint + symbolic reasoning.

## How it works

```
PE ─▶ Loader (LIEF)          sections, IAT imports, .pdata function ranges
   ─▶ CFG (Capstone)         per-function basic blocks, tagged terminators
   ─▶ TaintSources           call sites to known input APIs (recv/read/ReadFile/fread/…)
   ─▶ SpecEngine (Triton)    per source: taint the API buffer, walk the concrete
                             path to attacker-tainted conditional branches, then
                             execute the MISPREDICTED path for a bounded window
   ─▶ Sinks                  S1 dependent load (load var) / S2 tainted indirect target
   ─▶ QspectreClassifier     residual iff no lfence/mfence/cpuid on the spec path
   ─▶ Report                 ranked text + JSON
```

Key ideas:

- **Taint source = known input APIs.** The attacker-controlled buffer is the
  output of `recv`/`read`/`ReadFile`/`fread`/… resolved via the import table.
- **Bounds-check-bypass modelling.** The tainted buffer is seeded with an
  out-of-bounds concrete value so the *concrete* branch fails; the engine then
  speculates the *mispredicted* (in-bounds) body — the dangerous direction.
- **Dependent-load detection survives constant folding.** Each attacker-addressed
  load's result is minted as a fresh symbolic "load variable"; a later load whose
  effective address references a load variable is the dependent outer load.
- **Residual = no fence.** The speculative walk stops at `lfence`/`mfence`/`cpuid`.
  Reaching a sink means the compiler did *not* fence this path.

## Build (Windows, MSVC)

Dependencies come from vcpkg: `triton` (pulls `z3` + `capstone`) and `lief`.

```
vcpkg install triton lief --triplet x64-windows
cmake --preset vs2022-full        # Triton engine ON
cmake --build build --config Release
```

`cmake --preset vs2022` builds the loader/CFG-only subset (Triton OFF), useful
for `--dump` without the heavy dependency.

## Usage

```
specscout <target> [options]
  taint model (pick one; default --api):
    --api            attacker data from imported input APIs (user-mode)
    --driver         attacker data from IRP buffers of IOCTL dispatch routines (.sys)
    --params         attacker-controlled integer parameters (syscalls / exports)
  entry selection (for --driver / --params):
    --function <n>   restrict to one function: export name or 0xVA
    --exports        use every exported function as an entry
    --max-funcs <n>  cap functions scanned (default 1000)
  output:
    --dump           functions, imports, exports, CFG summary
    --json <file>    write findings as JSON
    --confirm        note the dynamic Flush+Reload confirmer
```

Set `SPECSCOUT_DEBUG=1` (and `SPECSCOUT_TRACE=1`) for per-site / per-instruction
tracing.

## Taint models

The attacker-input source is pluggable; the speculative walk and sinks are shared.

- **`--api`** (user-mode) — taint the buffer written by an imported input API
  (`recv`/`read`/`ReadFile`/`fread`/…). Precise, but needs the API to be an
  import (dynamic CRT, `/MD`).
- **`--driver`** (kernel `.sys`) — treat a routine as an IOCTL dispatcher
  (`DRIVER_DISPATCH(PDEVICE_OBJECT, PIRP)`), build a sandbox `_IRP` with the real
  x64 offsets, and taint `Irp->AssociatedIrp.SystemBuffer`, `Irp->UserBuffer` /
  `Type3InputBuffer`, and the IOCTL `InputBufferLength`. Dispatch routines are
  auto-discovered from `DriverEntry`'s stores into `DriverObject->MajorFunction[]`
  (best-effort), or named with `--function`.
- **`--params`** (syscall / export surface) — treat the integer parameter
  registers (`rcx`/`rdx`/`r8`/`r9`) at a function entry as attacker-controlled.

### Scanning drivers and ntoskrnl

```
specscout driver.sys --driver                       # auto-find IOCTL handlers
specscout driver.sys --driver --function MyDispatch  # or name one
specscout ntoskrnl.exe --params --function NtFoo     # target one syscall handler
specscout ntoskrnl.exe --params --exports --max-funcs 300   # bounded sweep
```

`ntoskrnl.exe` (≈13 MB, ~38 k functions) loads in a couple of seconds thanks to
**lazy, map-on-read memory** (image bytes are served to Triton on demand instead
of mapped up front). The broad `--params` / `--driver` models **over-approximate**
— they assume parameters/IRP buffers are attacker-controlled — so treat their
output as a **candidate set to triage**, not confirmed bugs. A scaling filter
keeps only loads where a prior load's result is used as a *scaled* index (the
cache-transmitter shape `array2[v*stride]`), which discards ordinary pointer
chasing (`p->a->b`) and cut a 150-export ntoskrnl sweep from 65 hits to 1.

## Validation corpus

`tests/corpus/` has two gadgets (`s1_fread.cpp`, `s2_fread.cpp`) whose index comes
from `fread`. `build.bat` compiles each `/O2` with and without `/Qspectre`:

| Binary     | Built with        | SpecScout result                                   |
|------------|-------------------|----------------------------------------------------|
| Binary     | Built with      | Model      | Result                                         |
|------------|-----------------|------------|------------------------------------------------|
| `s1.exe`   | `/O2`           | `--api`    | **S1 `a[b[i]]`** (true positive)               |
| `s1_q.exe` | `/O2 /Qspectre` | `--api`    | **clean** — MSVC `lfence` (true negative)      |
| `s2.exe`   | `/O2`           | `--api`    | **S2 `b[i]()`** (true positive)                |
| `s2_q.exe` | `/O2 /Qspectre` | `--api`    | **S2 still reported** — `/Qspectre` misses it  |
| `s3.exe`   | `/O2`           | `--params` | **S1** from a parameter index (true positive)  |
| `s3_q.exe` | `/O2 /Qspectre` | `--params` | **clean** (true negative)                      |
| `s4.exe`   | `/O2`           | `--driver` | **S1** via an IOCTL `SystemBuffer` (true pos.) |
| `s4_q.exe` | `/O2 /Qspectre` | `--driver` | **clean** (true negative)                      |

The `s2_q` row is the headline: `/Qspectre` targets load bounds-check-bypass and
does **not** fence the indirect-call gadget, so SpecScout flags a real residual.
`s3`/`s4` exercise the parameter and driver-IRP taint models end to end.

## Dynamic confirmation (`specscout_confirm`)

`confirm/harness.cpp` builds the flagged S1 gadget, mistrains the guard, and
recovers a secret through the `array2[]` cache side channel — confirming the
gadget class is live on the host CPU. With no argument it runs the built-in
self-test:

```
specscout_confirm
...
[confirm] recovered 10/10 bytes -> gadget is EXPLOITABLE (leak confirmed)
```

Given a finder JSON report it walks every finding and, for each **S1**, runs an
in-process replica keyed to that finding — mistraining the guard and delaying
the transmit load by the reported `spec_distance` to also probe whether the
speculation window reaches that far on your CPU:

```
specscout ntoskrnl.exe --params --exports --json gadgets.json
specscout_confirm gadgets.json            # leak-test up to --limit S1 findings
specscout_confirm gadgets.json --all      # test every finding (slower)

[#0] S1:a[b[i]] fn=0x1403a08e0 guard=0x1403a0e5d -> sink=0x1403a0b86  dist=+24
      recovered 10/10 bytes -> S1 class EXPLOITABLE on this CPU
...
=== summary: 18/20 S1 tested confirmed; 32 S2 listed for manual review ===
```

What it proves and what it does **not**: the harness runs an in-process replica
on the host CPU, so a clean recovery confirms the gadget **class** is exploitable
here and that the speculation window reaches the reported distance. It does *not*
execute the target binary's code at the reported address — confirming an in-binary
gadget in situ (especially a kernel-mode ntoskrnl / driver gadget, which needs a
privileged harness driving the real syscall/IOCTL inputs) is out of scope, as is
**S2** indirect-branch (BTB) confirmation; S2 findings are listed for manual
review rather than silently "confirmed".

## Limitations

- **Intra-procedural.** Taint entering in one function and used as an index in
  another is not yet followed across calls.
- **Concrete-path discovery.** Guards are found along one concrete path; deeply
  nested / loop-dependent guards can be missed (same class as oo7).
- **Modelled calls.** Non-source calls are treated as returning with no effect;
  return-value-gated control flow (e.g. `if (fread(...) != n)`) is not modelled.
- **Over-approximation in broad modes.** `--params` and `--driver` assume
  parameters / IRP buffers are attacker-controlled, so their hits are candidates
  to triage, not confirmed vulnerabilities. The scaling filter keeps precision
  reasonable, and `--function` lets you target genuinely attacker-reachable
  entries (e.g. a specific syscall handler).
- **Best-effort IOCTL discovery.** `--driver` auto-detection reads straight-line
  `DriverEntry`; obfuscated or indirect `MajorFunction[]` setup needs `--function`.
- **`--api` needs imports.** A statically-linked `fread` is not a resolvable
  import (use a dynamic CRT, `/MD`).
- **Dynamic confirm** is reliable only where inputs are controllable.
```
