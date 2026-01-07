// theme-test.js
/* JS: prototypes, function forms, classes, async, destructuring, nullish, optional chaining */

export const PI = 3.14159;
export const now = () => new Date();

export function add(a, b = 0) { return a + b }
export async function main() {
  const user = { name: "Ada", meta: { tags: ["js", "theme"] } };

  const { name, meta: { tags } } = user;
  const first = tags?.[0] ?? "none";

  const msg = `Hello, ${name}! first=${first}`;
  const ok = /hello/i.test(msg);

  const arr = [1, 2, 3].map(n => n * 2);
  const obj = Object.freeze({ arr, ok });

  console.log(obj);
  return obj;
}

class Person {
  constructor(name) { this.name = name }
  greet() { return `hi ${this.name}` }
}
Person.prototype.kind = "human";
