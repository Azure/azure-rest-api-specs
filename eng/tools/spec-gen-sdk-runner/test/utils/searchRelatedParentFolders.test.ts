import path from "node:path";
import { fileURLToPath } from "node:url";
import { describe, expect, test } from "vitest";
import { readmeMdRegex, typespecProjectRegex } from "../../src/spec-helpers.js";
import { searchRelatedParentFolders } from "../../src/utils.js";

describe("searchRelatedParentFolders", () => {
  // Get the absolute path to the repo root
  const currentFilePath = fileURLToPath(import.meta.url);
  const repoRoot = path.resolve(path.dirname(currentFilePath), "../fixtures/");

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
