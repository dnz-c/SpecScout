#!/usr/bin/env python3
"""Locate DriverEntry & dispatch registration in veracrypt.sys and VMNET.SYS exports."""
import re
from pathlib import Path

AN = Path(r"A:\MyProgramming\C++\SpecScout\analysis\kuna")

def blocks_of(drv):
    t = (AN / drv / (drv + ".c")).read_text(errors="replace")
    return [(m.group(1), m.group(2), m.group(3))
            for m in re.finditer(r"// Function: (\S+) @ 0x([0-9a-f]+)\n(.*?)(?=\n// Function: |\Z)", t, re.S)]

STORE_ANY = re.compile(r"(\w+|\(\w+\*\))(\s*\*\s*)?\)?\s*\+\s*(0x[0-9a-fA-F]+|v[0-9a-f]+)\)?\s*=\s*(\w+)")

for drv in ["veracrypt.sys", "VMNET.SYS"]:
    print("=" * 70)
    print(drv)
    bl = blocks_of(drv)
    for name, va, body in bl:
        if not ({"IoCreateDevice", "IoCreateSymbolicLink"} & set(re.findall(r"\b(?:IoCreateDevice|IoCreateSymbolicLink)\b", body))):
            continue
        print(f"  --- candidate block {name} @ 0x{va}  (len {len(body)})")
        # any fn-pointer-looking store
        for ln in body.splitlines():
            if "sub_" in ln and ("= sub" in ln or "= &" in ln):
                print("    ", ln.strip()[:150])
        # calls it makes
        calls = re.findall(r"\b(sub_\w+|Io\w+|Rtl\w+|Ex\w+)\(", body)
        print("    calls:", ", ".join(dict.fromkeys(calls))[:300])
