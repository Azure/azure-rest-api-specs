import { describe, expect, it } from "vitest";
import {
  getPrecedingSwaggers,
  getExistedVersionOperations,
  type Swagger,
} from "../../src/utils/spec.js";
import { ApiVersionLifecycleStage } from "../../src/types/breaking-change.js";

// Type definitions for tests (extending the base interfaces if needed)
interface MockSwagger extends Swagger {
  // Can add test-specific properties if needed
}

describe("Helper functions for version analysis", () => {
  describe("getPrecedingSwaggers", () => {
    it("should find preceding stable and preview versions", async () => {
      // Mock swagger objects for different versions
      const mockSwaggers: MockSwagger[] = [
        {
          path: "/test/stable/2020-07-02/a.json",
          versionKind: ApiVersionLifecycleStage.STABLE,
        },
        {
          path: "/test/stable/2020-08-04/a.json",
          versionKind: ApiVersionLifecycleStage.STABLE,
        },
        {
          path: "/test/preview/2020-07-02/a.json",
          versionKind: ApiVersionLifecycleStage.PREVIEW,
        },
        {
          path: "/test/preview/2020-08-04-preview/a.json",
          versionKind: ApiVersionLifecycleStage.PREVIEW,
        },
      ];

      const targetPath = "/test/stable/2020-08-04/a.json";
      const result = await getPrecedingSwaggers(targetPath, mockSwaggers);

      expect(result).toHaveProperty("stable");
      expect(result).toHaveProperty("preview");
      expect(result.stable).toBe("/test/stable/2020-07-02/a.json");
      // The logic now finds the most recent preview version that's <= target version
      expect(result.preview).toBe("/test/preview/2020-08-04-preview/a.json");
    });

    it("should return undefined when no preceding versions exist", async () => {
      const mockSwaggers: MockSwagger[] = [
        {
          path: "/test/stable/2020-07-02/a.json",
          versionKind: ApiVersionLifecycleStage.STABLE,
        },
      ];

      const targetPath = "/test/stable/2020-07-02/a.json";
      const result = await getPrecedingSwaggers(targetPath, mockSwaggers);

      expect(result).toHaveProperty("stable");
      expect(result).toHaveProperty("preview");
      expect(result.stable).toBeUndefined();
      expect(result.preview).toBeUndefined();
    });

    it("should return undefined when target swagger is not found", async () => {
      const mockSwaggers: MockSwagger[] = [
        {
          path: "/test/stable/2020-07-02/a.json",
          versionKind: ApiVersionLifecycleStage.STABLE,
        },
      ];

      const targetPath = "/nonexistent/path.json";
      const result = await getPrecedingSwaggers(targetPath, mockSwaggers);

      expect(result).toHaveProperty("stable");
      expect(result).toHaveProperty("preview");
      expect(result.stable).toBeUndefined();
      expect(result.preview).toBeUndefined();
    });

    it("should handle null or undefined availableSwaggers array", async () => {
      const targetPath = "/test/stable/2020-08-04/a.json";

      // Test with null
      const resultNull = await getPrecedingSwaggers(targetPath, null);
      expect(resultNull).toHaveProperty("stable");
      expect(resultNull).toHaveProperty("preview");
      expect(resultNull.stable).toBeUndefined();
      expect(resultNull.preview).toBeUndefined();

      // Test with undefined
      const resultUndefined = await getPrecedingSwaggers(targetPath, undefined);
      expect(resultUndefined).toHaveProperty("stable");
      expect(resultUndefined).toHaveProperty("preview");
      expect(resultUndefined.stable).toBeUndefined();
      expect(resultUndefined.preview).toBeUndefined();

      // Test with empty array
      const resultEmpty = await getPrecedingSwaggers(targetPath, []);
      expect(resultEmpty).toHaveProperty("stable");
      expect(resultEmpty).toHaveProperty("preview");
      expect(resultEmpty.stable).toBeUndefined();
      expect(resultEmpty.preview).toBeUndefined();
    });
  });

  describe("getExistedVersionOperations", () => {
    it("should find operations that exist in both previous and current versions", async () => {
      const mockOperations1 = new Map([
        [
          "Operation_Test1",
          {
            id: "Operation_Test1",
            path: "/test/path1",
            httpMethod: "GET",
          },
        ],
        [
          "Operation_Test2",
          {
            id: "Operation_Test2",
            path: "/test/path2",
            httpMethod: "POST",
          },
        ],
      ]);

      const mockOperations2 = new Map([
        [
          "Operation_Test1",
          {
            id: "Operation_Test1",
            path: "/test/path1",
            httpMethod: "GET",
          },
        ],
        [
          "Operation_Test3",
          {
            id: "Operation_Test3",
            path: "/test/path3",
            httpMethod: "DELETE",
          },
        ],
      ]);

      const mockSwaggers: MockSwagger[] = [
        {
          path: "/test/stable/2020-07-02/b.json", // Different filename
          getOperations: async () => mockOperations1,
        },
        {
          path: "/test/stable/2020-08-04/a.json",
          getOperations: async () => mockOperations2,
        },
      ];

      const targetPath = "/test/stable/2020-08-04/a.json";
      const result = await getExistedVersionOperations(targetPath, mockSwaggers);

      expect(result).toBeInstanceOf(Map);
      // The result should contain the previous swagger path as key, not the target path
      expect(result.has("/test/stable/2020-07-02/b.json")).toBe(true);

      const operations = result.get("/test/stable/2020-07-02/b.json");
      expect(operations).toBeDefined();
      if (operations) {
        expect(operations).toHaveLength(1);

        const operation = operations[0];
        expect(operation).toHaveProperty("id", "Operation_Test1");
        expect(operation).toHaveProperty("path", "/test/path1");
        expect(operation).toHaveProperty("httpMethod", "GET");
      }
    });

    it("should return empty result when no matching operations exist", async () => {
      const mockOperations1 = new Map([
        [
          "Operation_Old",
          {
            id: "Operation_Old",
            path: "/test/old",
            httpMethod: "GET",
          },
        ],
      ]);

      const mockOperations2 = new Map([
        [
          "Operation_New",
          {
            id: "Operation_New",
            path: "/test/new",
            httpMethod: "POST",
          },
        ],
      ]);

      const mockSwaggers: MockSwagger[] = [
        {
          path: "/test/stable/2020-07-02/b.json", // Different filename
          getOperations: async () => mockOperations1,
        },
        {
          path: "/test/stable/2020-08-04/a.json",
          getOperations: async () => mockOperations2,
        },
      ];

      const targetPath = "/test/stable/2020-08-04/a.json";
      const result = await getExistedVersionOperations(targetPath, mockSwaggers);

      expect(result).toBeInstanceOf(Map);
      // Should contain the previous swagger path with empty operations
      expect(result.has("/test/stable/2020-07-02/b.json")).toBe(true);

      const operations = result.get("/test/stable/2020-07-02/b.json");
      expect(operations).toBeDefined();
      if (operations) {
        expect(operations).toHaveLength(0);
      }
    });

    it("should return empty map when target swagger is not found", async () => {
      /** @type {any[]} */
      const mockSwaggers = [
        {
          path: "/test/stable/2020-07-02/a.json",
          getOperations: async () => new Map(),
        },
      ];

      const targetPath = "/nonexistent/path.json";
      const result = await getExistedVersionOperations(targetPath, mockSwaggers);

      expect(result).toBeInstanceOf(Map);
      expect(result.size).toBe(0);
    });

    it("should handle multiple previous versions correctly", async () => {
      const sharedOperation = {
        id: "SharedOperation",
        path: "/shared/path",
        httpMethod: "GET",
      };

      const mockOperations1 = new Map([["SharedOperation", sharedOperation]]);
      const mockOperations2 = new Map([["SharedOperation", sharedOperation]]);
      const mockOperations3 = new Map([["SharedOperation", sharedOperation]]);

      const mockSwaggers: MockSwagger[] = [
        {
          path: "/test/stable/2020-05-01/b.json", // Different filename
          getOperations: async () => mockOperations1,
        },
        {
          path: "/test/stable/2020-07-02/c.json", // Different filename
          getOperations: async () => mockOperations2,
        },
        {
          path: "/test/stable/2020-08-04/a.json",
          getOperations: async () => mockOperations3,
        },
      ];

      const targetPath = "/test/stable/2020-08-04/a.json";
      const result = await getExistedVersionOperations(targetPath, mockSwaggers);

      expect(result).toBeInstanceOf(Map);
      // Should contain both previous swagger paths as keys
      expect(result.has("/test/stable/2020-05-01/b.json")).toBe(true);
      expect(result.has("/test/stable/2020-07-02/c.json")).toBe(true);

      // Check operations from first previous version
      const operations1 = result.get("/test/stable/2020-05-01/b.json");
      expect(operations1).toBeDefined();
      if (operations1) {
        expect(operations1).toHaveLength(1);
        expect(operations1[0]).toHaveProperty("id", "SharedOperation");
      }

      // Check operations from second previous version
      const operations2 = result.get("/test/stable/2020-07-02/c.json");
      expect(operations2).toBeDefined();
      if (operations2) {
        expect(operations2).toHaveLength(1);
        expect(operations2[0]).toHaveProperty("id", "SharedOperation");
      }
    });

    it("should handle null or undefined availableSwaggers array", async () => {
      const targetPath = "/test/stable/2020-08-04/a.json";

      // Test with null
      const resultNull = await getExistedVersionOperations(targetPath, null);
      expect(resultNull).toBeInstanceOf(Map);
      expect(resultNull.size).toBe(0);

      // Test with undefined
      const resultUndefined = await getExistedVersionOperations(targetPath, undefined);
      expect(resultUndefined).toBeInstanceOf(Map);
      expect(resultUndefined.size).toBe(0);

      // Test with empty array
      const resultEmpty = await getExistedVersionOperations(targetPath, []);
      expect(resultEmpty).toBeInstanceOf(Map);
      expect(resultEmpty.size).toBe(0);
    });
  });
});
