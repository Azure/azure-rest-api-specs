import path from "node:path";
import { fileURLToPath } from "node:url";
import { describe, expect, test } from "vitest";
import { readmeMdRegex, typespecProjectRegex } from "../../src/spec-helpers.js";
import { searchRelatedParentFolders } from "../../src/utils.js";

describe("searchRelatedParentFolders", () => {
  // Get the absolute path to the repo root
  const currentFilePath = fileURLToPath(import.meta.url);
  const repoRoot = path.resolve(path.dirname(currentFilePath), "../fixtures/");

  describe("without findAll option (default behavior)", () => {
    test("finds readme files for multiple paths", () => {
      const files = [
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json",
        "specification/contosowidgetmanager/data-plane/Azure.Contoso.WidgetManager/preview/2022-11-01-preview/widgets.json",
      ];

      const result = searchRelatedParentFolders(files, {
        searchFileRegex: readmeMdRegex,
        specRepoFolder: repoRoot,
        stopAtFolder: "specification",
      });

      expect(Object.keys(result)).toHaveLength(2);
      expect(result["specification/contosowidgetmanager/resource-manager"]).toBeDefined();
      expect(result["specification/contosowidgetmanager/data-plane"]).toBeDefined();
    });

    test("handles files from same parent directory", () => {
      const files = [
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Get.json",
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples/Employees_Delete.json",
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json",
      ];

      const result = searchRelatedParentFolders(files, {
        searchFileRegex: readmeMdRegex,
        specRepoFolder: repoRoot,
      });

      expect(Object.keys(result)).toHaveLength(1);
      expect(result["specification/contosowidgetmanager/resource-manager"]).toHaveLength(3);
    });

    test("respects stopAtFolder boundary", () => {
      const files = ["specification/contosowidgetmanager/Contoso.Management/main.tsp"];

      const result = searchRelatedParentFolders(files, {
        searchFileRegex: readmeMdRegex,
        specRepoFolder: repoRoot,
        stopAtFolder: "specification",
      });

      expect(Object.keys(result)).toHaveLength(0);
    });

    test("find tspconfig.yaml", () => {
      const files = [
        "specification/contosowidgetmanager/Contoso.Management/main.tsp",
        "specification/contosowidgetmanager/Contoso.Management/client.tsp",
        "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
      ];

      const result = searchRelatedParentFolders(files, {
        searchFileRegex: typespecProjectRegex,
        specRepoFolder: repoRoot,
        stopAtFolder: "specification",
      });

      expect(Object.keys(result)).toHaveLength(2);
      expect(result["specification/contosowidgetmanager/Contoso.Management"]).toBeDefined();
      expect(result["specification/contosowidgetmanager/Contoso.WidgetManager"]).toBeDefined();
      expect(result["specification/contosowidgetmanager/Contoso.Management"]).toContain(
        "specification/contosowidgetmanager/Contoso.Management/main.tsp",
      );
      expect(result["specification/contosowidgetmanager/Contoso.Management"]).toContain(
        "specification/contosowidgetmanager/Contoso.Management/client.tsp",
      );
      expect(result["specification/contosowidgetmanager/Contoso.WidgetManager"]).toContain(
        "specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml",
      );
    });
  });

  describe("with findAll option for v2 folder structure", () => {
    test("finds all tspconfig.yaml files for SubService change in resource-manager", () => {
      // Simulating a change in SubService1/foo.tsp - should find both SubService1 and Service1 tspconfigs
      const files = [
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1/foo.tsp",
      ];

      const result = searchRelatedParentFolders(files, {
        searchFileRegex: typespecProjectRegex,
        specRepoFolder: repoRoot,
        stopAtFolder: "specification",
        findAll: true,
      });

      expect(Object.keys(result)).toHaveLength(2);
      expect(
        result[
          "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1"
        ],
      ).toBeDefined();
      expect(
        result["specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1"],
      ).toBeDefined();
      // Both should contain the same file
      expect(
        result[
          "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1"
        ],
      ).toContain(
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1/foo.tsp",
      );
      expect(
        result["specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1"],
      ).toContain(
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1/foo.tsp",
      );
    });

    test("finds all tspconfig.yaml files for SubService change in data-plane", () => {
      // Simulating a change in DataPlaneSubService/widget.tsp
      const files = [
        "specification/contosowidgetmanager/data-plane/DataPlaneService/DataPlaneSubService/widget.tsp",
      ];

      const result = searchRelatedParentFolders(files, {
        searchFileRegex: typespecProjectRegex,
        specRepoFolder: repoRoot,
        stopAtFolder: "specification",
        findAll: true,
      });

      expect(Object.keys(result)).toHaveLength(2);
      expect(
        result[
          "specification/contosowidgetmanager/data-plane/DataPlaneService/DataPlaneSubService"
        ],
      ).toBeDefined();
      expect(
        result["specification/contosowidgetmanager/data-plane/DataPlaneService"],
      ).toBeDefined();
    });

    test("finds only Service tspconfig when change is in Service folder (not SubService)", () => {
      // Simulating a change in Service1/main.tsp - should only find Service1 tspconfig
      const files = [
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/main.tsp",
      ];

      const result = searchRelatedParentFolders(files, {
        searchFileRegex: typespecProjectRegex,
        specRepoFolder: repoRoot,
        stopAtFolder: "specification",
        findAll: true,
      });

      expect(Object.keys(result)).toHaveLength(1);
      expect(
        result["specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1"],
      ).toBeDefined();
      expect(
        result["specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1"],
      ).toContain(
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/main.tsp",
      );
    });

    test("does not use findAll for non-v2 folder structure even when findAll is true", () => {
      // For old folder structure (not containing resource-manager or data-plane), should only find nearest
      // Note: There IS a parent tspconfig.yaml at specification/contosowidgetmanager/Contoso.Management/
      // but when starting from NestedService/foo.tsp, only NestedService/tspconfig.yaml should be found
      // because the path doesn't contain 'resource-manager' or 'data-plane'
      const files = ["specification/contosowidgetmanager/Contoso.Management/NestedService/foo.tsp"];

      const result = searchRelatedParentFolders(files, {
        searchFileRegex: typespecProjectRegex,
        specRepoFolder: repoRoot,
        stopAtFolder: "specification",
        findAll: true,
      });

      // Should only find one tspconfig (nearest) even with findAll: true
      // The parent tspconfig at Contoso.Management/ should NOT be included
      expect(Object.keys(result)).toHaveLength(1);
      expect(
        result["specification/contosowidgetmanager/Contoso.Management/NestedService"],
      ).toBeDefined();
      expect(result["specification/contosowidgetmanager/Contoso.Management"]).toBeUndefined();
    });

    test("handles multiple files from different SubServices", () => {
      // Simulating changes in both SubService1 and SubService2
      const files = [
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1/foo.tsp",
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService2/bar.tsp",
      ];

      const result = searchRelatedParentFolders(files, {
        searchFileRegex: typespecProjectRegex,
        specRepoFolder: repoRoot,
        stopAtFolder: "specification",
        findAll: true,
      });

      // Should find 3 tspconfigs: SubService1, SubService2, and Service1 (parent)
      expect(Object.keys(result)).toHaveLength(3);
      expect(
        result[
          "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1"
        ],
      ).toBeDefined();
      expect(
        result[
          "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService2"
        ],
      ).toBeDefined();
      expect(
        result["specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1"],
      ).toBeDefined();

      // Service1 tspconfig should have files from both SubServices
      const service1Files =
        result["specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1"];
      expect(service1Files).toContain(
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1/foo.tsp",
      );
      expect(service1Files).toContain(
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService2/bar.tsp",
      );
    });

    test("handles mixed changes from Service and SubService", () => {
      // Simulating changes in both Service1 and SubService1
      const files = [
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/main.tsp",
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1/foo.tsp",
      ];

      const result = searchRelatedParentFolders(files, {
        searchFileRegex: typespecProjectRegex,
        specRepoFolder: repoRoot,
        stopAtFolder: "specification",
        findAll: true,
      });

      // Should find 2 tspconfigs: SubService1 and Service1
      expect(Object.keys(result)).toHaveLength(2);
      expect(
        result[
          "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1"
        ],
      ).toBeDefined();
      expect(
        result["specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1"],
      ).toBeDefined();

      // Service1 tspconfig should have files from both Service1 and SubService1
      const service1Files =
        result["specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1"];
      expect(service1Files).toContain(
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/main.tsp",
      );
      expect(service1Files).toContain(
        "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1/foo.tsp",
      );
    });
  });
});
