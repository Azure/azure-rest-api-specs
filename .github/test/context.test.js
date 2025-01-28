import { describe, expect, it } from "vitest";

import { extractInputs } from "../src/context.js";

describe("context", () => {
  it("throws if inputs null", async () => {
    await expect(extractInputs(null, null, null)).rejects.toThrow();
  });
});
