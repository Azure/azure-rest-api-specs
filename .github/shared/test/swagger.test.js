// @ts-check

import { dirname, resolve, join } from "path";
import { describe, expect, it, beforeEach } from "vitest";
import {
  Swagger,
  getVersionFromInputFile,
  getPrecedingSwaggers,
  getLegacyVersionOperations,
  API_VERSION_LIFECYCLE_STAGES,
} from "../src/swagger.js";

import { fileURLToPath } from "url";
import { Readme } from "../src/readme.js";
import { Tag } from "../src/tag.js";
import { SpecModel } from "../src/spec-model.js";
import { ConsoleLogger } from "../src/logger.js";

const __dirname = dirname(fileURLToPath(import.meta.url));

describe("Swagger", () => {
  it("can be created with mock path", async () => {
    const swagger = new Swagger("bar");
    expect(swagger.path).toBe(resolve("bar"));
    expect(swagger.tag).toBeUndefined();

    await expect(swagger.getRefs()).rejects.toThrowError(/Failed to resolve file for swagger/i);
  });

  it("resolves path against Tag.readme", async () => {
    const readme = new Readme("/specs/foo/readme.md");
    const tag = new Tag("2025-01-01", [], { readme });
    const swagger = new Swagger("test.json", { tag });

    expect(swagger.path).toBe(resolve("/specs/foo/test.json"));
  });

  // TODO: Test that path is resolved against backpointer

  it("excludes example files", async () => {
    const swagger = new Swagger(resolve(__dirname, "fixtures/swagger/ignoreExamples/swagger.json"));
    const refs = await swagger.getRefs();

    const expectedIncludedPath = resolve(
      __dirname,
      "fixtures/swagger/ignoreExamples/included.json",
    );
    expect(refs).toMatchObject(
      new Map([
        [
          expectedIncludedPath,
          expect.objectContaining({
            path: expect.stringContaining(expectedIncludedPath),
          }),
        ],
      ]),
    );
  });

  describe("getVersionFromInputFile", () => {
    describe("resource-manager paths", () => {
      it("should extract version from standard resource-manager paths", async () => {
        const testCases = [
          {
            path: "specification/network/resource-manager/Microsoft.Network/stable/2023-01-01/network.json",
            expected: "2023-01-01",
          },
          {
            path: "specification/storage/resource-manager/Microsoft.Storage/stable/2024-04-01/storage.json",
            expected: "2024-04-01",
          },
        ];

        for (const { path, expected } of testCases) {
          expect(await getVersionFromInputFile(path)).toBe(expected);
        }
      });

      it("should extract preview versions from resource-manager paths", async () => {
        const testCases = [
          {
            path: "specification/network/resource-manager/Microsoft.Network/preview/2023-01-01-preview/network.json",
            expected: "2023-01-01",
          },
          {
            path: "specification/network/resource-manager/Microsoft.Network/preview/2024-04-01-preview/network.json",
            expected: "2024-04-01",
            withPreview: false,
          },
          {
            path: "specification/network/resource-manager/Microsoft.Network/preview/2024-04-01-preview/network.json",
            expected: "2024-04-01-preview",
            withPreview: true,
          },
        ];

        for (const { path, expected, withPreview = false } of testCases) {
          expect(await getVersionFromInputFile(path, withPreview)).toBe(expected);
        }
      });

      it("should handle other preview types in resource-manager paths", async () => {
        const testCases = [
          "specification/network/resource-manager/Microsoft.Network/stable/2023-01-01-alpha/network.json",
          "specification/network/resource-manager/Microsoft.Network/stable/2023-01-01-beta/network.json",
          "specification/network/resource-manager/Microsoft.Network/stable/2023-01-01-rc/network.json",
        ];

        for (const path of testCases) {
          expect(await getVersionFromInputFile(path)).toBe("2023-01-01");
        }
      });
    });

    describe("data-plane paths", () => {
      it("should extract version from data-plane stable paths", async () => {
        const testCases = [
          {
            path: "specification/textanalytics/data-plane/TextAnalytics/stable/v3.1/textanalytics.json",
            expected: "v3.1",
          },
          {
            path: "specification/cognitiveservices/data-plane/Face/stable/v1.0/face.json",
            expected: "v1.0",
          },
        ];

        for (const { path, expected } of testCases) {
          expect(await getVersionFromInputFile(path)).toBe(expected);
        }
      });

      it("should extract version from data-plane preview paths", async () => {
        const testCases = [
          {
            path: "specification/textanalytics/data-plane/TextAnalytics/preview/v3.2-preview.1/textanalytics.json",
            expected: "v3.2-preview.1",
          },
          {
            path: "specification/cognitiveservices/data-plane/Face/preview/v1.1-preview.1/face.json",
            expected: "v1.1-preview.1",
          },
        ];

        for (const { path, expected } of testCases) {
          expect(await getVersionFromInputFile(path)).toBe(expected);
        }
      });

      it("should handle standard date versions in data-plane paths", async () => {
        const path =
          "specification/textanalytics/data-plane/TextAnalytics/stable/2023-04-01/textanalytics.json";
        expect(await getVersionFromInputFile(path)).toBe("2023-04-01");
      });
    });

    describe("edge cases and invalid inputs", () => {
      it("should return undefined for paths without valid version patterns", async () => {
        const testCases = [
          "specification/network/resource-manager/Microsoft.Network/unknown/test.json",
          "specification/network/resource-manager/Microsoft.Network/stable/invalid-version/test.json",
          "invalid/path/structure.json",
        ];

        for (const path of testCases) {
          expect(await getVersionFromInputFile(path)).toBeUndefined();
        }
      });

      it("should return undefined for empty or malformed paths", async () => {
        const testCases = ["", "/", "test.json"];

        for (const path of testCases) {
          expect(await getVersionFromInputFile(path)).toBeUndefined();
        }
      });
    });
  });

  describe("Helper functions for version analysis", () => {
    let mockSwaggers;
    let testFixturePath;

    beforeEach(() => {
      testFixturePath = join(__dirname, "fixtures", "swagger", "specification");

      // Create mock Swagger objects based on test fixtures
      mockSwaggers = [
        {
          path: join(
            testFixturePath,
            "servicelinker/resource-manager/Microsoft.ServiceLinker/stable/2022-05-01/servicelinker.json",
          ),
          getVersion: async () => "2022-05-01",
          get versionKind() {
            return API_VERSION_LIFECYCLE_STAGES.STABLE;
          },
          getFileName: async () => "servicelinker.json",
          getOperations: async () => [
            {
              id: "Linker_List",
              httpMethod: "GET",
              path: "/subscriptions/{subscriptionId}/providers/Microsoft.ServiceLinker/linkers",
            },
            {
              id: "Linker_Get",
              httpMethod: "GET",
              path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceLinker/linkers/{linkerName}",
            },
          ],
        },
        {
          path: join(
            testFixturePath,
            "servicelinker/resource-manager/Microsoft.ServiceLinker/stable/2024-04-01/servicelinker.json",
          ),
          getVersion: async () => "2024-04-01",
          get versionKind() {
            return API_VERSION_LIFECYCLE_STAGES.STABLE;
          },
          getFileName: async () => "servicelinker.json",
          getOperations: async () => [
            {
              id: "Linker_List",
              httpMethod: "GET",
              path: "/subscriptions/{subscriptionId}/providers/Microsoft.ServiceLinker/linkers",
            },
            {
              id: "Linker_Get",
              httpMethod: "GET",
              path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceLinker/linkers/{linkerName}",
            },
            {
              id: "Linker_Create",
              httpMethod: "PUT",
              path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceLinker/linkers/{linkerName}",
            },
          ],
        },
        {
          path: join(
            testFixturePath,
            "servicelinker/resource-manager/Microsoft.ServiceLinker/preview/2023-04-01-preview/servicelinker.json",
          ),
          getVersion: async () => "2023-04-01",
          get versionKind() {
            return API_VERSION_LIFECYCLE_STAGES.PREVIEW;
          },
          getFileName: async () => "servicelinker.json",
          getOperations: async () => [
            {
              id: "Linker_List",
              httpMethod: "GET",
              path: "/subscriptions/{subscriptionId}/providers/Microsoft.ServiceLinker/linkers",
            },
            {
              id: "Linker_Preview",
              httpMethod: "POST",
              path: "/subscriptions/{subscriptionId}/providers/Microsoft.ServiceLinker/linkers/preview",
            },
          ],
        },
        {
          path: join(
            testFixturePath,
            "servicelinker/resource-manager/Microsoft.ServiceLinker/preview/2024-07-01-preview/servicelinker.json",
          ),
          getVersion: async () => "2024-07-01",
          get versionKind() {
            return API_VERSION_LIFECYCLE_STAGES.PREVIEW;
          },
          getFileName: async () => "servicelinker.json",
          getOperations: async () => [
            {
              id: "Linker_List",
              httpMethod: "GET",
              path: "/subscriptions/{subscriptionId}/providers/Microsoft.ServiceLinker/linkers",
            },
            {
              id: "Linker_Preview",
              httpMethod: "POST",
              path: "/subscriptions/{subscriptionId}/providers/Microsoft.ServiceLinker/linkers/preview",
            },
            {
              id: "Linker_Advanced",
              httpMethod: "POST",
              path: "/subscriptions/{subscriptionId}/providers/Microsoft.ServiceLinker/linkers/advanced",
            },
          ],
        },
        {
          path: join(
            testFixturePath,
            "network/resource-manager/Microsoft.Network/stable/2020-07-02/a.json",
          ),
          getVersion: async () => "2020-07-02",
          get versionKind() {
            return API_VERSION_LIFECYCLE_STAGES.STABLE;
          },
          getFileName: async () => "a.json",
          getOperations: async () => [
            {
              id: "VirtualNetworks_List",
              httpMethod: "GET",
              path: "/subscriptions/{subscriptionId}/providers/Microsoft.Network/virtualNetworks",
            },
          ],
        },
        {
          path: join(
            testFixturePath,
            "network/resource-manager/Microsoft.Network/stable/2020-08-04/a.json",
          ),
          getVersion: async () => "2020-08-04",
          get versionKind() {
            return API_VERSION_LIFECYCLE_STAGES.STABLE;
          },
          getFileName: async () => "a.json",
          getOperations: async () => [
            {
              id: "VirtualNetworks_List",
              httpMethod: "GET",
              path: "/subscriptions/{subscriptionId}/providers/Microsoft.Network/virtualNetworks",
            },
            {
              id: "VirtualNetworks_Create",
              httpMethod: "PUT",
              path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}",
            },
          ],
        },
        {
          path: join(
            testFixturePath,
            "network/resource-manager/Microsoft.Network/preview/2020-07-02/a.json",
          ),
          getVersion: async () => "2020-07-02",
          get versionKind() {
            return API_VERSION_LIFECYCLE_STAGES.PREVIEW;
          },
          getFileName: async () => "a.json",
          getOperations: async () => [
            {
              id: "VirtualNetworks_List",
              httpMethod: "GET",
              path: "/subscriptions/{subscriptionId}/providers/Microsoft.Network/virtualNetworks",
            },
          ],
        },
        {
          path: join(
            testFixturePath,
            "network/resource-manager/Microsoft.Network/preview/2020-08-04-preview/a.json",
          ),
          getVersion: async () => "2020-08-04",
          get versionKind() {
            return API_VERSION_LIFECYCLE_STAGES.PREVIEW;
          },
          getFileName: async () => "a.json",
          getOperations: async () => [
            {
              id: "VirtualNetworks_List",
              httpMethod: "GET",
              path: "/subscriptions/{subscriptionId}/providers/Microsoft.Network/virtualNetworks",
            },
            {
              id: "VirtualNetworks_Preview",
              httpMethod: "POST",
              path: "/subscriptions/{subscriptionId}/providers/Microsoft.Network/virtualNetworks/preview",
            },
          ],
        },
      ];
    });

    describe("getPrecedingSwaggers", () => {
      it("should find preceding preview and stable versions", async () => {
        const targetPath = join(
          testFixturePath,
          "servicelinker/resource-manager/Microsoft.ServiceLinker/stable/2024-04-01/servicelinker.json",
        );
        const result = await getPrecedingSwaggers(targetPath, mockSwaggers);

        expect(result.stable).toBe(
          join(
            testFixturePath,
            "servicelinker/resource-manager/Microsoft.ServiceLinker/stable/2022-05-01/servicelinker.json",
          ),
        );
        // Should find the preview version <= current version (2023-04-01, not 2024-07-01)
        expect(result.preview).toBe(
          join(
            testFixturePath,
            "servicelinker/resource-manager/Microsoft.ServiceLinker/preview/2023-04-01-preview/servicelinker.json",
          ),
        );
      });

      it("should find preceding preview version for preview files", async () => {
        const targetPath = join(
          testFixturePath,
          "servicelinker/resource-manager/Microsoft.ServiceLinker/preview/2024-07-01-preview/servicelinker.json",
        );
        const result = await getPrecedingSwaggers(targetPath, mockSwaggers);

        expect(result.preview).toBe(
          join(
            testFixturePath,
            "servicelinker/resource-manager/Microsoft.ServiceLinker/preview/2023-04-01-preview/servicelinker.json",
          ),
        );
        expect(result.stable).toBe(
          join(
            testFixturePath,
            "servicelinker/resource-manager/Microsoft.ServiceLinker/stable/2024-04-01/servicelinker.json",
          ),
        );
      });

      it("should return undefined when no preceding stable versions exist", async () => {
        const targetPath = join(
          testFixturePath,
          "servicelinker/resource-manager/Microsoft.ServiceLinker/stable/2022-05-01/servicelinker.json",
        );
        const result = await getPrecedingSwaggers(targetPath, mockSwaggers);

        expect(result.stable).toBeUndefined();
        // Should find no preview version <= 2022-05-01 (all previews are newer)
        expect(result.preview).toBeUndefined();
      });

      it("should handle non-existent target swagger", async () => {
        const targetPath = "/non/existent/swagger.json";
        const result = await getPrecedingSwaggers(targetPath, mockSwaggers);

        expect(result.preview).toBeUndefined();
        expect(result.stable).toBeUndefined();
      });

      it("should work with network API fixtures", async () => {
        const targetPath = join(
          testFixturePath,
          "network/resource-manager/Microsoft.Network/stable/2020-08-04/a.json",
        );
        const result = await getPrecedingSwaggers(targetPath, mockSwaggers);

        expect(result.stable).toBe(
          join(
            testFixturePath,
            "network/resource-manager/Microsoft.Network/stable/2020-07-02/a.json",
          ),
        );
        expect(result.preview).toBe(
          join(
            testFixturePath,
            "network/resource-manager/Microsoft.Network/preview/2020-08-04-preview/a.json",
          ),
        );
      });
    });

    describe("getLegacyVersionOperations", () => {
      it("should find operations that exist in both previous and current versions", async () => {
        const targetPath = join(
          testFixturePath,
          "servicelinker/resource-manager/Microsoft.ServiceLinker/stable/2024-04-01/servicelinker.json",
        );
        const result = await getLegacyVersionOperations(targetPath, mockSwaggers);

        expect(result.length).toBeGreaterThan(0);

        // Should find common operations from 2022-05-01 version
        const linkerListOp = result.find((op) => op.id === "Linker_List");
        expect(linkerListOp).toBeDefined();
        expect(linkerListOp?.swagger).toBe(
          join(
            testFixturePath,
            "servicelinker/resource-manager/Microsoft.ServiceLinker/stable/2022-05-01/servicelinker.json",
          ),
        );

        const linkerGetOp = result.find((op) => op.id === "Linker_Get");
        expect(linkerGetOp).toBeDefined();
        expect(linkerGetOp?.swagger).toBe(
          join(
            testFixturePath,
            "servicelinker/resource-manager/Microsoft.ServiceLinker/stable/2022-05-01/servicelinker.json",
          ),
        );

        // Should not find operations that only exist in current version
        const linkerCreateOp = result.find((op) => op.id === "Linker_Create");
        expect(linkerCreateOp).toBeUndefined();
      });

      it("should find operations from multiple previous versions", async () => {
        const targetPath = join(
          testFixturePath,
          "servicelinker/resource-manager/Microsoft.ServiceLinker/preview/2024-07-01-preview/servicelinker.json",
        );
        const result = await getLegacyVersionOperations(targetPath, mockSwaggers);

        expect(result.length).toBeGreaterThan(0);

        // Should find operations from 2023-04-01-preview version
        const linkerPreviewOp = result.find((op) => op.id === "Linker_Preview");
        expect(linkerPreviewOp).toBeDefined();
        expect(linkerPreviewOp?.swagger).toBe(
          join(
            testFixturePath,
            "servicelinker/resource-manager/Microsoft.ServiceLinker/preview/2023-04-01-preview/servicelinker.json",
          ),
        );
      });

      it("should return empty array for oldest version with no previous versions", async () => {
        const targetPath = join(
          testFixturePath,
          "servicelinker/resource-manager/Microsoft.ServiceLinker/stable/2022-05-01/servicelinker.json",
        );
        const result = await getLegacyVersionOperations(targetPath, mockSwaggers);

        expect(result).toEqual([]);
      });

      it("should handle non-existent target swagger", async () => {
        const targetPath = "/non/existent/swagger.json";
        const result = await getLegacyVersionOperations(targetPath, mockSwaggers);

        expect(result).toEqual([]);
      });

      it("should only include operations that exist in current version", async () => {
        const targetPath = join(
          testFixturePath,
          "network/resource-manager/Microsoft.Network/stable/2020-08-04/a.json",
        );
        const result = await getLegacyVersionOperations(targetPath, mockSwaggers);

        // Should find VirtualNetworks_List from both 2020-07-02 stable and 2020-07-02 preview
        expect(result.length).toBe(2);

        const vnListOps = result.filter((op) => op.id === "VirtualNetworks_List");
        expect(vnListOps.length).toBe(2); // Found from both previous versions

        // Verify the swagger sources are different
        const swaggerSources = vnListOps.map((op) => op.swagger);
        expect(swaggerSources).toContain(
          join(
            testFixturePath,
            "network/resource-manager/Microsoft.Network/stable/2020-07-02/a.json",
          ),
        );
        expect(swaggerSources).toContain(
          join(
            testFixturePath,
            "network/resource-manager/Microsoft.Network/preview/2020-07-02/a.json",
          ),
        );
      });

      it("should preserve operation structure with correct property mapping", async () => {
        const targetPath = join(
          testFixturePath,
          "servicelinker/resource-manager/Microsoft.ServiceLinker/stable/2024-04-01/servicelinker.json",
        );
        const result = await getLegacyVersionOperations(targetPath, mockSwaggers);

        const operation = result[0];
        expect(operation).toHaveProperty("id");
        expect(operation).toHaveProperty("httpMethod");
        expect(operation).toHaveProperty("path");
        expect(operation).toHaveProperty("swagger");

        expect(typeof operation.id).toBe("string");
        expect(typeof operation.httpMethod).toBe("string");
        expect(typeof operation.path).toBe("string");
        expect(typeof operation.swagger).toBe("string");
      });
    });

    describe("getOperations", () => {
      it("should return normal operations", async () => {
        const targetPath = join(
          testFixturePath,
          "servicelinker/resource-manager/Microsoft.ServiceLinker/stable/2024-04-01/test.json",
        );
        const specModel = new SpecModel(testFixturePath, {
          logger: new ConsoleLogger(/*debug*/ true),
        });
        const result = await specModel.getSwaggers();
        const swagger = result.find((s) => s.path === targetPath);

        if (!swagger) throw new Error("Swagger not found for the given path");
        const operationsMap = await swagger.getOperations();
        expect(operationsMap.size).toBe(3);

        let expectedApiPath =
          "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.ServiceLinker/locations/{location}/dryruns/{dryrunName}";

        // Test specific operations by ID
        const createDryrun = operationsMap.get("Connector_CreateDryrun");
        const getDryrun = operationsMap.get("Connector_GetDryrun");
        const listDryruns = operationsMap.get("Connector_ListDryrun");

        expect(createDryrun).toBeDefined();
        if (createDryrun) {
          expect(createDryrun.id).toBe("Connector_CreateDryrun");
          expect(createDryrun.httpMethod).toBe("PUT");
          expect(createDryrun.path).toBe(expectedApiPath);
        }

        expect(getDryrun).toBeDefined();
        if (getDryrun) {
          expect(getDryrun.id).toBe("Connector_GetDryrun");
          expect(getDryrun.httpMethod).toBe("GET");
          expect(getDryrun.path).toBe(expectedApiPath);
        }

        expectedApiPath =
          "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.ServiceLinker/locations/{location}/dryruns";
        expect(listDryruns).toBeDefined();
        if (listDryruns) {
          expect(listDryruns.id).toBe("Connector_ListDryrun");
          expect(listDryruns.httpMethod).toBe("GET");
          expect(listDryruns.path).toBe(expectedApiPath);
        }
      });
    });
  });
});
