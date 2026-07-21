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
  extractRelativePathFromUrl,
  findSuppressionsFiles,
  isFileSuppressedForAvocado,
  isResultSuppressed,
} from "../src/avocado-code.js";
import { MessageLevel, MessageType } from "../src/message.js";
import { stringify } from "../src/ndjson.js";
import { createMockCore } from "./mocks.js";

const core = createMockCore();
const outputFile = "avocado.ndjson";

describe("extractRelativePathFromUrl", () => {
  it("extracts relative path from GitHub blob URL", () => {
    const url =
      "https://github.com/Azure/azure-rest-api-specs/blob/abc123/specification/hybridcompute/resource-manager/readme.md";
    expect(extractRelativePathFromUrl(url)).toBe(
      "specification/hybridcompute/resource-manager/readme.md",
    );
  });

  it("returns undefined for non-blob URLs", () => {
    expect(extractRelativePathFromUrl("https://github.com/Azure/avocado")).toBeUndefined();
  });

  it("returns undefined for empty input", () => {
    expect(extractRelativePathFromUrl("")).toBeUndefined();
    expect(extractRelativePathFromUrl(undefined)).toBeUndefined();
  });
});

describe("findSuppressionsFiles", () => {
  beforeEach(() => {
    lstatMock.mockReset();
    accessMock.mockReset();
  });

  it("returns empty array if lstat throws", async () => {
    lstatMock.mockRejectedValueOnce(new Error("ENOENT"));
    const result = await findSuppressionsFiles("/nonexistent/path/file.json");
    expect(result).toEqual([]);
  });
});

describe("isFileSuppressedForAvocado", () => {
  beforeEach(() => {
    lstatMock.mockReset();
    accessMock.mockReset();
    readFileMock.mockReset();
  });

  it("returns false if no suppressions.yaml files found", async () => {
    lstatMock.mockResolvedValueOnce({ isDirectory: () => false });
    // All access calls fail (no suppressions.yaml anywhere)
    accessMock.mockRejectedValue(new Error("ENOENT"));

    const result = await isFileSuppressedForAvocado(
      "/repo/specification/hybridcompute/stable/2025-01-13/HybridCompute.json",
    );
    expect(result).toBe(false);
  });

  it("returns true when matching Swagger Avocado suppression found", async () => {
    lstatMock.mockResolvedValueOnce({ isDirectory: () => false });

    // suppressions.yaml found in stable/2025-01-13/ parent
    const suppressionsPath =
      "/repo/specification/hybridcompute/resource-manager/Microsoft.HybridCompute/HybridCompute/suppressions.yaml";
    accessMock.mockImplementation(async (p) => {
      if (p === suppressionsPath) return; // success
      throw new Error("ENOENT");
    });

    const yaml = `
- tool: Swagger Avocado
  path: ./stable/2025-01-13/HybridCompute.json
  reason: test suppression
`;
    readFileMock.mockImplementation(async (p) => {
      if (p === suppressionsPath) return yaml;
      throw new Error("ENOENT");
    });

    const result = await isFileSuppressedForAvocado(
      "/repo/specification/hybridcompute/resource-manager/Microsoft.HybridCompute/HybridCompute/stable/2025-01-13/HybridCompute.json",
    );
    expect(result).toBe(true);
  });

  it("returns true when wildcard path matches", async () => {
    lstatMock.mockResolvedValueOnce({ isDirectory: () => false });

    const suppressionsPath =
      "/repo/specification/hybridcompute/resource-manager/Microsoft.HybridCompute/HybridCompute/suppressions.yaml";
    accessMock.mockImplementation(async (p) => {
      if (p === suppressionsPath) return;
      throw new Error("ENOENT");
    });

    const yaml = `
- tool: Swagger Avocado
  path: ./stable/2025-01-13/*.json
  reason: wildcard suppression
`;
    readFileMock.mockImplementation(async (p) => {
      if (p === suppressionsPath) return yaml;
      throw new Error("ENOENT");
    });

    const result = await isFileSuppressedForAvocado(
      "/repo/specification/hybridcompute/resource-manager/Microsoft.HybridCompute/HybridCompute/stable/2025-01-13/privateLinkScopes.json",
    );
    expect(result).toBe(true);
  });

  it("returns false when tool does not match", async () => {
    lstatMock.mockResolvedValueOnce({ isDirectory: () => false });

    const suppressionsPath =
      "/repo/specification/hybridcompute/resource-manager/Microsoft.HybridCompute/HybridCompute/suppressions.yaml";
    accessMock.mockImplementation(async (p) => {
      if (p === suppressionsPath) return;
      throw new Error("ENOENT");
    });

    const yaml = `
- tool: TypeSpecRequirement
  path: ./stable/2025-01-13/HybridCompute.json
  reason: different tool
`;
    readFileMock.mockImplementation(async (p) => {
      if (p === suppressionsPath) return yaml;
      throw new Error("ENOENT");
    });

    const result = await isFileSuppressedForAvocado(
      "/repo/specification/hybridcompute/resource-manager/Microsoft.HybridCompute/HybridCompute/stable/2025-01-13/HybridCompute.json",
    );
    expect(result).toBe(false);
  });
});

