// @ts-check

import { describe, expect, it } from "vitest";
import { byDate, invert } from "../src/sort.js";

describe("byDate", () => {
  const input = [
    { foo: "2025-01-01" },
    { foo: "2023-01-01" },
    { foo: "2024-01-01" },
  ];

  it("ascending by default", async () => {
    input.sort(byDate((s) => s.foo));

    // Value `undefined` always sorts to the end
    expect(input).toEqual([
      { foo: "2023-01-01" },
      { foo: "2024-01-01" },
      { foo: "2025-01-01" },
    ]);
  });

  it("descending with invert()", async () => {
    input.sort(invert(byDate((s) => s.foo)));

    // Value `undefined` always sorts to the end
    expect(input).toEqual([
      { foo: "2025-01-01" },
      { foo: "2024-01-01" },
      { foo: "2023-01-01" },
    ]);
  });
});
