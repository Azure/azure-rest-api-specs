import crypto from "node:crypto";

type JsonValue = import("./runtime-types.ts").JsonValue;

function canonicalValue(value: unknown, stack: Set<object>): JsonValue {
  if (value === null || typeof value === "string" || typeof value === "boolean") return value;
  if (typeof value === "number") {
    if (!Number.isFinite(value))
      throw new TypeError("Canonical JSON does not support non-finite numbers.");
    return value === 0 ? 0 : value;
  }
  if (Array.isArray(value)) {
    if (stack.has(value)) throw new TypeError("Canonical JSON does not support cyclic values.");
    stack.add(value);
    const items = value as unknown[];

    const result: JsonValue[] = items.map((item) =>
      item === undefined || typeof item === "function" || typeof item === "symbol"
        ? null
        : canonicalValue(item, stack),
    );
    stack.delete(value);
    return result;
  }
  if (typeof value === "object") {
    if (stack.has(value)) throw new TypeError("Canonical JSON does not support cyclic values.");
    stack.add(value);

    const result: {
      [key: string]: JsonValue;
    } = {};
    const objectValue = value as Record<string, unknown>;
    for (const key of Object.keys(objectValue).sort()) {
      const item = objectValue[key];
      if (item === undefined || typeof item === "function" || typeof item === "symbol") continue;
      result[key] = canonicalValue(item, stack);
    }
    stack.delete(value);
    return result;
  }
  throw new TypeError(`Canonical JSON does not support ${typeof value} values.`);
}

export function canonicalJson(value: unknown): string {
  return JSON.stringify(canonicalValue(value, new Set()));
}

export function stableId(prefix: string, value: unknown, length: number = 16): string {
  if (!/^[a-z][a-z0-9-]*$/.test(prefix)) {
    throw new TypeError(`Invalid stable ID prefix: ${prefix}`);
  }
  if (!Number.isInteger(length) || length < 8 || length > 64) {
    throw new TypeError(`Invalid stable ID length: ${length}`);
  }
  const digest = crypto.createHash("sha256").update(canonicalJson(value)).digest("hex");
  return `${prefix}-${digest.slice(0, length)}`;
}

export function compareCanonical(left: unknown, right: unknown): number {
  return canonicalJson(left).localeCompare(canonicalJson(right));
}

export function sortCanonical<T>(values: T[]): T[] {
  return [...values].sort(compareCanonical);
}

export const canonicalStringify = canonicalJson;
export const contentId = stableId;
