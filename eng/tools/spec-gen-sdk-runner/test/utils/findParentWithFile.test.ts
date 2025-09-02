import path from "node:path";
import { fileURLToPath } from "node:url";
import { describe, expect, test } from "vitest";
import { typespecProjectRegex } from "../../src/spec-helpers.js";
import { findParentWithFile } from "../../src/utils.js";

describe("findParentWithFile", () => {
  // Get the absolute path to the repo root
  const currentFilePath = fileURLToPath(import.meta.url);
  const repoRoot = path.resolve(path.dirname(currentFilePath), "../fixtures/");

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

  test("handles single segment path", () => {
    const result = findParentWithFile(".", typespecProjectRegex, repoRoot);
    expect(result).toBeUndefined();
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
