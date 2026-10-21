#!/usr/bin/env python3
"""Direct intersection: --params hit VAs vs all functions referenced from igdkmdn DriverEntry."""
import json, re, subprocess
from pathlib import Path

SYS = r"C:\WINDOWS\System32\DriverStore\FileRepository\iigd_dch.inf_amd64_b57fc4f35ff4051b\igdkmdn64.sys"
out = subprocess.run(["kuna", "decompile", SYS, "0x143377000", "--addr"],
                     capture_output=True, text=True, errors="replace", timeout=300)
body = out.stdout

refs = {int(x, 16) for x in re.findall(r"\bsub_([0-9a-f]+)\(", body)}
hits = json.loads(Path(r"A:\MyProgramming\C++\SpecScout\analysis\specscout\igdkmdn64.params.json")
                  .read_text(encoding="utf-8-sig"))
fnd = hits.get("findings", [])
print(f"hits: {len(fnd)}   DriverEntry-referenced functions: {len(refs)}")
direct = [h for h in fnd if int(h["function"], 16) in refs]
print(f"direct DriverEntry-table hits: {len(direct)}")
for h in direct[:20]:
    print(f"  {h['function']}  {h['kind']}  guard={h['guard']} sink={h['sink']}  {h.get('guard_text','')}")
