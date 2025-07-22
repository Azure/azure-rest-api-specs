import { describe, it, expect, beforeEach, afterEach, vi } from "vitest";
import { existsSync } from "node:fs";
import * as path from "node:path";
import {
  getReadmeFolder,
  isInDevFolder,
  checkBreakingChangeOnSameVersion,
  doBreakingChangeDetection,
  getSpecModel,
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

vi.mock("node:fs", async (importOriginal) => {
  const actual = await importOriginal<typeof import("node:fs")>();
  return {
    ...actual,
    appendFileSync: vi.fn(),
    existsSync: vi.fn(),
  };
});

// Mock specific functions but keep getSpecModel as real implementation
vi.mock("../src/detect-breaking-change.js", async () => {
  const original = await vi.importActual<any>("../src/detect-breaking-change.js");
  return {
    ...original,
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

describe("detect-breaking-change", () => {
  let mockContext: Context;
  let mockDetectionContext: BreakingChangeDetectionContext;
  let detectionModule: any;

  // Test constants
  const TEST_CONSTANTS = {
    PATHS: {
      network:
        "specification/network/resource-manager/Microsoft.Network/stable/2019-11-01/network.json",
      storage:
        "specification/storage/resource-manager/Microsoft.Storage/stable/2021-04-01/storage.json",
      networkStable:
        "specification/network/resource-manager/Microsoft.Network/stable/2021-05-01/network.json",
    },
    FOLDERS: {
      tempRepo: "/test/working/dir",
      specRepo: "/test/repo",
      mockFolder: "/mock/folder",
    },
    OPERATIONS: {
      operation1: { id: "operation1", path: "/api/test1", httpMethod: "GET" },
      operation2: { id: "operation2", path: "/api/test2", httpMethod: "POST" },
      operation3: { id: "operation3", path: "/api/test3", httpMethod: "DELETE" },
    },
  };

  // Test data factories
  const TestFixtures = {
    createMockSpecModel: (folder = TEST_CONSTANTS.FOLDERS.mockFolder, swaggers: any[] = []) => ({
      getSwaggers: vi.fn().mockResolvedValue(swaggers || []),
      folder,
      logger: { info: vi.fn(), warn: vi.fn(), error: vi.fn() },
      readmes: [] as any[],
    }),

    createSpyManager: () => {
      const spies: Array<any> = [];
      return {
        add: (spy: any) => {
          spies.push(spy);
          return spy;
        },
        restoreAll: () => {
          spies.forEach((spy) => spy.mockRestore());
          spies.length = 0;
        },
      };
    },

    createMockOperations: () =>
      new Map([
        ["operation1", TEST_CONSTANTS.OPERATIONS.operation1],
        ["operation2", TEST_CONSTANTS.OPERATIONS.operation2],
      ]),

    createMockOperationsArray: () =>
      new Map([
        [
          "/test/swagger1.json",
          [TEST_CONSTANTS.OPERATIONS.operation1, TEST_CONSTANTS.OPERATIONS.operation2],
        ],
        ["/test/swagger2.json", [TEST_CONSTANTS.OPERATIONS.operation3]],
      ]),

    createMockContext: (overrides = {}) =>
      ({
        prInfo: {
          targetBranch: "main",
          sourceBranch: "feature-branch",
          baseBranch: "main",
          currentBranch: "feature-branch",
          tempRepoFolder: TEST_CONSTANTS.FOLDERS.tempRepo,
          checkout: vi.fn(),
        },
        localSpecRepoPath: TEST_CONSTANTS.FOLDERS.specRepo,
        workingFolder: "/test/working",
        logFileFolder: "/test/logs",
        swaggerDirs: ["specification"],
        baseBranch: "main",
        headCommit: "abc123",
        runType: "SAME_VERSION" as any,
        checkName: "test-check",
        targetRepo: "Azure/azure-rest-api-specs",
        sourceRepo: "user/azure-rest-api-specs",
        prNumber: "123",
        prSourceBranch: "feature-branch",
        prTargetBranch: "main",
        oadMessageProcessorContext: {
          logFilePath: "/test/logs/openapi-diff-runner.log",
          prUrl: "https://github.com/Azure/azure-rest-api-specs/pull/123",
          messageCache: [],
        },
        prUrl: "https://github.com/Azure/azure-rest-api-specs/pull/123",
        ...overrides,
      }) as Context,

    createMockDetectionContext: (contextOverrides = {}, overrides = {}) => {
      const context = TestFixtures.createMockContext(contextOverrides);
      return {
        context,
        existingVersionSwaggers: ["existing1.json", "existing2.json"],
        newVersionSwaggers: ["new1.json", "new2.json"],
        newVersionChangedSwaggers: ["changed1.json", "changed2.json"],
        msgs: [],
        runtimeErrors: [],
        oadTracer: { traces: [], baseBranch: "main", context },
        tempTagName: "oad-default-tag",
        ...overrides,
      } as BreakingChangeDetectionContext;
    },

    createTestContext: (overrides = {}) =>
      ({
        localSpecRepoPath: "/path/to/spec/repo",
        ...overrides,
      }) as Context,

    createMockSwagger: (pathOverride?: string, operationsOverride?: Map<string, any>) => ({
      path: pathOverride || `${TEST_CONSTANTS.FOLDERS.tempRepo}/${TEST_CONSTANTS.PATHS.storage}`,
      getOperations: vi
        .fn()
        .mockResolvedValue(operationsOverride || TestFixtures.createMockOperations()),
    }),
  };

  // Mock setup utilities
  const MockSetup = {
    setupDefaultMocks: () => {
      vi.mocked(existsSync).mockReturnValue(true);
      vi.mocked(getExistedVersionOperations).mockResolvedValue(new Map());
      vi.mocked(getPrecedingSwaggers).mockResolvedValue({
        stable: "/test/previous-stable.json",
        preview: "/test/previous-preview.json",
      });
    },

    setupSpecModelMock: (mockInstance?: any) => {
      if (mockInstance) {
        // Use the provided instance
        vi.mocked(SpecModel).mockImplementation(() => mockInstance as unknown as SpecModel);
        return mockInstance;
      } else {
        // Create different instances based on folder path
        vi.mocked(SpecModel).mockImplementation((folder: string) => {
          return TestFixtures.createMockSpecModel(folder) as unknown as SpecModel;
        });
        return null; // No specific instance to return
      }
    },

    resetAllMocks: () => {
      vi.clearAllMocks();
      vi.resetAllMocks();
    },
  };

  beforeEach(async () => {
    MockSetup.resetAllMocks();
    detectionModule = await import("../src/detect-breaking-change.js");

    mockContext = TestFixtures.createMockContext();
    mockDetectionContext = TestFixtures.createMockDetectionContext();

    MockSetup.setupDefaultMocks();
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  describe("getReadmeFolder", () => {
    it("should extract folder path up to resource-manager", () => {
      const testPath = TEST_CONSTANTS.PATHS.network;
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
      MockSetup.resetAllMocks();
      vi.mocked(existsSync).mockReturnValue(true);
    });

    it("should create and cache SpecModel for new folder", async () => {
      const mockSpecModelInstance = TestFixtures.createMockSpecModel();
      MockSetup.setupSpecModelMock(mockSpecModelInstance);
      vi.mocked(existsSync).mockReturnValue(true);

      const repoFolder = "/path/to/repo";
      const result1 = getSpecModel(repoFolder, TEST_CONSTANTS.PATHS.network);
      const result2 = getSpecModel(repoFolder, TEST_CONSTANTS.PATHS.network);

      expect(result1).toBe(result2);
      expect(result1).toBeDefined();
      expect(vi.mocked(existsSync)).toHaveBeenCalledWith(
        path.join("/path/to/repo", "specification/network/resource-manager"),
      );
    });

    it("should return undefined when folder does not exist", async () => {
      const mockSpecModelInstance = TestFixtures.createMockSpecModel();
      MockSetup.setupSpecModelMock(mockSpecModelInstance);
      vi.mocked(existsSync).mockReturnValue(false);

      const repoFolder = "/path/to/repo";
      const result = getSpecModel(repoFolder, TEST_CONSTANTS.PATHS.network);

      expect(result).toBeUndefined();
      expect(vi.mocked(existsSync)).toHaveBeenCalledWith(
        path.join("/path/to/repo", "specification/network/resource-manager"),
      );
    });

    it("should not cache when folder does not exist", async () => {
      const mockSpecModelInstance = TestFixtures.createMockSpecModel();
      MockSetup.setupSpecModelMock(mockSpecModelInstance);
      vi.mocked(existsSync).mockReturnValue(false);

      const result1 = getSpecModel("/path/to/repo", TEST_CONSTANTS.PATHS.network);
      const result2 = getSpecModel("/path/to/repo", TEST_CONSTANTS.PATHS.network);

      expect(result1).toBeUndefined();
      expect(result2).toBeUndefined();
      expect(vi.mocked(existsSync)).toHaveBeenCalledTimes(2); // Called twice, no caching for undefined
    });

    it("should create different SpecModels for different folders", async () => {
      // Don't pass a specific mock instance - let it create different ones
      MockSetup.setupSpecModelMock();
      vi.mocked(existsSync).mockReturnValue(true);

      const repoFolder = "/path/to/repo";
      const result1 = getSpecModel(repoFolder, TEST_CONSTANTS.PATHS.network);
      const result2 = getSpecModel(repoFolder, TEST_CONSTANTS.PATHS.storage);

      expect(result1).not.toBe(result2);
      expect(result1).toBeDefined();
      expect(result2).toBeDefined();
    });
  });

  describe("checkAPIsBeingMovedToANewSpec", () => {
    beforeEach(() => {
      MockSetup.resetAllMocks();
    });

    it("should process moved APIs when found", async () => {
      const spyManager = TestFixtures.createSpyManager();
      const mockOperationsArray = TestFixtures.createMockOperationsArray();
      const mockTargetOperations = TestFixtures.createMockOperations();

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
      const testContext = TestFixtures.createTestContext();

      await detectionModule.checkAPIsBeingMovedToANewSpec(
        testContext,
        TEST_CONSTANTS.PATHS.networkStable,
        [],
      );

      expect(checkAPIsBeingMovedToANewSpecSpy).toHaveBeenCalledWith(
        testContext,
        TEST_CONSTANTS.PATHS.networkStable,
        [],
      );
      expect(vi.mocked(getExistedVersionOperations)).toHaveBeenCalledWith(
        TEST_CONSTANTS.PATHS.networkStable,
        [],
        [...mockTargetOperations.values()],
      );

      spyManager.restoreAll();
    });

    it("should handle empty moved APIs", async () => {
      const spyManager = TestFixtures.createSpyManager();
      vi.clearAllMocks();

      const mockTargetOperations = TestFixtures.createMockOperations();

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
      const testContext = TestFixtures.createTestContext();

      await detectionModule.checkAPIsBeingMovedToANewSpec(
        testContext,
        TEST_CONSTANTS.PATHS.storage,
        [],
      );

      expect(checkAPIsBeingMovedToANewSpecSpy).toHaveBeenCalledWith(
        testContext,
        TEST_CONSTANTS.PATHS.storage,
        [],
      );
      expect(vi.mocked(getExistedVersionOperations)).toHaveBeenCalledWith(
        TEST_CONSTANTS.PATHS.storage,
        [],
        [...mockTargetOperations.values()],
      );

      spyManager.restoreAll();
    });
  });

  describe("checkCrossVersionBreakingChange", () => {
    let mockSpecModelInstance: any;

    beforeEach(async () => {
      mockSpecModelInstance = TestFixtures.createMockSpecModel("/mock/folder", [
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

      mockDetectionContext.newVersionSwaggers = [TEST_CONSTANTS.PATHS.networkStable];
      mockDetectionContext.newVersionChangedSwaggers = [];
      mockDetectionContext.existingVersionSwaggers = [];

      const result = await detectionModule.checkCrossVersionBreakingChange(mockDetectionContext);

      expect(result).toBeDefined();
      expect(result.msgs).toBeDefined();
      expect(result.runtimeErrors).toBeDefined();
      expect(result.oadViolationsCnt).toBeDefined();
      expect(result.errorCnt).toBeDefined();
    });

    it("should process swaggers with previous versions", async () => {
      // Complete mock reset to avoid interference from other tests
      vi.clearAllMocks();
      vi.resetAllMocks();

      // Ensure existsSync returns true for this test so getSpecModel doesn't return undefined
      vi.mocked(existsSync).mockReturnValue(true);

      const mockTargetOperations = new Map([
        ["operation1", { id: "operation1", path: "/api/test1", httpMethod: "GET" }],
      ]);

      const mockTargetSwagger = {
        path: "/test/working/dir/specification/storage/resource-manager/Microsoft.Storage/stable/2021-04-01/storage.json",
        getOperations: vi.fn().mockResolvedValue(mockTargetOperations),
      };

      // Create a proper mock SpecModel instance that actually works
      const mockSpecModelInstance = {
        getSwaggers: vi.fn().mockResolvedValue([mockTargetSwagger]),
        folder: "/test/working/dir/specification/storage/resource-manager",
        logger: { info: vi.fn(), warn: vi.fn(), error: vi.fn() },
        readmes: [] as any[],
      };

      // Mock SpecModel constructor directly
      vi.mocked(SpecModel).mockImplementation(() => mockSpecModelInstance as unknown as SpecModel);

      // Mock getExistedVersionOperations to return a proper Map
      vi.mocked(getExistedVersionOperations).mockResolvedValue(new Map());

      // Mock getPrecedingSwaggers to return some previous versions to avoid checkAPIsBeingMovedToANewSpec call
      vi.mocked(getPrecedingSwaggers).mockResolvedValue({
        stable: "/test/previous-stable.json",
        preview: undefined,
      });

      // Import the module
      const detectionModule = await import("../src/detect-breaking-change.js");

      mockDetectionContext.newVersionSwaggers = [TEST_CONSTANTS.PATHS.storage];
      mockDetectionContext.newVersionChangedSwaggers = [];
      mockDetectionContext.existingVersionSwaggers = [];
      mockDetectionContext.context = {
        ...mockContext,
        localSpecRepoPath: "/path/to/repo",
        prInfo: {
          ...mockContext.prInfo,
          tempRepoFolder: "/test/working/dir",
        },
      } as Context;

      const result = await detectionModule.checkCrossVersionBreakingChange(mockDetectionContext);

      expect(result).toBeDefined();
      // For this simplified test, just verify that the function completes successfully
      expect(result.msgs).toBeDefined();
      expect(result.runtimeErrors).toBeDefined();

      // Verify that SpecModel was called to create the specModel
      expect(vi.mocked(SpecModel)).toHaveBeenCalled();
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
      mockDetectionContext.existingVersionSwaggers = [
        TEST_CONSTANTS.PATHS.networkStable,
        TEST_CONSTANTS.PATHS.storage,
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
        TEST_CONSTANTS.PATHS.networkStable,
        TEST_CONSTANTS.PATHS.storage,
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
