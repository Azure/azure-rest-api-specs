import { describe, expect, it } from "vitest";
import { setEquals } from "../src/equality.js";

describe("equality", () => {
  it("setEquals", () => {
    expect(setEquals(null, null)).toBe(false);
  });

  // TODO: Add more tests
});
