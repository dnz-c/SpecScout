#!/usr/bin/env python3
import re
import subprocess

SYS = r"C:\WINDOWS\System32\DriverStore\FileRepository\iigd_dch.inf_amd64_b57fc4f35ff4051b\igdkmdn64.sys"
out = subprocess.run(["kuna", "decompile", SYS, "0x143377000", "--addr"],
                     capture_output=True, text=True, errors="replace")
body = out.stdout
# any line storing through a0 at ANY offset or via array index
for ln in body.splitlines():
    if re.search(r"a0\s*\+|a0\[|\(a0|0x70\)|0xe0\)|0xe8\)|0xf0\)|memcpy|Copy", ln):
        print(ln.strip()[:180])
