#!/usr/bin/env python3
"""Sweep: kuna (IOCTL handler discovery) -> specscout (Spectre v1 gadget scan) -> report."""
import json, re, subprocess, sys, os
from pathlib import Path

ROOT     = Path(r"A:\MyProgramming\C++\SpecScout")
AN       = ROOT / "analysis"
SPEC     = ROOT / r"build\Release\specscout.exe"
KUNA     = "kuna"
SKIP     = {"amdkmdag.sys", "igdkmdn64.sys"}          # giants handled separately
MJ_DEVICE_CONTROL = 0xE0                               # MajorFunction[0x0E] @ 0x70 + 0x0E*8

BLOCK_RE = re.compile(r"// Function: (\S+) @ 0x([0-9a-f]+)\n(.*?)(?=\n// Function: |\Z)", re.S)
STORE_RE = re.compile(r"\+ 0x([0-9a-fA-F]+)\) = (\w+)\s*;")

def run(cmd, timeout=600):
    return subprocess.run(cmd, capture_output=True, text=True, errors="replace", timeout=timeout)

def find_handlers(c_file):
    """Return [(entry_name, entry_va, ioctl_handler, stores)] for blocks with >=2 MajorFunction-range stores."""
    blocks = []
    for m in BLOCK_RE.finditer(c_file.read_text(encoding="utf-8", errors="replace")):
        name, va, body = m.group(1), "0x" + m.group(2), m.group(3)
        stores = []
        for s in STORE_RE.finditer(body):
            disp = int(s.group(1), 16)
            if 0x60 <= disp <= 0x158:
                stores.append((disp, s.group(2)))
        if len(stores) >= 2:
            blocks.append((name, va, stores))
    if not blocks:
        return []
    out = []
    for name, va, stores in blocks:
        ioctl = next((t for d, t in stores if d == MJ_DEVICE_CONTROL), None)
        out.append({"entry": name, "va": va, "ioctl": ioctl, "stores": stores})
    return out

def main():
    targets = json.loads((AN / "t1_hashes.json").read_text(encoding="utf-8-sig"))
    targets = [t for t in targets if t["Exists"] and not t["InLOL"]
               and not t["Driver"].startswith("dump_") and t["Driver"] not in SKIP]
    report = []
    for i, t in enumerate(targets, 1):
        name, path = t["Driver"], t["Path"]
        kdir = AN / "kuna" / name
        r = {"driver": name, "handler": "", "devices": [], "note": "", "findings": []}
        print(f"[{i}/{len(targets)}] {name} ... ", end="", flush=True)
        kdir.mkdir(parents=True, exist_ok=True)

        # 1) kuna decompile
        try:
            p = run([KUNA, "decompile-project", path, "-o", str(kdir), "--jobs", "auto",
                     "--max-fn-seconds", "120"], timeout=900)
        except subprocess.TimeoutExpired:
            p = None
            r["note"] = "kuna timeout"
        c_file = kdir / f"{name}.c"
        if p is not None and c_file.exists():
            handlers = find_handlers(c_file)
            if not handlers:
                r["note"] = "no DriverEntry MajorFunction stores found"
            else:
                r["entry"] = ", ".join(h["entry"] for h in handlers)
                pick = next((h for h in handlers if h["ioctl"]), handlers[0])
                r["handler"] = pick["ioctl"] or ""
                r["stores"] = ", ".join(f"0x{d:x}={n}" for d, n in pick["stores"])
        else:
            if not r["note"]:
                r["note"] = "kuna fail: " + (p.stderr or "")[:200] if p is not None else "kuna fail"
        # 2) device names
        try:
            s = run([KUNA, "strings", path, "--encoding", "all", "--json",
                     r"--filter", r"(?i)\\(device|dosdevices|\?\?)\\"], timeout=120)
            if s.returncode == 0:
                j = json.loads(s.stdout)
                r["devices"] = [x["text"] for x in j.get("strings", [])]
        except Exception as e:
            r["note"] += f" strings: {e}"

        # 3) specscout
        jout = AN / "specscout" / f"{name}.json"
        jout.parent.mkdir(exist_ok=True)
        args = [SPEC, path, "--driver"]
        if r["handler"].startswith("sub_"):
            args += ["--function", "0x" + r["handler"][4:]]
        args += ["--json", str(jout)]
        try:
            sp = run(args, timeout=1800)
            r["specscout_rc"] = sp.returncode
            if jout.exists():
                j = json.loads(jout.read_text(encoding="utf-8"))
                r["findings"] = [{"kind": f.get("kind"), "function": f.get("function"),
                                  "guard": f.get("guard"), "guard_text": f.get("guard_text"),
                                  "sink": f.get("sink"), "confidence": f.get("confidence")}
                                 for f in j.get("findings", [])]
            else:
                r["note"] += " specscout: no json (" + (sp.stderr or "")[:200] + ")"
        except Exception as e:
            r["note"] += f" specscout err: {e}"
        report.append(r)
        print(f"handler={r['handler'] or '-':>14}  findings={len(r['findings'])}  "
              f"devices={len(r['devices'])}" + (f"  [{r['note']}]" if r["note"] else ""))

    (AN / "sweep_results.json").write_text(json.dumps(report, indent=1), encoding="utf-8")
    # console summary
    print("\n" + "=" * 80)
    hits = [r for r in report if r["findings"]]
    print(f"drivers swept: {len(report)}   drivers with findings: {len(hits)}")
    for r in hits:
        print(f"\n=== {r['driver']} ===   handler: {r['handler']}   devices: {'; '.join(r['devices'])}")
        for f in r["findings"]:
            print(f"  {f['kind']}  conf={f['confidence']}  fn={f['function']}  "
                  f"guard={f['guard']}({f['guard_text']})  sink={f['sink']}")
    if not hits:
        print("  (none)")
    print("\nfull report ->", AN / "sweep_results.json")

if __name__ == "__main__":
    main()
