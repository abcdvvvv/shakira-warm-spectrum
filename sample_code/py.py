from __future__ import annotations
from dataclasses import dataclass
from typing import Any, Iterable
import re, math, json

HEX = 0xDEADBEEF
SCI = 6.022e23
COMPLEX = 2 + 3j

@dataclass(frozen=True)
class Foo:
    x: float
    tag: str = "warm"

def clamp01(x: float) -> float:
    return 0.0 if x < 0 else 1.0 if x > 1 else float(x)

def parse_kv(line: str) -> dict[str, Any]:
    m = re.match(r"^\s*(\w+)\s*=\s*([-+]?\d+(\.\d+)?(e[-+]?\d+)?)\s*$", line, re.I)
    if not m:
        raise ValueError(f"bad line: {line!r}")
    return {"name": m.group(1), "val": float(m.group(2))}

async def main() -> None:
    items = [Foo(i / 2, tag=("hot" if i % 2 else "cold")) for i in range(1, 6)]
    nums = [1, 2.0, 3_000, 1e-9, HEX, COMPLEX, math.inf, math.nan]
    data = {"items": [f.__dict__ for f in items], "nums": nums, "ok": True, "none": None}
    text = f"tag={items[0].tag}, x={items[0].x:.3f}, sci={SCI:.2e}, hex={HEX:#x}"
    print(text)
    print(json.dumps(data, indent=2, default=str))
    try:
        kv = parse_kv("alpha=1.23e-4")
        print(kv, clamp01(kv["val"] * 1e5))
    except Exception as e:
        print("caught:", type(e).__name__, e)
    finally:
        pass

if __name__ == "__main__":
    import asyncio
    asyncio.run(main())
