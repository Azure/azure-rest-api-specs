import { describe, expect, it } from "vitest";
import { ApiVersionLifecycleStage } from "../../src/types/breaking-change.js";
import {
  deduplicateSwaggers,
  getBaseNameForSwagger,
  getExistedVersionOperations,
  getPrecedingSwaggers,
  type Swagger,
} from "../../src/utils/spec.js";

// Type definitions for tests (extending the base interfaces if needed)
interface MockSwagger extends Swagger {
  // Can add test-specific properties if needed
}

describe("Helper functions for version analysis", () => {
  // Helper function to create mock operations
  const createMockOperation = (id: string, path: string, httpMethod = "GET") => ({
    id,
    path,
    httpMethod,
  });

  // Helper function to create mock swagger objects
  const createMockSwagger = (
    path: string,
    versionKind?: ApiVersionLifecycleStage,
    operations?: Map<string, any>,
  ): MockSwagger => ({
    path,
    ...(versionKind && { versionKind }),
    ...(operations && { getOperations: async () => operations }),
  });

  // Helper function to create operations map
  const createOperationsMap = (
    operations: Array<{ id: string; path: string; httpMethod?: string }>,
  ) => {
    const map = new Map();
    operations.forEach((op) => {
      map.set(op.id, createMockOperation(op.id, op.path, op.httpMethod || "GET"));
    });
    return map;
  };

  // Helper function to expect standard result structure
  const expectResultStructure = (result: any, stable?: string, preview?: string) => {
    expect(result).toHaveProperty("stable");
    expect(result).toHaveProperty("preview");
    if (stable !== undefined) expect(result.stable).toBe(stable);
    if (preview !== undefined) expect(result.preview).toBe(preview);
  };

  // Common test paths
  const TEST_PATHS = {
    stable2020_07_02: "/test/stable/2020-07-02/a.json",
    stable2020_08_04: "/test/stable/2020-08-04/a.json",
    preview2020_07_02: "/test/preview/2020-07-02/a.json",
    preview2020_08_04: "/test/preview/2020-08-04-preview/a.json",
    differentFile2020_07_02: "/test/stable/2020-07-02/b.json",
    differentFile2020_05_01: "/test/stable/2020-05-01/b.json",
    differentFile2020_07_02_c: "/test/stable/2020-07-02/c.json",
    nonexistent: "/nonexistent/path.json",
  };

  // Common operations
  const OPERATIONS = {
    test1: { id: "Operation_Test1", path: "/test/path1", httpMethod: "GET" },
    test2: { id: "Operation_Test2", path: "/test/path2", httpMethod: "POST" },
    test3: { id: "Operation_Test3", path: "/test/path3", httpMethod: "DELETE" },
    old: { id: "Operation_Old", path: "/test/old", httpMethod: "GET" },
    new: { id: "Operation_New", path: "/test/new", httpMethod: "POST" },
    shared: { id: "SharedOperation", path: "/shared/path", httpMethod: "GET" },
  };
  describe("getPrecedingSwaggers", () => {
    it("should find preceding stable and preview versions", async () => {
      // Mock swagger objects for different versions
      const mockSwaggers: MockSwagger[] = [
        createMockSwagger(TEST_PATHS.stable2020_07_02, ApiVersionLifecycleStage.STABLE),
        createMockSwagger(TEST_PATHS.stable2020_08_04, ApiVersionLifecycleStage.STABLE),
        createMockSwagger(TEST_PATHS.preview2020_07_02, ApiVersionLifecycleStage.PREVIEW),
        createMockSwagger(TEST_PATHS.preview2020_08_04, ApiVersionLifecycleStage.PREVIEW),
      ];

      const result = await getPrecedingSwaggers(TEST_PATHS.stable2020_08_04, mockSwaggers);

      expectResultStructure(result, TEST_PATHS.stable2020_08_04, TEST_PATHS.preview2020_08_04);
    });

    it("should return the version itself when it's the only version", async () => {
      const mockSwaggers: MockSwagger[] = [
        createMockSwagger(TEST_PATHS.stable2020_07_02, ApiVersionLifecycleStage.STABLE),
      ];

      const result = await getPrecedingSwaggers(TEST_PATHS.stable2020_07_02, mockSwaggers);

      expectResultStructure(result, TEST_PATHS.stable2020_07_02);
      expect(result.preview).toBeUndefined();
    });

    it("should return undefined when target swagger is not found", async () => {
      const mockSwaggers: MockSwagger[] = [
        createMockSwagger(TEST_PATHS.stable2020_07_02, ApiVersionLifecycleStage.STABLE),
      ];

      await expect(getPrecedingSwaggers(TEST_PATHS.nonexistent, mockSwaggers)).rejects.toThrow(
        `Failed to read version from file:${TEST_PATHS.nonexistent}`,
      );
    });

    it("should handle null or undefined availableSwaggers array", async () => {
      const testCases = [[], [], []]; // Testing empty arrays multiple times

      for (const swaggers of testCases) {
        const result = await getPrecedingSwaggers(TEST_PATHS.stable2020_08_04, swaggers);
        expectResultStructure(result);
        expect(result.stable).toBeUndefined();
        expect(result.preview).toBeUndefined();
      }
    });
  });

  describe("getExistedVersionOperations", () => {
    it("should find operations that exist in both previous and current versions", async () => {
      const mockOperations1 = createOperationsMap([OPERATIONS.test1, OPERATIONS.test2]);
      const mockOperations2 = createOperationsMap([OPERATIONS.test1, OPERATIONS.test3]);

      const mockSwaggers: MockSwagger[] = [
        createMockSwagger(TEST_PATHS.differentFile2020_07_02, undefined, mockOperations1),
        createMockSwagger(TEST_PATHS.stable2020_08_04, undefined, mockOperations2),
      ];

      const targetOperations = [
        createMockOperation(OPERATIONS.test1.id, OPERATIONS.test1.path),
        createMockOperation(
          OPERATIONS.test3.id,
          OPERATIONS.test3.path,
          OPERATIONS.test3.httpMethod,
        ),
      ];

      const result = await getExistedVersionOperations(
        TEST_PATHS.stable2020_08_04,
        mockSwaggers,
        targetOperations,
      );

      expect(result).toBeInstanceOf(Map);
      expect(result.has(TEST_PATHS.differentFile2020_07_02)).toBe(true);

      const operations = result.get(TEST_PATHS.differentFile2020_07_02);
      expect(operations).toBeDefined();
      if (operations) {
        expect(operations).toHaveLength(1);
        expect(operations[0]).toHaveProperty("id", OPERATIONS.test1.id);
        expect(operations[0]).toHaveProperty("path", OPERATIONS.test1.path);
        expect(operations[0]).toHaveProperty("httpMethod", OPERATIONS.test1.httpMethod);
      }
    });

    it("should return empty result when no matching operations exist", async () => {
      const mockOperations1 = createOperationsMap([OPERATIONS.old]);
      const mockOperations2 = createOperationsMap([OPERATIONS.new]);

      const mockSwaggers: MockSwagger[] = [
        createMockSwagger(TEST_PATHS.differentFile2020_07_02, undefined, mockOperations1),
        createMockSwagger(TEST_PATHS.stable2020_08_04, undefined, mockOperations2),
      ];

      const targetOperations = [
        createMockOperation(OPERATIONS.new.id, OPERATIONS.new.path, OPERATIONS.new.httpMethod),
      ];

      const result = await getExistedVersionOperations(
        TEST_PATHS.stable2020_08_04,
        mockSwaggers,
        targetOperations,
      );

      expect(result).toBeInstanceOf(Map);
      expect(result.has(TEST_PATHS.differentFile2020_07_02)).toBe(true);

      const operations = result.get(TEST_PATHS.differentFile2020_07_02);
      expect(operations).toBeDefined();
      if (operations) {
        expect(operations).toHaveLength(0);
      }
    });

    it("should return empty map when target swagger is not found", async () => {
      const mockSwaggers = [createMockSwagger(TEST_PATHS.stable2020_07_02, undefined, new Map())];

      const result = await getExistedVersionOperations(TEST_PATHS.nonexistent, mockSwaggers, []);

      expect(result).toBeInstanceOf(Map);
      expect(result.size).toBe(0);
    });

    it("should handle multiple previous versions correctly", async () => {
      const sharedOperationMap = createOperationsMap([OPERATIONS.shared]);

      const mockSwaggers: MockSwagger[] = [
        createMockSwagger(TEST_PATHS.differentFile2020_05_01, undefined, sharedOperationMap),
        createMockSwagger(TEST_PATHS.differentFile2020_07_02_c, undefined, sharedOperationMap),
        createMockSwagger(TEST_PATHS.stable2020_08_04, undefined, sharedOperationMap),
      ];

      const targetOperations = [createMockOperation(OPERATIONS.shared.id, OPERATIONS.shared.path)];
      const result = await getExistedVersionOperations(
        TEST_PATHS.stable2020_08_04,
        mockSwaggers,
        targetOperations,
      );

      expect(result).toBeInstanceOf(Map);
      expect(result.has(TEST_PATHS.differentFile2020_05_01)).toBe(true);
      expect(result.has(TEST_PATHS.differentFile2020_07_02_c)).toBe(true);

      // Check operations from first previous version
      const operations1 = result.get(TEST_PATHS.differentFile2020_05_01);
      expect(operations1).toBeDefined();
      if (operations1) {
        expect(operations1).toHaveLength(1);
        expect(operations1[0]).toHaveProperty("id", OPERATIONS.shared.id);
      }

      // Check operations from second previous version
      const operations2 = result.get(TEST_PATHS.differentFile2020_07_02_c);
      expect(operations2).toBeDefined();
      if (operations2) {
        expect(operations2).toHaveLength(1);
        expect(operations2[0]).toHaveProperty("id", OPERATIONS.shared.id);
      }
    });

    it("should handle null or undefined availableSwaggers array", async () => {
      const testCases = [[], [], []]; // Testing empty arrays multiple times

      for (const swaggers of testCases) {
        const result = await getExistedVersionOperations(TEST_PATHS.stable2020_08_04, swaggers, []);
        expect(result).toBeInstanceOf(Map);
        expect(result.size).toBe(0);
      }
    });
  });

  describe("getBaseNameForSwagger", () => {
    it("should extract the filename after the version segment", () => {
      const result = getBaseNameForSwagger(
        "specification/network/resource-manager/Microsoft.Network/stable/2019-11-01/network.json",
        "2019-11-01",
      );
      expect(result).toBe("network.json");
    });

    it("should return the basename when no version is provided", () => {
      const result = getBaseNameForSwagger(
        "specification/network/resource-manager/Microsoft.Network/stable/2019-11-01/network.json",
      );
      expect(result).toBe("network.json");
    });

    it("should handle paths without version segments", () => {
      const result = getBaseNameForSwagger("specification/network/test.json");
      expect(result).toBe("test.json");
    });
  });

  describe("deduplicateSwaggers", () => {
    it("should return empty array for empty input", () => {
      const result = deduplicateSwaggers([]);
      expect(result).toEqual([]);
    });

    it("should return the same array when no duplicates exist", () => {
      const mockSwaggers: MockSwagger[] = [
        createMockSwagger(TEST_PATHS.stable2020_07_02),
        createMockSwagger(TEST_PATHS.stable2020_08_04),
        createMockSwagger(TEST_PATHS.preview2020_07_02),
      ];

      const result = deduplicateSwaggers(mockSwaggers);

      expect(result).toHaveLength(3);
      expect(result[0].path).toBe(TEST_PATHS.stable2020_07_02);
      expect(result[1].path).toBe(TEST_PATHS.stable2020_08_04);
      expect(result[2].path).toBe(TEST_PATHS.preview2020_07_02);
    });

    it("should remove duplicate swaggers with same path", () => {
      const mockSwaggers: MockSwagger[] = [
        createMockSwagger(TEST_PATHS.stable2020_07_02),
        createMockSwagger(TEST_PATHS.stable2020_08_04),
        createMockSwagger(TEST_PATHS.stable2020_07_02), // duplicate
        createMockSwagger(TEST_PATHS.preview2020_07_02),
        createMockSwagger(TEST_PATHS.stable2020_08_04), // duplicate
      ];

      const result = deduplicateSwaggers(mockSwaggers);

      expect(result).toHaveLength(3);
      expect(result.map((s) => s.path)).toEqual([
        TEST_PATHS.stable2020_07_02,
        TEST_PATHS.stable2020_08_04,
        TEST_PATHS.preview2020_07_02,
      ]);
    });

    it("should handle single swagger", () => {
      const mockSwaggers: MockSwagger[] = [createMockSwagger(TEST_PATHS.stable2020_07_02)];

      const result = deduplicateSwaggers(mockSwaggers);

      expect(result).toHaveLength(1);
      expect(result[0].path).toBe(TEST_PATHS.stable2020_07_02);
    });

    it("should handle all duplicates scenario", () => {
      const mockSwaggers: MockSwagger[] = [
        createMockSwagger(TEST_PATHS.stable2020_07_02),
        createMockSwagger(TEST_PATHS.stable2020_07_02),
        createMockSwagger(TEST_PATHS.stable2020_07_02),
      ];

      const result = deduplicateSwaggers(mockSwaggers);

      expect(result).toHaveLength(1);
      expect(result[0].path).toBe(TEST_PATHS.stable2020_07_02);
    });

    it("should not mutate the original array", () => {
      const mockSwaggers: MockSwagger[] = [
        createMockSwagger(TEST_PATHS.stable2020_07_02),
        createMockSwagger(TEST_PATHS.stable2020_07_02),
      ];
      const originalLength = mockSwaggers.length;

      const result = deduplicateSwaggers(mockSwaggers);

      expect(mockSwaggers).toHaveLength(originalLength); // Original unchanged
      expect(result).not.toBe(mockSwaggers); // Different array instance
      expect(result).toHaveLength(1);
    });
  });
});
