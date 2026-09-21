import assert from "node:assert/strict";
import test from "node:test";
import { canonicalJson, stableId } from "./stable-id.mjs";

test("canonical JSON and IDs are independent of object key order", () => {
  assert.equal(canonicalJson({ b: 2, a: { d: 4, c: 3 } }), '{"a":{"c":3,"d":4},"b":2}');
  assert.equal(stableId("fact", { b: 2, a: 1 }), stableId("fact", { a: 1, b: 2 }));
});

test("canonical JSON rejects cycles and non-finite numbers", () => {
  const cyclic = {};
  cyclic.self = cyclic;
  assert.throws(() => canonicalJson(cyclic), /cyclic/);
  assert.throws(() => canonicalJson({ value: Number.NaN }), /non-finite/);
});
