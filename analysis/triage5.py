#!/usr/bin/env python3
"""Find DriverEntry -> MajorFunction setup in globmerger.sys and osfdisk.sys (unknown publishers)."""
import re
from pathlib import Path

AN = Path(r"A:\MyProgramming\C++\SpecScout\analysis\kuna")

def blocks_of(drv):
    t = (AN / drv / (drv + ".c")).read_text(errors="replace")
    return [(m.group(1), m.group(2), m.group(3))
            for m in re.finditer(r"// Function: (\S+) @ 0x([0-9a-f]+)\n(.*?)(?=\n// Function: |\Z)", t, re.S)]

for drv in ["globmerger.sys", "osfdisk.sys"]:
    print("=" * 70, "\n" + drv)
    bl = blocks_of(drv)
    # blocks that touch IoCreateDevice or dispatch-ish APIs
    for name, va, body in bl:
        apis = set(re.findall(r"\b(IoCreateDevice|IoCreateSymbolicLink|IoCreateDeviceSecure|NdisMRegisterMiniportDriver|NdisWdf|WdfDriverCreate)\b", body))
        if not apis:
            continue
        stores = re.findall(r"\+ 0x([0-9a-fA-F]+)\) = (sub_[0-9a-f]+)\s*;", body)
        stores = [(d, f) for d, f in stores if 0x60 <= int(d, 16) <= 0x158]
        print(f"  {name} @ 0x{va}  apis={sorted(apis)}  fn-stores={[(hex(int(d,16)), f) for d, f in stores]}")
        for ln in body.splitlines():
            if apis & {"IoCreateDevice"} and re.search(r"RtlInitUnicodeString|\\Device|\\DosDevices|\\?\?\\", ln):
                print("      ", ln.strip()[:160])
