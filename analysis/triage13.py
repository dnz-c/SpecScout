#!/usr/bin/env python3
import re, subprocess

SYS = r"C:\WINDOWS\System32\DriverStore\FileRepository\iigd_dch.inf_amd64_b57fc4f35ff4051b\igdkmdn64.sys"
for addr in ["0x140361f7c", "0x140013f60", "0x1402709b0", "0x140009b10"]:
    out = subprocess.run(["kuna", "decompile", SYS, addr, "--addr"],
                         capture_output=True, text=True, errors="replace", timeout=300)
    body = out.stdout
    found = []
    for m in re.finditer(r"\+ (0x[0-9a-fA-F]+)\) = (\S+?);", body):
        d = int(m.group(1), 16)
        if 0x60 <= d <= 0x158:
            found.append((hex(d), m.group(2)[:50]))
    print(f"{addr}: rc={out.returncode} block={len(body)}B  MJ-stores={found[:8] if found else '-'}")
    if found:
        open(rf"A:\MyProgramming\C++\SpecScout\analysis\kuna\igd_{addr[2:]}.c", "w").write(body)
