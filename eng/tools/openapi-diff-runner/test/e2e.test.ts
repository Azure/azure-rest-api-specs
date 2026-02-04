import { BREAKING_CHANGES_CHECK_TYPES } from "@azure-tools/specs-shared/breaking-change";
import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import { appendFileSync, existsSync, PathLike } from "node:fs";
import { describe, expect, it, vi } from "vitest";
import { getSwaggerDiffs } from "../src/command-helpers.js";
import { validateBreakingChange } from "../src/commands.js";
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

describe("getSwaggerDiffs", () => {
  it("renameToAddDelete", async () => {
    mockChangedFilesStatuses({
      renames: [{ from: "data-plane/from.json", to: "data-plane/to.json" }],
    });

    const diffs = await getSwaggerDiffs();
    expect(diffs.additions).toEqual(["data-plane/to.json"]);
    expect(diffs.deletions).toEqual(["data-plane/from.json"]);
    expect(diffs.modifications).toEqual([]);
  });
});

describe("validateBreakingChange", () => {
  it("test1", async () => {
    mockChangedFilesStatuses({
      modifications: ["specification/foo/data-plane/Foo/stable/2026-01-01/foo.json"],
    });

    mockExistsSync(["/tempRepo/specification/foo/data-plane/Foo/stable/2026-01-01/foo.json"]);

    vi.mocked(runOad).mockResolvedValue([]);

    vi.mocked(appendFileSync).mockResolvedValue();

    const statusCode = await validateBreakingChange({
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

    expect(statusCode).toEqual(0);
  });
});
