// @ts-check

import { describe, it, beforeEach } from "vitest";
import { SwaggerVersionCache } from "../src/swagger-version-cache.js";
import { strict as assert } from "assert";
import { join, dirname } from "path";
import { fileURLToPath } from "url";

// Get the directory of this test file
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

/**
 * Unit tests for SwaggerVersionCache class using existing test fixtures
 */
describe("SwaggerVersionCache", () => {
  let cache;
  let testRpFolder;

  beforeEach(async () => {
    cache = new SwaggerVersionCache();

    // Use existing test fixtures - point to the resource provider folder
    testRpFolder = join(
      __dirname,
      "fixtures",
      "swagger-version-cache",
      "specification",
      "servicelinker",
      "resource-manager",
      "Microsoft.ServiceLinker",
    );
  });

  describe("Static utility methods", () => {
    it("should identify version type correctly", () => {
      assert.equal(
        SwaggerVersionCache.getVersionType("/path/stable/2023-01-01/test.json"),
        "stable",
      );
      assert.equal(
        SwaggerVersionCache.getVersionType("/path/preview/2023-01-01-preview/test.json"),
        "preview",
      );
    });

    it("should extract RP folder correctly", () => {
      const testPath =
        "specification/network/resource-manager/Microsoft.Network/stable/2023-01-01/network.json";
      const expected = "specification/network/resource-manager/Microsoft.Network";
      assert.equal(SwaggerVersionCache.getRPFolder(testPath), expected);
    });

    it("should handle dev folder conversion", () => {
      let testPath =
        "dev/network/resource-manager/Microsoft.Network/stable/2023-01-01/network.json";
      let expected = "specification/network/resource-manager/Microsoft.Network";
      assert.equal(SwaggerVersionCache.getRPFolder(testPath), expected);

      testPath = "specification/testRP/stable/2020-08-01/a.json";
      expected = "specification/testRP";
      assert.equal(SwaggerVersionCache.getRPFolder(testPath), expected);

      testPath = "specification/Microsoft.Test/stable/2020-08-01/subfoler/a.json";
      expected = "specification/Microsoft.Test";
      assert.equal(SwaggerVersionCache.getRPFolder(testPath), expected);
    });

    it("should return undefined for invalid paths", () => {
      assert.equal(SwaggerVersionCache.getRPFolder("invalid/path"), undefined);
      assert.equal(SwaggerVersionCache.getRPFolder(""), undefined);
    });
  });

  describe("File discovery", () => {
    it("should find all swagger files in RP folder", async () => {
      const files = await cache.getAllSwaggers(testRpFolder);

      // Should find many JSON files (including examples and swagger files)
      assert(files.length > 0);
      assert(files.every((f) => f.endsWith(".json")));
      assert(files.every((f) => !f.includes("examples"))); // Examples should be excluded

      // Verify we find the actual swagger files we expect
      assert(files.some((f) => f.includes("stable/2022-05-01/servicelinker.json")));
      assert(files.some((f) => f.includes("stable/2024-04-01/servicelinker.json")));
      assert(files.some((f) => f.includes("preview/2023-04-01-preview/servicelinker.json")));
      assert(files.some((f) => f.includes("preview/2024-07-01-preview/servicelinker.json")));
    });

    it("should cache swagger files results", async () => {
      // First call
      const files1 = await cache.getAllSwaggers(testRpFolder);

      // Second call should return cached result
      const files2 = await cache.getAllSwaggers(testRpFolder);

      assert.deepEqual(files1, files2);

      const stats = cache.getCacheStats();
      assert.equal(stats.swaggersByRp, 1);
    });

    it("should handle non-existent directories gracefully", async () => {
      const files = await cache.getAllSwaggers("/non/existent/path");
      assert.deepEqual(files, []);
    });
  });

  describe("Version mapping", () => {
    it("should create version metadata for all swagger files", async () => {
      const versions = await cache.getVersionMapping(testRpFolder);

      // Should find 4 versions (2 stable + 2 preview) from the versioned directories
      assert.equal(versions.length, 4);

      const stable2022 = versions.find((v) => v.version === "2022-05-01");
      assert(stable2022);
      assert.equal(stable2022.versionType, "stable");
      assert.equal(stable2022.fileName, "servicelinker.json");

      const stable2024 = versions.find((v) => v.version === "2024-04-01");
      assert(stable2024);
      assert.equal(stable2024.versionType, "stable");

      const preview2023 = versions.find((v) => v.version === "2023-04-01");
      assert(preview2023);
      assert.equal(preview2023.versionType, "preview");

      const preview2024 = versions.find((v) => v.version === "2024-07-01");
      assert(preview2024);
      assert.equal(preview2024.versionType, "preview");
    });

    it("should cache version mapping results", async () => {
      // First call
      const versions1 = await cache.getVersionMapping(testRpFolder);

      // Second call should return cached result
      const versions2 = await cache.getVersionMapping(testRpFolder);

      assert.deepEqual(versions1, versions2);

      const stats = cache.getCacheStats();
      assert.equal(stats.versionsByRp, 1);
    });
  });

  describe("Operations extraction", () => {
    it("should extract operations from swagger file", async () => {
      const swaggerPath = join(testRpFolder, "stable", "2024-04-01", "servicelinker.json");
      const operations = await cache.getOperations(swaggerPath);

      // ServiceLinker should have multiple operations
      assert(operations.length > 0);

      // Check that operations have the expected structure
      const firstOp = operations[0];
      assert(firstOp.operationId);
      assert(firstOp.httpMethod);
      assert(firstOp.path);
    });

    it("should cache operations results", async () => {
      // Start with a clean cache
      cache.clearCaches();

      const swaggerPath = join(testRpFolder, "stable", "2022-05-01", "servicelinker.json");

      // First call
      const operations1 = await cache.getOperations(swaggerPath);

      // Second call should return cached result
      const operations2 = await cache.getOperations(swaggerPath);

      assert.deepEqual(operations1, operations2);

      const stats = cache.getCacheStats();
      assert.equal(stats.operationsBySwagger, 1);
    });

    it("should handle non-existent files gracefully", async () => {
      const invalidPath = join(testRpFolder, "non-existent.json");

      const operations = await cache.getOperations(invalidPath);
      assert.deepEqual(operations, []);
    });
  });

  describe("Version analysis", () => {
    it("should find most recent preceding stable version", async () => {
      const currentFile = join(testRpFolder, "stable", "2024-04-01", "servicelinker.json");
      const precedingStable = await cache.getPrecedingStable(currentFile);

      // Should find the 2022-05-01 version
      assert(precedingStable);
      assert(precedingStable.includes("2022-05-01"));
    });

    it("should find most recent preceding preview version", async () => {
      const currentFile = join(testRpFolder, "preview", "2024-07-01-preview", "servicelinker.json");
      const precedingPreview = await cache.getPrecedingPreview(currentFile);

      // Should find the 2023-04-01-preview version
      assert(precedingPreview);
      assert(precedingPreview.includes("2023-04-01-preview"));
    });

    it("should return undefined when no preceding version exists", async () => {
      const currentFile = join(testRpFolder, "stable", "2022-05-01", "servicelinker.json");
      const precedingStable = await cache.getPrecedingStable(currentFile);

      // 2022-05-01 is the oldest stable version, so no preceding stable
      assert.equal(precedingStable, undefined);
    });

    it("should handle files with invalid RP folder", async () => {
      const precedingStable = await cache.getPrecedingStable("/invalid/path/file.json");
      assert.equal(precedingStable, undefined);
    });
  });

  describe("Legacy operations analysis", () => {
    it("should find operations that exist in both old and current versions", async () => {
      const currentFile = join(testRpFolder, "stable", "2024-04-01", "servicelinker.json");
      const legacyOps = await cache.getLegacyVersionOperations(currentFile);

      // Should find operations from 2022-05-01 version that also exist in 2024-04-01
      assert(legacyOps.length > 0);

      // All operations should have swagger reference
      assert(legacyOps.every((op) => op.swagger));

      // Should reference the older version file
      assert(legacyOps.every((op) => op.swagger.includes("2022-05-01")));
    });

    it("should return empty array for files with no legacy versions", async () => {
      const currentFile = join(testRpFolder, "stable", "2022-05-01", "servicelinker.json");
      const legacyOps = await cache.getLegacyVersionOperations(currentFile);

      // 2022-05-01 is the oldest stable version, so no legacy operations
      assert.deepEqual(legacyOps, []);
    });
  });

  describe("Cross-version analysis for resource-manager APIs", () => {
    let networkRpFolder;

    beforeEach(() => {
      networkRpFolder = join(
        __dirname,
        "fixtures",
        "swagger-version-cache",
        "specification",
        "network",
        "resource-manager",
        "Microsoft.Network",
      );
    });

    it("should find closest preview versions correctly", async () => {
      // Test case: stable 2020-07-02 -> preview 2020-07-02
      const stableFile1 = join(networkRpFolder, "stable", "2020-07-02", "a.json");
      const closestPreview1 = await cache.getPrecedingPreview(stableFile1);
      assert.equal(closestPreview1, join(networkRpFolder, "preview", "2020-07-02", "a.json"));

      // Test case: stable 2020-08-04 -> preview 2020-08-04-preview
      const stableFile2 = join(networkRpFolder, "stable", "2020-08-04", "a.json");
      const closestPreview2 = await cache.getPrecedingPreview(stableFile2);
      assert.equal(
        closestPreview2,
        join(networkRpFolder, "preview", "2020-08-04-preview", "a.json"),
      );

      // Test case: preview file should not find another preview (no previous preview)
      const previewFile = join(networkRpFolder, "preview", "2020-07-02", "a.json");
      const closestPreview3 = await cache.getPrecedingPreview(previewFile);
      assert.equal(closestPreview3, undefined);
    });

    it("should find closest stable versions correctly", async () => {
      // Test case: stable 2020-08-04 -> stable 2020-07-02
      const stableFile1 = join(networkRpFolder, "stable", "2020-08-04", "a.json");
      const closestStable1 = await cache.getPrecedingStable(stableFile1);
      assert.equal(closestStable1, join(networkRpFolder, "stable", "2020-07-02", "a.json"));

      // Test case: oldest stable should not find previous stable
      const stableFile2 = join(networkRpFolder, "stable", "2020-07-02", "a.json");
      const closestStable2 = await cache.getPrecedingStable(stableFile2);
      assert.equal(closestStable2, undefined);
    });
  });

  describe("Cross-version analysis for data-plane APIs", () => {
    let textAnalyticsRpFolder;

    beforeEach(() => {
      textAnalyticsRpFolder = join(
        __dirname,
        "fixtures",
        "swagger-version-cache",
        "specification",
        "textanalytics",
        "data-plane",
        "TextAnalytics",
      );
    });

    it("should find closest stable and preview versions for data-plane APIs", async () => {
      // Test case: preview v3.2-preview.6 -> stable v3.1
      const previewFile = join(textAnalyticsRpFolder, "preview", "v3.2-preview.6", "a.json");
      const closestStable = await cache.getPrecedingStable(previewFile);
      assert.equal(closestStable, join(textAnalyticsRpFolder, "stable", "v3.1", "a.json"));

      // Test case: preview v3.2-preview.6 -> preview v3.2-preview.1
      const closestPreview = await cache.getPrecedingPreview(previewFile);
      assert.equal(
        closestPreview,
        join(textAnalyticsRpFolder, "preview", "v3.2-preview.1", "a.json"),
      );
    });
  });

  describe("Basic validation tests", () => {
    it("should handle invalid file paths gracefully", async () => {
      // Test with non-existent files
      const precedingPreview1 = await cache.getPrecedingPreview("test/test.json");
      assert.equal(precedingPreview1, undefined);

      const precedingStable1 = await cache.getPrecedingStable("src/tests/Resource/test.json");
      assert.equal(precedingStable1, undefined);
    });
  });

  describe("Cache management", () => {
    it("should clear all caches", async () => {
      // Populate caches
      await cache.getAllSwaggers(testRpFolder);
      await cache.getVersionMapping(testRpFolder);

      let stats = cache.getCacheStats();
      assert(stats.swaggersByRp > 0);
      assert(stats.versionsByRp > 0);

      // Clear caches
      cache.clearCaches();

      stats = cache.getCacheStats();
      assert.equal(stats.swaggersByRp, 0);
      assert.equal(stats.versionsByRp, 0);
      assert.equal(stats.operationsBySwagger, 0);
    });

    it("should clear cache for specific folder", async () => {
      // Populate caches
      await cache.getAllSwaggers(testRpFolder);
      await cache.getVersionMapping(testRpFolder);

      // Clear cache for specific folder
      cache.clearCacheForFolder(testRpFolder);

      const stats = cache.getCacheStats();
      assert.equal(stats.swaggersByRp, 0);
      assert.equal(stats.versionsByRp, 0);
    });

    it("should provide accurate cache statistics", async () => {
      // Start with a clean cache
      cache.clearCaches();

      let stats = cache.getCacheStats();
      assert.equal(stats.swaggersByRp, 0);
      assert.equal(stats.versionsByRp, 0);
      assert.equal(stats.operationsBySwagger, 0);

      // Populate caches
      await cache.getAllSwaggers(testRpFolder);
      await cache.getVersionMapping(testRpFolder);
      const swaggerPath = join(testRpFolder, "stable", "2022-05-01", "servicelinker.json");
      await cache.getOperations(swaggerPath);

      stats = cache.getCacheStats();
      assert.equal(stats.swaggersByRp, 1);
      assert.equal(stats.versionsByRp, 1);
      assert.equal(stats.operationsBySwagger, 1);
    });
  });
});
