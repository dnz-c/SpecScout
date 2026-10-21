#!/usr/bin/env python3
import json
data = json.loads((Path := __import__("pathlib").Path(r"A:\MyProgramming\C++\SpecScout\analysis\sweep_results.json")).read_text(encoding="utf-8-sig"))
for r in data:
    note = r.get("note", "")
    if note:
        print(f"{r['driver']:30} {note[:130]}")
print("--- drivers with resolved handlers scanned:")
for r in data:
    if r.get("handler"):
        print(f"{r['driver']:30} handler={r['handler']}")
