import { describe, test, expect, vi, beforeEach } from "vitest";
import { detectChangedSpecConfigFiles, groupSpecConfigPaths } from "../../src/spec-helpers.js";
import { SpecGenSdkCmdInput } from "../../src/types.js";
import { fileURLToPath } from "node:url";
import path from "node:path";
import {
  type ChangedSpecs,
  type SpecConfigs,
  normalizePath,
  getChangedFiles,
} from "../../src/utils.js";

vi.mock("../../src/utils.js", async () => {
  const actual = await vi.importActual<typeof import("../../src/utils.js")>("../../src/utils.js");

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
    vi.mocked(getChangedFiles).mockReturnValue([]);
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
