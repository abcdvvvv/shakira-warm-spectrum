// theme-test.ts
/* Keywords, types, generics, unions, enums, decorators-ish, template literals */

export type ID = string | number;
export interface ApiResponse<T> { ok: boolean; data?: T; error?: Error }

export enum Mode { Dev = "dev", Prod = "prod" }

export const VERSION = 1n as const; // bigint + const
export const re = /^(?<name>[a-z_]\w*)$/giu; // regex + named group

export class Box<T extends { id: ID }> {
  readonly #cache = new Map<ID, T>(); // private field
  constructor(public mode: Mode = Mode.Dev) {}

  get(id: ID): T | undefined { return this.#cache.get(id) }

  set(item: T): this {
    this.#cache.set(item.id, item);
    return this;
  }

  async fetch(url: string): Promise<ApiResponse<T[]>> {
    const q = `${url}?mode=${this.mode}&v=${VERSION}`;
    try {
      const res = await fakeHttp<T[]>(q);
      return { ok: true, data: res ?? [] };
    } catch (e) {
      return { ok: false, error: e instanceof Error ? e : new Error(String(e)) };
    }
  }
}

export const tuple = [1, "x", true] as const;
export const obj = { a: 1, b: { c: 2 } } satisfies Record<string, unknown>;

function fakeHttp<T>(_url: string): Promise<T | null> {
  return Promise.resolve(null);
}

const add = (a: number, b: number) => a + b;
const squares = [1, 2, 3].map(n => n * n);
const onClick = (_e: Event) => { /* noop */ };
