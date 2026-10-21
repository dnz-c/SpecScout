#!/usr/bin/env python3
"""veracrypt dispatch hunting + KMDF categorization of remaining drivers."""
import re
from pathlib import Path

AN = Path(r"A:\MyProgramming\C++\SpecScout\analysis\kuna")

# --- veracrypt: find blocks calling IoCreateDevice / holding MajorFunction stores
vc = (AN / "veracrypt.sys" / "veracrypt.sys.c").read_text(errors="replace")
for m in re.finditer(r"// Function: (\S+) @ 0x([0-9a-f]+)\n(.*?)(?=\n// Function: |\Z)", vc, re.S):
    name, va, body = m.group(1), m.group(2), m.group(3)
    hits = []
    if "IoCreateDevice" in body:
        hits.append("IoCreateDevice")
    if re.search(r"\+ v[0-9a-f]+\*\s*8\)|\+ \(v[0-9a-f]+ << 3\)", body):
        hits.append("reg-indexed store")
    if hits:
        print(f"veracrypt: {name} @ 0x{va}: {hits}")
        # print the store lines with context
        for ln in body.splitlines():
            if re.search(r"\+ 0x[0-9a-f]+\) = |IoCreateDevice|MajorFunction|<< 3", ln):
                print("   ", ln.strip()[:160])

# --- categorize remaining 'no stores' drivers as WDF or not
for drv in ["rt25cx21x64.sys", "iaLPSS2_I2C_ADL.sys", "mullvad-split-tunnel.sys",
            "TeeDriverW10x64.sys", "iaLPSS2_GPIO2_ADL.sys", "amdfendrmgr.sys",
            "amdxe.sys", "SteamStreamingMicrophone.sys", "VMNET.SYS"]:
    p = AN / drv / (drv + ".c")
    t = p.read_text(errors="replace")
    wdf = len(re.findall(r"Wdf\w+", t))
    evt = len(re.findall(r"EvtIo\w+|WDF_IO_QUEUE|WdfIoQueueCreate", t))
    print(f"{drv:30} Wdf-api-hits={wdf:4}  queue/evt-hits={evt:3}  blocks={t.count('// Function:')}")
