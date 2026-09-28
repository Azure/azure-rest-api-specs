import { afterEach, describe, expect, it, vi } from "vitest";

const mockDiff = vi.hoisted(() => vi.fn().mockResolvedValue(""));

vi.mock("simple-git", () => ({
  simpleGit: vi.fn().mockReturnValue({
    diff: mockDiff,
  }),
}));

import { resolve } from "path";
import * as simpleGit from "simple-git";
import {
  dataPlane,
  example,
  getChangedFiles,
  getChangedFilesStatuses,
  json,
  markdown,
  preview,
  quickstartTemplate,
  readme,
  resourceManager,
  scenario,
  stable,
  swagger,
  tsp,
  tspconfig,
  typespec,
} from "../src/changed-files.ts";
import { debugLogger } from "../src/logger.ts";

describe("changedFiles", () => {
  afterEach(() => {
    vi.clearAllMocks();
  });

  it.each([{}, { logger: debugLogger }])(`getChangedFiles(%o)`, async (options) => {
    const files = [
      ".github/src/changed-files.js",
      "specification/contosowidgetmanager/Contoso.Management/main.tsp",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Get.json",
    ];

    mockDiff.mockResolvedValue(files.join("\0") + "\0");

    await expect(getChangedFiles(options)).resolves.toEqual(files);
    expect(mockDiff).toHaveBeenCalledWith(["--name-only", "-z", "HEAD^", "HEAD"]);

    const specFiles = files.filter((f) => f.startsWith("specification"));
    mockDiff.mockResolvedValue(specFiles.join("\0") + "\0");
    await expect(getChangedFiles({ ...options, paths: ["specification"] })).resolves.toEqual(
      specFiles,
    );
    expect(mockDiff).toHaveBeenCalledWith([
      "--name-only",
      "-z",
      "HEAD^",
      "HEAD",
      "--",
      "specification",
    ]);
  });

  it("getChangedFiles returns empty array when no files are changed", async () => {
    mockDiff.mockResolvedValue("");
    await expect(getChangedFiles()).resolves.toEqual([]);
    expect(mockDiff).toHaveBeenCalledWith(["--name-only", "-z", "HEAD^", "HEAD"]);
  });

  it("getChangedFiles accepts gitOptions parameter", async () => {
    const files = ["file1.json", "file2.json"];
    mockDiff.mockResolvedValue(files.join("\0") + "\0");

    await expect(getChangedFiles({ gitOptions: ["--no-renames"] })).resolves.toEqual(files);
    expect(mockDiff).toHaveBeenCalledWith(["--name-only", "-z", "--no-renames", "HEAD^", "HEAD"]);
  });

  it("getChangedFiles preserves non-ASCII names, quotes, backslashes, and whitespace", async () => {
    const files = [
      " leading.json",
      "caf\u00e9.json",
      'quote".json',
      "back\\slash.json",
      "tab\tname.json",
      "line\nname.json",
      "trailing.json ",
    ];
    mockDiff.mockResolvedValue(files.join("\0") + "\0");
    await expect(getChangedFiles()).resolves.toEqual(files);
  });

  const readers = [
    { name: "getChangedFiles", read: getChangedFiles },
    { name: "getChangedFilesStatuses", read: getChangedFilesStatuses },
  ];

  it.each(readers)("$name does not mutate reusable path filters", async ({ read }) => {
    mockDiff.mockResolvedValue("");
    const paths = ["specification"];
    await read({ paths });
    await read({ paths });
    expect(paths).toEqual(["specification"]);
    expect(mockDiff.mock.calls[0]).toEqual(mockDiff.mock.calls[1]);
  });

  it.each(readers)("$name propagates Git errors", async ({ read }) => {
    const error = new Error("Invalid revision");
    mockDiff.mockRejectedValueOnce(error);
    await expect(read()).rejects.toBe(error);
  });

  it("getChangedFiles accepts multiple gitOptions", async () => {
    const files = ["file1.json"];
    mockDiff.mockResolvedValue(files.join("\0") + "\0");

    await expect(
      getChangedFiles({ gitOptions: ["--no-renames", "--find-copies"] }),
    ).resolves.toEqual(files);
    expect(mockDiff).toHaveBeenCalledWith([
      "--name-only",
      "-z",
      "--no-renames",
      "--find-copies",
      "HEAD^",
      "HEAD",
    ]);
  });

  const files = [
    "CONTRIBUTING.MD",
    "cspell.json",
    "cspell.yaml",
    "MixedCase.jSoN",
    "MixedCase.mD",
    "README.MD",
    "not-spec/contosowidgetmanager/data-plane/readme.md",
    "not-spec/contosowidgetmanager/resource-manager/readme.md",
    "not-spec/contosowidgetmanager/Contoso.Management/main.tsp",
    "not-spec/contosowidgetmanager/Contoso.Management/tspconfig.yaml",
    "not-spec/contosowidgetmanager/Contoso.Management/examples/2021-11-01/Employees_Get.json",
    "not-spec/contosowidgetmanager/Contoso.Management/examples/2021-12-01-preview/Employees_Get.json",
    "not-spec/contosowidgetmanager/Contoso.Management/scenarios/2021-11-01/Employees_Get.json",
    "not-spec/contosowidgetmanager/Contoso.Management/scenarios/2021-12-01-preview/Employees_Get.json",
    "not-spec/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-12-01-preview/contoso.json",
    "not-spec/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
    "specification/contosowidgetmanager/data-plane/readme.md",
    "specification/contosowidgetmanager/Contoso.Management/main.tsp",
    "specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml",
    "specification/contosowidgetmanager/Contoso.Management/examples/2021-11-01/Employees_Get.json",
    "specification/contosowidgetmanager/Contoso.Management/examples/2021-12-01-preview/Employees_Get.json",
    "specification/contosowidgetmanager/resource-manager/readme.md",
    "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-12-01-preview/contoso.json",
    "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-12-01-preview/examples/Employees_Get.json",
    "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
    "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Get.json",
    "specification/contosowidgetmanager/Contoso.Management/scenarios/2021-11-01/Employees_Get.json",
    "specification/contosowidgetmanager/Contoso.Management/scenarios/2021-12-01-preview/Employees_Get.json",
    "specification/compute/quickstart-templates/swagger.json",
  ];

  const filesResolved = files.map((f) => resolve(f));

  it("filter:json", () => {
    const expected = [
      "cspell.json",
      "MixedCase.jSoN",
      "not-spec/contosowidgetmanager/Contoso.Management/examples/2021-11-01/Employees_Get.json",
      "not-spec/contosowidgetmanager/Contoso.Management/examples/2021-12-01-preview/Employees_Get.json",
      "not-spec/contosowidgetmanager/Contoso.Management/scenarios/2021-11-01/Employees_Get.json",
      "not-spec/contosowidgetmanager/Contoso.Management/scenarios/2021-12-01-preview/Employees_Get.json",
      "not-spec/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-12-01-preview/contoso.json",
      "not-spec/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      "specification/contosowidgetmanager/Contoso.Management/examples/2021-11-01/Employees_Get.json",
      "specification/contosowidgetmanager/Contoso.Management/examples/2021-12-01-preview/Employees_Get.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-12-01-preview/contoso.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-12-01-preview/examples/Employees_Get.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Get.json",
      "specification/contosowidgetmanager/Contoso.Management/scenarios/2021-11-01/Employees_Get.json",
      "specification/contosowidgetmanager/Contoso.Management/scenarios/2021-12-01-preview/Employees_Get.json",
      "specification/compute/quickstart-templates/swagger.json",
    ];

    expect(files.filter(json)).toEqual(expected);
    expect(filesResolved.filter(json)).toEqual(expected.map((f) => resolve(f)));
  });

  it("filter:markdown", () => {
    const expected = [
      "CONTRIBUTING.MD",
      "MixedCase.mD",
      "README.MD",
      "not-spec/contosowidgetmanager/data-plane/readme.md",
      "not-spec/contosowidgetmanager/resource-manager/readme.md",
      "specification/contosowidgetmanager/data-plane/readme.md",
      "specification/contosowidgetmanager/resource-manager/readme.md",
    ];

    expect(files.filter(markdown)).toEqual(expected);
    expect(filesResolved.filter(markdown)).toEqual(expected.map((f) => resolve(f)));
  });

  it("filter:readme", () => {
    const expected = [
      "README.MD",
      "not-spec/contosowidgetmanager/data-plane/readme.md",
      "not-spec/contosowidgetmanager/resource-manager/readme.md",
      "specification/contosowidgetmanager/data-plane/readme.md",
      "specification/contosowidgetmanager/resource-manager/readme.md",
    ];

    expect(files.filter(readme)).toEqual(expected);
    expect(filesResolved.filter(readme)).toEqual(expected.map((f) => resolve(f)));
  });

  it("filter:tsp", () => {
    const expected = [
      "not-spec/contosowidgetmanager/Contoso.Management/main.tsp",
      "specification/contosowidgetmanager/Contoso.Management/main.tsp",
    ];
    expect(files.filter(tsp)).toEqual(expected);
  });

  it("filter:tspconfig", () => {
    const expected = [
      "not-spec/contosowidgetmanager/Contoso.Management/tspconfig.yaml",
      "specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml",
    ];
    expect(files.filter(tspconfig)).toEqual(expected);
  });

  it("filter:typespec", () => {
    const expected = [
      "not-spec/contosowidgetmanager/Contoso.Management/main.tsp",
      "not-spec/contosowidgetmanager/Contoso.Management/tspconfig.yaml",
      "specification/contosowidgetmanager/Contoso.Management/main.tsp",
      "specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml",
    ];
    expect(files.filter(typespec)).toEqual(expected);
  });

  it("filter:data-plane", () => {
    const expected = [
      "not-spec/contosowidgetmanager/data-plane/readme.md",
      "specification/contosowidgetmanager/data-plane/readme.md",
    ];

    expect(files.filter(dataPlane)).toEqual(expected);
    expect(filesResolved.filter(dataPlane)).toEqual(expected.map((f) => resolve(f)));
  });

  it("filter:resource-manager", () => {
    const expected = [
      "not-spec/contosowidgetmanager/resource-manager/readme.md",
      "not-spec/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-12-01-preview/contoso.json",
      "not-spec/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      "specification/contosowidgetmanager/resource-manager/readme.md",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-12-01-preview/contoso.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-12-01-preview/examples/Employees_Get.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Get.json",
    ];

    expect(files.filter(resourceManager)).toEqual(expected);
    expect(filesResolved.filter(resourceManager)).toEqual(expected.map((f) => resolve(f)));
  });

  it("filter:preview", () => {
    const expected = [
      "not-spec/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-12-01-preview/contoso.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-12-01-preview/contoso.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-12-01-preview/examples/Employees_Get.json",
    ];

    expect(files.filter(preview)).toEqual(expected);
    expect(filesResolved.filter(preview)).toEqual(expected.map((f) => resolve(f)));
  });

  it("filter:stable", () => {
    const expected = [
      "not-spec/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Get.json",
    ];

    expect(files.filter(stable)).toEqual(expected);
    expect(filesResolved.filter(stable)).toEqual(expected.map((f) => resolve(f)));
  });

  it("filter:example", () => {
    const expected = [
      "not-spec/contosowidgetmanager/Contoso.Management/examples/2021-11-01/Employees_Get.json",
      "not-spec/contosowidgetmanager/Contoso.Management/examples/2021-12-01-preview/Employees_Get.json",
      "specification/contosowidgetmanager/Contoso.Management/examples/2021-11-01/Employees_Get.json",
      "specification/contosowidgetmanager/Contoso.Management/examples/2021-12-01-preview/Employees_Get.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-12-01-preview/examples/Employees_Get.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Get.json",
    ];

    expect(files.filter(example)).toEqual(expected);
    expect(filesResolved.filter(example)).toEqual(expected.map((f) => resolve(f)));
  });

  it("filter:quickstartTemplate", () => {
    const expected = ["specification/compute/quickstart-templates/swagger.json"];

    expect(files.filter(quickstartTemplate)).toEqual(expected);
  });

  it("filter:scenarios", () => {
    const expected = [
      "not-spec/contosowidgetmanager/Contoso.Management/scenarios/2021-11-01/Employees_Get.json",
      "not-spec/contosowidgetmanager/Contoso.Management/scenarios/2021-12-01-preview/Employees_Get.json",
      "specification/contosowidgetmanager/Contoso.Management/scenarios/2021-11-01/Employees_Get.json",
      "specification/contosowidgetmanager/Contoso.Management/scenarios/2021-12-01-preview/Employees_Get.json",
    ];

    expect(files.filter(scenario)).toEqual(expected);
    expect(filesResolved.filter(scenario)).toEqual(expected.map((f) => resolve(f)));
  });

  it("filter:swagger", () => {
    const expected = [
      "not-spec/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-12-01-preview/contoso.json",
      "not-spec/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-12-01-preview/contoso.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
    ];

    expect(files.filter(swagger)).toEqual(expected);
    expect(filesResolved.filter(swagger)).toEqual(expected.map((f) => resolve(f)));
  });

  describe("getChangedFilesStatuses", () => {
    it.each([{}, { logger: debugLogger }])(
      "should categorize files correctly with all types of changes (%o)",
      async (options) => {
        const records = [
          ["M", ".github/src/changed-files.js"],
          ["A", "specification/new-service/readme.md"],
          ["M", "specification/existing-service/main.tsp"],
          ["D", "specification/old-service/contoso.json"],
          ["R100", "specification/service/old-name.json", "specification/service/new-name.json"],
          ["C90", "specification/template/base.json", "specification/service/derived.json"],
          ["T", "specification/service/type-changed.json"],
        ];
        const gitOutput = records.flat().join("\0") + "\0";

        mockDiff.mockResolvedValue(gitOutput);
        let result = await getChangedFilesStatuses(options);
        expect(result).toEqual({
          additions: ["specification/new-service/readme.md", "specification/service/derived.json"],
          modifications: [
            ".github/src/changed-files.js",
            "specification/existing-service/main.tsp",
            "specification/service/type-changed.json",
          ],
          deletions: ["specification/old-service/contoso.json"],
          renames: [
            {
              from: "specification/service/old-name.json",
              to: "specification/service/new-name.json",
            },
          ],
          total: 7,
        });
        expect(mockDiff).toHaveBeenCalledWith(["--name-status", "-z", "HEAD^", "HEAD"]);

        const specGitOutput =
          records
            .filter((record) => record[1].startsWith("specification/"))
            .flat()
            .join("\0") + "\0";
        mockDiff.mockResolvedValue(specGitOutput);
        result = await getChangedFilesStatuses({ ...options, paths: ["specification"] });
        expect(result).toEqual({
          additions: ["specification/new-service/readme.md", "specification/service/derived.json"],
          modifications: [
            "specification/existing-service/main.tsp",
            "specification/service/type-changed.json",
          ],
          deletions: ["specification/old-service/contoso.json"],
          renames: [
            {
              from: "specification/service/old-name.json",
              to: "specification/service/new-name.json",
            },
          ],
          total: 6,
        });
        expect(mockDiff).toHaveBeenCalledWith([
          "--name-status",
          "-z",
          "HEAD^",
          "HEAD",
          "--",
          "specification",
        ]);
      },
    );

    it("should handle empty git output", async () => {
      mockDiff.mockResolvedValue("");
      const result = await getChangedFilesStatuses();
      expect(result).toEqual({
        additions: [],
        modifications: [],
        deletions: [],
        renames: [],
        total: 0,
      });
    });

    it("should handle only additions", async () => {
      const gitOutput =
        ["A", "specification/service1/readme.md", "A", "specification/service2/main.tsp"].join(
          "\0",
        ) + "\0";

      mockDiff.mockResolvedValue(gitOutput);
      const result = await getChangedFilesStatuses();
      expect(result).toEqual({
        additions: ["specification/service1/readme.md", "specification/service2/main.tsp"],
        modifications: [],
        deletions: [],
        renames: [],
        total: 2,
      });
    });

    it("should handle only renames", async () => {
      const gitOutput =
        [
          "R95",
          "old/path/file1.json",
          "new/path/file1.json",
          "R100",
          "service/old.tsp",
          "service/new.tsp",
        ].join("\0") + "\0";

      mockDiff.mockResolvedValue(gitOutput);
      const result = await getChangedFilesStatuses();
      expect(result).toEqual({
        additions: [],
        modifications: [],
        deletions: [],
        renames: [
          {
            from: "old/path/file1.json",
            to: "new/path/file1.json",
          },
          {
            from: "service/old.tsp",
            to: "service/new.tsp",
          },
        ],
        total: 2,
      });
    });

    it("should pass git options correctly", async () => {
      const options = {
        baseCommitish: "origin/main",
        headCommitish: "feature-branch",
        cwd: "/custom/path",
      };

      mockDiff.mockResolvedValue("A\0test.json\0");
      await getChangedFilesStatuses(options);
      expect(simpleGit.simpleGit).toHaveBeenCalledWith("/custom/path");
      expect(mockDiff).toHaveBeenCalledWith([
        "--name-status",
        "-z",
        "origin/main",
        "feature-branch",
      ]);
    });

    it("should accept gitOptions parameter", async () => {
      mockDiff.mockResolvedValue("A\0file1.json\0M\0file2.json\0");
      const result = await getChangedFilesStatuses({ gitOptions: ["--no-renames"] });
      expect(result).toEqual({
        additions: ["file1.json"],
        modifications: ["file2.json"],
        deletions: [],
        renames: [],
        total: 2,
      });
      expect(mockDiff).toHaveBeenCalledWith([
        "--name-status",
        "-z",
        "--no-renames",
        "HEAD^",
        "HEAD",
      ]);
    });

    it("should accept multiple gitOptions", async () => {
      mockDiff.mockResolvedValue("A\0file1.json\0");
      const result = await getChangedFilesStatuses({
        gitOptions: ["--no-renames", "--find-copies"],
      });
      expect(result).toEqual({
        additions: ["file1.json"],
        modifications: [],
        deletions: [],
        renames: [],
        total: 1,
      });
      expect(mockDiff).toHaveBeenCalledWith([
        "--name-status",
        "-z",
        "--no-renames",
        "--find-copies",
        "HEAD^",
        "HEAD",
      ]);
    });

    it("should log categories selectively with a logger", async () => {
      // When only some categories are populated and a logger is provided, the per-category
      // if-blocks whose category is empty should take their false branch.
      const gitOutput =
        ["A", "specification/service1/readme.md", "A", "specification/service2/main.tsp"].join(
          "\0",
        ) + "\0";

      mockDiff.mockResolvedValue(gitOutput);
      const result = await getChangedFilesStatuses({ logger: debugLogger });
      expect(result).toEqual({
        additions: ["specification/service1/readme.md", "specification/service2/main.tsp"],
        modifications: [],
        deletions: [],
        renames: [],
        total: 2,
      });

      // Also test with no additions so the additions log block's false branch is covered
      const gitOutputNoAdditions = "M\0specification/service1/readme.md\0";
      mockDiff.mockResolvedValue(gitOutputNoAdditions);
      const result2 = await getChangedFilesStatuses({ logger: debugLogger });
      expect(result2).toEqual({
        additions: [],
        modifications: ["specification/service1/readme.md"],
        deletions: [],
        renames: [],
        total: 1,
      });
    });

    it("preserves literal filenames across mixed status records", async () => {
      const records = [
        ["A", " leading.json"],
        ["M", "line\nbreak.json"],
        ["D", 'quote".json'],
        ["R100", "old\tname.json", "new\nname.json"],
        ["C75", "back\\slash.json", "caf\u00e9.json"],
        ["M", "trailing.json "],
      ];
      mockDiff.mockResolvedValue(records.flat().join("\0") + "\0");
      await expect(getChangedFilesStatuses()).resolves.toEqual({
        additions: [" leading.json", "caf\u00e9.json"],
        modifications: ["line\nbreak.json", "trailing.json "],
        deletions: ['quote".json'],
        renames: [{ from: "old\tname.json", to: "new\nname.json" }],
        total: 6,
      });
    });

    it.each(["M", "M\0\0", "\0file.json\0"])(
      "rejects incomplete status records: %j",
      async (output) => {
        mockDiff.mockResolvedValue(output);
        await expect(getChangedFilesStatuses()).rejects.toThrow(
          "Invalid NUL-delimited git diff --name-status output",
        );
      },
    );

    it.each(["R100", "C75"])("rejects a %s record without its destination", async (status) => {
      mockDiff.mockResolvedValue(`${status}\0source.json\0`);
      await expect(getChangedFilesStatuses()).rejects.toThrow(
        "Missing destination in git diff rename/copy record",
      );
    });
  });
});
