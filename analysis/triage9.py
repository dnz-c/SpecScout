#!/usr/bin/env python3
import re
from pathlib import Path

AN = Path(r"A:\MyProgramming\C++\SpecScout\analysis\kuna")

def block(drv, fname):
    t = (AN / drv / (drv + ".c")).read_text(errors="replace")
    m = re.search(rf"// Function: {re.escape(fname)} @ 0x([0-9a-f]+)\n(.*?)(?=\n// Function: |\Z)", t, re.S)
    return m.group(2) if m else None

for drv, funcs in [("globmerger.sys", ["sub_14001d078", "sub_14000ed10"]),
                   ("osfdisk.sys", ["sub_140200170"]),
                   ("VMNET.SYS", ["sub_18000902c"]),
                   ("SteamStreamingSpeakers.sys", ["sub_14000a010"])]:
    print("=" * 76, "\n" + drv)
    for f in funcs:
        body = block(drv, f)
        print(f"--- {f} ({len(body) if body else 0} bytes)")
        if body:
            print(body[:2600])
