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
specscout <target.exe> [--dump] [--json <file>] [--confirm]
  --dump         print recovered functions, imports, and CFG summary
  --json <file>  write findings as JSON
```

Set `SPECSCOUT_DEBUG=1` (and `SPECSCOUT_TRACE=1`) for per-site / per-instruction
tracing.

## Validation corpus

`tests/corpus/` has two gadgets (`s1_fread.cpp`, `s2_fread.cpp`) whose index comes
from `fread`. `build.bat` compiles each `/O2` with and without `/Qspectre`:

| Binary     | Built with        | SpecScout result                                   |
|------------|-------------------|----------------------------------------------------|
| `s1.exe`   | `/O2`             | **S1 `a[b[i]]` reported** (true positive)          |
| `s1_q.exe` | `/O2 /Qspectre`   | **clean** — MSVC inserted `lfence` (true negative) |
| `s2.exe`   | `/O2`             | **S2 `b[i]()` reported** (true positive)           |
| `s2_q.exe` | `/O2 /Qspectre`   | **S2 still reported** — `/Qspectre` misses it      |

The `s2_q` row is the headline: `/Qspectre` targets load bounds-check-bypass and
does **not** fence the indirect-call gadget, so SpecScout flags a real residual.

## Dynamic confirmation (`specscout_confirm`)

`confirm/harness.cpp` builds the flagged S1 gadget, mistrains the guard, and
recovers a secret through the `array2[]` cache side channel — confirming the
gadget class is live on the host CPU:

```
[confirm] recovered 10/10 bytes -> gadget is EXPLOITABLE (leak confirmed)
```

(Driving an arbitrary external PE straight from a JSON finding is future work;
this is the in-process confirmer the primitive is built for.)

## Limitations (v1)

- **Intra-procedural.** Taint entering in one function and used as an index in
  another is not yet followed across calls.
- **Concrete-path discovery.** Guards are found along one concrete path; deeply
  nested / loop-dependent guards can be missed (same class as oo7).
- **Modelled calls.** Non-source calls are treated as returning with no effect;
  return-value-gated control flow (e.g. `if (fread(...) != n)`) is not modelled.
- **Statically-linked input APIs.** Works best when the input API is an import
  (dynamic CRT, `/MD`); a statically-linked `fread` is not a resolvable import.
- **Dynamic confirm** is reliable only where inputs are controllable.
```
