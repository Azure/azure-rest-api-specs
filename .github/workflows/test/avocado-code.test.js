import { randomUUID } from "crypto";
import { describe, expect, it, vi } from "vitest";
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

  it("no-ops if file cannot be read", async () => {
    const filename = randomUUID();

    vi.stubEnv("AVOCADO_OUTPUT_FILE", filename);

    await expect(generateJobSummary({ core })).resolves.toBeUndefined();

    expect(core.info).toHaveBeenLastCalledWith(
      expect.stringContaining(`Error: ENOENT: no such file or directory, open '${filename}'`),
    );
  });
});
