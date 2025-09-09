import path from "node:path";
import { fileURLToPath } from "node:url";
import { beforeEach, describe, expect, test, vi } from "vitest";
import {
  detectChangedSpecConfigFiles,
  groupSpecConfigPaths,
  processTypeSpecProjectsV2FolderStructure,
} from "../src/spec-helpers.js";
import { SpecGenSdkCmdInput } from "../src/types.js";
import {
  type ChangedSpecs,
  type SpecConfigs,
  getChangedFiles,
  normalizePath,
} from "../src/utils.js";

vi.mock("../src/utils.js", async () => {
  const actual = await vi.importActual<typeof import("../src/utils.js")>("../src/utils.js");

  return {
    ...actual,
    getChangedFiles: vi.fn(),
  };
});

function normalizeResultItem(item: ChangedSpecs): ChangedSpecs {
  return {
    specs: item.specs.map((path) => normalizePath(path)),
    ...(item.readmeMd ? { readmeMd: normalizePath(item.readmeMd) } : {}),
    ...(item.typespecProject ? { typespecProject: normalizePath(item.typespecProject) } : {}),
  };
}

/**
 * Normalizes all path properties in an array of SpecConfigs objects
 * @param configsArray - Array of SpecConfigs objects to normalize
 * @returns A new array with normalized path properties
 */
function normalizeSpecConfigsArray(configsArray: SpecConfigs[]): SpecConfigs[] {
  return configsArray.map((config) => {
    return {
      ...(config.readmePath ? { readmePath: normalizePath(config.readmePath) } : {}),
      ...(config.tspconfigPath ? { tspconfigPath: normalizePath(config.tspconfigPath) } : {}),
    };
  });
}

