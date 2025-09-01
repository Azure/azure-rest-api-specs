import path from "node:path";
import { fileURLToPath } from "node:url";
import { beforeEach, describe, expect, test, vi } from "vitest";
import {
  findFilesRecursive,
  findReadmeFiles,
  getArgumentValue,
  getRelativePathFromSpecification,
  mapToObject,
  normalizePath,
  objectToMap,
} from "../../src/utils.js";

// Get the absolute path to the repo root
const currentFilePath = fileURLToPath(import.meta.url);
const repoRoot = path.resolve(path.dirname(currentFilePath), "../fixtures/");

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

  describe("getArgumentValue", () => {
    test("return the argument value", () => {
      const args = ["--batch-type", "all-specs", "--pr-number", "9527"];
      const result = getArgumentValue(args, "--batch-type", "");
      expect(result).toBe("all-specs");
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

  describe("mapToObject", () => {
    test("converts Map to Object correctly", () => {
      const map = new Map([
        ["key1", "value1"],
        ["key2", "value2"],
      ]);
      const result = mapToObject(map);
      expect(result).toEqual({ key1: "value1", key2: "value2" });
    });

    test("handles empty Map", () => {
      const map = new Map();
      const result = mapToObject(map);
      expect(result).toEqual({});
    });
  });

  describe("objectToMap", () => {
    test("converts Object to Map correctly", () => {
      const obj = { key1: "value1", key2: "value2" };
      const result = objectToMap(obj);
      expect(result).toEqual(
        new Map([
          ["key1", "value1"],
          ["key2", "value2"],
        ]),
      );
    });

    test("handles empty Object", () => {
      const obj = {};
      const result = objectToMap(obj);
      expect(result).toEqual(new Map());
    });
  });

  describe("normalizePath", () => {
    beforeEach(() => {
      vi.clearAllMocks();
    });

    test("normalizePath in Windows", () => {
      vi.spyOn(process, "platform", "get").mockReturnValue("win32");
      /* eslint-disable unicorn/prefer-string-raw */
      const path = "specification\\contosowidgetmanager\\Contoso.WidgetManager.Shared\\main.tsp";
      const convertPath =
        "specification/contosowidgetmanager/Contoso.WidgetManager.Shared/main.tsp";
      const result = normalizePath(path);
      expect(result).toEqual(convertPath);
    });

    test("normalizePath in Linux", () => {
      vi.spyOn(process, "platform", "get").mockReturnValue("linux");
      const path = "specification/contosowidgetmanager/Contoso.WidgetManager.Shared/main.tsp";
      const result = normalizePath(path);
      expect(result).toEqual(path);
    });
  });
});
