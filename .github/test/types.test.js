import { describe, expect, it } from "vitest";
import * as types from "../src/types.js";

describe("types", () => {
  // Added primarily to get 100% code coverage, but also good to enforce
  it("has no exports", async () => {
    expect(Object.keys(types)).toEqual([]);
  });
});
