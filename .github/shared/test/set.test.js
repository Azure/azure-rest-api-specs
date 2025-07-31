// @ts-check

import { describe, expect, it } from "vitest";
import { intersect } from "../src/set";

describe("set", () => {
  it.each([
    [[], [], []],
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
      /** @type {(string|number)[]} */ setA,
      /** @type {(string|number)[]} */ setB,
      /** @type {(string|number)[]} */ result,
    ) => {
      expect(intersect(new Set(setA), new Set(setB))).toEqual(new Set(result));
    },
  );
});
