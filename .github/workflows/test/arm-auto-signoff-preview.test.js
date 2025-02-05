import { describe, expect, it } from "vitest";
import { armAutoSignoffPreviewImpl } from "../src/arm-auto-signoff-preview.js";

describe("armAutoSignoffPreviewImpl", () => {
  it("rejects if inputs null", async () => {
    await expect(armAutoSignoffPreviewImpl({})).rejects.toThrow();
  });
});
