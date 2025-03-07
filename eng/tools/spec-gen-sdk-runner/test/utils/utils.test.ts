import { describe, test, expect } from "vitest";
import {
  findFilesRecursive,
  findReadmeFiles,
  getRelativePathFromSpecification,
} from "../../src/utils.js";
import { fileURLToPath } from "node:url";
import path from "node:path";

// Get the absolute path to the repo root
const currentFilePath = fileURLToPath(import.meta.url);
const repoRoot = path.resolve(path.dirname(currentFilePath), "../../../../../");

describe("Utils", () => {
  describe("findFilesRecursive", () => {
    test("finds all tspconfig.yaml files recursively", () => {
      const searchPath = path.normalize(`${repoRoot}/specification/contosowidgetmanager`);
      const results = findFilesRecursive(searchPath, "tspconfig.yaml");
      expect(results).toHaveLength(2);
      expect(results).toContain(
        path.normalize("specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml"),
      );
      expect(results).toContain(
        path.normalize("specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml"),
      );
    });

    test("returns empty array for non-existent files", () => {
      const results = findFilesRecursive(
        `${repoRoot}/specification/contosowidgetmanager`,
        "nonexistent.txt",
      );
      expect(results).toEqual([]);
    });

    test("handles case-insensitive search", () => {
      const results = findFilesRecursive(
        `${repoRoot}/specification/contosowidgetmanager`,
        "TSPCONFIG.YAML",
      );
      expect(results).toHaveLength(2);
    });
  });

  describe("findReadmeFiles", () => {
    test("finds all readme.md files in directory", () => {
      const searchPath = path.normalize(`${repoRoot}/specification/contosowidgetmanager`);
      const results = findReadmeFiles(searchPath);
      expect(results).toHaveLength(2);
      expect(results).toContain(
        path.normalize("specification/contosowidgetmanager/resource-manager/readme.md"),
      );
      expect(results).toContain(
        path.normalize("specification/contosowidgetmanager/data-plane/readme.md"),
      );
    });

    test("returns empty array for directory without readme files", () => {
      const results = findReadmeFiles(
        `${repoRoot}/specification/contosowidgetmanager/Contoso.Management`,
      );
      expect(results).toEqual([]);
    });
  });

  describe("getRelativePathFromSpecification", () => {
    test("extracts path from specification folder", () => {
      const result = getRelativePathFromSpecification(
        path.normalize("/repo/root/specification/apicenter/resource-manager/readme.md"),
      );
      expect(result).toBe(path.normalize("specification/apicenter/resource-manager/readme.md"));
    });

    test("returns original path if specification is not found", () => {
      const path = "/some/other/path/file.txt";
      const result = getRelativePathFromSpecification(path);
      expect(result).toBe(path);
    });

    test("handles paths with multiple specification occurrences", () => {
      const result = getRelativePathFromSpecification(
        path.normalize("/repo/root/specification/old/specification/apicenter/readme.md"),
      );
      expect(result).toBe(path.normalize("specification/old/specification/apicenter/readme.md"));
    });

    test("handles empty path", () => {
      const result = getRelativePathFromSpecification("");
      expect(result).toBe("");
    });
  });
});
