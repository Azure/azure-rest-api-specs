import { BREAKING_CHANGES_CHECK_TYPES } from "@azure-tools/specs-shared/breaking-change";
import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import { devNull } from "node:os";
import path, { resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { createDummySwagger } from "../src/command-helpers.js";
import { validateBreakingChange } from "../src/commands.js";
import { runOad } from "../src/run-oad.js";

const serviceParent = "specification/foo/data-plane/";

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

type TestCase = {
  name: string;
  changedFiles: {
    additions?: string[];
    modifications?: string[];
    deletions?: string[];
    renames?: {
      from: string;
      to: string;
    }[];
  };
  expectedCreateDummySwaggers?: { old: string[]; new: string[] };
  expectedOadCalls: {
    sameVersion?: { old: string; new: string }[];
    crossVersion?: { old: string; new: string }[];
  };
};

const cases: TestCase[] = [
  {
    name: "modify one file, one version",
    changedFiles: {
      modifications: ["Foo/stable/2025-03-01/foo.json"],
    },
    expectedOadCalls: {
      sameVersion: [
        {
          old: "Foo/stable/2025-03-01/foo.json",
          new: "Foo/stable/2025-03-01/foo.json",
        },
      ],
    },
  },
  {
    name: "modify one file, multiple versions",
    changedFiles: {
      modifications: [
        "Foo/preview/2025-04-01-preview/foo.json",
        "Foo/stable/2025-01-01/foo.json",
        "Foo/stable/2025-03-01/foo.json",
      ],
    },
    expectedOadCalls: {
      sameVersion: [
        {
          old: "Foo/preview/2025-04-01-preview/foo.json",
          new: "Foo/preview/2025-04-01-preview/foo.json",
        },
        {
          old: "Foo/stable/2025-01-01/foo.json",
          new: "Foo/stable/2025-01-01/foo.json",
        },
        {
          old: "Foo/stable/2025-03-01/foo.json",
          new: "Foo/stable/2025-03-01/foo.json",
        },
      ],
    },
  },
  {
    name: "modify multiple files, multiple versions",
    changedFiles: {
      modifications: [
        "Bar/preview/2025-04-01-preview/bar.json",
        "Bar/preview/2025-04-01-preview/baz.json",
        "Bar/stable/2025-03-01/bar.json",
        "Bar/stable/2025-03-01/baz.json",
      ],
    },
    expectedOadCalls: {
      sameVersion: [
        {
          old: "Bar/preview/2025-04-01-preview/bar.json",
          new: "Bar/preview/2025-04-01-preview/bar.json",
        },
        {
          old: "Bar/preview/2025-04-01-preview/baz.json",
          new: "Bar/preview/2025-04-01-preview/baz.json",
        },
        {
          old: "Bar/stable/2025-03-01/bar.json",
          new: "Bar/stable/2025-03-01/bar.json",
        },
        {
          old: "Bar/stable/2025-03-01/baz.json",
          new: "Bar/stable/2025-03-01/baz.json",
        },
      ],
    },
  },
  {
    name: "add new stable, one file",
    changedFiles: {
      additions: ["Foo/stable/2026-01-01/foo.json"],
    },
    expectedOadCalls: {
      crossVersion: [
        {
          old: "Foo/preview/2025-04-01-preview/foo.json",
          new: "Foo/stable/2026-01-01/foo.json",
        },
        {
          old: "Foo/stable/2025-03-01/foo.json",
          new: "Foo/stable/2026-01-01/foo.json",
        },
      ],
    },
  },
  {
    name: "add new stable, multiple files",
    changedFiles: {
      additions: ["Bar/stable/2026-01-01/bar.json", "Bar/stable/2026-01-01/baz.json"],
    },
    expectedOadCalls: {
      crossVersion: [
        {
          old: "Bar/preview/2025-04-01-preview/bar.json",
          new: "Bar/stable/2026-01-01/bar.json",
        },
        {
          old: "Bar/preview/2025-04-01-preview/baz.json",
          new: "Bar/stable/2026-01-01/baz.json",
        },
        {
          old: "Bar/stable/2025-03-01/bar.json",
          new: "Bar/stable/2026-01-01/bar.json",
        },
        {
          old: "Bar/stable/2025-03-01/baz.json",
          new: "Bar/stable/2026-01-01/baz.json",
        },
      ],
    },
  },
  {
    name: "rename one file, one version",
    changedFiles: {
      renames: [
        {
          from: "Foo/stable/2025-03-01/foo.json",
          to: "Foo/stable/2025-03-01/openapi.json",
        },
      ],
    },
    expectedOadCalls: {
      sameVersion: [
        {
          old: "Foo/stable/2025-03-01/foo.json",
          new: "Foo/stable/2025-03-01/openapi.json",
        },
      ],
    },
  },
  {
    name: "rename one file, one version, as add/remove",
    changedFiles: {
      // If a file is renamed, but has too many changes, "git diff" may return it as an
      // add/delete, rather than a rename.
      additions: ["Foo/stable/2025-03-01/openapi.json"],
      deletions: ["Foo/stable/2025-03-01/foo.json"],
    },
    expectedOadCalls: {
      sameVersion: [
        {
          old: "Foo/stable/2025-03-01/foo.json",
          new: "Foo/stable/2025-03-01/openapi.json",
        },
      ],
    },
  },
  {
    name: "rename one file, change case of service",
    changedFiles: {
      additions: ["FOO/stable/2025-03-01/openapi.json"],
      deletions: ["Foo/stable/2025-03-01/foo.json"],
    },
    expectedOadCalls: {
      sameVersion: [
        {
          old: "Foo/stable/2025-03-01/foo.json",
          new: "FOO/stable/2025-03-01/openapi.json",
        },
      ],
    },
  },
  {
    // Minimal repro for https://github.com/Azure/azure-rest-api-specs/issues/38245
    name: "rename files, change case of service, two versions",
    changedFiles: {
      additions: ["FOO/stable/2025-03-01/openapi.json"],
      deletions: ["Foo/stable/2025-03-01/foo.json"],
      renames: [
        {
          from: "Foo/stable/2025-01-01/foo.json",
          to: "FOO/stable/2025-01-01/foo.json",
        },
      ],
    },
    expectedOadCalls: {
      sameVersion: [
        {
          old: "Foo/stable/2025-01-01/foo.json",
          new: "FOO/stable/2025-01-01/foo.json",
        },
        {
          old: "Foo/stable/2025-03-01/foo.json",
          new: "FOO/stable/2025-03-01/openapi.json",
        },
      ],
    },
  },
  {
    name: "convert two swaggers to one (TSP conversion)",
    changedFiles: {
      additions: ["specification/bar/data-plane/Bar/stable/2025-03-01/openapi.json"],
      deletions: [
        "specification/bar/data-plane/Bar/stable/2025-03-01/bar.json",
        "specification/bar/data-plane/Bar/stable/2025-03-01/baz.json",
      ],
    },
    expectedOadCalls: {
      // Comparisons are probably invalid, and will fail, but better than comparing to a dummy file
      sameVersion: [
        {
          old: "specification/bar/data-plane/Bar/stable/2025-03-01/bar.json",
          new: "specification/bar/data-plane/Bar/stable/2025-03-01/openapi.json",
        },
        {
          old: "specification/bar/data-plane/Bar/stable/2025-03-01/baz.json",
          new: "specification/bar/data-plane/Bar/stable/2025-03-01/openapi.json",
        },
      ],
    },
  },
  {
    name: "convert one swagger to two (very rare)",
    changedFiles: {
      additions: ["Foo/stable/2025-03-01/openapi1.json", "Foo/stable/2025-03-01/openapi2.json"],
      deletions: ["Foo/stable/2025-03-01/foo.json"],
    },
    expectedOadCalls: {
      // Comparisons are probably invalid, and will fail, but better than comparing to a dummy file
      sameVersion: [
        {
          old: "Foo/stable/2025-03-01/foo.json",
          new: "Foo/stable/2025-03-01/openapi1.json",
        },
        {
          old: "Foo/stable/2025-03-01/foo.json",
          new: "Foo/stable/2025-03-01/openapi2.json",
        },
      ],
    },
  },
];

describe("validateBreakingChange", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it.each(cases)(
    "$name",
    async ({ changedFiles, expectedCreateDummySwaggers, expectedOadCalls }) => {
      expectedCreateDummySwaggers = expectedCreateDummySwaggers || { old: [], new: [] };

      const finalExpectedOadCalls = {
        sameVersion: expectedOadCalls.sameVersion || [],
        crossVersion: expectedOadCalls.crossVersion || [],
      };

      // Prepend all input strings with the service parent folder (omitted from string literals for brevity)
      // Use string concat instead of path.join(), since test inputs are all posix paths, and resolved at runtime
      prependParentFolder(changedFiles, expectedCreateDummySwaggers, finalExpectedOadCalls);

      mockChangedFilesStatuses(changedFiles);

      const mockCreateDummySwagger = vi.mocked(createDummySwagger);

      const mockRunOad = vi.mocked(runOad).mockResolvedValue([]);

      for (const data of [
        {
          runType: BREAKING_CHANGES_CHECK_TYPES.SAME_VERSION,
          expectedOadCalls: finalExpectedOadCalls.sameVersion,
        },
        {
          runType: BREAKING_CHANGES_CHECK_TYPES.CROSS_VERSION,
          expectedOadCalls: finalExpectedOadCalls.crossVersion,
        },
      ]) {
        mockRunOad.mockClear();

        const statusCode = await validateBreakingChange({
          ...context,
          runType: data.runType,
        });

        expect(statusCode).toEqual(0);

        expect(mockCreateDummySwagger).toBeCalledTimes(
          expectedCreateDummySwaggers.old.length + expectedCreateDummySwaggers.new.length,
        );

        for (const expected of expectedCreateDummySwaggers.old) {
          expect(mockCreateDummySwagger).toBeCalledWith(
            expect.anything(),
            resolve(context.prInfo.tempRepoFolder, expected),
          );
        }

        for (const expected of expectedCreateDummySwaggers.new) {
          expect(mockCreateDummySwagger).toBeCalledWith(expect.anything(), resolve(expected));
        }

        expect(mockRunOad).toBeCalledTimes(data.expectedOadCalls.length);

        for (const expected of data.expectedOadCalls) {
          expect(mockRunOad).toBeCalledWith(
            path.join(context.prInfo.tempRepoFolder, expected.old),
            expected.new,
          );
        }
      }
    },
  );
});

