import { BREAKING_CHANGES_CHECK_TYPES } from "@azure-tools/specs-shared/breaking-change";
import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import { devNull } from "node:os";
import path, { resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { createDummySwagger } from "../src/command-helpers.js";
import { validateBreakingChange } from "../src/commands.js";
import { runOad } from "../src/run-oad.js";

vi.mock("@azure-tools/specs-shared/changed-files", async () => {
  const actual = await vi.importActual("@azure-tools/specs-shared/changed-files");
  return {
    ...actual,
    getChangedFilesStatuses: vi.fn(),
  };
});

vi.mock("../src/run-oad.js", () => ({
  runOad: vi.fn(),
}));

vi.mock("../src/command-helpers.js", async () => {
  const actual = await vi.importActual("../src/command-helpers.js");
  return {
    ...actual,
    createDummySwagger: vi.fn(),
  };
});

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

const __dirname = path.dirname(fileURLToPath(import.meta.url));

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
    tempRepoFolder: path.resolve(__dirname, "fixtures"),
    checkout: function (branch: string): Promise<void> {
      console.log("checkout " + branch);
      return Promise.resolve();
    },
  },
  prNumber: "",
  prSourceBranch: "",
  prTargetBranch: "",
  oadMessageProcessorContext: {
    logFilePath: devNull,
    prUrl: "",
    messageCache: [],
  },
  prUrl: "",
};

