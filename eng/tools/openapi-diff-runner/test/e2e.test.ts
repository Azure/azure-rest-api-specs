import { BREAKING_CHANGES_CHECK_TYPES } from "@azure-tools/specs-shared/breaking-change";
import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import { appendFileSync, existsSync, PathLike } from "node:fs";
import { resolve } from "node:path";
import { describe, expect, it, vi } from "vitest";
import { validateBreakingChange as validateBreakingChangeImpl } from "../src/commands.js";
import { runOad } from "../src/run-oad.js";

vi.mock("@azure-tools/specs-shared/changed-files", async () => {
  const actual = await vi.importActual("@azure-tools/specs-shared/changed-files");
  return {
    ...actual,
    getChangedFilesStatuses: vi.fn(),
  };
});

vi.mock("node:fs", async () => {
  const actual = await vi.importActual("node:fs");
  const mockAppendFileSync = vi.fn();
  const mockExistsSync = vi.fn();

  return {
    ...actual,
    // Mock the default export (for `import fs from "node:fs"`)
    default: {
      ...(actual.default as any),
      appendFileSync: mockAppendFileSync,
      existsSync: mockExistsSync,
    },
    // Also mock named exports (for `import { appendFileSync } from "node:fs"`)
    appendFileSync: mockAppendFileSync,
    existsSync: mockExistsSync,
  };
});

vi.mock("../src/run-oad.js", () => ({
  runOad: vi.fn(),
}));

function mockChangedFilesStatuses(
  partial: Partial<{
    additions: string[];
    modifications: string[];
    deletions: string[];
    renames: { from: string; to: string }[];
  }> = {},
) {
  const defaultResult = {
    additions: [],
    modifications: [],
    deletions: [],
    renames: [],
    total: 0,
  };

  const result = { ...defaultResult, ...partial };

  result.total =
    result.additions.length +
    result.modifications.length +
    result.deletions.length +
    result.renames.length;

  return vi.mocked(getChangedFilesStatuses).mockResolvedValue(result);
}

function mockExistsSync(pathsToExist: string[] = []) {
  const mockExistsSyncFn = vi.mocked(existsSync);
  mockExistsSyncFn.mockImplementation((path: PathLike) => {
    return pathsToExist.includes(path.toString());
  });
  return mockExistsSyncFn;
}

async function validateBreakingChange() {
  return await validateBreakingChangeImpl({
    localSpecRepoPath: "",
    workingFolder: "",
    logFileFolder: "",
    swaggerDirs: [],
    baseBranch: "",
    headCommit: "",
    runType: BREAKING_CHANGES_CHECK_TYPES.SAME_VERSION,
    checkName: "",
    targetRepo: "",
    sourceRepo: "",
    prInfo: {
      targetBranch: "",
      sourceBranch: "",
      baseBranch: "",
      currentBranch: "",
      tempRepoFolder: "/tempRepo",
      checkout: function (branch: string): Promise<void> {
        console.log("checkout " + branch);
        return Promise.resolve();
      },
    },
    prNumber: "",
    prSourceBranch: "",
    prTargetBranch: "",
    oadMessageProcessorContext: {
      logFilePath: "",
      prUrl: "",
      messageCache: [],
    },
    prUrl: "",
  });
}

describe("validateBreakingChange", () => {
  it("runs oad on a modified swagger", async () => {
    mockChangedFilesStatuses({
      modifications: ["specification/foo/data-plane/Foo/stable/2026-01-01/foo.json"],
    });

    mockExistsSync(["/tempRepo/specification/foo/data-plane/Foo/stable/2026-01-01/foo.json"]);

    const mockRunOad = vi.mocked(runOad).mockResolvedValue([]);

    const logs: string[] = [];
    vi.mocked(appendFileSync).mockImplementation((_path, data) => {
      logs.push(data.toString());
    });

    const statusCode = await validateBreakingChange();

    expect(statusCode).toEqual(0);

    expect(mockRunOad).toBeCalledWith(
      resolve("/tempRepo/specification/foo/data-plane/Foo/stable/2026-01-01/foo.json"),
      resolve("specification/foo/data-plane/Foo/stable/2026-01-01/foo.json"),
    );

    // const jsonLog = logs.find((l) => l.startsWith("{"));
    // const markdownLog = JSON.parse(jsonLog || "").message.trim();

    // expect(markdownLog).toMatchInlineSnapshot(
    //   `
    //   "| Compared specs ([vunknown](https://www.npmjs.com/package/@azure/oad/v/unknown)) | new version | base version |
    //   |-------|-------------|--------------|
    //   | foo.json | 2026-01-01 ([](https://github.com//blob//specification/foo/data-plane/Foo/stable/2026-01-01/foo.json)) | 2026-01-01 ([](https://github.com//blob//specification/foo/data-plane/Foo/stable/2026-01-01/foo.json)) |"
    // `,
    // );
  });
});
