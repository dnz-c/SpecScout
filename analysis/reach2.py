#!/usr/bin/env python3
"""Re-run specscout --params on igdkmdn64 with proper output capture, then reachability BFS."""
import json, re, subprocess
from pathlib import Path

AN = Path(r"A:\MyProgramming\C++\SpecScout\analysis")
KD = AN / "kuna" / "igdkmdn64.sys"
ENTR = 0x143377000  # DriverEntry VA (PE entry point)

# --- specscout --params (full run, no truncation)
pj = AN / "specscout" / "igdkmdn64.params.json"
p = subprocess.run([r"A:\MyProgramming\C++\SpecScout\build\Release\specscout.exe",
                    r"C:\WINDOWS\System32\DriverStore\FileRepository\iigd_dch.inf_amd64_b57fc4f35ff4051b\igdkmdn64.sys",
                    "--json", str(pj), "--params", "--max-funcs", "3000"],
                   capture_output=True, text=True, errors="replace", timeout=3600)
print("specscout rc:", p.returncode, "| wrote json:", pj.exists())
hits = json.loads(pj.read_text(encoding="utf-8-sig"))
fnd = hits.get("findings", [])
print("findings:", len(fnd))

# --- parse call graph from kuna export
txt = (KD / "igdkmdn64.sys.c").read_text(errors="replace")
blocks = {}
for m in re.finditer(r"// Function: (\S+) @ 0x([0-9a-f]+)\n(.*?)(?=\n// Function: |\Z)", txt, re.S):
    blocks[int(m.group(2), 16)] = (m.group(1), m.group(3))
print("functions in export:", len(blocks))

# direct references (calls AND address-taken) from DriverEntry
droots = {int(x, 16) for x in re.findall(r"\bsub_([0-9a-f]+)\(", blocks[ENTR][1])}

# BFS over direct calls from every root
seen = set(droots) | {ENTR}
frontier = list(droots) + [ENTR]
while frontier:
    nxt = []
    for v in frontier:
        for tgt in [int(x, 16) for x in re.findall(r"\bsub_([0-9a-f]+)\(", blocks.get(v, (None, ""))[1] or "")]:
            if tgt not in seen and tgt in blocks:
                seen.add(tgt)
                nxt.append(tgt)
    frontier = nxt

direct_hits  = [h for h in fnd if int(h["function"], 16) in droots]
static_hits  = [h for h in fnd if int(h["function"], 16) in seen]
print(f"roots from DriverEntry: {len(droots)}   statically reachable fns: {len(seen)}")
print(f"hits: direct-table hits={len(direct_hits)}  BFS-reachable hits={len(static_hits)}")
for h in direct_hits[:15]:
    print(f"  DIRECT {h['function']}  {h['kind']}  guard={h['guard']} {h.get('guard_text','')}")
for h in static_hits[:15]:
    if h not in direct_hits:
        print(f"  REACH  {h['function']}  {h['kind']}  guard={h['guard']} {h.get('guard_text','')}")
