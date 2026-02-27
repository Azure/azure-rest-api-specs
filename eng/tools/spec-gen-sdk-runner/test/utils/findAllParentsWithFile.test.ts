import path from "node:path";
import { fileURLToPath } from "node:url";
import { describe, expect, test } from "vitest";
import { typespecProjectRegex } from "../../src/spec-helpers.js";
import { findAllParentsWithFile } from "../../src/utils.js";

describe("findAllParentsWithFile", () => {
  // Get the absolute path to the repo root
  const currentFilePath = fileURLToPath(import.meta.url);
  const repoRoot = path.resolve(path.dirname(currentFilePath), "../fixtures/");

  test("finds single file in current directory", () => {
    const result = findAllParentsWithFile(
      "specification/contosowidgetmanager/Contoso.WidgetManager",
      typespecProjectRegex,
      repoRoot,
    );
    expect(result).toHaveLength(1);
    expect(result[0]).toBe("specification/contosowidgetmanager/Contoso.WidgetManager");
  });

  test("finds all tspconfig.yaml files in v2 resource-manager folder structure", () => {
    // Starting from SubService1 folder, should find both SubService1 and Service1 tspconfigs
    const result = findAllParentsWithFile(
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1",
      typespecProjectRegex,
      repoRoot,
      "specification",
    );
    expect(result).toHaveLength(2);
    // Results are ordered from nearest to farthest
    expect(result[0]).toBe(
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1",
    );
    expect(result[1]).toBe(
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1",
    );
  });

  test("finds all tspconfig.yaml files in v2 data-plane folder structure", () => {
    // Starting from DataPlaneSubService folder, should find both DataPlaneSubService and DataPlaneService tspconfigs
    const result = findAllParentsWithFile(
      "specification/contosowidgetmanager/data-plane/DataPlaneService/DataPlaneSubService",
      typespecProjectRegex,
      repoRoot,
      "specification",
    );
    expect(result).toHaveLength(2);
    // Results are ordered from nearest to farthest
    expect(result[0]).toBe(
      "specification/contosowidgetmanager/data-plane/DataPlaneService/DataPlaneSubService",
    );
    expect(result[1]).toBe("specification/contosowidgetmanager/data-plane/DataPlaneService");
  });

  test("finds only service tspconfig when starting from service folder", () => {
    const result = findAllParentsWithFile(
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1",
      typespecProjectRegex,
      repoRoot,
      "specification",
    );
    expect(result).toHaveLength(1);
    expect(result[0]).toBe(
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1",
    );
  });

  test("throws error when directory does not exist", () => {
    expect(() =>
      findAllParentsWithFile("specification/nonexistent/path", typespecProjectRegex, repoRoot),
    ).toThrow(/ENOENT/);
  });

  test("stops at specified boundary and finds files before it", () => {
    // Start from SubService1 and set boundary at Microsoft.Contoso
    // Should find tspconfig.yaml in SubService1 and Service1, but not traverse above Microsoft.Contoso
    const result = findAllParentsWithFile(
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1",
      typespecProjectRegex,
      repoRoot,
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso",
    );
    // Should find both SubService1 and Service1 tspconfigs before hitting the boundary
    expect(result).toHaveLength(2);
    expect(result[0]).toBe(
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1",
    );
    expect(result[1]).toBe(
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1",
    );
  });

  test("handles single segment path", () => {
    const result = findAllParentsWithFile(".", typespecProjectRegex, repoRoot);
    expect(result).toHaveLength(0);
  });

  test("finds file from deeply nested path within SubService", () => {
    // Simulating a change in a deeply nested folder under SubService1
    // Start from an existing folder (SubService1 itself) to test traversal
    const result = findAllParentsWithFile(
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1",
      typespecProjectRegex,
      repoRoot,
      "specification",
    );
    // Should find both SubService1 and Service1 tspconfigs
    expect(result).toHaveLength(2);
    expect(result[0]).toBe(
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1/SubService1",
    );
    expect(result[1]).toBe(
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/Service1",
    );
  });
});
