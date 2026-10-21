#!/usr/bin/env python3
import re
from pathlib import Path

AN = Path(r"A:\MyProgramming\C++\SpecScout\analysis\kuna")

def block(drv, fname):
    t = (AN / drv / (drv + ".c")).read_text(errors="replace")
    m = re.search(rf"// Function: {re.escape(fname)} @ 0x([0-9a-f]+)\n(.*?)(?=\n// Function: |\Z)", t, re.S)
    return m.group(2) if m else None

def follow(drv, chain, maxlines=48):
    print("=" * 76)
    print(drv, "chain:", " -> ".join(chain))
    for f in chain:
        body = block(drv, f)
        if body is None:
            print(f"  {f}: <not found>")
            continue
        calls = list(dict.fromkeys(re.findall(r"\b(sub_\w+|Io\w+|Ndis\w+|Wdf\w+|Rtl\w+)\(", body)))[:16]
        stores = [(d, v) for d, v in re.findall(r"\+ (0x[0-9a-fA-F]+)\) = ([^;]+);", body)
                  if 0x60 <= int(d, 16) <= 0x158]
        devs = [ln.strip()[:120] for ln in body.splitlines() if re.search(r'L"\\\\(?:Device|DosDevices|\?\?)', ln)]
        print(f"  --- {f}: calls={calls}")
        for d, v in stores:
            print(f"      store {d} = {v[:60]}")
        for d in devs:
            print(f"      dev: {d}")

follow("globmerger.sys", ["sub_14000ce90"])
follow("osfdisk.sys", ["sub_14020019c"])
follow("VMNET.SYS", ["sub_18000902c"])
follow("SteamStreamingSpeakers.sys", ["sub_14000a010"])
