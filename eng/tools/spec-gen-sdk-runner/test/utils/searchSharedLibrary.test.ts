import { describe, test, expect } from "vitest";
import { searchSharedLibrary } from "../../src/utils.js";
import { fileURLToPath } from "node:url";
import path from "node:path";
import { typespecProjectSharedLibraryRegex } from "../../src/change-files.js";

describe("searchSharedLibrary", () => {
  // Get the absolute path to the repo root
  const currentFilePath = fileURLToPath(import.meta.url);
  const repoRoot = path.resolve(path.dirname(currentFilePath), "../../../../../");

  test("identifies shared library files", () => {
    const files = [
      "specification/contosowidgetmanager/Contoso.WidgetManager.Shared/main.tsp",
      "specification/contosowidgetmanager/Contoso.WidgetManager.Shared/examples/a.json",
      "specification/contosowidgetmanager/Contoso.Management/main.tsp",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json",
    ];

    const result = searchSharedLibrary(files, {
      searchFileRegex: typespecProjectSharedLibraryRegex,
      specRepoFolder: repoRoot,
    });

    expect(result).toHaveLength(2);
    expect(result).toContain(
      "specification/contosowidgetmanager/Contoso.WidgetManager.Shared/main.tsp",
    );
    expect(result).toContain(
      "specification/contosowidgetmanager/Contoso.WidgetManager.Shared/examples/a.json",
    );
  });

  test("handles empty file list", () => {
    const result = searchSharedLibrary([], {
      searchFileRegex: typespecProjectSharedLibraryRegex,
      specRepoFolder: repoRoot,
    });

    expect(result).toHaveLength(0);
  });

  test("handles case sensitivity correctly", () => {
    const files = [
      "specification/storage/Storage.Shared/main.tsp",
      "specification/compute/Compute.SHARED/types.tsp",
    ];

    const result = searchSharedLibrary(files, {
      searchFileRegex: typespecProjectSharedLibraryRegex,
      specRepoFolder: repoRoot,
    });

    expect(result).toHaveLength(1);
  });
});
