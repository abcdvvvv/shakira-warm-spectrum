// theme-test.tsx
import React, { useMemo, useState } from "react";

type Props = { title?: string; count0?: number };

export function App({ title = "Theme Lab", count0 = 1 }: Props) {
  const [count, setCount] = useState<number>(count0);

  const doubled = useMemo(() => count * 2, [count]);
  const cls = count % 2 === 0 ? "even" : "odd";

  const onClick: React.MouseEventHandler<HTMLButtonElement> = (e) => {
    e.preventDefault();
    setCount((c) => c + 1);
  };

  return (
    <section className={`card ${cls}`} data-count={count}>
      <h1 aria-label="title">{title}</h1>

      <button onClick={onClick} disabled={count > 5}>
        count: {count} / doubled: {doubled}
      </button>

      <pre style={{ whiteSpace: "pre-wrap" }}>
        {JSON.stringify({ count, doubled }, null, 2)}
      </pre>
    </section>
  );
}
