#!/usr/bin/env python3
"""igdkmdn64.sys: read AddressOfEntryPoint from PE header, kuna-decompile that block,
then follow one level for the MajorFunction stores."""
import re, struct, subprocess, json
from pathlib import Path

SYS = r"C:\WINDOWS\System32\DriverStore\FileRepository\iigd_dch.inf_amd64_b57fc4f35ff4051b\igdkmdn64.sys"
data = open(SYS, "rb").read(4096)
e_lfanew = struct.unpack_from("<I", data, 0x3C)[0]
opt = e_lfanew + 0x18
image_base = struct.unpack_from("<Q", data, opt + 0x18)[0]
aoe_rva = struct.unpack_from("<I", data, e_lfanew + 0x18 + 0x10)[0]  # AddressOfEntryPoint in optional header
# sections to map rva->file off
nsec = struct.unpack_from("<H", data, e_lfanew + 6)[0]
opt_size = struct.unpack_from("<H", data, e_lfanew + 20)[0]
sec_off = e_lfanew + 24 + opt_size
rva = aoe_rva
foff = None
for i in range(nsec):
    s = sec_off + i * 40
    name = data[s:s+8].rstrip(b"\0").decode()
    va, raw, vsize = struct.unpack_from("<I", data, s+12)[0], struct.unpack_from("<I", data, s+20)[0], struct.unpack_from("<I", data, s+8)[0]
    if va <= rva < va + max(vsize, raw):
        foff = raw + (rva - va)
        break
print(f"ImageBase=0x{image_base:x} EntryRVA=0x{aoe_rva:x} -> EntryVA=0x{image_base+aoe_rva:x} file-off=0x{foff:x}")

out = subprocess.run(["kuna", "decompile", SYS, hex(image_base + aoe_rva), "--addr"],
                     capture_output=True, text=True, errors="replace")
print((out.stdout or out.stderr)[:3000])
