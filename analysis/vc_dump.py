#!/usr/bin/env python3
"""Dump the rest of veracrypt's dispatch + any 0x2220xx constants."""
import re
from pathlib import Path

t = Path(r"A:\MyProgramming\C++\SpecScout\analysis\kuna\veracrypt.sys\veracrypt.sys.c").read_text(errors="replace")
m = re.search(r"// Function: sub_1400534e0 @ 0x1400534e0\n(.*?)(?=\n// Function: |\Z)", t, re.S)
body = m.group(1)
print("block size:", len(body))
# tail
print(body[3500:7000])
