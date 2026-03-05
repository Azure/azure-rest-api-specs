import { mockAll, mockFolder } from "./mocks.js";
mockAll();

import * as fsPromises from "fs/promises";
import * as globbyModule from "globby";
import path from "path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import {
  FoundSuppression,
  parseSuppressions,
  riskySuppressionRules,
  TspLintSuppressionsCheckRule,
  validSuppressionRules,
} from "../src/rules/tsp-lint-suppressions.js";

describe("tsp-lint-suppressions", function () {
  beforeEach(() => {
    vi.mocked(globbyModule.globby).mockResolvedValue([]);
  });

  afterEach(() => {
    vi.clearAllMocks();
  });

  describe("parseSuppressions", function () {
    it("should parse a single valid suppression", function () {
      const content = `  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-long-running-operation-options requires @extension"\n`;
      const result = parseSuppressions(content, "test.tsp");
      expect(result).toHaveLength(1);
      expect(result[0]).toMatchObject({
        rule: "@azure-tools/typespec-azure-core/no-openapi",
        reason: "x-ms-long-running-operation-options requires @extension",
        file: "test.tsp",
        line: 1,
      } as FoundSuppression);
    });

    it("should parse a risky suppression", function () {
      const content = `  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Specify operationId to remove OrReplace from generated name"\n`;
      const result = parseSuppressions(content, "routes.tsp");
      expect(result).toHaveLength(1);
      expect(result[0]).toMatchObject({
        rule: "@azure-tools/typespec-azure-core/no-operation-id",
        reason: "Specify operationId to remove OrReplace from generated name",
        file: "routes.tsp",
        line: 1,
      } as FoundSuppression);
    });

    it("should parse multiple suppressions", function () {
      const content =
        `  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "reason1"\n` +
        `  #suppress "@azure-tools/typespec-azure-core/no-openapi" "reason2"\n`;
      const result = parseSuppressions(content, "main.tsp");
      expect(result).toHaveLength(2);
      expect(result[0].rule).toBe("@azure-tools/typespec-azure-core/no-operation-id");
      expect(result[1].rule).toBe("@azure-tools/typespec-azure-core/no-openapi");
    });

    it("should report correct line numbers", function () {
      const content =
        `// some code\n` +
        `\n` +
        `  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "reason"\n`;
      const result = parseSuppressions(content, "main.tsp");
      expect(result).toHaveLength(1);
      expect(result[0].line).toBe(3);
    });

    it("should skip commented-out suppressions", function () {
      const content = `  //#suppress "@azure-tools/typespec-azure-core/no-operation-id" "reason"\n`;
      const result = parseSuppressions(content, "main.tsp");
      // The regex `^[ \t]*#suppress` requires the line to start with optional
      // horizontal whitespace followed immediately by `#suppress`.
      // A commented line like `  //#suppress` has `//` before `#suppress`,
      // which does not match `[ \t]*#suppress`, so it is correctly skipped.
      expect(result).toHaveLength(0);
    });

    it("should return empty array when no suppressions", function () {
      const content = `namespace Foo;\nmodel Bar {}\n`;
      const result = parseSuppressions(content, "main.tsp");
      expect(result).toHaveLength(0);
    });
  });

  describe("suppression sets", function () {
    it("should have no-openapi in valid suppressions", function () {
      expect(validSuppressionRules.has("@azure-tools/typespec-azure-core/no-openapi")).toBe(true);
    });

    it("should have no-operation-id in risky suppressions", function () {
      expect(riskySuppressionRules.has("@azure-tools/typespec-azure-core/no-operation-id")).toBe(
        true,
      );
    });

    it("should not overlap between valid and risky sets", function () {
      for (const rule of validSuppressionRules) {
        expect(riskySuppressionRules.has(rule)).toBe(false);
      }
    });
  });

  describe("TspLintSuppressionsCheckRule", function () {
    it("should succeed with no TypeSpec files", async function () {
      vi.mocked(globbyModule.globby).mockResolvedValue([]);
      const result = await new TspLintSuppressionsCheckRule().execute(mockFolder);
      expect(result.success).toBe(true);
    });

    it("should succeed with only valid suppressions", async function () {
      const tspContent =
        `  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-long-running-operation-options requires @extension"\n` +
        `  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-pageable requires @extension for non-standard list operation"\n`;

      vi.mocked(globbyModule.globby).mockResolvedValue(["routes.tsp"]);
      vi.mocked(fsPromises.readFile).mockResolvedValue(tspContent);

      const result = await new TspLintSuppressionsCheckRule().execute(mockFolder);
      expect(result.success).toBe(true);
      expect(result.stdOutput).toContain("Valid TypeSpec suppressions");
      expect(result.stdOutput).toContain("no-openapi");
    });

    it("should fail with risky no-operation-id suppression", async function () {
      const tspContent = `  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Specify operationId to remove OrReplace from generated name"\n`;

      vi.mocked(globbyModule.globby).mockResolvedValue(["routes.tsp"]);
      vi.mocked(fsPromises.readFile).mockResolvedValue(tspContent);

      const result = await new TspLintSuppressionsCheckRule().execute(mockFolder);
      expect(result.success).toBe(false);
      expect(result.errorOutput).toContain("Risky TypeSpec suppressions found");
      expect(result.errorOutput).toContain("no-operation-id");
    });

    it("should report valid suppressions in stdOutput and risky in errorOutput", async function () {
      const tspContent =
        `  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "risky reason"\n` +
        `  #suppress "@azure-tools/typespec-azure-core/no-openapi" "valid reason"\n`;

      vi.mocked(globbyModule.globby).mockResolvedValue(["main.tsp"]);
      vi.mocked(fsPromises.readFile).mockResolvedValue(tspContent);

      const result = await new TspLintSuppressionsCheckRule().execute(mockFolder);
      expect(result.success).toBe(false);
      expect(result.stdOutput).toContain("Valid TypeSpec suppressions");
      expect(result.stdOutput).toContain("no-openapi");
      expect(result.errorOutput).toContain("Risky TypeSpec suppressions found");
      expect(result.errorOutput).toContain("no-operation-id");
    });

    it("should scan multiple TypeSpec files", async function () {
      vi.mocked(globbyModule.globby).mockResolvedValue(["main.tsp", "routes.tsp", "models.tsp"]);
      vi.mocked(fsPromises.readFile).mockImplementation((filePath) => {
        const p = filePath as string;
        if (p.endsWith("routes.tsp")) {
          return Promise.resolve(
            `  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "risky"\n`,
          );
        }
        return Promise.resolve(`namespace Foo;\n`);
      });

      const result = await new TspLintSuppressionsCheckRule().execute(mockFolder);
      expect(result.success).toBe(false);
      expect(result.errorOutput).toContain("routes.tsp");
    });

    it("should include file and line number in output", async function () {
      const tspContent =
        `// first line\n` +
        `  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "risky"\n`;

      vi.mocked(globbyModule.globby).mockResolvedValue(["routes.tsp"]);
      vi.mocked(fsPromises.readFile).mockResolvedValue(tspContent);

      const result = await new TspLintSuppressionsCheckRule().execute(mockFolder);
      expect(result.success).toBe(false);
      expect(result.errorOutput).toContain("routes.tsp:2:");
    });

    it("should include suppression-fix guidance in error output", async function () {
      const tspContent = `  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "reason"\n`;

      vi.mocked(globbyModule.globby).mockResolvedValue(["main.tsp"]);
      vi.mocked(fsPromises.readFile).mockResolvedValue(tspContent);

      const result = await new TspLintSuppressionsCheckRule().execute(mockFolder);
      expect(result.success).toBe(false);
      expect(result.errorOutput).toContain("suppressions.yaml");
      expect(result.errorOutput).toContain("TspLintSuppressionsCheck");
    });

    it("should succeed with unclassified suppressions (not in risky list)", async function () {
      const tspContent = `  #suppress "@azure-tools/typespec-azure-core/documentation-required" "not needed"\n`;

      vi.mocked(globbyModule.globby).mockResolvedValue(["main.tsp"]);
      vi.mocked(fsPromises.readFile).mockResolvedValue(tspContent);

      // documentation-required is not in the risky list, so it should pass
      const result = await new TspLintSuppressionsCheckRule().execute(mockFolder);
      expect(result.success).toBe(true);
      expect(result.stdOutput).toContain("Valid TypeSpec suppressions");
    });

    it("should use globby with cwd set to the folder", async function () {
      const globbySpy = vi.mocked(globbyModule.globby);
      await new TspLintSuppressionsCheckRule().execute(mockFolder);
      expect(globbySpy).toHaveBeenCalledWith("**/*.tsp", {
        cwd: mockFolder,
        absolute: false,
      });
    });

    it("should construct file path relative to folder when reading", async function () {
      vi.mocked(globbyModule.globby).mockResolvedValue(["subdir/routes.tsp"]);
      vi.mocked(fsPromises.readFile).mockResolvedValue("");

      await new TspLintSuppressionsCheckRule().execute(mockFolder);

      expect(vi.mocked(fsPromises.readFile)).toHaveBeenCalledWith(
        path.join(mockFolder, "subdir/routes.tsp"),
        { encoding: "utf8" },
      );
    });
  });
});
