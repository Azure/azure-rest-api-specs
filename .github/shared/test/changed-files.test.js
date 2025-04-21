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
  json,
  readme,
  resourceManager,
  specification,
  swagger,
} from "../src/changed-files.js";
import { consoleLogger } from "../src/logger.js";

describe("changedFiles", () => {
  afterEach(() => {
    vi.clearAllMocks();
  });

  it.each([{}, { logger: consoleLogger }])(
    `getChangedFiles(%o)`,
    async (options) => {
      const files = [
        ".github/src/changed-files.js",
        "specification/contosowidgetmanager/Contoso.Management/main.tsp",
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Get.json",
      ];

      vi.mocked(simpleGit.simpleGit().diff).mockResolvedValue(files.join("\n"));

      await expect(getChangedFiles(options)).resolves.toEqual(files);
    },
  );

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
  ];

  it("filter:json", () => {
    const expected = [
      "cspell.json",
      "MixedCase.jSoN",
      "specification/contosowidgetmanager/Contoso.Management/examples/2021-11-01/Employees_Get.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Get.json",
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
    ];

    expect(files.filter(specification)).toEqual(expected);
  });

  it("filter:data-plane", () => {
    const expected = [
      "specification/contosowidgetmanager/data-plane/readme.md",
    ];

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

  it("filter:swagger", () => {
    const expected = [
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
    ];

    expect(files.filter(swagger)).toEqual(expected);
  });
});
