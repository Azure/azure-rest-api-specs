import { beforeEach, describe, expect, it, vi } from "vitest";

// Mock fs/promises before imports
vi.mock("fs/promises", () => ({
  access: vi.fn(),
  constants: { R_OK: 4 },
  lstat: vi.fn(),
  readFile: vi.fn(),
}));

import * as fs from "fs/promises";

const accessMock = /** @type {import("vitest").Mock} */ (fs.access);
const lstatMock = /** @type {import("vitest").Mock} */ (fs.lstat);
const readFileMock = /** @type {import("vitest").Mock} */ (fs.readFile);

import generateJobSummaryImpl, {
  extractSpecificationPath,
  isFileSuppressed,
  suppressionGlobToRegExp,
} from "../src/avocado-code.js";
import { MessageLevel, MessageType } from "../src/message.js";
import { stringify } from "../src/ndjson.js";
import { createMockCore } from "./mocks.js";

const core = createMockCore();
const outputFile = "avocado.ndjson";

describe("generateJobSummary", () => {
  /**
   * @param {unknown} asyncFunctionArgs
   */
  function generateJobSummary(asyncFunctionArgs) {
    return generateJobSummaryImpl(
      /** @type {import("@actions/github-script").AsyncFunctionArguments} */ (asyncFunctionArgs),
    );
  }

  beforeEach(() => {
    vi.stubEnv("AVOCADO_OUTPUT_FILE", outputFile);
    accessMock.mockReset().mockRejectedValue(new Error("ENOENT"));
    lstatMock.mockReset().mockResolvedValue({ isDirectory: () => false });
    readFileMock.mockReset();
    core.summary.addRaw.mockReset();
    core.summary.write.mockReset();
    core.setFailed.mockReset();
  });

  it("throws if env var not set", async () => {
    vi.unstubAllEnvs();

    await expect(generateJobSummary({ core })).rejects.toThrowErrorMatchingInlineSnapshot(
      `[Error: Env var AVOCADO_OUTPUT_FILE must be set]`,
    );

    expect(core.info.mock.calls.at(-1)?.[0]).toMatchInlineSnapshot(
      `"avocadoOutputFile: undefined"`,
    );
  });

  it("no-ops if file cannot be read", async () => {
    readFileMock.mockRejectedValueOnce(
      new Error(`ENOENT: no such file or directory, open '${outputFile}'`),
    );

    await expect(generateJobSummary({ core })).resolves.toBeUndefined();

    expect(core.info.mock.calls.at(-1)?.[0]).toContain(
      "Error reading 'avocado.ndjson': Error: ENOENT: no such file or directory, open 'avocado.ndjson'",
    );
  });

  it("no-ops with notice if file is empty", async () => {
    readFileMock.mockResolvedValueOnce("");

    await expect(generateJobSummary({ core })).resolves.toBeUndefined();

    expect(core.notice.mock.calls.at(-1)?.[0]).toMatchInlineSnapshot(
      `"No messages in 'avocado.ndjson'"`,
    );
  });

  it("generates summary for success", async () => {
    vi.stubEnv("GITHUB_STEP_SUMMARY", "test-step-summary");

    /** @type {import("../src/message.js").MessageRecord[]} */
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
    expect(core.summary.write).toBeCalledTimes(1);

    expect(core.setOutput).toBeCalledWith("summary", "test-step-summary");
    expect(core.setFailed).not.toBeCalled();
  });

  it("generates summary for failure", async () => {
    vi.stubEnv("GITHUB_STEP_SUMMARY", "test-step-summary");

    /** @type {import("../src/message.js").MessageRecord[]} */
    const messages = [
      {
        type: MessageType.Raw,
        level: MessageLevel.Info,
        message: "test-raw-info",
        time: new Date().toISOString(),
      },
      {
        type: MessageType.Result,
        level: MessageLevel.Error,
        code: "NO_JSON_FILE_FOUND",
        message: "The JSON file is not found but it is referenced from the readme file.",
        docUrl: "https://github.com/Azure/avocado/blob/master/README.md#NO_JSON_FILE_FOUND",
        time: "2025-07-11T00:01:00.418Z",
        paths: [
          {
            tag: "readme",
            path: "https://github.com/mikeharder/azure-rest-api-specs/blob/4e6083f35e27d8e1e3b78222cf4bd27b87cd1409/specification/contosowidgetmanager/resource-manager/readme.md",
          },
          {
            tag: "json",
            path: "https://github.com/mikeharder/azure-rest-api-specs/blob/4e6083f35e27d8e1e3b78222cf4bd27b87cd1409/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso2.json",
          },
        ],
      },
      {
        type: MessageType.Raw,
        level: MessageLevel.Warning,
        message: "test-raw-notice",
        time: new Date().toISOString(),
      },
    ];

    const str = stringify(messages);

    readFileMock.mockResolvedValueOnce(str);

    await expect(generateJobSummary({ core })).resolves.toBeUndefined();

    expect(core.summary.addRaw.mock.calls[0][0]).toMatchInlineSnapshot(`
      "| Rule                                                                                              | Message                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
      | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
      | ℹ️ test-raw-info                                                                                  |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
      | ❌ [NO_JSON_FILE_FOUND](https://github.com/Azure/avocado/blob/master/README.md#NO_JSON_FILE_FOUND) | The JSON file is not found but it is referenced from the readme file.<br>readme: [specification/contosowidgetmanager/resource-manager/readme.md](https://github.com/mikeharder/azure-rest-api-specs/blob/4e6083f35e27d8e1e3b78222cf4bd27b87cd1409/specification/contosowidgetmanager/resource-manager/readme.md)<br>json: [Microsoft.Contoso/stable/2021-11-01/contoso2.json](https://github.com/mikeharder/azure-rest-api-specs/blob/4e6083f35e27d8e1e3b78222cf4bd27b87cd1409/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso2.json) |
      | ⚠️ test-raw-notice                                                                                |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |"
    `);
    expect(core.summary.write).toBeCalledTimes(1);

    expect(core.setOutput).toBeCalledWith("summary", "test-step-summary");
    expect(core.setFailed).toBeCalledWith(
      "Avocado found 1 unsuppressed error(s). See the job summary for details.",
    );
  });
});

describe("Avocado suppressions", () => {
  it("extracts a specification path from a GitHub URL", () => {
    expect(
      extractSpecificationPath(
        "https://github.com/Azure/azure-rest-api-specs/blob/abc/specification/vmware/resource-manager/readme.md",
      ),
    ).toBe("specification/vmware/resource-manager/readme.md");
  });

  it("matches suppression globs", () => {
    expect(
      suppressionGlobToRegExp("/specification/**/stable/*.json").test(
        "/specification/service/resource-manager/stable/version.json",
      ),
    ).toBe(true);
  });

  it("matches a file-level Swagger Avocado suppression", async () => {
    lstatMock.mockResolvedValueOnce({ isDirectory: () => false });
    accessMock.mockImplementation((path) => {
      if (path === "/workspace/specification/vmware/suppressions.yaml") {
        return Promise.resolve();
      }
      return Promise.reject(new Error("ENOENT"));
    });
    readFileMock.mockResolvedValueOnce(`
- tool: Swagger Avocado
  path: ./stable/2023-03-01/vmware.json
  reason: The operation was intentionally retired.
`);

    const result = await isFileSuppressed(
      "/workspace/specification/vmware/stable/2023-03-01/vmware.json",
    );

    expect(result).toBe(true);
  });
});
