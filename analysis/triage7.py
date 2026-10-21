#!/usr/bin/env python3
import re
from pathlib import Path

AN = Path(r"A:\MyProgramming\C++\SpecScout\analysis\kuna")
ENTRY = {"globmerger.sys": "0x14001d010", "osfdisk.sys": "0x140200170",
         "VMNET.SYS": "0x180009000", "SteamStreamingSpeakers.sys": "0x140001184"}

for drv, ep in ENTRY.items():
    t = (AN / drv / (drv + ".c")).read_text(errors="replace")
    m = re.search(rf"// Function: (\S+) @ {ep}\n(.*?)(?=\n// Function: |\Z)", t, re.S)
    print("=" * 76)
    print(drv, "-> entry block:", m.group(1) if m else f"NOT FOUND at {ep}")
    if m:
        body = m.group(2)
        # summarize calls and stores
        calls = list(dict.fromkeys(re.findall(r"\b(sub_\w+|Io\w+|Ndis\w+|Wdf\w+|Rtl\w+)\(", body)))[:14]
        stores = re.findall(r"\+ (0x[0-9a-fA-F]+)\) = ([^;]+);", body)
        stores = [(d, v[:40]) for d, v in stores if 0x60 <= int(d, 16) <= 0x158]
        print("  calls:", ", ".join(calls))
        print("  MJ-range stores:", [(d, v) for d, v in stores])
        # device names in body
        for ln in body.splitlines():
            if re.search(r"L\"\\\\(Device|DosDevices|\?\?)", ln):
                print("   dev:", ln.strip()[:150])
