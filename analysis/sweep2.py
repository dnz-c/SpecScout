#!/usr/bin/env python3
"""Re-sweep T1 drivers with the interprocedural-enabled specscout build."""
import json, subprocess, sys
from pathlib import Path

AN      = Path(r"A:\MyProgramming\C++\SpecScout\analysis")
SPEC    = Path(r"A:\MyProgramming\C++\SpecScout\build\Release\specscout.exe")
OUTDIR  = AN / "specscout2"
OUTDIR.mkdir(parents=True, exist_ok=True)

# handler VAs found by the kuna phase (previous sweep + manual triage of obfuscated entries)
HANDLERS = {
    "amdfendr.sys":        "0x710c0",
    "amdsafd.sys":         "0x140010744",
    "AtihdWT6.sys":        "0x1400313d0",
    "CH341S64.SYS":        "0x186d0",
    "cpuz155_x64.sys":     "0x11900",
    "CtiIo64.sys":         "0x13800",
    "GPUZ-v2.sys":         "0x140001ef0",
    "hcmon.sys":           "0x1400021e0",
    "HidEventFilter.sys":  "0x140006d20",
    "RTKVHD64.sys":        "0x14054d1a0",
    "semav6msr64.sys":     "0x140007700",
    "veracrypt.sys":       "0x1400534e0",
    "vmci.sys":            "0x140002060",
    "vmnetuserif.sys":     "0x1400013a0",
    "vmx86.sys":           "0x1400047d0",
    "vsock.sys":           "0x140002c40",
    "amdkmdag.sys":        None,   # auto-discovery (33 routines found earlier)
    "igdkmdn64.sys":       None,   # bounded --params fallback
}

targets = json.loads((AN / "t1_hashes.json").read_text(encoding="utf-8-sig"))
paths = {t["Driver"]: t["Path"] for t in targets if t["Exists"]}
paths.update({
    "amdkmdag.sys":  r"C:\WINDOWS\System32\DriverStore\FileRepository\u0205306.inf_amd64_ed4bdb51fc506ec7\B026676\amdkmdag.sys",
    "igdkmdn64.sys": r"C:\WINDOWS\System32\DriverStore\FileRepository\iigd_dch.inf_amd64_b57fc4f35ff4051b\igdkmdn64.sys",
})

results = []
for name, handler in HANDLERS.items():
    path = paths.get(name)
    if not path:
        print(f"!! {name}: no path", flush=True)
        continue
    jout = OUTDIR / (name + ".json")
    args = [str(SPEC), path, "--driver"]
    if handler:
        args += ["--function", handler]
    args += ["--json", str(jout)]
    try:
        p = subprocess.run(args, capture_output=True, text=True, errors="replace", timeout=5400)
        stdout = p.stdout
    except subprocess.TimeoutExpired:
        stdout, p = "TIMEOUT", None
    findings = []
    if jout.exists():
        try:
            j = json.loads(jout.read_text(encoding="utf-8-sig"))
            findings = j.get("findings", [])
        except Exception as e:
            findings = [{"error": str(e)}]
    line = f"{name:26} {('handler=' + handler) if handler else 'auto':>16}  rc={p.returncode if p else '?'}  findings={len(findings)}"
    print(line, flush=True)
    results.append({"driver": name, "handler": handler, "stdout": stdout,
                    "findings": findings})

(AN / "sweep2_results.json").write_text(json.dumps(results, indent=1), encoding="utf-8")
print("\n=== drivers with findings ===")
for r in results:
    if r["findings"]:
        print(f"\n--- {r['driver']}  ({len(r['findings'])} finding(s))")
        for f in r["findings"][:12]:
            print(f"  {f.get('kind')}  fn={f.get('function')}  guard={f.get('guard')}"
                  f"({f.get('guard_text','')})  sink={f.get('sink')}  conf={f.get('confidence')}")
