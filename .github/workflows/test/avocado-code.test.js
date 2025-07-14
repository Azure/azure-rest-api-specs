import { beforeEach, describe, expect, it, vi } from "vitest";

// Mock fs/promises before imports
vi.mock("fs/promises", () => ({ readFile: vi.fn() }));

import * as fs from "fs/promises";

import generateJobSummary from "../src/avocado-code.js";
import { MessageLevel, MessageType } from "../src/message.js";
import { stringify } from "../src/ndjson.js";
import { createMockCore } from "./mocks.js";

const core = createMockCore();
const outputFile = "avocado.ndjson";
const stepSummary = "test-step-summary";

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

    expect(core.info.mock.calls.at(-1)[0]).toMatchInlineSnapshot(`"avocadoOutputFile: undefined"`);
  });

  it("no-ops if file cannot be read", async () => {
    readFileMock.mockRejectedValueOnce(
      new Error(`ENOENT: no such file or directory, open '${outputFile}'`),
    );

    await expect(generateJobSummary({ core })).resolves.toBeUndefined();

    expect(core.info.mock.calls.at(-1)[0]).toMatchInlineSnapshot(
      `"Error reading 'avocado.ndjson': Error: ENOENT: no such file or directory, open 'avocado.ndjson'"`,
    );
  });

  it("no-ops with notice if file is empty", async () => {
    readFileMock.mockResolvedValueOnce("");

    await expect(generateJobSummary({ core })).resolves.toBeUndefined();

    expect(core.notice.mock.calls.at(-1)[0]).toMatchInlineSnapshot(
      `"No messages in 'avocado.ndjson'"`,
    );
  });

  it("generates summary for success", async () => {
    vi.stubEnv("GITHUB_STEP_SUMMARY", stepSummary);

    /** @type {import("../src/message.js").RawMessageRecord[]} */
    const messages = [
      {
        type: MessageType.Raw,
        level: MessageLevel.Info,
        message: "success",
        time: new Date().toISOString(),
      },
    ];

    readFileMock.mockResolvedValueOnce(stringify(messages));

    await expect(generateJobSummary({ core })).resolves.toBeUndefined();

    expect(core.summary.addRaw.mock.calls[0][0]).toMatchInlineSnapshot(`"Success"`);
  });
});
