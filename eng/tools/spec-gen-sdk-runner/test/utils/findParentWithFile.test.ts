import { describe, test, expect } from "vitest";
import { findParentWithFile } from "../../src/utils.js";
import { fileURLToPath } from "node:url";
import path from "node:path";
import { typespecProjectRegex } from "../../src/change-files.js";

describe("findParentWithFile", () => {
  // Get the absolute path to the repo root
  const currentFilePath = fileURLToPath(import.meta.url);
  const repoRoot = path.resolve(path.dirname(currentFilePath), "../../../../../");

  test("finds file in current directory", () => {
    const result = findParentWithFile(
      "specification/contosowidgetmanager/Contoso.WidgetManager",
      typespecProjectRegex,
      repoRoot,
    );
    expect(result).toBe("specification/contosowidgetmanager/Contoso.WidgetManager");
  });

  test("finds file in parent directory", () => {
    const result = findParentWithFile(
      "specification/contosowidgetmanager/Contoso.WidgetManager/examples/2022-11-01-preview",
      typespecProjectRegex,
      repoRoot,
    );
    expect(result).toBe("specification/contosowidgetmanager/Contoso.WidgetManager");
  });

  test("stops at specified boundary", () => {
    const result = findParentWithFile(
      "specification/contosowidgetmanager/Contoso.WidgetManager",
      /^config\.json$/,
      repoRoot,
      "specification",
    );
    expect(result).toBeUndefined();
  });

  test("handles non-existent path", () => {
    const result = findParentWithFile("specification/nonexistent/path", /^readme\.md$/i, repoRoot);
    expect(result).toBeUndefined();
  });
});