describe("isResultSuppressed", () => {
  beforeEach(() => {
    lstatMock.mockReset();
    accessMock.mockReset();
    readFileMock.mockReset();
  });

  it("returns false if no json path in message", async () => {
    /** @type {import('../src/message.js').ResultMessageRecord} */
    const message = {
      type: MessageType.Result,
      level: MessageLevel.Error,
      code: "MISSING_README",
      message: "Missing readme",
      time: new Date().toISOString(),
      paths: [],
    };
    expect(await isResultSuppressed(message, "/repo")).toBe(false);
  });
});

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
    vi.stubEnv("GITHUB_WORKSPACE", "/workspace");
    readFileMock.mockReset();
    lstatMock.mockReset();
    accessMock.mockReset();
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

  it("generates summary for failure and calls setFailed for unsuppressed errors", async () => {
    vi.stubEnv("GITHUB_STEP_SUMMARY", "test-step-summary");
    // Simulate no suppressions.yaml files
    lstatMock.mockResolvedValue({ isDirectory: () => false });
    accessMock.mockRejectedValue(new Error("ENOENT"));

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
    expect(core.setFailed).toBeCalledWith(expect.stringContaining("1 error(s)"));
  });

  it("does not call setFailed when all errors are suppressed", async () => {
    vi.stubEnv("GITHUB_STEP_SUMMARY", "test-step-summary");

    // Simulate suppressions.yaml found in spec directory
    lstatMock.mockResolvedValue({ isDirectory: () => false });
    const suppressionsPath =
      "/workspace/specification/contosowidgetmanager/resource-manager/suppressions.yaml";
    accessMock.mockImplementation(async (p) => {
      if (p === suppressionsPath) return;
      throw new Error("ENOENT");
    });
    const suppressionsYaml = `
- tool: Swagger Avocado
  path: ./Microsoft.Contoso/stable/2021-11-01/contoso2.json
  reason: test suppression
`;
    readFileMock
      .mockResolvedValueOnce(
        stringify([
          {
            type: MessageType.Result,
            level: MessageLevel.Error,
            code: "NO_JSON_FILE_FOUND",
            message: "The JSON file is not found.",
            docUrl: "https://github.com/Azure/avocado/blob/master/README.md#NO_JSON_FILE_FOUND",
            time: new Date().toISOString(),
            paths: [
              {
                tag: "json",
                path: "https://github.com/Azure/azure-rest-api-specs/blob/abc123/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso2.json",
              },
            ],
          },
        ]),
      )
      .mockResolvedValue(suppressionsYaml);

    await expect(generateJobSummary({ core })).resolves.toBeUndefined();

    expect(core.setFailed).not.toBeCalled();
    expect(core.info).toBeCalledWith(
      expect.stringContaining("1 error(s) suppressed via suppressions.yaml"),
    );
  });
});
