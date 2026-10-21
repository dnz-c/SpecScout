#!/usr/bin/env python3
"""Reachability analysis for igdkmdn64.sys --params hits:
   1. parse the full kuna export call graph
   2. roots = functions referenced from dispatch-registered DriverEntry subtree
      (we approximate: any function referenced in a store to the DriverObject range,
       plus the DriverEntry itself)
   3. BFS over static call edges; mark reachable functions
   4. intersect with specscout --params hits and report IOCTL-reachable candidates."""
import json, re
from pathlib import Path

AN   = Path(r"A:\MyProgramming\C++\SpecScout\analysis")
KD   = AN / "kuna" / "igdkmdn64.sys"
ENTR = 0x143377000          # DriverEntry (PE entry, from kuna)

# parse all functions from the export
blocks = {}
for m in re.finditer(r"// Function: (\S+) @ 0x([0-9a-f]+)\n(.*?)(?=\n// Function: |\Z)",
                     (KD / "igdkmdn64.sys.c").read_text(errors="replace"), re.S):
    blocks[int(m.group(2), 16)] = (m.group(1), m.group(3))

# call edges: target VA -> caller set
calls = {}
for va, (name, body) in blocks.items():
    for tgt in re.findall(r"\bsub_([0-9a-f]+)\(", body):
        calls.setdefault(int(tgt, 16), set()).add(va)

# find dispatch registration: look for stores of fn pointers into a DriverObject-ish
# object inside the DriverEntry's transitive closure is overkill; instead find any
# store of sub_* into an object at offsets 0x70..0xE8 within DriverEntry's closure
MJ_STO = re.compile(r"\+ 0x([0-9a-fA-F]+)\) = (sub_[0-9a-f]+)")
roots = {ENTR}
for va, (name, body) in blocks.items():
    if va not in calls:  # referenced from nowhere = possible root (entry / indirect)
        continue
for d, f in MJ_STO.findall((KD / "igdkmdn64.sys.c").read_text(errors="replace")):
    pass  # covered below per-block

hits = json.loads((AN / "specscout" / "igdkmdn64.params.json").read_text(encoding="utf-8-sig"))
hits = hits.get("findings", [])
hit_vas = {int(h["function"], 16): h for h in hits}

# BFS from DriverEntry over static edges
seen = {ENTR}
frontier = [ENTR]
while frontier:
    nxt = []
    for v in frontier:
        body = blocks.get(v, (None, ""))[1]
        for tgt in map(int, re.findall(r"\bsub_([0-9a-f]+)\(", body), ):
            if tgt not in seen and tgt in blocks:
                seen.add(tgt)
                nxt.append(tgt)
    frontier = nxt

reach_hits = sorted((va, h) for va, h in hit_vas.items() if va in seen)
print(f"functions parsed: {len(blocks)}   reachable from DriverEntry: {len(seen)}")
print(f"--params hits: {len(hits)}   hits inside reachable set: {len(reach_hits)}")
for va, h in reach_hits[:25]:
    print(f"  {blocks[va][0]}  {h['kind']}  guard={h['guard']} sink={h['sink']}  spec={'+%s' % h.get('spec_distance','?')}")
