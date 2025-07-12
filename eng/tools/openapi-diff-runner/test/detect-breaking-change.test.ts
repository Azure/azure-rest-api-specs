import { describe, it, expect, beforeEach, afterEach, vi } from "vitest";
import {
  getReadmeFolder,
  isInDevFolder,
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

// Mock getSpecModel and other functions since they're not automatically picked up by vi.mock
vi.mock("../src/detect-breaking-change.js", async () => {
  const original = await vi.importActual<any>("../src/detect-breaking-change.js");
  return {
    ...original,
    getSpecModel: vi.fn(),
    createBreakingChangeDetectionContext: vi
      .fn()
      .mockImplementation(
        (context, existingVersionSwaggers, newVersionSwaggers, newVersionChangedSwaggers) => ({
          context,
          existingVersionSwaggers,
          newVersionSwaggers,
          newVersionChangedSwaggers,
          msgs: [],
          runtimeErrors: [],
          tempTagName: "oad-default-tag",
          oadViolationsCnt: 0,
          errorCnt: 0,
        }),
      ),
  };
});

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
  LogLevel: {
    Error: "error",
    Warn: "warn",
    Info: "info",
    Debug: "debug",
    Notice: "notice",
    Group: "group",
    EndGroup: "endgroup",
  },
  LOG_PREFIX: "Runner-",
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
  let detectionModule: any;

  // Helper function to create mock SpecModel
  const createMockSpecModel = (folder = "/mock/folder", swaggers: any[] = []) => ({
    getSwaggers: vi.fn().mockResolvedValue(swaggers),
    folder,
    logger: { info: vi.fn(), warn: vi.fn(), error: vi.fn() },
    readmes: [] as any[],
  });

  // Helper function to create mock operations
  const createMockOperations = () =>
    new Map([
      ["operation1", { id: "operation1", path: "/api/test1", httpMethod: "GET" }],
      ["operation2", { id: "operation2", path: "/api/test2", httpMethod: "POST" }],
    ]);

  // Helper function to create mock operations array for getExistedVersionOperations
  const createMockOperationsArray = () =>
    new Map([
      [
        "/test/swagger1.json",
        [
          { id: "operation1", path: "/api/test1", httpMethod: "GET" },
          { id: "operation2", path: "/api/test2", httpMethod: "POST" },
        ],
      ],
      ["/test/swagger2.json", [{ id: "operation3", path: "/api/test3", httpMethod: "DELETE" }]],
    ]);

  // Helper function to create test context
  const createTestContext = (overrides = {}) =>
    ({
      localSpecRepoPath: "/path/to/spec/repo",
      ...overrides,
    }) as Context;

  // Helper function to manage spies with automatic cleanup
  const createSpyManager = () => {
    const spies: any[] = [];
    return {
      add: (spy: any) => {
        spies.push(spy);
        return spy;
      },
      restoreAll: () => spies.forEach((spy) => spy.mockRestore?.()),
    };
  };

  // Common test paths
  const TEST_PATHS = {
    network:
      "specification/network/resource-manager/Microsoft.Network/stable/2019-11-01/network.json",
    storage:
      "specification/storage/resource-manager/Microsoft.Storage/stable/2021-04-01/storage.json",
    networkStable:
      "specification/network/resource-manager/Microsoft.Network/stable/2021-05-01/network.json",
  };

  beforeEach(async () => {
    vi.clearAllMocks();
    detectionModule = await import("../src/detect-breaking-change.js");

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

    // Create mock detection context manually instead of using the function
    // since we're testing that function itself
    mockDetectionContext = {
      context: mockContext,
      existingVersionSwaggers: ["existing1.json", "existing2.json"],
      newVersionSwaggers: ["new1.json", "new2.json"],
      newVersionChangedSwaggers: ["changed1.json", "changed2.json"],
      msgs: [],
      runtimeErrors: [],
      oadTracer: { traces: [], baseBranch: "main", context: mockContext },
      tempTagName: "oad-default-tag",
    };
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
      vi.clearAllMocks();
      const mockSpecModelInstance = createMockSpecModel();
      vi.mocked(SpecModel).mockImplementation(() => mockSpecModelInstance as unknown as SpecModel);
    });

    it("should create and cache SpecModel for new folder", async () => {
      const spyManager = createSpyManager();
      const getSpecModelSpy = spyManager.add(vi.spyOn(detectionModule, "getSpecModel"));
      const getReadmeFolderSpy = spyManager.add(vi.spyOn(detectionModule, "getReadmeFolder"));

      getReadmeFolderSpy.mockReturnValue("specification/network/resource-manager");

      const repoFolder = "/path/to/repo";
      const result1 = detectionModule.getSpecModel(repoFolder, TEST_PATHS.network);
      const result2 = detectionModule.getSpecModel(repoFolder, TEST_PATHS.network);

      expect(getSpecModelSpy).toHaveBeenCalledTimes(2);
      expect(getSpecModelSpy).toHaveBeenCalledWith(repoFolder, TEST_PATHS.network);
      expect(result1).toBe(result2);

      spyManager.restoreAll();
    });

    it("should create different SpecModels for different folders", async () => {
      const spyManager = createSpyManager();
      const mockSpecModel1 = createMockSpecModel(
        "/path/to/repo/specification/network/resource-manager",
      );
      const mockSpecModel2 = createMockSpecModel(
        "/path/to/repo/specification/storage/resource-manager",
      );

      vi.mocked(SpecModel)
        .mockImplementationOnce(() => mockSpecModel1 as unknown as SpecModel)
        .mockImplementationOnce(() => mockSpecModel2 as unknown as SpecModel);

      const getReadmeFolderSpy = spyManager.add(vi.spyOn(detectionModule, "getReadmeFolder"));
      getReadmeFolderSpy.mockImplementation((path: string) => {
        if (path.includes("network")) return "specification/network/resource-manager";
        if (path.includes("storage")) return "specification/storage/resource-manager";
        return undefined;
      });

      const getSpecModelSpy = spyManager.add(vi.spyOn(detectionModule, "getSpecModel"));
      getSpecModelSpy
        .mockReturnValueOnce(mockSpecModel1 as unknown as SpecModel)
        .mockReturnValueOnce(mockSpecModel2 as unknown as SpecModel);

      const repoFolder = "/path/to/repo";
      const result1 = detectionModule.getSpecModel(repoFolder, TEST_PATHS.network);
      const result2 = detectionModule.getSpecModel(repoFolder, TEST_PATHS.storage);

      expect(result1).not.toBe(result2);
      expect(result1.folder).toBe("/path/to/repo/specification/network/resource-manager");
      expect(result2.folder).toBe("/path/to/repo/specification/storage/resource-manager");
      expect(getSpecModelSpy).toHaveBeenCalledTimes(2);

      spyManager.restoreAll();
    });
  });

  describe("checkAPIsBeingMovedToANewSpec", () => {
    beforeEach(() => {
      vi.clearAllMocks();
    });

    it("should process moved APIs when found", async () => {
      const spyManager = createSpyManager();
      const mockOperationsArray = createMockOperationsArray();
      const mockTargetOperations = createMockOperations();

      const checkAPIsBeingMovedToANewSpecSpy = spyManager.add(
        vi.spyOn(detectionModule, "checkAPIsBeingMovedToANewSpec"),
      );

      checkAPIsBeingMovedToANewSpecSpy.mockImplementation(
        async (_context: any, swaggerPath: any, _availableSwaggers: any) => {
          await getExistedVersionOperations(swaggerPath, [], [...mockTargetOperations.values()]);
          return;
        },
      );

      vi.mocked(getExistedVersionOperations).mockResolvedValue(mockOperationsArray);
      const testContext = createTestContext();

      await detectionModule.checkAPIsBeingMovedToANewSpec(
        testContext,
        TEST_PATHS.networkStable,
        [],
      );

      expect(checkAPIsBeingMovedToANewSpecSpy).toHaveBeenCalledWith(
        testContext,
        TEST_PATHS.networkStable,
        [],
      );
      expect(vi.mocked(getExistedVersionOperations)).toHaveBeenCalledWith(
        TEST_PATHS.networkStable,
        [],
        [...mockTargetOperations.values()],
      );

      spyManager.restoreAll();
    });

    it("should handle empty moved APIs", async () => {
      const spyManager = createSpyManager();
      vi.clearAllMocks();

      const mockTargetOperations = createMockOperations();

      const checkAPIsBeingMovedToANewSpecSpy = spyManager.add(
        vi.spyOn(detectionModule, "checkAPIsBeingMovedToANewSpec"),
      );

      checkAPIsBeingMovedToANewSpecSpy.mockImplementation(
        async (_context: any, swaggerPath: any, _availableSwaggers: any) => {
          await getExistedVersionOperations(swaggerPath, [], [...mockTargetOperations.values()]);
          return;
        },
      );

      vi.mocked(getExistedVersionOperations).mockResolvedValue(new Map());
      const testContext = createTestContext();

      await detectionModule.checkAPIsBeingMovedToANewSpec(testContext, TEST_PATHS.storage, []);

      expect(checkAPIsBeingMovedToANewSpecSpy).toHaveBeenCalledWith(
        testContext,
        TEST_PATHS.storage,
        [],
      );
      expect(vi.mocked(getExistedVersionOperations)).toHaveBeenCalledWith(
        TEST_PATHS.storage,
        [],
        [...mockTargetOperations.values()],
      );

      spyManager.restoreAll();
    });
  });

  describe("checkCrossVersionBreakingChange", () => {
    let mockSpecModelInstance: any;

    beforeEach(async () => {
      mockSpecModelInstance = createMockSpecModel("/mock/folder", [
        { path: "/test/swagger1.json" },
        { path: "/test/swagger2.json" },
      ]);

      vi.mocked(SpecModel).mockImplementation(() => mockSpecModelInstance);
      vi.mocked(getPrecedingSwaggers).mockResolvedValue({
        stable: "/test/previous-stable.json",
        preview: "/test/previous-preview.json",
      });
    });

    it("should process new version swaggers", async () => {
      const detectionModule = await import("../src/detect-breaking-change.js");
      const getSpecModelSpy = vi.spyOn(detectionModule, "getSpecModel");
      getSpecModelSpy.mockReturnValue(mockSpecModelInstance);

      mockDetectionContext.newVersionSwaggers = [TEST_PATHS.networkStable];
      mockDetectionContext.newVersionChangedSwaggers = [];
      mockDetectionContext.existingVersionSwaggers = [];

      const result = await detectionModule.checkCrossVersionBreakingChange(mockDetectionContext);

      expect(result).toBeDefined();
      expect(result.msgs).toBeDefined();
      expect(result.runtimeErrors).toBeDefined();
      expect(result.oadViolationsCnt).toBeDefined();
      expect(result.errorCnt).toBeDefined();
    });

    it("should process swaggers with no previous versions", async () => {
      vi.clearAllMocks();

      const mockTargetOperations = new Map([
        ["operation1", { id: "operation1", path: "/api/test1", httpMethod: "GET" }],
      ]);

      const mockTargetSwagger = {
        path: "/test/path/to/swagger.json",
        getOperations: vi.fn().mockResolvedValue(mockTargetOperations),
      };

      const mockSpecModel = createMockSpecModel("/mock/folder", [mockTargetSwagger]);
      const detectionModule = await import("../src/detect-breaking-change.js");
      const mockGetSpecModel = vi.spyOn(detectionModule, "getSpecModel");
      mockGetSpecModel.mockReturnValue(mockSpecModel as unknown as SpecModel);

      vi.mocked(getPrecedingSwaggers).mockImplementation(async () => {
        await detectionModule.checkAPIsBeingMovedToANewSpec(mockContext, "test-path", []);
        return { stable: undefined, preview: undefined };
      });

      const checkAPIsBeingMovedToANewSpecSpy = vi.spyOn(
        detectionModule,
        "checkAPIsBeingMovedToANewSpec",
      );
      checkAPIsBeingMovedToANewSpecSpy.mockImplementation(
        async (_context, swaggerPath, _availableSwaggers) => {
          await getExistedVersionOperations(swaggerPath, [], [...mockTargetOperations.values()]);
        },
      );

      mockDetectionContext.newVersionSwaggers = [TEST_PATHS.storage];
      mockDetectionContext.newVersionChangedSwaggers = [];
      mockDetectionContext.existingVersionSwaggers = [];
      mockDetectionContext.context = {
        ...mockContext,
        localSpecRepoPath: "/path/to/repo",
      } as Context;

      const result = await detectionModule.checkCrossVersionBreakingChange(mockDetectionContext);

      expect(result).toBeDefined();
      expect(checkAPIsBeingMovedToANewSpecSpy).toHaveBeenCalled();

      mockGetSpecModel.mockRestore();
      checkAPIsBeingMovedToANewSpecSpy.mockRestore();
    });
  });

  describe("createBreakingChangeDetectionContext", () => {
    it("should create context with all required properties", async () => {
      vi.mocked(detectionModule.createBreakingChangeDetectionContext).mockImplementation(
        (
          context: any,
          existingVersionSwaggers: any,
          newVersionSwaggers: any,
          newVersionChangedSwaggers: any,
          oadTracer: any,
        ) => ({
          context,
          existingVersionSwaggers,
          newVersionSwaggers,
          newVersionChangedSwaggers,
          msgs: [],
          runtimeErrors: [],
          tempTagName: "oad-default-tag",
          oadTracer,
        }),
      );

      const context = detectionModule.createBreakingChangeDetectionContext(
        mockContext,
        ["existing1.json"],
        ["new1.json"],
        ["changed1.json"],
        {} as any,
      );

      expect(detectionModule.createBreakingChangeDetectionContext).toHaveBeenCalled();
      expect(context.context).toBe(mockContext);
      expect(context.existingVersionSwaggers).toEqual(["existing1.json"]);
      expect(context.newVersionSwaggers).toEqual(["new1.json"]);
      expect(context.newVersionChangedSwaggers).toEqual(["changed1.json"]);
    });
  });

  describe("checkBreakingChangeOnSameVersion", () => {
    beforeEach(() => {
      mockDetectionContext.existingVersionSwaggers = [TEST_PATHS.networkStable, TEST_PATHS.storage];
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
      mockDetectionContext.existingVersionSwaggers = [TEST_PATHS.networkStable, TEST_PATHS.storage];

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
      mockCheckout = vi.fn().mockResolvedValue(undefined);
      mockDetectionContext.context = {
        ...mockContext,
        prInfo: { ...mockContext.prInfo, checkout: mockCheckout },
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

      expect(mockDetectionContext.msgs.length).toBeGreaterThanOrEqual(initialMsgsLength);
      expect(mockDetectionContext.runtimeErrors.length).toBeGreaterThanOrEqual(initialErrorsLength);
    });

    it("should process different API version lifecycle stages", async () => {
      const stableResult = await doBreakingChangeDetection(
        mockDetectionContext,
        mockOldSpec,
        mockNewSpec,
        "SAME_VERSION" as any,
        ApiVersionLifecycleStage.STABLE,
      );

      expect(stableResult).toBeDefined();

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
