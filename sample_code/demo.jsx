// theme-test.jsx
import React, { useEffect, useRef } from "react";

export default function Widget({ items = ["a", "b", "c"] }) {
  const boxRef = useRef(null);

  useEffect(() => {
    const el = boxRef.current;
    if (!el) return;
    el.dataset.ready = "true";
  }, []);

  return (
    <div ref={boxRef} className="widget" role="region">
      <ul>
        {items.map((x, i) => (
          <li key={`${x}-${i}`} title="item">
            {x.toUpperCase()}
          </li>
        ))}
      </ul>
    </div>
  );
}
