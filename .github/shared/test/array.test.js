// @ts-check

import { describe, expect, it } from "vitest";
import { filterAsync } from "../src/array.js";

describe("filterAsync", () => {
  it("filters items based on async predicate", async () => {
    const input = [1, 2, 3, 4, 5, 6];

    const result = await filterAsync(input, async (item, index) => {
      return item % 2 === 0 || index % 3 === 0;
    });

    expect(result).toEqual([1, 2, 4, 6]);
  });

  it("works with empty array", async () => {
    const result = await filterAsync([], async () => true);
    expect(result).toEqual([]);
  });
});
