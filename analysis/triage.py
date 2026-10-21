#!/usr/bin/env python3
"""Triage drivers whose dispatch setup wasn't a plain constant store:
find register-displaced MajorFunction stores and fn-pointer arrays in the kuna export."""
import re
from pathlib import Path

AN = Path(r"A:\MyProgramming\C++\SpecScout\analysis\kuna")
DRIVERS = ["veracrypt.sys", "AtihdWT6.sys", "RTKVHD64.sys", "rt25cx21x64.sys",
           "iaLPSS2_I2C_ADL.sys", "mullvad-split-tunnel.sys", "TeeDriverW10x64.sys",
           "iaLPSS2_GPIO2_ADL.sys", "amdfendrmgr.sys", "amdxe.sys",
           "SteamStreamingMicrophone.sys", "VMNET.SYS"]

STORE_CONST = re.compile(r"\+ 0x([0-9a-fA-F]+)\) = (sub_[0-9a-f]+)\s*;")   # const-disp fn-ptr store
STORE_REG   = re.compile(r"\+ (v[0-9a-f]+)\) = (sub_[0-9a-f]+)\s*;")       # reg-disp fn-ptr store

for drv in DRIVERS:
    p = AN / drv / (drv + ".c")
    if not p.exists():
        print(f"{drv:30} <no export>")
        continue
    t = p.read_text(errors="replace")
    # per-block: capture const + reg-displaced fn-ptr stores
    blocks = []
    for m in re.finditer(r"// Function: (\S+) @ 0x([0-9a-f]+)\n(.*?)(?=\n// Function: |\Z)", t, re.S):
        name, va, body = m.group(1), m.group(2), m.group(3)
        const = [(int(d, 16), f) for d, f in STORE_CONST.findall(body) if 0x60 <= int(d, 16) <= 0x158]
        reg = STORE_REG.findall(body)
        blocks.append((name, va, const, reg))
    with_const = [b for b in blocks if len(b[2]) >= 2]
    with_reg  = [b for b in blocks if b[3]]
    line = f"{drv:30} const-disp blocks={len(with_const)}"
    if with_const:
        name, va, const, _ = max(with_const, key=lambda b: len(b[2]))
        line += f"  e.g. {name}@0x{va} stores={[(hex(d), f) for d, f in const][:8]}"
    line += f"   reg-disp blocks={len(with_reg)}"
    if with_reg:
        name, va, _, reg = with_reg[0]
        line += f"  e.g. {name}@0x{va} targets={[f for _, f in reg][:5]}"
    print(line)
