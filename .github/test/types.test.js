import { describe, expect, it } from "vitest";
import * as types from "../src/types.js";

describe("types", () => {
  it("has no exports", async () => {
    expect(Object.keys(types)).toEqual([]);
  });
});
