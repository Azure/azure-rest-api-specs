// @ts-check

import { afterEach, describe, expect, it, vi } from "vitest";

vi.mock("simple-git", () => ({
  simpleGit: vi.fn().mockReturnValue({
    diff: vi.fn().mockResolvedValue(""),
  }),
}));

import * as simpleGit from "simple-git";
import {
  dataPlane,
  example,
  getChangedFiles,
  getChangedFilesStatuses,
  json,
  readme,
  resourceManager,
  scenario,
  specification,
  swagger,
} from "../src/changed-files.js";
import { debugLogger } from "../src/logger.js";

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

    vi.mocked(simpleGit.simpleGit().diff).mockResolvedValue(files.join("\n"));

    await expect(getChangedFiles(options)).resolves.toEqual(files);
  });

  const files = [
    "cspell.json",
    "cspell.yaml",
    "MixedCase.jSoN",
    "README.MD",
    "specification/contosowidgetmanager/data-plane/readme.md",
    "specification/contosowidgetmanager/Contoso.Management/main.tsp",
    "specification/contosowidgetmanager/Contoso.Management/examples/2021-11-01/Employees_Get.json",
    "specification/contosowidgetmanager/resource-manager/readme.md",
    "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
    "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Get.json",
    "specification/contosowidgetmanager/Contoso.Management/scenarios/2021-11-01/Employees_Get.json",
  ];

  it("filter:json", () => {
    const expected = [
      "cspell.json",
      "MixedCase.jSoN",
      "specification/contosowidgetmanager/Contoso.Management/examples/2021-11-01/Employees_Get.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Get.json",
      "specification/contosowidgetmanager/Contoso.Management/scenarios/2021-11-01/Employees_Get.json",
    ];

    expect(files.filter(json)).toEqual(expected);
  });

  it("filter:readme", () => {
    const expected = [
      "README.MD",
      "specification/contosowidgetmanager/data-plane/readme.md",
      "specification/contosowidgetmanager/resource-manager/readme.md",
    ];

    expect(files.filter(readme)).toEqual(expected);
  });

  it("filter:specification", () => {
    const expected = [
      "specification/contosowidgetmanager/data-plane/readme.md",
      "specification/contosowidgetmanager/Contoso.Management/main.tsp",
      "specification/contosowidgetmanager/Contoso.Management/examples/2021-11-01/Employees_Get.json",
      "specification/contosowidgetmanager/resource-manager/readme.md",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Get.json",
      "specification/contosowidgetmanager/Contoso.Management/scenarios/2021-11-01/Employees_Get.json",
    ];

    expect(files.filter(specification)).toEqual(expected);
  });

  it("filter:data-plane", () => {
    const expected = ["specification/contosowidgetmanager/data-plane/readme.md"];

    expect(files.filter(dataPlane)).toEqual(expected);
  });

  it("filter:resource-manager", () => {
    const expected = [
      "specification/contosowidgetmanager/resource-manager/readme.md",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Get.json",
    ];

    expect(files.filter(resourceManager)).toEqual(expected);
  });

  it("filter:example", () => {
    const expected = [
      "specification/contosowidgetmanager/Contoso.Management/examples/2021-11-01/Employees_Get.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Get.json",
    ];

    expect(files.filter(example)).toEqual(expected);
  });

  it("filter:scenarios", () => {
    const expected = [
      "specification/contosowidgetmanager/Contoso.Management/scenarios/2021-11-01/Employees_Get.json",
    ];

    expect(files.filter(scenario)).toEqual(expected);
  });

  it("filter:swagger", () => {
    const expected = [
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
    ];

    expect(files.filter(swagger)).toEqual(expected);
  });

  describe("getChangedFilesStatuses", () => {
    it.each([{}, { logger: debugLogger }])(
      "should categorize files correctly with all types of changes (%o)",
      async (options) => {
        const gitOutput = [
          "A\tspecification/new-service/readme.md",
          "M\tspecification/existing-service/main.tsp",
          "D\tspecification/old-service/contoso.json",
          "R100\tspecification/service/old-name.json\tspecification/service/new-name.json",
          "C90\tspecification/template/base.json\tspecification/service/derived.json",
          "T\tspecification/service/type-changed.json",
        ].join("\n");

        vi.mocked(simpleGit.simpleGit().diff).mockResolvedValue(gitOutput);
        const result = await getChangedFilesStatuses(options);
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
      },
    );

    it("should handle empty git output", async () => {
      vi.mocked(simpleGit.simpleGit().diff).mockResolvedValue("");
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
      const gitOutput = [
        "A\tspecification/service1/readme.md",
        "A\tspecification/service2/main.tsp",
      ].join("\n");

      vi.mocked(simpleGit.simpleGit().diff).mockResolvedValue(gitOutput);
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
      const gitOutput = [
        "R95\told/path/file1.json\tnew/path/file1.json",
        "R100\tservice/old.tsp\tservice/new.tsp",
      ].join("\n");

      vi.mocked(simpleGit.simpleGit().diff).mockResolvedValue(gitOutput);
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

      vi.mocked(simpleGit.simpleGit().diff).mockResolvedValue("A\ttest.json");
      await getChangedFilesStatuses(options);
      expect(simpleGit.simpleGit).toHaveBeenCalledWith("/custom/path");
      expect(simpleGit.simpleGit().diff).toHaveBeenCalledWith([
        "--name-status",
        "origin/main",
        "feature-branch",
      ]);
    });
  });
});
