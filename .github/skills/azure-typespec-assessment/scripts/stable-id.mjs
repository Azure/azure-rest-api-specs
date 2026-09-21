import crypto from "node:crypto";

function canonicalValue(value, stack) {
  if (value === null || typeof value === "string" || typeof value === "boolean") return value;
  if (typeof value === "number") {
    if (!Number.isFinite(value)) throw new TypeError("Canonical JSON does not support non-finite numbers.");
    return Object.is(value, -0) ? 0 : value;
  }
  if (Array.isArray(value)) {
    if (stack.has(value)) throw new TypeError("Canonical JSON does not support cyclic values.");
    stack.add(value);
    const result = value.map((item) =>
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
    const result = {};
    for (const key of Object.keys(value).sort()) {
      const item = value[key];
      if (item === undefined || typeof item === "function" || typeof item === "symbol") continue;
      result[key] = canonicalValue(item, stack);
    }
    stack.delete(value);
    return result;
  }
  throw new TypeError(`Canonical JSON does not support ${typeof value} values.`);
}

export function canonicalJson(value) {
  return JSON.stringify(canonicalValue(value, new Set()));
}

export function stableId(prefix, value, length = 16) {
  if (!/^[a-z][a-z0-9-]*$/.test(prefix)) {
    throw new TypeError(`Invalid stable ID prefix: ${prefix}`);
  }
  if (!Number.isInteger(length) || length < 8 || length > 64) {
    throw new TypeError(`Invalid stable ID length: ${length}`);
  }
  const digest = crypto.createHash("sha256").update(canonicalJson(value)).digest("hex");
  return `${prefix}-${digest.slice(0, length)}`;
}

export function compareCanonical(left, right) {
  return canonicalJson(left).localeCompare(canonicalJson(right));
}

export function sortCanonical(values) {
  return [...values].sort(compareCanonical);
}

export const canonicalStringify = canonicalJson;
export const contentId = stableId;
