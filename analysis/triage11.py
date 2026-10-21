#!/usr/bin/env python3
import re, subprocess

SYS = r"C:\WINDOWS\System32\DriverStore\FileRepository\iigd_dch.inf_amd64_b57fc4f35ff4051b\igdkmdn64.sys"
out = subprocess.run(["kuna", "decompile", SYS, "0x143377000", "--addr"],
                     capture_output=True, text=True, errors="replace")
print("rc:", out.returncode, "len:", len(out.stdout))
body = out.stdout
# find the DriverEntry-looking stores
for m in re.finditer(r"\+ (0x[0-9a-fA-F]+)\) = (\S+?);", body):
    d = int(m.group(1), 16)
    if 0x60 <= d <= 0x158:
        print(f"  store {hex(d)} -> {m.group(2)[:70]}")
print(body[:200], "...")
# else search for stores in array-index form
for m in re.finditer(r"\(\(long long \*\)a0\)\[0x([0-9a-fA-F]+)\] = (\S+?);", body):
    d = int(m.group(1), 16) * 8
    if 0x60 <= d <= 0x158:
        print(f"  idx-store {hex(d)} -> {m.group(2)[:70]}")
