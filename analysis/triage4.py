#!/usr/bin/env python3
"""veracrypt: trace the init chain from DriverEntry and find the MajorFunction registration."""
import re
from pathlib import Path

AN = Path(r"A:\MyProgramming\C++\SpecScout\analysis\kuna")
t = (AN / "veracrypt.sys" / "veracrypt.sys.c").read_text(errors="replace")

blocks = {}
order = []
for m in re.finditer(r"// Function: (\S+) @ 0x([0-9a-f]+)\n(.*?)(?=\n// Function: |\Z)", t, re.S):
    name = m.group(1)
    blocks[name] = m.group(3)
    order.append(name)

# reverse xrefs: who calls sub_1400b61ec / sub_140053080 / sub_14004962c ?
targets = ["sub_1400b61ec", "sub_140053080", "sub_14004962c", "sub_140056a44", "sub_14004ebe4"]
for tgt in targets:
    callers = [n for n in order if n != tgt and tgt in blocks[n]]
    print(f"callers of {tgt}: {callers[:6]}")

# print any block containing a MajorFunction-range store with 'sub_' RHS anywhere
print("\n--- blocks with fn-ptr stores in 0x60..0x158 range:")
for name in order:
    body = blocks[name]
    stores = [(int(d, 16), f) for d, f in re.findall(r"\+ 0x([0-9a-fA-F]+)\) = (sub_[0-9a-f]+)\s*;", body)
              if 0x60 <= int(d, 16) <= 0x158]
    if stores:
        print(f"  {name}: {[(hex(d), f) for d, f in stores]}")
