// @ts-check

import { describe, expect, it } from "vitest";
import { setEquals } from "../src/equality.js";

describe("equality", () => {
  it.each([
    // null and undefined are never equal to anything
    [null, null, false],
    [undefined, undefined, false],
    [null, undefined, false],
    [null, [], false],
    [undefined, [], false],
    // different lengths
    [[], [1], false],
    [[1], [1, 2], false],
    [[1, 2], [1, 2, 3], false],
    // different elements
    [[1], [2], false],
    [[1, 2], [1, 3], false],
    [[1, 2], [2, 3], false],
    [[1, 2, 3], [2, 3, 4], false],
    // sets with same elements, size >= 0
    [[], [], true],
    [[1], [1], true],
    [[1, 2], [1, 2], true],
    [[1, 2, 3], [1, 2, 3], true],
  ])("setEquals(%s, %s, %s)", (input1, input2, expected) => {
    const [set1, set2] = [input1, input2].map((input) =>
      input instanceof Array ? new Set(input) : input,
    );

    // @ts-ignore
    expect(setEquals(set1, set2)).toBe(expected);
    // @ts-ignore
    expect(setEquals(set2, set1)).toBe(expected);
  });
});
