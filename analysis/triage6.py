#!/usr/bin/env python3
"""Inspect globmerger/osfdisk exports: entry point, stores with any RHS, untyped calls."""
import re, json
from pathlib import Path

AN = Path(r"A:\MyProgramming\C++\SpecScout\analysis\kuna")
for drv in ["globmerger.sys", "osfdisk.sys", "SteamStreamingSpeakers.sys", "VMNET.SYS"]:
    kdir = AN / drv
    readme = kdir / "README.md"
    print("=" * 70)
    print(drv)
    if readme.exists():
        for ln in readme.read_text(errors="replace").splitlines():
            if re.search(r"functions|entry|success|fail", ln, re.I):
                print("  ", ln.strip()[:180])
    c = kdir / (drv + ".c")
    t = c.read_text(errors="replace")
    # stores into a0/a1 at MajorFunction offsets, ANY rhs
    for m in re.finditer(r"// Function: (\S+) @ 0x([0-9a-f]+)\n(.*?)(?=\n// Function: |\Z)", t, re.S):
        name, va, body = m.group(1), m.group(2), m.group(3)
        hits = re.findall(r"\+ 0x(6[0-9a-fA-F]|7[0-9a-fA-F]|[89a-fA-F][0-9a-fA-F]|1[0-5][0-9a-fA-F])\) = ([^;]+)", body)
        if hits and name == "sub_" + va:  # unnamed = likely entry when imagebase 0? just report all
            pass
    # DriverEntry candidates: blocks referencing IoCreateDevice via raw import (unresolved) — search strings
    ioc = len(re.findall(r"IoCreateDevice|IoCreateSymbolicLink", t))
    undecl = len(re.findall(r"\\x[0-9a-f]{2}\\x[0-9a-f]{2}", t))
    print(f"   IoCreateDevice refs: {ioc}")
