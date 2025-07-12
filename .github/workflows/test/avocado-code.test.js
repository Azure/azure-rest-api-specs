import { beforeEach, describe, expect, it, vi } from "vitest";

// Mock fs/promises before imports
vi.mock("fs/promises", () => ({ readFile: vi.fn() }));

import * as fs from "fs/promises";

import generateJobSummary from "../src/avocado-code.js";
import { createMockCore } from "./mocks.js";

const core = createMockCore();
const outputFile = "avocado.ndjson";

describe("generateJobSummary", () => {
  /** @type {import("vitest").Mock} */
  const readFileMock = fs.readFile;

  beforeEach(() => {
    vi.stubEnv("AVOCADO_OUTPUT_FILE", outputFile);
    readFileMock.mockReset();
  });

  it("throws if env var not set", async () => {
    vi.unstubAllEnvs();

    await expect(generateJobSummary({ core })).rejects.toThrowErrorMatchingInlineSnapshot(
      `[Error: Env var AVOCADO_OUTPUT_FILE must be set]`,
    );
    expect(core.info).toHaveBeenCalledWith("avocadoOutputFile: undefined");
  });

  it("no-ops if file cannot be read", async () => {
    readFileMock.mockRejectedValueOnce(
      new Error(`ENOENT: no such file or directory, open '${outputFile}'`),
    );

    await expect(generateJobSummary({ core })).resolves.toBeUndefined();

    expect(core.info).toHaveBeenLastCalledWith(
      expect.stringContaining(`Error: ENOENT: no such file or directory, open '${outputFile}'`),
    );
  });

  it("no-ops with notice if file is empty", async () => {
    readFileMock.mockResolvedValueOnce("");

    await expect(generateJobSummary({ core })).resolves.toBeUndefined();

    expect(core.info).toHaveBeenLastCalledWith(
      expect.stringContaining(`Error: ENOENT: no such file or directory, open '${outputFile}'`),
    );
  });
});
