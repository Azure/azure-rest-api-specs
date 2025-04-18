// @ts-check

import { describe, expect, it } from "vitest";
import { byDate, invert } from "../src/sort.js";

describe("byDate", () => {
  // Test "undefined in input" and "undefined returned from getDate()" separately,
  // since JS array.sort() special-cases "undefined in input" to always sort
  // to the end of the array, without even passing it to the comparator.
  const input = [
    "2025-01-01",
    null,
    "2023-01-01",
    undefined,
    "undefined",
    "2024-01-01",
    "invalid",
  ];

  // Convert string "undefined" to value `undefined`, to test "undefined returned from getDate()"
  const comparator = byDate((s) => (s === "undefined" ? undefined : s));

  it("ascending by default", async () => {
    input.sort(comparator);

    // Value `undefined` always sorts to the end
    expect(input).toEqual([
      null,
      "undefined",
      "invalid",
      "2023-01-01",
      "2024-01-01",
      "2025-01-01",
      undefined,
    ]);
  });

  it("descending with invert()", async () => {
    input.sort(invert(comparator));

    // Value `undefined` always sorts to the end
    expect(input).toEqual([
      "2025-01-01",
      "2024-01-01",
      "2023-01-01",
      null,
      "undefined",
      "invalid",
      undefined,
    ]);
  });
});
