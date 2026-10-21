#!/usr/bin/env python3
"""Show the decompiled region of CtiIo64's dispatch around the guard (0x13833) and sink (0x1386a)."""
import re
from pathlib import Path

t = Path(r"A:\MyProgramming\C++\SpecScout\analysis\kuna\CtiIo64.sys\CtiIo64.sys.c").read_text(errors="replace")
m = re.search(r"// Function: sub_13800 @ 0x13800\n(.*?)(?=\n// Function: |\Z)", t, re.S)
body = m.group(1)
lines = body.splitlines()
# find lines mentioning data table indexing / the suspicious constants
for i, ln in enumerate(lines):
    if re.search(r"0x8050|v\d+\[\w|>> 0x18|& 0xff|\*v\d+", ln):
        for j in range(max(0, i - 1), min(len(lines), i + 2)):
            print(f"{j:4}  {lines[j][:160]}")
        print("---")
