import { BREAKING_CHANGES_CHECK_TYPES } from "@azure-tools/specs-shared/breaking-change";
import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import { appendFileSync, existsSync, PathLike } from "node:fs";
import path from "node:path";
import { beforeEach, describe, expect, it, vi } from "vitest";
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
  const mockMkdirSync = vi.fn();
  const mockReadFileSync = vi.fn().mockReturnValue("{}");
  const mockWriteFileSync = vi.fn();

  return {
    ...actual,
    // Mock the default export (for `import fs from "node:fs"`)
    default: {
      ...(actual.default as any),
      appendFileSync: mockAppendFileSync,
      existsSync: mockExistsSync,
      mkdirSync: mockMkdirSync,
      readFileSync: mockReadFileSync,
      writeFileSync: mockWriteFileSync,
    },
    // Also mock named exports (for `import { appendFileSync } from "node:fs"`)
    appendFileSync: mockAppendFileSync,
    existsSync: mockExistsSync,
    mkdirSync: mockMkdirSync,
    readFileSync: mockReadFileSync,
    writeFileSync: mockWriteFileSync,
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

const context = {
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
};

describe("validateBreakingChange", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it.each([
    {
      name: "modify one file",
      changedFiles: {
        modifications: ["specification/foo/data-plane/Foo/stable/2026-01-01/foo.json"],
      },
      existingFiles: ["specification/foo/data-plane/Foo/stable/2026-01-01/foo.json"],
      expectedOadCalls: [
        {
          old: "specification/foo/data-plane/Foo/stable/2026-01-01/foo.json",
          new: "specification/foo/data-plane/Foo/stable/2026-01-01/foo.json",
        },
      ],
    },
    {
      name: "change case folder, rename file",
      changedFiles: {
        additions: [
          "specification/nginx/resource-manager/Nginx.NginxPlus/preview/2025-03-01-preview/openapi.json",
        ],
        deletions: [
          "specification/nginx/resource-manager/NGINX.NGINXPLUS/preview/2025-03-01-preview/swagger.json",
        ],
        renames: [
          {
            from: "specification/nginx/resource-manager/NGINX.NGINXPLUS/stable/2023-09-01/swagger.json",
            to: "specification/nginx/resource-manager/Nginx.NginxPlus/stable/2023-09-01/swagger.json",
          },
        ],
      },
      existingFiles: [
        "specification/nginx/resource-manager/NGINX.NGINXPLUS/stable/2023-09-01/swagger.json",
        "specification/nginx/resource-manager/NGINX.NGINXPLUS/preview/2025-03-01-preview/swagger.json",
      ],
      expectedOadCalls: [
        {
          old: "specification/nginx/resource-manager/NGINX.NGINXPLUS/preview/2025-03-01-preview/swagger.json",
          new: "specification/nginx/resource-manager/Nginx.NginxPlus/preview/2025-03-01-preview/openapi.json",
        },
        {
          old: "specification/nginx/resource-manager/NGINX.NGINXPLUS/stable/2023-09-01/swagger.json",
          new: "specification/nginx/resource-manager/Nginx.NginxPlus/stable/2023-09-01/swagger.json",
        },
      ],
    },
  ])("$name", async ({ changedFiles, existingFiles, expectedOadCalls }) => {
    mockChangedFilesStatuses(changedFiles);

    mockExistsSync(existingFiles.map((f) => path.join(context.prInfo.tempRepoFolder, f)));

    const mockRunOad = vi.mocked(runOad).mockResolvedValue([]);

    const logs: string[] = [];
    vi.mocked(appendFileSync).mockImplementation((_path, data) => {
      logs.push(data.toString());
    });

    const statusCode = await validateBreakingChange(context);

    expect(statusCode).toEqual(0);

    for (const expected of expectedOadCalls) {
      expect(mockRunOad).toBeCalledWith(
        path.join(context.prInfo.tempRepoFolder, expected.old),
        expected.new,
      );
    }

    // Ensure no extra calls
    expect(mockRunOad).toBeCalledTimes(expectedOadCalls.length);

    // Useful for debugging the markdown log

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
