import { describe, expect, it } from "vitest";
import generateJobSummary from "../src/avocado-code.js";
import { createMockCore } from "./mocks.js";

const core = createMockCore();

describe("generateJobSummary", () => {
  it("throws if env var not set", async () => {
    await expect(generateJobSummary({ core })).rejects.toThrowErrorMatchingInlineSnapshot(
      `[Error: Env var AVOCADO_OUTPUT_FILE must be set]`,
    );
    expect(core.info).toHaveBeenCalledWith("avocadoOutputFile: undefined");
  });
});
