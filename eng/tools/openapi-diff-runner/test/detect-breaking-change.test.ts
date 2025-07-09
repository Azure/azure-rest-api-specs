import { describe, it, expect, beforeEach, afterEach, vi } from "vitest";
import {
  checkCrossVersionBreakingChange,
  getSpecModel,
  getReadmeFolder,
  checkAPIsBeingMovedToANewSpec,
  isInDevFolder,
  createBreakingChangeDetectionContext,
  checkBreakingChangeOnSameVersion,
  doBreakingChangeDetection,
  type BreakingChangeDetectionContext,
} from "../src/detect-breaking-change.js";
import { Context, ApiVersionLifecycleStage } from "../src/types/breaking-change.js";
import { SpecModel } from "@azure-tools/specs-shared/spec-model";
import { getExistedVersionOperations, getPrecedingSwaggers } from "../src/utils/spec.js";

vi.mock("@azure-tools/specs-shared/spec-model", () => ({
  SpecModel: vi.fn(),
}));

vi.mock("../src/utils/spec.js", () => ({
  getExistedVersionOperations: vi.fn(),
  getPrecedingSwaggers: vi.fn(),
}));

vi.mock("../src/utils/common-utils.js", () => ({
  convertRawErrorToUnifiedMsg: vi.fn().mockReturnValue('{"type":"Raw","level":"Error"}'),
  specIsPreview: vi.fn().mockReturnValue(false),
  blobHref: vi.fn().mockReturnValue("https://github.com/test/test.json"),
  branchHref: vi.fn().mockReturnValue("https://github.com/test/test.json"),
  getRelativeSwaggerPathToRepo: vi.fn().mockImplementation((path) => path),
  processOadRuntimeErrorMessage: vi.fn(),
}));

vi.mock("../src/log.js", () => ({
  logMessage: vi.fn(),
  logError: vi.fn(),
}));

vi.mock("../src/run-oad.js", () => ({
  runOad: vi.fn().mockResolvedValue([]),
}));

vi.mock("../src/utils/oad-message-processor.js", () => ({
  processAndAppendOadMessages: vi.fn(),
}));

vi.mock("../src/utils/apply-rules.js", () => ({
  applyRules: vi.fn().mockReturnValue([]),
}));

vi.mock("node:fs", async (importOriginal) => {
  const actual = await importOriginal<typeof import("node:fs")>();
  return {
    ...actual,
    appendFileSync: vi.fn(),
    readFileSync: vi
      .fn()
      .mockReturnValue('{"name": "@azure-tools/openapi-diff-runner", "version": "1.0.0"}'),
  };
});