function prependParentFolder(
  changedFiles: {
    additions?: string[];
    modifications?: string[];
    deletions?: string[];
    renames?: {
      from: string;
      to: string;
    }[];
  },
  expectedCreateDummySwaggers: { old: string[]; new: string[] },
  expectedOadCalls: {
    sameVersion: { old: string; new: string }[];
    crossVersion: { old: string; new: string }[];
  },
) {
  if (changedFiles.additions !== undefined) {
    changedFiles.additions = changedFiles.additions?.map((p) => serviceParent + p);
  }
  if (changedFiles.modifications !== undefined) {
    changedFiles.modifications = changedFiles.modifications?.map((p) => serviceParent + p);
  }
  if (changedFiles.deletions !== undefined) {
    changedFiles.deletions = changedFiles.deletions?.map((p) => serviceParent + p);
  }
  if (changedFiles.renames !== undefined) {
    changedFiles.renames = changedFiles.renames?.map((r) => ({
      from: serviceParent + r.from,
      to: serviceParent + r.to,
    }));
  }

  expectedCreateDummySwaggers.old = expectedCreateDummySwaggers.old.map((p) => serviceParent + p);
  expectedCreateDummySwaggers.new = expectedCreateDummySwaggers.new.map((p) => serviceParent + p);

  expectedOadCalls.sameVersion = expectedOadCalls.sameVersion.map((c) => ({
    old: serviceParent + c.old,
    new: serviceParent + c.new,
  }));
  expectedOadCalls.crossVersion = expectedOadCalls.crossVersion.map((c) => ({
    old: serviceParent + c.old,
    new: serviceParent + c.new,
  }));
}
