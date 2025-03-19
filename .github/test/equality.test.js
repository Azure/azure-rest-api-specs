// @ts-check

import { describe, expect, it } from "vitest";
import { setEquals } from "../src/equality.js";

describe("equality", () => {
  // TODO: replace sets with arrays in inputs, add sets of size 2 and 3
  it.each([
    [null, null, false],
    [undefined, undefined, false],
    [null, undefined, false],
    [null, new Set(), false],
    [undefined, new Set(), false],
    [new Set(), new Set(), true],
    [new Set(), new Set([1]), false],
    [new Set([1]), new Set([1]), true],
    [new Set([1]), new Set([2]), false],
  ])("setEquals(%s, %s, %s)", (set1, set2, expected) => {
    // @ts-ignore
    expect(setEquals(set1, set2)).toBe(expected);
    // @ts-ignore
    expect(setEquals(set2, set1)).toBe(expected);
  });

  // TODO: Add more tests
});
