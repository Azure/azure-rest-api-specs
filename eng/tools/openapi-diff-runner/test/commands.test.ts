import { BREAKING_CHANGES_CHECK_TYPES } from "@azure-tools/specs-shared/breaking-change";
import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import { vol } from "memfs";
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

vi.hoisted(async () => {
  const { vol } = await vi.importActual<typeof import("memfs")>("memfs");
  // Read by `oad-types.ts` at module load
  vol.fromJSON({ "/home/mharder/specs/eng/tools/package.json": "{}" }, "/");
});

vi.mock("node:fs", async () => {
  const { fs } = await vi.importActual<typeof import("memfs")>("memfs");
  return {
    ...fs,
    default: fs,
  };
});

vi.mock("fs", async () => {
  const { fs } = await vi.importActual<typeof import("memfs")>("memfs");
  return {
    ...fs,
    default: fs,
  };
});

vi.mock("node:fs/promises", async () => {
  const { fs } = await vi.importActual<typeof import("memfs")>("memfs");
  return {
    ...fs.promises,
    default: fs.promises,
  };
});

vi.mock("fs/promises", async () => {
  const { fs } = await vi.importActual<typeof import("memfs")>("memfs");
  return {
    ...fs.promises,
    default: fs.promises,
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
  vol.reset();
  if (pathsToExist.length === 0) {
    return;
  }
  const fileMap = Object.fromEntries(pathsToExist.map((filePath) => [filePath, "{}"]));
  vol.fromJSON(fileMap, "/");
}

const context = {
  localSpecRepoPath: "",
  workingFolder: "",
  logFileFolder: "",
  swaggerDirs: [],
  baseBranch: "",
  headCommit: "",
  runType: "",
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
    logFilePath: "/openapi-diff-runner.log",
    prUrl: "",
    messageCache: [],
  },
  prUrl: "",
};

const cases = [
  {
    name: "modify one file",
    changedFiles: {
      additions: [],
      modifications: ["specification/foo/data-plane/Foo/stable/2026-01-01/foo.json"],
    },
    existingFiles: ["specification/foo/data-plane/Foo/stable/2026-01-01/foo.json"],
    expectedOadCalls: {
      sameVersion: [
        {
          old: "specification/foo/data-plane/Foo/stable/2026-01-01/foo.json",
          new: "specification/foo/data-plane/Foo/stable/2026-01-01/foo.json",
        },
      ],
      crossVersion: [],
    },
  },
  {
    name: "add new stable",
    changedFiles: {
      additions: ["specification/foo/data-plane/Foo/stable/2026-01-01/foo.json"],
      modifications: [],
    },
    existingFiles: [
      // TODO: Add mock content for readme.md, to return previous files
      "specification/foo/data-plane/Foo/readme.md",
      "specification/foo/data-plane/Foo/stable/2025-01-01/foo.json",
    ],
    expectedOadCalls: {
      sameVersion: [],
      crossVersion: [
        {
          old: "specification/foo/data-plane/Foo/stable/2025-01-01/foo.json",
          new: "specification/foo/data-plane/Foo/stable/2026-01-01/foo.json",
        },
      ],
    },
  }, // Currently failing, code needs better support for renames
  //
  // {
  //   name: "change case folder, rename file",
  //   changedFiles: {
  //     additions: [
  //       "specification/nginx/resource-manager/Nginx.NginxPlus/preview/2025-03-01-preview/openapi.json",
  //     ],
  //     deletions: [
  //       "specification/nginx/resource-manager/NGINX.NGINXPLUS/preview/2025-03-01-preview/swagger.json",
  //     ],
  //     renames: [
  //       {
  //         from: "specification/nginx/resource-manager/NGINX.NGINXPLUS/stable/2023-09-01/swagger.json",
  //         to: "specification/nginx/resource-manager/Nginx.NginxPlus/stable/2023-09-01/swagger.json",
  //       },
  //     ],
  //   },
  //   existingFiles: [
  //     "specification/nginx/resource-manager/NGINX.NGINXPLUS/stable/2023-09-01/swagger.json",
  //     "specification/nginx/resource-manager/NGINX.NGINXPLUS/preview/2025-03-01-preview/swagger.json",
  //   ],
  //   expectedOadCalls: [
  //     {
  //       old: "specification/nginx/resource-manager/NGINX.NGINXPLUS/preview/2025-03-01-preview/swagger.json",
  //       new: "specification/nginx/resource-manager/Nginx.NginxPlus/preview/2025-03-01-preview/openapi.json",
  //     },
  //     {
  //       old: "specification/nginx/resource-manager/NGINX.NGINXPLUS/stable/2023-09-01/swagger.json",
  //       new: "specification/nginx/resource-manager/Nginx.NginxPlus/stable/2023-09-01/swagger.json",
  //     },
  //   ],
  // },
];

describe("validateBreakingChange", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    vol.reset();
  });

  it.each(cases)("$name", async ({ changedFiles, existingFiles, expectedOadCalls }) => {
    mockChangedFilesStatuses(changedFiles);

    const tempRepoPaths = existingFiles.map((f) => path.join(context.prInfo.tempRepoFolder, f));
    const workingTreePaths = [
      ...(changedFiles.additions ?? []),
      ...(changedFiles.modifications ?? []),
    ].map((f) => path.resolve(f));
    mockExistsSync([...tempRepoPaths, ...workingTreePaths]);

    const mockRunOad = vi.mocked(runOad).mockResolvedValue([]);

    for (const data of [
      {
        runType: BREAKING_CHANGES_CHECK_TYPES.SAME_VERSION,
        expectedOadCalls: expectedOadCalls.sameVersion,
      },
      {
        runType: BREAKING_CHANGES_CHECK_TYPES.CROSS_VERSION,
        expectedOadCalls: expectedOadCalls.crossVersion,
      },
    ]) {
      mockRunOad.mockClear();

      const statusCodeSame = await validateBreakingChange({
        ...context,
        runType: data.runType,
      });

      expect(statusCodeSame).toEqual(0);

      for (const expected of data.expectedOadCalls) {
        expect(mockRunOad).toBeCalledWith(
          path.join(context.prInfo.tempRepoFolder, expected.old),
          expected.new,
        );
      }
    }
  });
});