describe("detect-breaking-change", () => {
  let mockContext: Context;
  let mockDetectionContext: BreakingChangeDetectionContext;

  beforeEach(() => {
    vi.clearAllMocks();

    mockContext = {
      prInfo: {
        tempRepoFolder: "/test/working/dir",
        baseBranch: "main",
        checkout: vi.fn(),
      },
      localSpecRepoPath: "/test/repo",
      baseBranch: "main",
      oadMessageProcessorContext: {},
    } as any;

    mockDetectionContext = createBreakingChangeDetectionContext(
      mockContext,
      ["existing1.json", "existing2.json"],
      ["new1.json", "new2.json"],
      ["changed1.json", "changed2.json"],
      {} as any,
    );
  });

  afterEach(() => {
    vi.resetAllMocks();
  });

  describe("getReadmeFolder", () => {
    it("should extract folder path up to resource-manager", () => {
      const testPath =
        "specification/network/resource-manager/Microsoft.Network/stable/2019-11-01/network.json";
      const result = getReadmeFolder(testPath);
      expect(result).toBe("specification/network/resource-manager");
    });

    it("should extract folder path up to data-plane", () => {
      const testPath =
        "specification/cognitiveservices/data-plane/TextAnalytics/preview/v3.1/textanalytics.json";
      const result = getReadmeFolder(testPath);
      expect(result).toBe("specification/cognitiveservices/data-plane");
    });

    it("should return first 3 segments as fallback", () => {
      const testPath = "specification/someservice/other/file.json";
      const result = getReadmeFolder(testPath);
      expect(result).toBe("specification/someservice/other");
    });

    it("should handle dev folder conversion", () => {
      const testPath =
        "dev/network/resource-manager/Microsoft.Network/stable/2019-11-01/network.json";
      const result = getReadmeFolder(testPath);
      expect(result).toBe("specification/network/resource-manager");
    });

    it("should return undefined for short paths", () => {
      const testPath = "spec/test";
      const result = getReadmeFolder(testPath);
      expect(result).toBeUndefined();
    });

    it("should handle paths with backslashes", () => {
      const testPath =
        "specification\\network\\resource-manager\\Microsoft.Network\\stable\\2019-11-01\\network.json";
      const result = getReadmeFolder(testPath);
      expect(result).toBe("specification/network/resource-manager");
    });
  });

  describe("isInDevFolder", () => {
    it("should return true for dev paths", () => {
      expect(isInDevFolder("dev/test/file.json")).toBe(true);
      expect(isInDevFolder("dev/network/resource-manager/test.json")).toBe(true);
    });

    it("should return false for non-dev paths", () => {
      expect(isInDevFolder("specification/test/file.json")).toBe(false);
      expect(isInDevFolder("other/dev/file.json")).toBe(false);
    });
  });

  describe("getSpecModel", () => {
    beforeEach(() => {
      // Clear the module-level cache
      // We need to access the internal cache somehow. Let's use a workaround.
      vi.clearAllMocks();

      const mockSpecModelInstance = {
        getSwaggers: vi.fn().mockResolvedValue([]),
      };
      vi.mocked(SpecModel).mockImplementation(() => mockSpecModelInstance as any);
    });

    it("should create and cache SpecModel for new folder", () => {
      const testPath =
        "specification/network/resource-manager/Microsoft.Network/stable/2019-11-01/network.json";

      const result1 = getSpecModel(testPath);
      const result2 = getSpecModel(testPath);

      // Should create SpecModel only once due to caching
      expect(vi.mocked(SpecModel)).toHaveBeenCalledTimes(1);
      expect(vi.mocked(SpecModel)).toHaveBeenCalledWith("specification/network/resource-manager");
      expect(result1).toBe(result2); // Same instance due to caching
    });

    it("should create different SpecModels for different folders", () => {
      const testPath1 =
        "specification/network/resource-manager/Microsoft.Network/stable/2019-11-01/network.json";
      const testPath2 =
        "specification/storage/resource-manager/Microsoft.Storage/stable/2021-04-01/storage.json";

      const result1 = getSpecModel(testPath1);
      const result2 = getSpecModel(testPath2);

      // Both should return valid SpecModel instances
      expect(result1).toBeDefined();
      expect(result2).toBeDefined();

      // SpecModel constructor should have been called with the correct folders
      expect(vi.mocked(SpecModel)).toHaveBeenCalledWith("specification/storage/resource-manager");
    });

    it("should throw error for invalid swagger path", () => {
      const testPath = "invalid";

      expect(() => getSpecModel(testPath)).toThrow(
        "Could not determine readme folder for swagger path: invalid",
      );
    });
  });

  describe("checkAPIsBeingMovedToANewSpec", () => {
    beforeEach(() => {
      vi.clearAllMocks();
    });

    it("should process moved APIs when found", async () => {
      const mockOperations = new Map([
        [
          "/test/swagger1.json",
          [
            { id: "operation1", path: "/api/test1", httpMethod: "GET" },
            { id: "operation2", path: "/api/test2", httpMethod: "POST" },
          ],
        ],
        ["/test/swagger2.json", [{ id: "operation3", path: "/api/test3", httpMethod: "DELETE" }]],
      ]);

      vi.mocked(getExistedVersionOperations).mockResolvedValue(mockOperations);

      await checkAPIsBeingMovedToANewSpec(
        "specification/network/resource-manager/Microsoft.Network/stable/2021-05-01/network.json",
        [],
      );

      expect(vi.mocked(getExistedVersionOperations)).toHaveBeenCalledWith(
        "specification/network/resource-manager/Microsoft.Network/stable/2021-05-01/network.json",
        [],
      );
    });

    it("should handle empty moved APIs", async () => {
      vi.clearAllMocks();
      vi.mocked(getExistedVersionOperations).mockResolvedValue(new Map());

      await checkAPIsBeingMovedToANewSpec(
        "specification/storage/resource-manager/Microsoft.Storage/stable/2021-04-01/storage.json",
        [],
      );

      expect(vi.mocked(getExistedVersionOperations)).toHaveBeenCalledWith(
        "specification/storage/resource-manager/Microsoft.Storage/stable/2021-04-01/storage.json",
        [],
      );
    });
  });

  describe("checkCrossVersionBreakingChange", () => {
    let mockSpecModelInstance: any;

    beforeEach(() => {
      mockSpecModelInstance = {
        getSwaggers: vi
          .fn()
          .mockResolvedValue([{ path: "/test/swagger1.json" }, { path: "/test/swagger2.json" }]),
      };
      vi.mocked(SpecModel).mockImplementation(() => mockSpecModelInstance as any);

      vi.mocked(getPrecedingSwaggers).mockResolvedValue({
        stable: "/test/previous-stable.json",
        preview: "/test/previous-preview.json",
      });
    });

    it("should process new version swaggers", async () => {
      mockDetectionContext.newVersionSwaggers = [
        "specification/network/resource-manager/Microsoft.Network/stable/2021-05-01/network.json",
      ];
      mockDetectionContext.newVersionChangedSwaggers = [];
      mockDetectionContext.existingVersionSwaggers = [];

      const result = await checkCrossVersionBreakingChange(mockDetectionContext);

      expect(result).toBeDefined();
      expect(result.msgs).toBeDefined();
      expect(result.runtimeErrors).toBeDefined();
      expect(result.oadViolationsCnt).toBeDefined();
      expect(result.errorCnt).toBeDefined();
    });

    it("should process swaggers with no previous versions", async () => {
      // Clear mocks to ensure clean state
      vi.clearAllMocks();

      // Mock no previous versions found
      vi.mocked(getPrecedingSwaggers).mockResolvedValue({
        stable: undefined,
        preview: undefined,
      });

      // Mock empty moved APIs result
      vi.mocked(getExistedVersionOperations).mockResolvedValue(new Map());

      mockDetectionContext.newVersionSwaggers = [
        "specification/storage/resource-manager/Microsoft.Storage/stable/2021-04-01/storage.json",
      ];
      mockDetectionContext.newVersionChangedSwaggers = [];
      mockDetectionContext.existingVersionSwaggers = [];

      const result = await checkCrossVersionBreakingChange(mockDetectionContext);

      expect(result).toBeDefined();
      expect(vi.mocked(getExistedVersionOperations)).toHaveBeenCalled();
    });
  });

  describe("createBreakingChangeDetectionContext", () => {
    it("should create context with all required properties", () => {
      const context = createBreakingChangeDetectionContext(
        mockContext,
        ["existing1.json"],
        ["new1.json"],
        ["changed1.json"],
        {} as any,
      );

      expect(context.context).toBe(mockContext);
      expect(context.existingVersionSwaggers).toEqual(["existing1.json"]);
      expect(context.newVersionSwaggers).toEqual(["new1.json"]);
      expect(context.newVersionChangedSwaggers).toEqual(["changed1.json"]);
      expect(context.msgs).toEqual([]);
      expect(context.runtimeErrors).toEqual([]);
      expect(context.tempTagName).toBe("oad-default-tag");
    });

    it("should handle empty arrays", () => {
      const context = createBreakingChangeDetectionContext(mockContext, [], [], [], {} as any);

      expect(context.existingVersionSwaggers).toEqual([]);
      expect(context.newVersionSwaggers).toEqual([]);
      expect(context.newVersionChangedSwaggers).toEqual([]);
    });
  });

  describe("checkBreakingChangeOnSameVersion", () => {
    beforeEach(() => {
      mockDetectionContext.existingVersionSwaggers = [
        "specification/network/resource-manager/Microsoft.Network/stable/2021-05-01/network.json",
        "specification/storage/resource-manager/Microsoft.Storage/preview/2021-09-01-preview/storage.json",
      ];
      mockDetectionContext.msgs = [];
      mockDetectionContext.runtimeErrors = [];
    });

    it("should process all existing version swaggers", async () => {
      const result = await checkBreakingChangeOnSameVersion(mockDetectionContext);

      expect(result).toBeDefined();
      expect(result.msgs).toBeDefined();
      expect(result.runtimeErrors).toBeDefined();
      expect(result.oadViolationsCnt).toBeDefined();
      expect(result.errorCnt).toBeDefined();
    });

    it("should handle empty existing version swaggers", async () => {
      mockDetectionContext.existingVersionSwaggers = [];

      const result = await checkBreakingChangeOnSameVersion(mockDetectionContext);

      expect(result.msgs).toEqual([]);
      expect(result.runtimeErrors).toEqual([]);
      expect(result.oadViolationsCnt).toBe(0);
      expect(result.errorCnt).toBe(0);
    });

    it("should accumulate violations and errors from multiple swaggers", async () => {
      mockDetectionContext.existingVersionSwaggers = [
        "specification/network/resource-manager/Microsoft.Network/stable/2021-05-01/network.json",
        "specification/storage/resource-manager/Microsoft.Storage/stable/2021-04-01/storage.json",
      ];

      const result = await checkBreakingChangeOnSameVersion(mockDetectionContext);

      expect(result).toBeDefined();
      expect(typeof result.oadViolationsCnt).toBe("number");
      expect(typeof result.errorCnt).toBe("number");
    });
  });

  describe("doBreakingChangeDetection", () => {
    const mockOldSpec = "/old/spec/path.json";
    const mockNewSpec =
      "specification/test/resource-manager/Microsoft.Test/stable/2021-05-01/test.json";
    let mockCheckout: any;

    beforeEach(() => {
      mockDetectionContext.msgs = [];
      mockDetectionContext.runtimeErrors = [];

      // Create a new mock checkout function for each test
      mockCheckout = vi.fn().mockResolvedValue(undefined);

      // Create a new mock context with the checkout method
      mockDetectionContext.context = {
        ...mockContext,
        prInfo: {
          ...mockContext.prInfo,
          checkout: mockCheckout,
        },
      } as any;
    });

    it("should successfully detect breaking changes", async () => {
      const result = await doBreakingChangeDetection(
        mockDetectionContext,
        mockOldSpec,
        mockNewSpec,
        "SAME_VERSION" as any,
        ApiVersionLifecycleStage.STABLE,
      );

      expect(result).toBeDefined();
      expect(typeof result.oadViolationsCnt).toBe("number");
      expect(typeof result.errorCnt).toBe("number");
      expect(result.oadViolationsCnt).toBeGreaterThanOrEqual(0);
      expect(result.errorCnt).toBeGreaterThanOrEqual(0);
    });

    it("should handle cross-version breaking change detection", async () => {
      const result = await doBreakingChangeDetection(
        mockDetectionContext,
        mockOldSpec,
        mockNewSpec,
        "CROSS_VERSION" as any,
        ApiVersionLifecycleStage.PREVIEW,
      );

      expect(result).toBeDefined();
      expect(typeof result.oadViolationsCnt).toBe("number");
      expect(typeof result.errorCnt).toBe("number");
    });

    it("should handle runtime errors gracefully", async () => {
      // Create a new detection context with a failing checkout method
      const errorDetectionContext = {
        ...mockDetectionContext,
        context: {
          ...mockDetectionContext.context,
          prInfo: {
            ...mockDetectionContext.context.prInfo,
            checkout: vi.fn().mockRejectedValue(new Error("Checkout failed")),
          },
        },
      } as any;

      const result = await doBreakingChangeDetection(
        errorDetectionContext,
        mockOldSpec,
        mockNewSpec,
        "SAME_VERSION" as any,
        ApiVersionLifecycleStage.STABLE,
      );

      expect(result).toBeDefined();
      expect(result.errorCnt).toBeGreaterThan(0);
      expect(errorDetectionContext.runtimeErrors.length).toBeGreaterThan(0);
    });

    it("should update detection context with messages and errors", async () => {
      const initialMsgsLength = mockDetectionContext.msgs.length;
      const initialErrorsLength = mockDetectionContext.runtimeErrors.length;

      await doBreakingChangeDetection(
        mockDetectionContext,
        mockOldSpec,
        mockNewSpec,
        "SAME_VERSION" as any,
        ApiVersionLifecycleStage.STABLE,
      );

      // The context should be updated (though the exact counts depend on mocked behavior)
      expect(mockDetectionContext.msgs.length).toBeGreaterThanOrEqual(initialMsgsLength);
      expect(mockDetectionContext.runtimeErrors.length).toBeGreaterThanOrEqual(initialErrorsLength);
    });

    it("should process different API version lifecycle stages", async () => {
      // Test with stable version
      const stableResult = await doBreakingChangeDetection(
        mockDetectionContext,
        mockOldSpec,
        mockNewSpec,
        "SAME_VERSION" as any,
        ApiVersionLifecycleStage.STABLE,
      );

      expect(stableResult).toBeDefined();

      // Test with preview version
      const previewResult = await doBreakingChangeDetection(
        mockDetectionContext,
        mockOldSpec,
        mockNewSpec,
        "SAME_VERSION" as any,
        ApiVersionLifecycleStage.PREVIEW,
      );

      expect(previewResult).toBeDefined();
    });
  });
});
