import { describe, test, expect } from "vitest";
import { searchRelatedTypeSpecProjectBySharedLibrary } from "../../src/utils.js";
import { fileURLToPath } from "node:url";
import path from "node:path";

describe("searchRelatedTypeSpecProjectBySharedLibrary", () => {
  // Get the absolute path to the repo root
  const currentFilePath = fileURLToPath(import.meta.url);
  const repoRoot = path.resolve(path.dirname(currentFilePath), "../../../../../");

  test("finds related TypeSpec projects for shared libraries", () => {
    const sharedLibraries = [
      path.normalize("specification/contosowidgetmanager/Contoso.WidgetManager.Shared/main.tsp"),
    ];

    const result = searchRelatedTypeSpecProjectBySharedLibrary(sharedLibraries, {
      searchFileRegex: /^tspconfig\.yaml$/,
      specRepoFolder: repoRoot,
    });
    const expectedPath = path.normalize("specification/contosowidgetmanager/Contoso.WidgetManager");
    expect(Object.keys(result)).toHaveLength(1);
    expect(result[expectedPath]).toBeDefined();
    expect(result[expectedPath]).toContain(
      sharedLibraries[0],
    );
  });

  test("handles empty shared libraries array", () => {
    const result = searchRelatedTypeSpecProjectBySharedLibrary([], {
      searchFileRegex: /^tspconfig\.yaml$/,
      specRepoFolder: repoRoot,
    });

    expect(Object.keys(result)).toHaveLength(0);
  });

  test("handles non-existent directories", () => {
    const sharedLibraries = [path.normalize("specification/nonexistent/Shared/main.tsp")];

    const result = searchRelatedTypeSpecProjectBySharedLibrary(sharedLibraries, {
      searchFileRegex: /^tspconfig\.yaml$/,
      specRepoFolder: repoRoot,
    });

    expect(Object.keys(result)).toHaveLength(0);
  });
});
