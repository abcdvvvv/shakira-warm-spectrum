# Python highlight demo
from dataclasses import dataclass
from typing import Any
import re, json, math

HEX = 0xDEADBEEF; SCI = 6.022e23; Z = 2 + 3j

@dataclass(frozen=True)
class Foo: x: float; tag: str = "warm"

def clamp01(x: float) -> float: return 0.0 if x < 0 else 1.0 if x > 1 else x
def parse_kv(s: str) -> dict[str, Any]:
    m = re.match(r"^\s*(\w+)\s*=\s*([-+]?\d+(\.\d+)?(e[-+]?\d+)?)\s*$", s, re.I)
    if not m: raise ValueError(f"bad: {s!r}")
    return {"name": m.group(1), "val": float(m.group(2))}

items = [Foo(i/2, "hot" if i % 2 else "cold") for i in range(1, 6)]
data = {"items": [f.__dict__ for f in items],
        "nums": [1, 2.0, 3_000, 1e-9, HEX, Z, math.inf, math.nan]}
print(f"tag={items[0].tag} sci={SCI:.2e} hex={HEX:#x}")
try: print(parse_kv("alpha=1.23e-4"), clamp01(2.5))
except Exception as e: print(type(e).__name__, e)
print(json.dumps(data, indent=2, default=str))
