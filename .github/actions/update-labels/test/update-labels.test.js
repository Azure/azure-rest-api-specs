import { describe, expect, it } from "vitest";
import updateLabels from "../src/update-labels.js";

describe("update-labels", () => {
  it("throws if inputs null", async () => {
    await expect(
      updateLabels({ github: null, context: null, core: null }),
    ).rejects.toThrow();
  });
});