describe("detectChangedSpecConfigFiles", () => {
  const currentFilePath = fileURLToPath(import.meta.url);
  const repoRoot = path.resolve(path.dirname(currentFilePath), "fixtures/");

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
    vi.mocked(getChangedFiles).mockReturnValue([]);
    const result = detectChangedSpecConfigFiles(mockCommandInput);
    expect(result).toEqual([]);
  });

  test("case with changed files but none under specification folder", () => {
    vi.mocked(getChangedFiles).mockReturnValue([
      "eng/tools/script1.js",
      "documentation/README.md",
      "profile/2020-09-01-hybrid.json",
    ]);
    const result = detectChangedSpecConfigFiles(mockCommandInput);
    expect(result).toEqual([]);
  });

  test("case with changed files only under scenarios folder", () => {
    vi.mocked(getChangedFiles).mockReturnValue([
      "specification/storage/scenarios/test1.json",
      "specification/compute/scenarios/test2.json",
    ]);
    const result = detectChangedSpecConfigFiles(mockCommandInput);
    expect(result).toEqual([]);
  });

  test("case with readme files", () => {
    vi.mocked(getChangedFiles).mockReturnValue([
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
    vi.mocked(getChangedFiles).mockReturnValue([
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
    vi.mocked(getChangedFiles).mockReturnValue([
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
    vi.mocked(getChangedFiles).mockReturnValue([
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

  test("case with V2 folder structure - resource-manager", () => {
    vi.mocked(getChangedFiles).mockReturnValue([
      "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/tspconfig.yaml",
      "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/main.tsp",
      "specification/service1/resource-manager/readme.md",
    ]);

    const result = detectChangedSpecConfigFiles(mockCommandInput);

    expect(result).toHaveLength(1);
    const normalizedResult = normalizeResultItem(result[0]);

    // In V2 structure, the TypeSpec project should be correctly associated with the readme
    expect(normalizedResult).toEqual({
      specs: [
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/tspconfig.yaml",
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/main.tsp",
      ],
      readmeMd:
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/readme.md",
      typespecProject:
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/tspconfig.yaml",
    });
  });

  test("case with V2 folder structure - data-plane", () => {
    vi.mocked(getChangedFiles).mockReturnValue([
      "specification/service1/data-plane/widget/tspconfig.yaml",
      "specification/service1/data-plane/widget/main.tsp",
      "specification/service1/data-plane/readme.md",
    ]);

    const result = detectChangedSpecConfigFiles(mockCommandInput);

    expect(result).toHaveLength(1);
    const normalizedResult = normalizeResultItem(result[0]);

    // In V2 structure, the TypeSpec project should be correctly associated with the readme
    expect(normalizedResult).toEqual({
      specs: [
        "specification/service1/data-plane/widget/tspconfig.yaml",
        "specification/service1/data-plane/widget/main.tsp",
      ],
      readmeMd: "specification/service1/data-plane/widget/readme.md",
      typespecProject: "specification/service1/data-plane/widget/tspconfig.yaml",
    });
  });

  test("case with V2 folder structure - nested subfolders", () => {
    vi.mocked(getChangedFiles).mockReturnValue([
      "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/examples/2021-11-01/create.json",
      "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/stable/2021-11-01/servicecontrol.json",
      "specification/service1/resource-manager/Microsoft.Service1/readme.md",
      "specification/service1/resource-manager/readme.md",
    ]);

    const result = detectChangedSpecConfigFiles(mockCommandInput);

    expect(result).toHaveLength(1);
    const normalizedResult = normalizeResultItem(result[0]);

    // The deepest TypeSpec project should be used, and both readme files should be cleaned up
    expect(normalizedResult).toEqual({
      specs: [
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/examples/2021-11-01/create.json",
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/stable/2021-11-01/servicecontrol.json",
      ],
      readmeMd:
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/readme.md",
      typespecProject:
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/tspconfig.yaml",
    });
  });

  test("case with V2 folder structure mixed with old structure", () => {
    vi.mocked(getChangedFiles).mockReturnValue([
      // V2 folder structure
      "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/tspconfig.yaml",
      "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/main.tsp",
      "specification/service1/resource-manager/readme.md",
      // Old folder structure
      "specification/contosowidgetmanager/Contoso.WidgetManager/client.tsp",
      "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
      "specification/contosowidgetmanager/data-plane/readme.md",
    ]);

    const result = detectChangedSpecConfigFiles(mockCommandInput);

    expect(result).toHaveLength(2);

    // First result should be for the V2 structure
    const normalizedV2Result = normalizeResultItem(result[0]);
    expect(normalizedV2Result).toEqual({
      specs: [
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/tspconfig.yaml",
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/main.tsp",
      ],
      readmeMd:
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/readme.md",
      typespecProject:
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/tspconfig.yaml",
    });

    // Second result should be for the old structure
    const normalizedOldResult = normalizeResultItem(result[1]);
    expect(normalizedOldResult).toEqual({
      specs: [
        "specification/contosowidgetmanager/data-plane/readme.md",
        "specification/contosowidgetmanager/Contoso.WidgetManager/client.tsp",
        "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
      ],
      readmeMd: "specification/contosowidgetmanager/data-plane/readme.md",
      typespecProject: "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
    });
  });

  test("case with multiple V2 folder structures", () => {
    vi.mocked(getChangedFiles).mockReturnValue([
      // First service
      "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/tspconfig.yaml",
      "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/main.tsp",
      "specification/service1/resource-manager/readme.md",
      // Second service
      "specification/service2/data-plane/widget2/tspconfig.yaml",
      "specification/service2/data-plane/widget2/main.tsp",
      "specification/service2/data-plane/readme.md",
    ]);

    const result = detectChangedSpecConfigFiles(mockCommandInput);

    expect(result).toHaveLength(2);

    // Results for both services should be properly processed with V2 structure
    const service1Result = result.find((r) => r.typespecProject?.includes("service1"));
    const service2Result = result.find((r) => r.typespecProject?.includes("service2"));

    expect(normalizeResultItem(service1Result!)).toEqual({
      specs: [
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/tspconfig.yaml",
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/main.tsp",
      ],
      readmeMd:
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/readme.md",
      typespecProject:
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/tspconfig.yaml",
    });

    expect(normalizeResultItem(service2Result!)).toEqual({
      specs: [
        "specification/service2/data-plane/widget2/tspconfig.yaml",
        "specification/service2/data-plane/widget2/main.tsp",
      ],
      readmeMd: "specification/service2/data-plane/widget2/readme.md",
      typespecProject: "specification/service2/data-plane/widget2/tspconfig.yaml",
    });
  });

  test("case with V2 folder structure - cross-platform path separators", () => {
    // Mock getChangedFiles to return paths with both forward and backslashes
    vi.mocked(getChangedFiles).mockReturnValue([
      String.raw`specification\service1\resource-manager\Microsoft.Service1\WidgetManagement\tspconfig.yaml`,
      "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/main.tsp",
      String.raw`specification\service1\resource-manager\readme.md`,
    ]);

    const result = detectChangedSpecConfigFiles(mockCommandInput);

    expect(result).toHaveLength(1);
    const normalizedResult = normalizeResultItem(result[0]);

    // The function should handle mixed path separators correctly
    expect(normalizedResult).toEqual({
      specs: [
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/tspconfig.yaml",
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/main.tsp",
      ],
      readmeMd:
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/readme.md",
      typespecProject:
        "specification/service1/resource-manager/Microsoft.Service1/WidgetManagement/tspconfig.yaml",
    });
  });
});

describe("groupSpecConfigPaths", () => {
  test("should group TypeSpec configs and readme files by service", () => {
    const tspconfigs = [
      "specification/storage/Storage.Management/tspconfig.yaml",
      "specification/storage/StorageClient/tspconfig.yaml",
      "specification/compute/Compute.Management/tspconfig.yaml",
    ];

    const readmes = [
      "specification/storage/resource-manager/readme.md",
      "specification/compute/resource-manager/readme.md",
    ];

    const result = normalizeSpecConfigsArray(groupSpecConfigPaths(tspconfigs, readmes));

    expect(result).toHaveLength(3); // 2 from storage, 1 from compute

    // Verify the results contain both readme and tspconfig paths as expected
    const storageManagementResult = result.find(
      (r) =>
        r.tspconfigPath === "specification/storage/Storage.Management/tspconfig.yaml" &&
        r.readmePath === "specification/storage/resource-manager/readme.md",
    );
    expect(storageManagementResult).toBeDefined();

    const storageClientResult = result.find(
      (r) => r.tspconfigPath === "specification/storage/StorageClient/tspconfig.yaml",
    );
    expect(storageClientResult).toBeDefined();

    const computeManagementResult = result.find(
      (r) =>
        r.tspconfigPath === "specification/compute/Compute.Management/tspconfig.yaml" &&
        r.readmePath === "specification/compute/resource-manager/readme.md",
    );
    expect(computeManagementResult).toBeDefined();
  });

  test("should handle empty inputs", () => {
    const result = groupSpecConfigPaths([], []);
    expect(result).toHaveLength(0);
  });

  test("should handle undefined inputs", () => {
    const result = groupSpecConfigPaths(undefined, undefined);
    expect(result).toHaveLength(0);

    const resultUndefinedReadmes = groupSpecConfigPaths([], undefined);
    expect(resultUndefinedReadmes).toHaveLength(0);

    const resultUndefinedConfigs = groupSpecConfigPaths(undefined, []);
    expect(resultUndefinedConfigs).toHaveLength(0);
  });

  test("should handle only TypeSpec configs", () => {
    const tspconfigs = [
      "specification/storage/Storage.Management/tspconfig.yaml",
      "specification/storage/StorageClient/tspconfig.yaml",
    ];

    const result = groupSpecConfigPaths(tspconfigs, []);

    expect(result).toHaveLength(2);
    for (const item of result) {
      expect(item.tspconfigPath).toBeDefined();
      expect(item.readmePath).toBeUndefined();
    }
  });

  test("should handle only readme files", () => {
    const readmes = [
      "specification/storage/resource-manager/readme.md",
      "specification/compute/resource-manager/readme.md",
    ];

    const result = groupSpecConfigPaths([], readmes);

    expect(result).toHaveLength(2);
    for (const item of result) {
      expect(item.readmePath).toBeDefined();
      expect(item.tspconfigPath).toBeUndefined();
    }
  });

  test("should skip unmatched readme files when skipUnmatchedReadme is true", () => {
    const tspconfigs = ["specification/storage/Storage.Management/tspconfig.yaml"];

    const readmes = [
      "specification/storage/resource-manager/readme.md",
      "specification/compute/resource-manager/readme.md", // This will be skipped
    ];

    const result = normalizeSpecConfigsArray(groupSpecConfigPaths(tspconfigs, readmes, true));

    expect(result).toHaveLength(1); // Only one matched pair, unmatched readme is skipped

    const storageManagementResult = result.find(
      (r) =>
        r.tspconfigPath === "specification/storage/Storage.Management/tspconfig.yaml" &&
        r.readmePath === "specification/storage/resource-manager/readme.md",
    );
    expect(storageManagementResult).toBeDefined();

    // Ensure the unmatched compute readme was skipped
    const computeResult = result.find(
      (r) => r.readmePath === "specification/compute/resource-manager/readme.md",
    );
    expect(computeResult).toBeUndefined();
  });

  test("should include unmatched readme files by default when skipUnmatchedReadme is false", () => {
    const tspconfigs = ["specification/storage/Storage.Management/tspconfig.yaml"];

    const readmes = [
      "specification/storage/resource-manager/readme.md",
      "specification/compute/resource-manager/readme.md", // This will be included
    ];

    const result = normalizeSpecConfigsArray(groupSpecConfigPaths(tspconfigs, readmes, false));

    expect(result).toHaveLength(2); // One matched pair and one unmatched readme

    // Ensure the unmatched compute readme was included
    const computeResult = result.find(
      (r) => r.readmePath === "specification/compute/resource-manager/readme.md",
    );
    expect(computeResult).toBeDefined();
    expect(computeResult?.tspconfigPath).toBeUndefined();
  });

  test("should handle data plane and mgmt path together", () => {
    const tspconfigs = [
      "specification/storage/Storage.Management/tspconfig.yaml",
      "specification/storage/StorageClient/tspconfig.yaml",
      "specification/compute/Compute.Management/tspconfig.yaml",
    ];

    const readmes = [
      "specification/storage/resource-manager/readme.md",
      "specification/storage/data-plane/readme.md",
      "specification/compute/data-plane/readme.md",
    ];

    const result = normalizeSpecConfigsArray(groupSpecConfigPaths(tspconfigs, readmes));
    expect(result).toHaveLength(4);

    // Configs should be correctly matched
    const storageMgmtResult = result.find(
      (r) =>
        r.tspconfigPath === "specification/storage/Storage.Management/tspconfig.yaml" &&
        r.readmePath === "specification/storage/resource-manager/readme.md",
    );
    expect(storageMgmtResult).toBeDefined();

    const storageDpResult = result.find(
      (r) =>
        r.tspconfigPath === "specification/storage/StorageClient/tspconfig.yaml" &&
        r.readmePath === "specification/storage/data-plane/readme.md",
    );
    expect(storageDpResult).toBeDefined();

    const computeMgmtResult = result.find(
      (r) => r.tspconfigPath === "specification/compute/Compute.Management/tspconfig.yaml",
    );
    expect(computeMgmtResult).toBeDefined();

    const computeDpResult = result.find(
      (r) => r.readmePath === "specification/compute/data-plane/readme.md",
    );
    expect(computeDpResult).toBeDefined();
  });

  test("should handle data plane and mgmt path together with skipUnmatchedReadme", () => {
    const tspconfigs = [
      "specification/storage/Storage.Management/tspconfig.yaml",
      "specification/storage/StorageClient/tspconfig.yaml",
    ];

    const readmes = [
      "specification/storage/resource-manager/readme.md",
      "specification/storage/data-plane/readme.md",
      "specification/compute/data-plane/readme.md", // This will be skipped when skipUnmatchedReadme is true
    ];

    const result = normalizeSpecConfigsArray(groupSpecConfigPaths(tspconfigs, readmes, true));
    expect(result).toHaveLength(2); // Only matched pairs from storage

    // Configs should be correctly matched for storage
    const storageMgmtResult = result.find(
      (r) =>
        r.tspconfigPath === "specification/storage/Storage.Management/tspconfig.yaml" &&
        r.readmePath === "specification/storage/resource-manager/readme.md",
    );
    expect(storageMgmtResult).toBeDefined();

    const storageDpResult = result.find(
      (r) =>
        r.tspconfigPath === "specification/storage/StorageClient/tspconfig.yaml" &&
        r.readmePath === "specification/storage/data-plane/readme.md",
    );
    expect(storageDpResult).toBeDefined();

    // The compute readme should be skipped
    const computeDpResult = result.find(
      (r) => r.readmePath === "specification/compute/data-plane/readme.md",
    );
    expect(computeDpResult).toBeUndefined();
  });
});

describe("processTypeSpecProjectsV2FolderStructure", () => {
  test("should process resource-manager structure and return ChangedSpecs with correct paths", () => {
    // Setup test data
    const readmeMDResult = {
      "specification/service/resource-manager": [
        "specification/service/resource-manager/readme.md",
      ],
      "specification/service/resource-manager/Microsoft.Service": [
        "specification/service/resource-manager/Microsoft.Service/readme.md",
      ],
    };

    const typespecProjectResult = {
      "specification/service/resource-manager/Microsoft.Service": [
        "specification/service/resource-manager/Microsoft.Service/tspconfig.yaml",
        "specification/service/resource-manager/Microsoft.Service/main.tsp",
      ],
    };

    // Run the function
    const result = processTypeSpecProjectsV2FolderStructure(readmeMDResult, typespecProjectResult);

    // Normalize results for comparison
    const normalizedResults = result.map((item) => normalizeResultItem(item));

    // Verify results
    expect(normalizedResults).toHaveLength(1);

    // Check structure of the returned ChangedSpecs object
    const spec = normalizedResults[0];
    expect(spec.typespecProject).toBe(
      normalizePath("specification/service/resource-manager/Microsoft.Service/tspconfig.yaml"),
    );
    expect(spec.readmeMd).toBe(
      normalizePath("specification/service/resource-manager/Microsoft.Service/readme.md"),
    );
    expect(spec.specs).toContain(
      normalizePath("specification/service/resource-manager/Microsoft.Service/tspconfig.yaml"),
    );
    expect(spec.specs).toContain(
      normalizePath("specification/service/resource-manager/Microsoft.Service/main.tsp"),
    );
    expect(spec.specs).toContain(
      normalizePath("specification/service/resource-manager/Microsoft.Service/readme.md"),
    );

    // Verify the readmeMDResult was modified as expected
    expect(readmeMDResult).not.toHaveProperty("specification/service/resource-manager");
    expect(readmeMDResult).not.toHaveProperty(
      "specification/service/resource-manager/Microsoft.Service",
    );

    // Verify the typespecProjectResult was modified as expected
    expect(typespecProjectResult).not.toHaveProperty(
      "specification/service/resource-manager/Microsoft.Service",
    );
  });

  test("should process data-plane structure and clean related readme entries", () => {
    // Setup test data
    const readmeMDResult = {
      "specification/service/data-plane": ["specification/service/data-plane/readme.md"],
      "specification/otherservice/data-plane": ["specification/otherservice/data-plane/readme.md"],
    };

    const typespecProjectResult = {
      "specification/service/data-plane/client": [
        "specification/service/data-plane/client/tspconfig.yaml",
        "specification/service/data-plane/client/main.tsp",
      ],
    };

    // Run the function
    const result = processTypeSpecProjectsV2FolderStructure(readmeMDResult, typespecProjectResult);

    // Normalize results for comparison
    const normalizedResults = result.map((item) => normalizeResultItem(item));

    // Verify results
    expect(normalizedResults).toHaveLength(1);

    // Check that the data-plane structure was processed correctly
    const spec = normalizedResults[0];
    expect(spec.typespecProject).toBe(
      normalizePath("specification/service/data-plane/client/tspconfig.yaml"),
    );
    expect(spec.readmeMd).toBeUndefined(); // No direct readme in the client folder
    expect(spec.specs).toContain(
      normalizePath("specification/service/data-plane/client/tspconfig.yaml"),
    );
    expect(spec.specs).toContain(normalizePath("specification/service/data-plane/client/main.tsp"));

    // Verify related readme was removed
    expect(readmeMDResult).not.toHaveProperty("specification/service/data-plane");

    // Verify unrelated readme remains
    expect(readmeMDResult).toHaveProperty("specification/otherservice/data-plane");

    // Verify the typespecProjectResult was cleaned
    expect(typespecProjectResult).not.toHaveProperty("specification/service/data-plane/client");
  });

  test("should handle multiple levels in the folder structure", () => {
    // Setup test data with nested structure
    const readmeMDResult = {
      "specification/service/resource-manager": [
        "specification/service/resource-manager/readme.md",
      ],
      "specification/service/resource-manager/Microsoft.Service": [
        "specification/service/resource-manager/Microsoft.Service/readme.md",
      ],
      "specification/service/resource-manager/Microsoft.Service/nested/subfolder": [
        "specification/service/resource-manager/Microsoft.Service/nested/subfolder/readme.md",
      ],
    };

    const typespecProjectResult = {
      "specification/service/resource-manager/Microsoft.Service/nested/subfolder": [
        "specification/service/resource-manager/Microsoft.Service/nested/subfolder/tspconfig.yaml",
        "specification/service/resource-manager/Microsoft.Service/nested/subfolder/main.tsp",
      ],
    };

    // Run the function
    const result = processTypeSpecProjectsV2FolderStructure(readmeMDResult, typespecProjectResult);

    // Normalize results for comparison
    const normalizedResults = result.map((item) => normalizeResultItem(item));

    // Verify results
    expect(normalizedResults).toHaveLength(1);

    // Check that the deeply nested structure was processed correctly
    const spec = normalizedResults[0];
    expect(spec.readmeMd).toBe(
      normalizePath(
        "specification/service/resource-manager/Microsoft.Service/nested/subfolder/readme.md",
      ),
    );

    // Verify parent readme entries were removed
    expect(readmeMDResult).not.toHaveProperty("specification/service/resource-manager");
    expect(readmeMDResult).not.toHaveProperty(
      "specification/service/resource-manager/Microsoft.Service",
    );
  });

  test("should handle empty inputs", () => {
    const result = processTypeSpecProjectsV2FolderStructure({}, {});
    expect(result).toHaveLength(0);
  });
});
