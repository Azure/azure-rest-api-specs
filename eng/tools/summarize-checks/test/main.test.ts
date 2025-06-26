import { describe, it, expect } from "vitest";
import { getPrState } from "../src/main.js";
// import path from "path";

// const REPOROOT = path.resolve(__dirname, "..", "..", "..", "..");

describe("invocation directory checks", () => {
  it("Should call getPRState without throwing an exception", async () => {
    await expect(getPrState()).resolves.toBeUndefined();
  });
});