const cases = [
  {
    name: "modify one file, one version",
    changedFiles: {
      modifications: ["specification/foo/data-plane/Foo/stable/2025-03-01/foo.json"],
    },
    expectedCreateDummySwaggers: {
      old: [],
      new: [],
    },
    expectedOadCalls: {
      sameVersion: [
        {
          old: "specification/foo/data-plane/Foo/stable/2025-03-01/foo.json",
          new: "specification/foo/data-plane/Foo/stable/2025-03-01/foo.json",
        },
      ],
      crossVersion: [],
    },
  },
  {
    name: "modify one file, multiple versions",
    changedFiles: {
      modifications: [
        "specification/foo/data-plane/Foo/preview/2025-04-01-preview/foo.json",
        "specification/foo/data-plane/Foo/stable/2025-01-01/foo.json",
        "specification/foo/data-plane/Foo/stable/2025-03-01/foo.json",
      ],
    },
    expectedCreateDummySwaggers: {
      old: [],
      new: [],
    },
    expectedOadCalls: {
      sameVersion: [
        {
          old: "specification/foo/data-plane/Foo/preview/2025-04-01-preview/foo.json",
          new: "specification/foo/data-plane/Foo/preview/2025-04-01-preview/foo.json",
        },
        {
          old: "specification/foo/data-plane/Foo/stable/2025-01-01/foo.json",
          new: "specification/foo/data-plane/Foo/stable/2025-01-01/foo.json",
        },
        {
          old: "specification/foo/data-plane/Foo/stable/2025-03-01/foo.json",
          new: "specification/foo/data-plane/Foo/stable/2025-03-01/foo.json",
        },
      ],
      crossVersion: [],
    },
  },
  {
    name: "modify multiple files, multiple versions",
    changedFiles: {
      modifications: [
        "specification/bar/data-plane/Bar/preview/2025-04-01-preview/bar.json",
        "specification/bar/data-plane/Bar/preview/2025-04-01-preview/baz.json",
        "specification/bar/data-plane/Bar/stable/2025-03-01/bar.json",
        "specification/bar/data-plane/Bar/stable/2025-03-01/baz.json",
      ],
    },
    expectedCreateDummySwaggers: {
      old: [],
      new: [],
    },
    expectedOadCalls: {
      sameVersion: [
        {
          old: "specification/bar/data-plane/Bar/preview/2025-04-01-preview/bar.json",
          new: "specification/bar/data-plane/Bar/preview/2025-04-01-preview/bar.json",
        },
        {
          old: "specification/bar/data-plane/Bar/preview/2025-04-01-preview/baz.json",
          new: "specification/bar/data-plane/Bar/preview/2025-04-01-preview/baz.json",
        },
        {
          old: "specification/bar/data-plane/Bar/stable/2025-03-01/bar.json",
          new: "specification/bar/data-plane/Bar/stable/2025-03-01/bar.json",
        },
        {
          old: "specification/bar/data-plane/Bar/stable/2025-03-01/baz.json",
          new: "specification/bar/data-plane/Bar/stable/2025-03-01/baz.json",
        },
      ],
      crossVersion: [],
    },
  },
  {
    name: "add new stable, one file",
    changedFiles: {
      additions: ["specification/foo/data-plane/Foo/stable/2026-01-01/foo.json"],
    },
    expectedCreateDummySwaggers: {
      old: [],
      new: [],
    },
    expectedOadCalls: {
      sameVersion: [],
      crossVersion: [
        {
          old: "specification/foo/data-plane/Foo/preview/2025-04-01-preview/foo.json",
          new: "specification/foo/data-plane/Foo/stable/2026-01-01/foo.json",
        },
        {
          old: "specification/foo/data-plane/Foo/stable/2025-03-01/foo.json",
          new: "specification/foo/data-plane/Foo/stable/2026-01-01/foo.json",
        },
      ],
    },
  },
  {
    name: "add new stable, multiple files",
    changedFiles: {
      additions: [
        "specification/bar/data-plane/Bar/stable/2026-01-01/bar.json",
        "specification/bar/data-plane/Bar/stable/2026-01-01/baz.json",
      ],
    },
    expectedCreateDummySwaggers: {
      old: [],
      new: [],
    },
    expectedOadCalls: {
      sameVersion: [],
      crossVersion: [
        {
          old: "specification/bar/data-plane/Bar/preview/2025-04-01-preview/bar.json",
          new: "specification/bar/data-plane/Bar/stable/2026-01-01/bar.json",
        },
        {
          old: "specification/bar/data-plane/Bar/preview/2025-04-01-preview/baz.json",
          new: "specification/bar/data-plane/Bar/stable/2026-01-01/baz.json",
        },
        {
          old: "specification/bar/data-plane/Bar/stable/2025-03-01/bar.json",
          new: "specification/bar/data-plane/Bar/stable/2026-01-01/bar.json",
        },
        {
          old: "specification/bar/data-plane/Bar/stable/2025-03-01/baz.json",
          new: "specification/bar/data-plane/Bar/stable/2026-01-01/baz.json",
        },
      ],
    },
  },
  {
    name: "rename one file, one version",
    changedFiles: {
      renames: [
        {
          from: "specification/foo/data-plane/Foo/stable/2025-01-01/foo.json",
          to: "specification/foo/data-plane/Foo/stable/2025-01-01/openapi.json",
        },
      ],
    },
    // TODO: After code is fixed, should not create *any* dummy swaggers
    expectedCreateDummySwaggers: {
      old: ["specification/foo/data-plane/Foo/stable/2025-01-01/openapi.json"],
      new: ["specification/foo/data-plane/Foo/stable/2025-01-01/foo.json"],
    },
    // TODO: After code is fixed, should only compare before and after renamed file
    expectedOadCalls: {
      sameVersion: [
        {
          old: "specification/foo/data-plane/Foo/stable/2025-01-01/foo.json",
          new: "specification/foo/data-plane/Foo/stable/2025-01-01/foo.json",
        },
        {
          old: "specification/foo/data-plane/Foo/stable/2025-01-01/openapi.json",
          new: "specification/foo/data-plane/Foo/stable/2025-01-01/openapi.json",
        },
      ],
      crossVersion: [],
    },
  },
  {
    name: "rename one file, change case of service",
    changedFiles: {
      addtions: ["specification/foo/data-plane/foo/stable/2025-01-01/openapi.json"],
      deletions: ["specification/foo/data-plane/Foo/stable/2025-01-01/foo.json"],
    },
    // TODO: After code is fixed, should not create *any* dummy swaggers
    expectedCreateDummySwaggers: {
      old: [],
      new: ["specification/foo/data-plane/Foo/stable/2025-01-01/foo.json"],
    },
    // TODO: After code is fixed, should only compare before and after renamed file
    expectedOadCalls: {
      sameVersion: [
        {
          old: "specification/foo/data-plane/Foo/stable/2025-01-01/foo.json",
          new: "specification/foo/data-plane/Foo/stable/2025-01-01/foo.json",
        },
      ],
      crossVersion: [],
    },
  },

  // Currently failing, code needs better support for renames
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
  });

  it.each(cases)(
    "$name",
    async ({ changedFiles, expectedCreateDummySwaggers, expectedOadCalls }) => {
      mockChangedFilesStatuses(changedFiles);

      const mockCreateDummySwagger = vi.mocked(createDummySwagger);

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

        const statusCode = await validateBreakingChange({
          ...context,
          runType: data.runType,
        });

        expect(statusCode).toEqual(0);

        for (const expected of expectedCreateDummySwaggers.old) {
          expect(mockCreateDummySwagger).toBeCalledWith(
            expect.anything(),
            resolve(context.prInfo.tempRepoFolder, expected),
          );
        }

        for (const expected of expectedCreateDummySwaggers.new) {
          expect(mockCreateDummySwagger).toBeCalledWith(expect.anything(), resolve(expected));
        }

        expect(mockCreateDummySwagger).toBeCalledTimes(
          expectedCreateDummySwaggers.old.length + expectedCreateDummySwaggers.new.length,
        );

        for (const expected of data.expectedOadCalls) {
          expect(mockRunOad).toBeCalledWith(
            path.join(context.prInfo.tempRepoFolder, expected.old),
            expected.new,
          );
        }

        expect(mockRunOad).toBeCalledTimes(data.expectedOadCalls.length);
      }
    },
  );
});
