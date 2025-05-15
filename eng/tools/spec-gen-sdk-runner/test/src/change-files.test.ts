import { describe, test, expect, vi, beforeEach } from "vitest";
import { detectChangedSpecConfigFiles } from "../../src/change-files.js";
import * as utils from "../../src/utils.js";
import { SpecGenSdkCmdInput } from "../../src/types.js";
import { fileURLToPath } from "node:url";
import path from "node:path";
import { type ChangedSpecs, normalizePath } from "../../src/utils.js";

vi.mock("../../src/utils.js", async () => {
  const actual = await vi.importActual<typeof import("../../src/utils.js")>("../../src/utils.js");

  return {
    ...actual,
    getChangedFiles: vi.fn(),
  };
});

function normalizeResultItem(item: ChangedSpecs): ChangedSpecs {
  return {
    specs: item.specs.map(path => normalizePath(path)),
    ...(item.readmeMd ? { readmeMd: normalizePath(item.readmeMd) } : {}),
    ...(item.typespecProject ? { typespecProject: normalizePath(item.typespecProject) } : {}),
  };
}

describe("detectChangedSpecConfigFiles", () => {
  const currentFilePath = fileURLToPath(import.meta.url);
  const repoRoot = path.resolve(path.dirname(currentFilePath), "../fixtures/");

  const mockCommandInput: SpecGenSdkCmdInput = {
    localSpecRepoPath: repoRoot,
    workingFolder: "",
    runMode: "",
    localSdkRepoPath: "",
    sdkRepoName: "",
    sdkLanguage: "",
    specCommitSha: "",
    specRepoHttpsUrl: "",
  };

  beforeEach(() => {
    vi.clearAllMocks();
  });

  test("case with empty change files", () => {
    vi.mocked(utils.getChangedFiles).mockReturnValue([]);
    const result = detectChangedSpecConfigFiles(mockCommandInput);
    expect(result).toEqual([]);
  });

  test("case with readme files", () => {
    vi.mocked(utils.getChangedFiles).mockReturnValue([
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json",
      "specification/contosowidgetmanager/data-plane/Azure.Contoso.WidgetManager/preview/2022-11-01-preview/widgets.json",
    ]);

    const result = detectChangedSpecConfigFiles(mockCommandInput);

    expect(result).toHaveLength(2);
    expect(normalizeResultItem(result[0])).toEqual({
      specs: [
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json",
      ],
      readmeMd: "specification/contosowidgetmanager/resource-manager/readme.md",
    });
    expect(normalizeResultItem(result[1])).toEqual({
      specs: [
        "specification/contosowidgetmanager/data-plane/Azure.Contoso.WidgetManager/preview/2022-11-01-preview/widgets.json",
      ],
      readmeMd: "specification/contosowidgetmanager/data-plane/readme.md",
    });
  });

  test("case with tsp files", () => {
    vi.mocked(utils.getChangedFiles).mockReturnValue([
      "specification/contosowidgetmanager/Contoso.Management/main.tsp",
      "specification/contosowidgetmanager/Contoso.Management/client.tsp",
      "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
    ]);

    const result = detectChangedSpecConfigFiles(mockCommandInput);

    expect(result).toHaveLength(2);
    expect(normalizeResultItem(result[0])).toEqual({
      specs: [
        "specification/contosowidgetmanager/Contoso.Management/main.tsp",
        "specification/contosowidgetmanager/Contoso.Management/client.tsp",
      ],
      typespecProject: "specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml",
    });
    expect(normalizeResultItem(result[1])).toEqual({
      specs: ["specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml"],
      typespecProject: "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
    });
  });

  test("case with shared files", () => {
    vi.mocked(utils.getChangedFiles).mockReturnValue([
      "specification/contosowidgetmanager/Contoso.WidgetManager.Shared/main.tsp",
      "specification/contosowidgetmanager/Contoso.Management/client.tsp",
      "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
    ]);

    const result = detectChangedSpecConfigFiles(mockCommandInput);

    expect(result).toHaveLength(2);
    expect(normalizeResultItem(result[0])).toEqual({
      specs: ["specification/contosowidgetmanager/Contoso.Management/client.tsp"],
      typespecProject: "specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml",
    });
    expect(normalizeResultItem(result[1])).toEqual({
      specs: [
        "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
        "specification/contosowidgetmanager/Contoso.WidgetManager.Shared/main.tsp",
      ],
      typespecProject: "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
    });
  });

  test("case with readme, tsp, shared files", () => {
    vi.mocked(utils.getChangedFiles).mockReturnValue([
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json",
      "specification/contosowidgetmanager/data-plane/Azure.Contoso.WidgetManager/preview/2022-11-01-preview/widgets.json",
      "specification/contosowidgetmanager/Contoso.WidgetManager.Shared/main.tsp",
      "specification/contosowidgetmanager/Contoso.Management/client.tsp",
      "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
    ]);

    const result = detectChangedSpecConfigFiles(mockCommandInput);

    expect(result).toHaveLength(2);
    expect(normalizeResultItem(result[0])).toEqual({
      specs: [
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json",
        "specification/contosowidgetmanager/Contoso.Management/client.tsp",
      ],
      readmeMd: "specification/contosowidgetmanager/resource-manager/readme.md",
      typespecProject: "specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml",
    });
    expect(normalizeResultItem(result[1])).toEqual({
      specs: [
        "specification/contosowidgetmanager/data-plane/Azure.Contoso.WidgetManager/preview/2022-11-01-preview/widgets.json",
        "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
        "specification/contosowidgetmanager/Contoso.WidgetManager.Shared/main.tsp",
      ],
      readmeMd: "specification/contosowidgetmanager/data-plane/readme.md",
      typespecProject: "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
    });
  });
});
