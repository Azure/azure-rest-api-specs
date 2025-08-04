// @ts-check

import { describe, expect, it } from "vitest";
import { intersect } from "../src/set";

describe("set", () => {
  it.each([
    [[], [], []],
    [[1, 2, 3], [], []],
    [
      [1, 2, 3],
      [2, 3, 4],
      [2, 3],
    ],
    [[1, 2, 3], [4, 5, 6], []],
    [
      [1, 2, 3],
      [1, 2, 3],
      [1, 2, 3],
    ],
    [
      ["a", "b", "c"],
      ["b", "c", "d"],
      ["b", "c"],
    ],
  ])(
    "intersect(%o, %o, %o)",
    async (
      /** @type {(string|number)[]} */ a,
      /** @type {(string|number)[]} */ b,
      /** @type {(string|number)[]} */ result,
    ) => {
      const setA = new Set(a);
      const setB = new Set(b);
      const setResult = new Set(result);

      // Check both orders, result should be same
      expect(intersect(setA, setB)).toEqual(setResult);
      expect(intersect(setB, setA)).toEqual(setResult);
    },
  );
});
