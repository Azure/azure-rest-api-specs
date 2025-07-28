// @ts-check

import { describe, expect, it } from "vitest";
import { setEquals } from "../src/equality.js";

describe("equality", () => {
  it.each([
    // not instanceof Set: null, undefined
    [null, null, false],
    [undefined, undefined, false],
    [null, undefined, false],
    [null, [], false],
    [undefined, [], false],
    // not instanceof Set: number, string, object, array
    [1, 1, false],
    ["a", "a", false],
    [{}, {}, false],
    [[], [], false],
    // different lengths
    [new Set(), new Set([1]), false],
    [new Set([1]), new Set([1, 2]), false],
    [new Set([1, 2]), new Set([1, 2, 3]), false],
    // different elements
    [new Set([1]), new Set([2]), false],
    [new Set([1, 2]), new Set([1, 3]), false],
    [new Set([1, 2]), new Set([2, 3]), false],
    [new Set([1, 2, 3]), new Set([2, 3, 4]), false],
    // sets with same elements, size >= 0
    [new Set(), new Set(), true],
    [new Set([1]), new Set([1]), true],
    [new Set([1, 2]), new Set([1, 2]), true],
    [new Set([1, 2, 3]), new Set([1, 2, 3]), true],
  ])("setEquals(%s, %s, %s)", (set1, set2, expected) => {
    // @ts-expect-error testing runtime behavior of invalid types
    expect(setEquals(set1, set2)).toBe(expected);
    // @ts-expect-error testing runtime behavior of invalid types
    expect(setEquals(set2, set1)).toBe(expected);
  });
});
