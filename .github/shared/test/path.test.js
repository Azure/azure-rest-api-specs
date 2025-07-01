// @ts-check

import { describe, it, beforeEach, afterEach } from "vitest";
import { includesFolder, getVersionFromInputFile, getBaseNameForSwagger } from "../src/path.js";
import { strict as assert } from "assert";
import { join, dirname } from "path";
import { fileURLToPath } from "url";
import { writeFileSync, mkdirSync, rmSync, existsSync } from "fs";

// Get the directory of this test file
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

/**
 * Unit tests for path.js utility functions
 */
describe("Path utilities", () => {
  let tempTestDir;

  beforeEach(() => {
    // Create a temporary directory for test files
    tempTestDir = join(__dirname, "temp-path-tests");
    if (existsSync(tempTestDir)) {
      rmSync(tempTestDir, { recursive: true, force: true });
    }
    mkdirSync(tempTestDir, { recursive: true });
  });

  afterEach(() => {
    // Clean up temporary directory
    if (existsSync(tempTestDir)) {
      rmSync(tempTestDir, { recursive: true, force: true });
    }
  });

  describe("includesFolder", () => {
    it("should return true when path contains the specified folder", () => {
      assert.equal(includesFolder("/path/to/examples/file.json", "examples"), true);
    });

    it("should return false when path does not contain the specified folder", () => {
      assert.equal(includesFolder("/path/to/swagger/file.json", "examples"), false);
    });
  });

  describe("getVersionFromInputFile", () => {
    describe("resource-manager (non-data-plane) paths", () => {
      it("should extract version from standard resource-manager paths", () => {
        assert.equal(
          getVersionFromInputFile(
            "specification/network/resource-manager/Microsoft.Network/stable/2023-01-01/network.json",
          ),
          "2023-01-01",
        );
      });

      it("should extract preview versions from resource-manager paths", () => {
        assert.equal(
          getVersionFromInputFile(
            "specification/network/resource-manager/Microsoft.Network/preview/2023-01-01-preview/network.json",
          ),
          "2023-01-01",
        );
        assert.equal(
          getVersionFromInputFile(
            "specification/network/resource-manager/Microsoft.Network/preview/2023-01-01-preview/network.json",
            true,
          ),
          "2023-01-01-preview",
        );
      });

      it("should handle other preview types in resource-manager paths", () => {
        assert.equal(
          getVersionFromInputFile(
            "specification/test/resource-manager/Microsoft.Test/preview/2023-01-01-privatepreview/test.json",
          ),
          "2023-01-01",
        );
        assert.equal(
          getVersionFromInputFile(
            "specification/test/resource-manager/Microsoft.Test/preview/2023-01-01-alpha/test.json",
          ),
          "2023-01-01",
        );
        assert.equal(
          getVersionFromInputFile(
            "specification/test/resource-manager/Microsoft.Test/preview/2023-01-01-beta/test.json",
          ),
          "2023-01-01",
        );
        assert.equal(
          getVersionFromInputFile(
            "specification/test/resource-manager/Microsoft.Test/preview/2023-01-01-rc/test.json",
          ),
          "2023-01-01",
        );
      });

      it("should handle withPreview flag for resource-manager paths", () => {
        assert.equal(
          getVersionFromInputFile(
            "specification/network/resource-manager/Microsoft.Network/preview/2023-01-01-preview/network.json",
            false,
          ),
          "2023-01-01",
        );
        assert.equal(
          getVersionFromInputFile(
            "specification/network/resource-manager/Microsoft.Network/preview/2023-01-01-preview/network.json",
            true,
          ),
          "2023-01-01-preview",
        );
        assert.equal(
          getVersionFromInputFile(
            "specification/test/resource-manager/Microsoft.Test/preview/2023-01-01-alpha/test.json",
            true,
          ),
          "2023-01-01-alpha",
        );
      });
    });

    describe("data-plane paths", () => {
      it("should extract version from data-plane stable paths", () => {
        assert.equal(
          getVersionFromInputFile(
            "specification/textanalytics/data-plane/TextAnalytics/stable/v3.1/TextAnalytics.json",
          ),
          "v3.1",
        );
        assert.equal(
          getVersionFromInputFile(
            "specification/cognitiveservices/data-plane/Face/stable/v1.0/Face.json",
          ),
          "v1.0",
        );
        assert.equal(
          getVersionFromInputFile(
            "specification/keyvault/data-plane/Microsoft.KeyVault/stable/7.3/keyvault.json",
          ),
          "7.3",
        );
      });

      it("should extract version from data-plane preview paths", () => {
        assert.equal(
          getVersionFromInputFile(
            "specification/textanalytics/data-plane/TextAnalytics/preview/v3.2-preview.1/TextAnalytics.json",
          ),
          "v3.2-preview.1",
        );
        assert.equal(
          getVersionFromInputFile(
            "specification/cognitiveservices/data-plane/Face/preview/v1.1-preview/Face.json",
          ),
          "v1.1-preview",
        );
      });

      it("should handle standard date versions in data-plane paths", () => {
        assert.equal(
          getVersionFromInputFile(
            "specification/eventgrid/data-plane/Microsoft.EventGrid/stable/2018-01-01/EventGrid.json",
          ),
          "2018-01-01",
        );
        assert.equal(
          getVersionFromInputFile(
            "specification/eventgrid/data-plane/Microsoft.EventGrid/preview/2020-10-15-preview/EventGrid.json",
          ),
          "2020-10-15",
        );
        assert.equal(
          getVersionFromInputFile(
            "specification/eventgrid/data-plane/Microsoft.EventGrid/preview/2020-10-15-preview/EventGrid.json",
            true,
          ),
          "2020-10-15-preview",
        );
      });
    });

    describe("version extraction from JSON files", () => {
      it("should extract version from JSON file info.version when path parsing fails", () => {
        const testSwaggerPath = join(tempTestDir, "test-swagger.json");
        const swaggerContent = {
          swagger: "2.0",
          info: {
            version: "1.0.0",
            title: "Test API",
          },
          paths: {},
        };
        writeFileSync(testSwaggerPath, JSON.stringify(swaggerContent, null, 2));

        const version = getVersionFromInputFile(testSwaggerPath);
        assert.equal(version, "1.0.0");
      });

      it("should handle JSON files without version info", () => {
        const testSwaggerPath = join(tempTestDir, "test-swagger-no-version.json");
        const swaggerContent = {
          swagger: "2.0",
          info: {
            title: "Test API",
          },
          paths: {},
        };
        writeFileSync(testSwaggerPath, JSON.stringify(swaggerContent, null, 2));

        const version = getVersionFromInputFile(testSwaggerPath);
        assert.equal(version, undefined);
      });

      it("should handle invalid JSON files gracefully", () => {
        const testSwaggerPath = join(tempTestDir, "invalid-swagger.json");
        writeFileSync(testSwaggerPath, "invalid json content");

        const version = getVersionFromInputFile(testSwaggerPath);
        assert.equal(version, undefined);
      });
    });

    describe("edge cases and invalid inputs", () => {
      it("should return undefined for non-existent files with no version in path", () => {
        assert.equal(getVersionFromInputFile("/non/existent/path/file.json"), undefined);
        assert.equal(getVersionFromInputFile("invalid/path/without/version.json"), undefined);
      });

      it("should return undefined for paths without valid version patterns", () => {
        assert.equal(
          getVersionFromInputFile(
            "specification/network/resource-manager/Microsoft.Network/invalid/version/network.json",
          ),
          undefined,
        );
        assert.equal(
          getVersionFromInputFile(
            "specification/test/data-plane/Test/invalid/badversion/test.json",
          ),
          undefined,
        );
      });

      it("should return undefined for empty or malformed paths", () => {
        assert.equal(getVersionFromInputFile(""), undefined);
        assert.equal(getVersionFromInputFile("/"), undefined);
        assert.equal(getVersionFromInputFile("file.json"), undefined);
      });
    });
  });

  describe("getBaseNameForSwagger", () => {
    it("should return the file path after version directory for resource-manager files", () => {
      assert.equal(
        getBaseNameForSwagger(
          "specification/network/resource-manager/Microsoft.Network/stable/2023-01-01/network.json",
        ),
        "network.json",
      );
      assert.equal(
        getBaseNameForSwagger(
          "specification/servicelinker/resource-manager/Microsoft.ServiceLinker/stable/2022-05-01/servicelinker.json",
        ),
        "servicelinker.json",
      );
      assert.equal(
        getBaseNameForSwagger(
          "specification/compute/resource-manager/Microsoft.Compute/preview/2023-01-01-preview/subfolder/compute.json",
        ),
        "subfolder/compute.json",
      );
    });

    it("should return the file path after version directory for data-plane files", () => {
      assert.equal(
        getBaseNameForSwagger(
          "specification/textanalytics/data-plane/TextAnalytics/stable/v3.1/TextAnalytics.json",
        ),
        "TextAnalytics.json",
      );
      assert.equal(
        getBaseNameForSwagger(
          "specification/cognitiveservices/data-plane/Face/preview/v1.1-preview/Face.json",
        ),
        "Face.json",
      );
      assert.equal(
        getBaseNameForSwagger(
          "specification/keyvault/data-plane/Microsoft.KeyVault/stable/7.3/subfolder/keyvault.json",
        ),
        "subfolder/keyvault.json",
      );
    });

    it("should handle preview versions correctly", () => {
      assert.equal(
        getBaseNameForSwagger(
          "specification/network/resource-manager/Microsoft.Network/preview/2023-01-01-preview/network.json",
        ),
        "network.json",
      );
      assert.equal(
        getBaseNameForSwagger(
          "specification/textanalytics/data-plane/TextAnalytics/preview/v3.2-preview.1/TextAnalytics.json",
        ),
        "TextAnalytics.json",
      );
    });

    it("should return basename when version cannot be extracted from path", () => {
      assert.equal(getBaseNameForSwagger("invalid/path/without/version/file.json"), "file.json");
      assert.equal(
        getBaseNameForSwagger(
          "specification/test/resource-manager/Microsoft.Test/invalid/path.json",
        ),
        "path.json",
      );
      assert.equal(getBaseNameForSwagger("simple-file.json"), "simple-file.json");
    });

    it("should handle complex nested paths", () => {
      assert.equal(
        getBaseNameForSwagger(
          "specification/network/resource-manager/Microsoft.Network/stable/2023-01-01/subfolder/nested/network.json",
        ),
        "subfolder/nested/network.json",
      );
      assert.equal(
        getBaseNameForSwagger(
          "specification/textanalytics/data-plane/TextAnalytics/stable/v3.1/nested/folder/file.json",
        ),
        "nested/folder/file.json",
      );
    });

    it("should handle files with version info in JSON when path parsing fails", () => {
      const testSwaggerPath = join(tempTestDir, "versioned-swagger.json");
      const swaggerContent = {
        swagger: "2.0",
        info: {
          version: "2023-01-01",
          title: "Test API",
        },
        paths: {},
      };
      writeFileSync(testSwaggerPath, JSON.stringify(swaggerContent, null, 2));

      // Since the path doesn't contain a version directory structure,
      // it should find version from JSON and try to use it
      const baseName = getBaseNameForSwagger(testSwaggerPath);
      // When no version directory is found, it falls back to basename
      assert.equal(baseName, "versioned-swagger.json");
    });

    it("should handle edge cases gracefully", () => {
      assert.equal(getBaseNameForSwagger(""), "");
      assert.equal(getBaseNameForSwagger("/"), "");
      assert.equal(getBaseNameForSwagger("file.json"), "file.json");
    });
  });
});
