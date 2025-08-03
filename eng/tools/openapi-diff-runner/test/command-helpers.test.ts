import { BREAKING_CHANGES_CHECK_TYPES } from "@azure-tools/specs-shared/breaking-change";
import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import { existsSync, mkdirSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import {
  BreakingChangeLabelsToBeAdded,
  buildPrInfo,
  changeBaseBranch,
  cleanDummySwagger,
  createContextFromParsedArgs,
  createDummySwagger,
  getCreatedDummySwaggerCount,
  getSwaggerDiffs,
  isSameVersionBreakingType,
  logFullOadMessagesList,
  outputBreakingChangeLabelVariables,
  type ParsedCliArguments,
} from "../src/command-helpers.js";
import { LogLevel } from "../src/log.js";
import {
  BreakingChangeReviewRequiredLabel,
  Context,
  VersioningReviewRequiredLabel,
} from "../src/types/breaking-change.js";
import { ResultMessageRecord } from "../src/types/message.js";

// Test constants
const TEST_CONSTANTS = {
  REPO: {
    NAME: "test/repo",
    CUSTOM: "custom/repo",
    SOURCE: "test/repo",
  },
  PATHS: {
    SPEC_REPO: "/path/to/repo",
    WORKING_FOLDER: "/working",
    LOG_FOLDER: "/logs",
    LOG_FILE: "/log/path",
    TEMP_REPO: "/working/dir",
    TEST_PATH: "/test/path",
    FILE_JS: "/path/to/file.js",
  },
  BRANCHES: {
    MAIN: "main",
    DEVELOP: "develop",
    FEATURE: "feature",
    ARM_CORE: "ARMCoreRPDev",
  },
  COMMITS: {
    HEAD: "HEAD",
    ABC123: "abc123",
  },
  PR: {
    NUMBER: "123",
    CUSTOM_NUMBER: "456",
    URL: "https://github.com/test/repo/pull/123",
    CUSTOM_URL: "https://github.com/custom/repo/pull/456",
  },
  SWAGGER_PATHS: {
    FOO: "specification/foo/resource-manager/Microsoft.Foo/stable/2023-01-01/foo.json",
    BAR: "specification/bar/data-plane/stable/2023-01-01/bar.json",
    BAZ: "specification/baz/resource-manager/Microsoft.Baz/stable/2023-01-01/baz.json",
    QUX_MGMT: "specification/qux/resource-manager/Microsoft.Qux/stable/2023-01-01/qux.json",
    QUX_DATA: "specification/qux/data-plane/stable/2023-01-01/qux.json",
    OLD_MGMT: "specification/old/resource-manager/Microsoft.Old/stable/2023-01-01/old.json",
    NEW_MGMT: "specification/new/resource-manager/Microsoft.New/stable/2023-01-01/new.json",
    OLD_DATA: "specification/old/data-plane/stable/2023-01-01/old.json",
  },
  NON_SWAGGER_PATHS: {
    YAML: ".github/workflows/test.yaml",
    EXAMPLE:
      "specification/bar/resource-manager/Microsoft.Bar/stable/2023-01-01/examples/example.json",
    README: "README.md",
    PACKAGE_JSON: "package.json",
    BUILD_JS: "dist/build.js",
    OLD_README: "old-readme.md",
    NEW_README: "new-readme.md",
  },
  MESSAGES: {
    ERROR: "Test error message",
    WARNING: "Test warning message",
    SWITCH_BRANCH: "switch target branch to main",
    CREATED_DUMMY: "created a dummy swagger:",
  },
  SWAGGER_DIRS: ["specification"],
  SWAGGER_CONTENT: {
    BASIC: {
      swagger: "2.0",
      info: { title: "Test API", version: "1.0" },
    },
    WITH_PATHS: {
      swagger: "2.0",
      info: { title: "Test API", version: "1.0" },
      paths: { "/test": { get: {} } },
      "x-ms-paths": { "/test2": { post: {} } },
      "x-ms-parameterized-host": { hostTemplate: "test.com" },
      parameters: { testParam: {} },
      definitions: { TestModel: {} },
    },
  },
};

// Factory functions for commonly used mock objects
function createMockContext(overrides = {}): Context {
  return {
    localSpecRepoPath: TEST_CONSTANTS.PATHS.SPEC_REPO,
    workingFolder: TEST_CONSTANTS.PATHS.WORKING_FOLDER,
    logFileFolder: TEST_CONSTANTS.PATHS.LOG_FOLDER,
    swaggerDirs: TEST_CONSTANTS.SWAGGER_DIRS,
    baseBranch: TEST_CONSTANTS.BRANCHES.MAIN,
    headCommit: TEST_CONSTANTS.COMMITS.HEAD,
    runType: BREAKING_CHANGES_CHECK_TYPES.SAME_VERSION,
    checkName: "test",
    targetRepo: TEST_CONSTANTS.REPO.NAME,
    sourceRepo: TEST_CONSTANTS.REPO.SOURCE,
    prNumber: TEST_CONSTANTS.PR.NUMBER,
    prSourceBranch: TEST_CONSTANTS.BRANCHES.FEATURE,
    prTargetBranch: TEST_CONSTANTS.BRANCHES.MAIN,
    oadMessageProcessorContext: {
      logFilePath: TEST_CONSTANTS.PATHS.LOG_FILE,
      prUrl: TEST_CONSTANTS.PR.URL,
      messageCache: [],
    },
    prUrl: TEST_CONSTANTS.PR.URL,
    ...overrides,
  } as Context;
}

function createMockPrInfo(overrides = {}) {
  return {
    baseBranch: TEST_CONSTANTS.BRANCHES.MAIN,
    targetBranch: TEST_CONSTANTS.BRANCHES.MAIN,
    sourceBranch: TEST_CONSTANTS.BRANCHES.FEATURE,
    tempRepoFolder: TEST_CONSTANTS.PATHS.TEMP_REPO,
    currentBranch: TEST_CONSTANTS.BRANCHES.MAIN,
    checkout: vi.fn(),
    ...overrides,
  };
}

function createMockSwaggerResult(overrides = {}) {
  return {
    additions: [TEST_CONSTANTS.SWAGGER_PATHS.FOO, TEST_CONSTANTS.SWAGGER_PATHS.BAR],
    modifications: [TEST_CONSTANTS.SWAGGER_PATHS.BAZ],
    deletions: [TEST_CONSTANTS.SWAGGER_PATHS.QUX_DATA],
    renames: [
      {
        from: TEST_CONSTANTS.SWAGGER_PATHS.OLD_MGMT,
        to: TEST_CONSTANTS.SWAGGER_PATHS.NEW_MGMT,
      },
    ],
    total: 5,
    ...overrides,
  };
}

function createMockMessages(): ResultMessageRecord[] {
  return [
    {
      type: "Result",
      level: "Error",
      message: TEST_CONSTANTS.MESSAGES.ERROR,
      time: new Date("2023-01-01"),
      paths: [],
    },
    {
      type: "Result",
      level: "Warning",
      message: TEST_CONSTANTS.MESSAGES.WARNING,
      time: new Date("2023-01-02"),
      paths: [],
    },
  ];
}

function setupCommonMocks() {
  const mockOadMessageProcessor = {
    logFilePath: TEST_CONSTANTS.PATHS.LOG_FILE,
    prUrl: TEST_CONSTANTS.PR.URL,
    messageCache: [],
  };
  return { mockOadMessageProcessor };
}

// Mock dependencies
vi.mock("node:fs");
vi.mock("node:url");
vi.mock("../src/utils/common-utils.js");
vi.mock("../src/utils/oad-message-processor.js");
vi.mock("../src/utils/pull-request.js");
vi.mock("../src/log.js");
vi.mock("@azure-tools/specs-shared/changed-files", async () => {
  const actual = await vi.importActual("@azure-tools/specs-shared/changed-files");
  return {
    ...actual,
    getChangedFilesStatuses: vi.fn(),
  };
});

describe("command-helpers", () => {
  const mockExistsSync = vi.mocked(existsSync);
  const mockMkdirSync = vi.mocked(mkdirSync);
  const mockReadFileSync = vi.mocked(readFileSync);
  const mockWriteFileSync = vi.mocked(writeFileSync);
  const mockRmSync = vi.mocked(rmSync);
  const mockFileURLToPath = vi.mocked(fileURLToPath);
  const mockGetChangedFilesStatuses = vi.mocked(getChangedFilesStatuses);

  beforeEach(() => {
    vi.clearAllMocks();

    // Setup default mocks
    mockFileURLToPath.mockReturnValue("/path/to/file.js");

    // Mock console methods to avoid test output noise
    vi.spyOn(console, "log").mockImplementation(() => {});
    vi.spyOn(console, "error").mockImplementation(() => {});

    // Clear BreakingChangeLabelsToBeAdded set
    BreakingChangeLabelsToBeAdded.clear();

    // Clean up any dummy swagger files between tests
    cleanDummySwagger();
  });

  afterEach(() => {
    vi.resetAllMocks();
  });

  describe("createContextFromParsedArgs", () => {
    const createTestParsedArgs = (
      overrides: Partial<ParsedCliArguments> = {},
    ): ParsedCliArguments => ({
      localSpecRepoPath: TEST_CONSTANTS.PATHS.SPEC_REPO,
      targetRepo: TEST_CONSTANTS.REPO.NAME,
      sourceRepo: TEST_CONSTANTS.REPO.SOURCE,
      prNumber: TEST_CONSTANTS.PR.NUMBER,
      runType: "SameVersion" as const,
      baseBranch: TEST_CONSTANTS.BRANCHES.MAIN,
      headCommit: TEST_CONSTANTS.COMMITS.HEAD,
      prSourceBranch: "",
      prTargetBranch: "",
      ...overrides,
    });

    it("should create context with default values", async () => {
      const { createOadMessageProcessor } = await import("../src/utils/oad-message-processor.js");
      const { mockOadMessageProcessor } = setupCommonMocks();
      vi.mocked(createOadMessageProcessor).mockReturnValue(mockOadMessageProcessor);

      const parsedArgs = createTestParsedArgs();
      const context = createContextFromParsedArgs(
        parsedArgs,
        TEST_CONSTANTS.PATHS.WORKING_FOLDER,
        TEST_CONSTANTS.PATHS.LOG_FOLDER,
      );

      expect(context.targetRepo).toBe(TEST_CONSTANTS.REPO.NAME);
      expect(context.prNumber).toBe(TEST_CONSTANTS.PR.NUMBER);
      expect(context.runType).toBe("SameVersion");
      expect(context.baseBranch).toBe(TEST_CONSTANTS.BRANCHES.MAIN);
      expect(context.headCommit).toBe(TEST_CONSTANTS.COMMITS.HEAD);
      expect(context.checkName).toBe("Swagger BreakingChange");
      expect(context.prUrl).toBe(TEST_CONSTANTS.PR.URL);
      expect(context.workingFolder).toBe(TEST_CONSTANTS.PATHS.WORKING_FOLDER);
      expect(context.logFileFolder).toBe(TEST_CONSTANTS.PATHS.LOG_FOLDER);
    });

    it("should use custom values when provided", async () => {
      const { createOadMessageProcessor } = await import("../src/utils/oad-message-processor.js");
      vi.mocked(createOadMessageProcessor).mockReturnValue({
        logFilePath: TEST_CONSTANTS.PATHS.LOG_FILE,
        prUrl: TEST_CONSTANTS.PR.CUSTOM_URL,
        messageCache: [],
      });

      const parsedArgs = createTestParsedArgs({
        targetRepo: TEST_CONSTANTS.REPO.CUSTOM,
        prNumber: TEST_CONSTANTS.PR.CUSTOM_NUMBER,
        runType: "CrossVersion",
        baseBranch: TEST_CONSTANTS.BRANCHES.DEVELOP,
        headCommit: TEST_CONSTANTS.COMMITS.ABC123,
        prSourceBranch: TEST_CONSTANTS.BRANCHES.FEATURE,
        prTargetBranch: TEST_CONSTANTS.BRANCHES.MAIN,
      });

      const context = createContextFromParsedArgs(
        parsedArgs,
        TEST_CONSTANTS.PATHS.WORKING_FOLDER,
        TEST_CONSTANTS.PATHS.LOG_FOLDER,
      );

      expect(context.targetRepo).toBe(TEST_CONSTANTS.REPO.CUSTOM);
      expect(context.prNumber).toBe(TEST_CONSTANTS.PR.CUSTOM_NUMBER);
      expect(context.runType).toBe("CrossVersion");
      expect(context.baseBranch).toBe(TEST_CONSTANTS.BRANCHES.DEVELOP);
      expect(context.headCommit).toBe(TEST_CONSTANTS.COMMITS.ABC123);
      expect(context.prSourceBranch).toBe(TEST_CONSTANTS.BRANCHES.FEATURE);
      expect(context.prTargetBranch).toBe(TEST_CONSTANTS.BRANCHES.MAIN);
      expect(context.checkName).toBe("BreakingChange(Cross-Version)");
    });

    it("should create proper URL and context structure", async () => {
      const { createOadMessageProcessor } = await import("../src/utils/oad-message-processor.js");
      const { mockOadMessageProcessor } = setupCommonMocks();
      vi.mocked(createOadMessageProcessor).mockReturnValue(mockOadMessageProcessor);

      const parsedArgs = createTestParsedArgs();
      const context = createContextFromParsedArgs(
        parsedArgs,
        TEST_CONSTANTS.PATHS.WORKING_FOLDER,
        TEST_CONSTANTS.PATHS.LOG_FOLDER,
      );

      expect(context.swaggerDirs).toEqual(["specification", "dev"]);
      expect(context.oadMessageProcessorContext).toBe(mockOadMessageProcessor);
      expect(createOadMessageProcessor).toHaveBeenCalledWith(
        TEST_CONSTANTS.PATHS.LOG_FOLDER,
        TEST_CONSTANTS.PR.URL,
      );
    });
  });

  describe("BreakingChangeLabelsToBeAdded", () => {
    it("should be a Set that can be modified", () => {
      expect(BreakingChangeLabelsToBeAdded).toBeInstanceOf(Set);
      expect(BreakingChangeLabelsToBeAdded.size).toBe(0);

      BreakingChangeLabelsToBeAdded.add("test-label");
      expect(BreakingChangeLabelsToBeAdded.has("test-label")).toBe(true);
      expect(BreakingChangeLabelsToBeAdded.size).toBe(1);

      BreakingChangeLabelsToBeAdded.clear();
      expect(BreakingChangeLabelsToBeAdded.size).toBe(0);
    });
  });

  describe("getSwaggerDiffs", () => {
    it("should return changed files successfully", async () => {
      const mockResult = createMockSwaggerResult();
      mockGetChangedFilesStatuses.mockResolvedValue(mockResult);

      const result = await getSwaggerDiffs({
        baseCommitish: TEST_CONSTANTS.BRANCHES.MAIN,
        cwd: TEST_CONSTANTS.PATHS.TEST_PATH,
        headCommitish: TEST_CONSTANTS.COMMITS.HEAD,
      });

      // Expected result should have renames added to additions and deletions, and no renames property
      const expectedResult = {
        additions: [...mockResult.additions, ...mockResult.renames.map((rename) => rename.to)],
        modifications: mockResult.modifications,
        deletions: [...mockResult.deletions, ...mockResult.renames.map((rename) => rename.from)],
        total:
          mockResult.additions.length +
          mockResult.modifications.length +
          mockResult.deletions.length +
          mockResult.renames.length * 2,
      };

      expect(result).toEqual(expectedResult);
      expect(mockGetChangedFilesStatuses).toHaveBeenCalledWith({
        baseCommitish: TEST_CONSTANTS.BRANCHES.MAIN,
        cwd: TEST_CONSTANTS.PATHS.TEST_PATH,
        headCommitish: TEST_CONSTANTS.COMMITS.HEAD,
        paths: ["specification"],
      });
    });

    it("should return empty result on error", async () => {
      mockGetChangedFilesStatuses.mockRejectedValue(new Error("Git error"));
      const result = await getSwaggerDiffs();
      expect(result).toEqual({
        additions: [],
        modifications: [],
        deletions: [],
        total: 0,
      });
    });

    it("should filter out non-Swagger files", async () => {
      const mockResultWithNonSwagger = {
        additions: [
          TEST_CONSTANTS.SWAGGER_PATHS.FOO, // Valid Swagger
          TEST_CONSTANTS.NON_SWAGGER_PATHS.YAML, // Non-Swagger (YAML)
          TEST_CONSTANTS.NON_SWAGGER_PATHS.EXAMPLE, // Example file
          TEST_CONSTANTS.NON_SWAGGER_PATHS.README, // Non-JSON
          TEST_CONSTANTS.SWAGGER_PATHS.BAZ, // Valid Swagger
        ],
        modifications: [
          TEST_CONSTANTS.SWAGGER_PATHS.QUX_MGMT, // Valid Swagger
          TEST_CONSTANTS.NON_SWAGGER_PATHS.PACKAGE_JSON, // Non-Swagger JSON
        ],
        deletions: [
          TEST_CONSTANTS.SWAGGER_PATHS.OLD_DATA, // Valid Swagger
          TEST_CONSTANTS.NON_SWAGGER_PATHS.BUILD_JS, // Non-Swagger
        ],
        renames: [
          {
            from: TEST_CONSTANTS.SWAGGER_PATHS.OLD_MGMT, // Valid Swagger
            to: TEST_CONSTANTS.SWAGGER_PATHS.NEW_MGMT, // Valid Swagger
          },
          {
            from: TEST_CONSTANTS.NON_SWAGGER_PATHS.OLD_README, // Non-Swagger
            to: TEST_CONSTANTS.NON_SWAGGER_PATHS.NEW_README, // Non-Swagger
          },
        ],
        total: 9,
      };

      mockGetChangedFilesStatuses.mockResolvedValue(mockResultWithNonSwagger);

      const result = await getSwaggerDiffs();

      // Only Swagger files should be returned, with renames added to additions and deletions
      expect(result).toEqual({
        additions: [
          TEST_CONSTANTS.SWAGGER_PATHS.FOO,
          TEST_CONSTANTS.SWAGGER_PATHS.BAZ,
          TEST_CONSTANTS.SWAGGER_PATHS.NEW_MGMT, // from valid rename
        ],
        modifications: [TEST_CONSTANTS.SWAGGER_PATHS.QUX_MGMT],
        deletions: [
          TEST_CONSTANTS.SWAGGER_PATHS.OLD_DATA,
          TEST_CONSTANTS.SWAGGER_PATHS.OLD_MGMT, // from valid rename
        ],
        total: 6, // 3 additions + 1 modification + 2 deletions (including rename files)
      });
    });

    it("should use default options when none provided", async () => {
      const emptyResult = createMockSwaggerResult({
        additions: [],
        modifications: [],
        deletions: [],
        renames: [],
        total: 0,
      });

      mockGetChangedFilesStatuses.mockResolvedValue(emptyResult);

      await getSwaggerDiffs();

      expect(mockGetChangedFilesStatuses).toHaveBeenCalledWith({
        baseCommitish: undefined,
        cwd: undefined,
        headCommitish: undefined,
        paths: ["specification"],
      });
    });

    it("should handle renames by adding them to additions and deletions", async () => {
      const mockResultWithRenames = {
        additions: [TEST_CONSTANTS.SWAGGER_PATHS.FOO],
        modifications: [TEST_CONSTANTS.SWAGGER_PATHS.BAZ],
        deletions: [TEST_CONSTANTS.SWAGGER_PATHS.OLD_DATA],
        renames: [
          {
            from: TEST_CONSTANTS.SWAGGER_PATHS.OLD_MGMT,
            to: TEST_CONSTANTS.SWAGGER_PATHS.NEW_MGMT,
          },
          {
            from: "specification/oldapi/data-plane/stable/2023-01-01/oldapi.json",
            to: "specification/newapi/data-plane/stable/2023-01-01/newapi.json",
          },
        ],
        total: 6,
      };

      mockGetChangedFilesStatuses.mockResolvedValue(mockResultWithRenames);

      const result = await getSwaggerDiffs();

      // Renames should be added to additions and deletions, not returned as renames
      expect(result).toEqual({
        additions: [
          TEST_CONSTANTS.SWAGGER_PATHS.FOO,
          TEST_CONSTANTS.SWAGGER_PATHS.NEW_MGMT, // from rename.to
          "specification/newapi/data-plane/stable/2023-01-01/newapi.json", // from rename.to
        ],
        modifications: [TEST_CONSTANTS.SWAGGER_PATHS.BAZ],
        deletions: [
          TEST_CONSTANTS.SWAGGER_PATHS.OLD_DATA,
          TEST_CONSTANTS.SWAGGER_PATHS.OLD_MGMT, // from rename.from
          "specification/oldapi/data-plane/stable/2023-01-01/oldapi.json", // from rename.from
        ],
        total: 7, // 3 additions + 1 modification + 3 deletions (including from renames)
      });
    });
  });

  describe("buildPrInfo", () => {
    it("should build PR info successfully", async () => {
      const { createPullRequestProperties } = await import("../src/utils/pull-request.js");
      const mockContext = createMockContext();
      const mockPrInfo = createMockPrInfo();

      vi.mocked(createPullRequestProperties).mockResolvedValue(mockPrInfo);

      await buildPrInfo(mockContext);

      expect(mockContext.prInfo).toBe(mockPrInfo);
      expect(createPullRequestProperties).toHaveBeenCalledWith(mockContext, "same-version");
    });

    it("should use cross-version prefix for CrossVersion run type", async () => {
      const { createPullRequestProperties } = await import("../src/utils/pull-request.js");
      const mockContext = createMockContext({ runType: "CrossVersion" });
      const mockPrInfo = createMockPrInfo();

      vi.mocked(createPullRequestProperties).mockResolvedValue(mockPrInfo);

      await buildPrInfo(mockContext);

      expect(createPullRequestProperties).toHaveBeenCalledWith(mockContext, "cross-version");
    });

    it("should throw error when PR info creation fails", async () => {
      const { createPullRequestProperties } = await import("../src/utils/pull-request.js");
      const mockContext = createMockContext();

      vi.mocked(createPullRequestProperties).mockResolvedValue(undefined);

      await expect(buildPrInfo(mockContext)).rejects.toThrow("create PR failed!");
    });

    it("should throw error when PR info has no target branch", async () => {
      const { createPullRequestProperties } = await import("../src/utils/pull-request.js");
      const mockContext = createMockContext();
      const mockPrInfo = createMockPrInfo({ targetBranch: "" }); // Empty target branch

      vi.mocked(createPullRequestProperties).mockResolvedValue(mockPrInfo);

      await expect(buildPrInfo(mockContext)).rejects.toThrow("create PR failed!");
    });
  });

  describe("changeBaseBranch", () => {
    it("should change base branch when different from target and not whitelisted", async () => {
      const { logMessage } = await import("../src/log.js");
      const mockContext = createMockContext({
        prTargetBranch: TEST_CONSTANTS.BRANCHES.DEVELOP,
        prInfo: createMockPrInfo({
          baseBranch: TEST_CONSTANTS.BRANCHES.DEVELOP,
          targetBranch: TEST_CONSTANTS.BRANCHES.DEVELOP,
          currentBranch: TEST_CONSTANTS.BRANCHES.DEVELOP,
        }),
      });

      changeBaseBranch(mockContext);

      expect(mockContext.prInfo!.baseBranch).toBe(TEST_CONSTANTS.BRANCHES.MAIN);
      expect(logMessage).toHaveBeenCalledWith(TEST_CONSTANTS.MESSAGES.SWITCH_BRANCH);
    });

    it("should not change base branch when same as target", () => {
      const mockContext = createMockContext({
        prTargetBranch: TEST_CONSTANTS.BRANCHES.MAIN, // Same as baseBranch
        prInfo: createMockPrInfo(),
      });

      const originalBaseBranch = mockContext.prInfo!.baseBranch;
      changeBaseBranch(mockContext);

      expect(mockContext.prInfo!.baseBranch).toBe(originalBaseBranch);
    });

    it("should not change base branch for whitelisted branches", () => {
      const mockContext = createMockContext({
        prTargetBranch: TEST_CONSTANTS.BRANCHES.ARM_CORE, // Whitelisted branch
        prInfo: createMockPrInfo({
          baseBranch: TEST_CONSTANTS.BRANCHES.ARM_CORE,
          targetBranch: TEST_CONSTANTS.BRANCHES.ARM_CORE,
          currentBranch: TEST_CONSTANTS.BRANCHES.ARM_CORE,
        }),
      });

      const originalBaseBranch = mockContext.prInfo!.baseBranch;
      changeBaseBranch(mockContext);

      expect(mockContext.prInfo!.baseBranch).toBe(originalBaseBranch);
    });

    it("should change base branch for CrossVersion run type when different from target", async () => {
      const { logMessage } = await import("../src/log.js");
      const mockContext = createMockContext({
        runType: "CrossVersion", // CrossVersion type
        prTargetBranch: TEST_CONSTANTS.BRANCHES.DEVELOP, // Different from baseBranch
        prInfo: createMockPrInfo({
          baseBranch: TEST_CONSTANTS.BRANCHES.DEVELOP,
          targetBranch: TEST_CONSTANTS.BRANCHES.DEVELOP,
          currentBranch: TEST_CONSTANTS.BRANCHES.DEVELOP,
        }),
      });

      changeBaseBranch(mockContext);

      // CrossVersion also changes base branch when different from target
      expect(mockContext.prInfo!.baseBranch).toBe(TEST_CONSTANTS.BRANCHES.MAIN);
      expect(logMessage).toHaveBeenCalledWith(TEST_CONSTANTS.MESSAGES.SWITCH_BRANCH);
    });
  });

  describe("logFullOadMessagesList", () => {
    it("should log all messages individually", async () => {
      const { logMessage } = await import("../src/log.js");
      const msgs = createMockMessages();

      logFullOadMessagesList(msgs);

      expect(logMessage).toHaveBeenCalledWith("---- Full list of messages ----", LogLevel.Group);
      expect(logMessage).toHaveBeenCalledWith("[");
      expect(logMessage).toHaveBeenCalledWith(JSON.stringify(msgs[0], null, 4) + ",");
      expect(logMessage).toHaveBeenCalledWith(JSON.stringify(msgs[1], null, 4) + ",");
      expect(logMessage).toHaveBeenCalledWith("]");
      expect(logMessage).toHaveBeenCalledWith(
        "---- End of full list of messages ----",
        LogLevel.EndGroup,
      );
    });

    it("should handle empty message list", async () => {
      const { logMessage } = await import("../src/log.js");

      logFullOadMessagesList([]);

      expect(logMessage).toHaveBeenCalledWith("---- Full list of messages ----", LogLevel.Group);
      expect(logMessage).toHaveBeenCalledWith("[");
      expect(logMessage).toHaveBeenCalledWith("]");
      expect(logMessage).toHaveBeenCalledWith(
        "---- End of full list of messages ----",
        LogLevel.EndGroup,
      );
    });
  });

  describe("createDummySwagger", () => {
    it("should create dummy swagger file successfully", async () => {
      const { logMessage } = await import("../src/log.js");

      const fromSwagger = "/path/to/source.json";
      const toSwagger = "/path/to/target.json";
      const mockSwaggerContent = JSON.stringify({
        swagger: "2.0",
        info: { title: "Test API", version: "1.0" },
        paths: { "/test": { get: {} } },
        "x-ms-paths": { "/test2": { post: {} } },
        "x-ms-parameterized-host": { hostTemplate: "test.com" },
        parameters: { testParam: {} },
        definitions: { TestModel: {} },
      });

      mockExistsSync.mockReturnValue(false);
      mockReadFileSync.mockReturnValue(Buffer.from(mockSwaggerContent));

      createDummySwagger(fromSwagger, toSwagger);

      expect(mockMkdirSync).toHaveBeenCalledWith("/path/to", { recursive: true });
      expect(mockReadFileSync).toHaveBeenCalledWith(fromSwagger);
      expect(mockWriteFileSync).toHaveBeenCalledWith(
        toSwagger,
        expect.stringContaining('"paths": {}'),
      );
      expect(logMessage).toHaveBeenCalledWith(
        `created a dummy swagger: ${toSwagger} from ${fromSwagger}`,
      );

      // Verify the dummy swagger content
      const writeCall = mockWriteFileSync.mock.calls[0];
      const writtenContent = JSON.parse(writeCall[1] as string);
      expect(writtenContent.paths).toEqual({});
      expect(writtenContent["x-ms-paths"]).toEqual({});
      expect(writtenContent["x-ms-parameterized-host"]).toBeUndefined();
      expect(writtenContent.parameters).toEqual({});
      expect(writtenContent.definitions).toEqual({});
    });

    it("should create directory if it doesn't exist", () => {
      const fromSwagger = "/path/to/source.json";
      const toSwagger = "/path/to/nested/target.json";
      const mockSwaggerContent = JSON.stringify({
        swagger: "2.0",
        info: { title: "Test API", version: "1.0" },
      });

      mockExistsSync.mockReturnValue(false);
      mockReadFileSync.mockReturnValue(Buffer.from(mockSwaggerContent));

      createDummySwagger(fromSwagger, toSwagger);

      expect(mockMkdirSync).toHaveBeenCalledWith("/path/to/nested", { recursive: true });
    });

    it("should not create directory if it already exists", () => {
      const fromSwagger = "/path/to/source.json";
      const toSwagger = "/path/to/target.json";
      const mockSwaggerContent = JSON.stringify({
        swagger: "2.0",
        info: { title: "Test API", version: "1.0" },
      });

      mockExistsSync.mockReturnValue(true);
      mockReadFileSync.mockReturnValue(Buffer.from(mockSwaggerContent));

      createDummySwagger(fromSwagger, toSwagger);

      expect(mockMkdirSync).not.toHaveBeenCalled();
    });

    it("should handle swagger without optional fields", () => {
      const fromSwagger = "/path/to/source.json";
      const toSwagger = "/path/to/target.json";
      const mockSwaggerContent = JSON.stringify({
        swagger: "2.0",
        info: { title: "Test API", version: "1.0" },
        paths: { "/test": { get: {} } },
      });

      mockExistsSync.mockReturnValue(true);
      mockReadFileSync.mockReturnValue(Buffer.from(mockSwaggerContent));

      createDummySwagger(fromSwagger, toSwagger);

      expect(mockWriteFileSync).toHaveBeenCalled();
      const writeCall = mockWriteFileSync.mock.calls[0];
      const writtenContent = JSON.parse(writeCall[1] as string);
      expect(writtenContent.paths).toEqual({});
      expect(writtenContent["x-ms-paths"]).toBeUndefined();
      expect(writtenContent["x-ms-parameterized-host"]).toBeUndefined();
    });
  });

  describe("cleanDummySwagger", () => {
    it("should remove all created dummy swagger files", () => {
      // Create some dummy files first
      const file1 = "/path/to/dummy1.json";
      const file2 = "/path/to/dummy2.json";

      mockExistsSync.mockReturnValue(true);
      mockReadFileSync.mockReturnValue(Buffer.from('{"swagger": "2.0"}'));

      createDummySwagger("/source1.json", file1);
      createDummySwagger("/source2.json", file2);

      // Clear previous mock calls before testing cleanup
      mockRmSync.mockClear();

      // Now clean them up
      cleanDummySwagger();

      expect(mockRmSync).toHaveBeenCalledWith(file1, { recursive: true, force: true });
      expect(mockRmSync).toHaveBeenCalledWith(file2, { recursive: true, force: true });
      expect(mockRmSync).toHaveBeenCalledTimes(2);
    });

    it("should handle empty list of created files", () => {
      // Clear any previous calls
      mockRmSync.mockClear();

      cleanDummySwagger();
      expect(mockRmSync).not.toHaveBeenCalled();
    });
  });

  describe("isSameVersionBreakingType", () => {
    it("should return true for SameVersion type", () => {
      expect(isSameVersionBreakingType("SameVersion")).toBe(true);
    });

    it("should return false for CrossVersion type", () => {
      expect(isSameVersionBreakingType("CrossVersion")).toBe(false);
    });
  });

  describe("getCreatedDummySwaggerCount", () => {
    it("should return current count of created dummy files", () => {
      // Get initial count (may not be 0 due to other tests)
      const initialCount = getCreatedDummySwaggerCount();

      mockExistsSync.mockReturnValue(true);
      mockReadFileSync.mockReturnValue(Buffer.from('{"swagger": "2.0"}'));

      createDummySwagger("/source1.json", "/dummy1.json");
      expect(getCreatedDummySwaggerCount()).toBe(initialCount + 1);

      createDummySwagger("/source2.json", "/dummy2.json");
      expect(getCreatedDummySwaggerCount()).toBe(initialCount + 2);
    });

    it("should return correct count after creating multiple dummy files", () => {
      const initialCount = getCreatedDummySwaggerCount();

      mockExistsSync.mockReturnValue(true);
      mockReadFileSync.mockReturnValue(Buffer.from('{"swagger": "2.0"}'));

      createDummySwagger("/source1.json", "/dummy1.json");
      createDummySwagger("/source2.json", "/dummy2.json");
      expect(getCreatedDummySwaggerCount()).toBe(initialCount + 2);

      cleanDummySwagger();
      expect(getCreatedDummySwaggerCount()).toBe(0);
    });

    it("should return 0 after cleaning all dummy files", () => {
      mockExistsSync.mockReturnValue(true);
      mockReadFileSync.mockReturnValue(Buffer.from('{"swagger": "2.0"}'));

      // Create some files
      createDummySwagger("/source1.json", "/dummy1.json");
      createDummySwagger("/source2.json", "/dummy2.json");
      expect(getCreatedDummySwaggerCount()).toBeGreaterThan(0);

      // Clean them
      cleanDummySwagger();
      expect(getCreatedDummySwaggerCount()).toBe(0);
    });
  });

  describe("outputBreakingChangeLabelVariables", () => {
    beforeEach(() => {
      // Clear the labels set before each test
      BreakingChangeLabelsToBeAdded.clear();
    });

    it("should set both labels to false when no labels need to be added", async () => {
      const { setOutput } = await import("../src/log.js");

      outputBreakingChangeLabelVariables();

      expect(setOutput).toHaveBeenCalledWith(
        "breakingChangeReviewLabelName",
        BreakingChangeReviewRequiredLabel,
      );
      expect(setOutput).toHaveBeenCalledWith("breakingChangeReviewLabelValue", "false");
      expect(setOutput).toHaveBeenCalledWith(
        "versioningReviewLabelName",
        VersioningReviewRequiredLabel,
      );
      expect(setOutput).toHaveBeenCalledWith("versioningReviewLabelValue", "false");
    });

    it("should set BreakingChangeReviewRequired to true when present in labels set", async () => {
      const { setOutput } = await import("../src/log.js");

      BreakingChangeLabelsToBeAdded.add(BreakingChangeReviewRequiredLabel);

      outputBreakingChangeLabelVariables();
      expect(setOutput).toHaveBeenCalledWith(
        "breakingChangeReviewLabelName",
        BreakingChangeReviewRequiredLabel,
      );
      expect(setOutput).toHaveBeenCalledWith("breakingChangeReviewLabelValue", "true");
      expect(setOutput).toHaveBeenCalledWith(
        "versioningReviewLabelName",
        VersioningReviewRequiredLabel,
      );
      expect(setOutput).toHaveBeenCalledWith("versioningReviewLabelValue", "false");
    });

    it("should set VersioningReviewRequired to true when present in labels set", async () => {
      const { setOutput } = await import("../src/log.js");

      BreakingChangeLabelsToBeAdded.add(VersioningReviewRequiredLabel);

      outputBreakingChangeLabelVariables();
      expect(setOutput).toHaveBeenCalledWith(
        "breakingChangeReviewLabelName",
        BreakingChangeReviewRequiredLabel,
      );
      expect(setOutput).toHaveBeenCalledWith("breakingChangeReviewLabelValue", "false");
      expect(setOutput).toHaveBeenCalledWith(
        "versioningReviewLabelName",
        VersioningReviewRequiredLabel,
      );
      expect(setOutput).toHaveBeenCalledWith("versioningReviewLabelValue", "true");
    });

    it("should set both labels to true when both are present in labels set", async () => {
      const { setOutput } = await import("../src/log.js");

      BreakingChangeLabelsToBeAdded.add(BreakingChangeReviewRequiredLabel);
      BreakingChangeLabelsToBeAdded.add(VersioningReviewRequiredLabel);

      outputBreakingChangeLabelVariables();
      expect(setOutput).toHaveBeenCalledWith(
        "breakingChangeReviewLabelName",
        BreakingChangeReviewRequiredLabel,
      );
      expect(setOutput).toHaveBeenCalledWith("breakingChangeReviewLabelValue", "true");
      expect(setOutput).toHaveBeenCalledWith(
        "versioningReviewLabelName",
        VersioningReviewRequiredLabel,
      );
      expect(setOutput).toHaveBeenCalledWith("versioningReviewLabelValue", "false");
    });

    it("should handle labels set with non-review labels", async () => {
      const { setOutput } = await import("../src/log.js");

      BreakingChangeLabelsToBeAdded.add("SomeOtherLabel");

      outputBreakingChangeLabelVariables();
      expect(setOutput).toHaveBeenCalledWith(
        "breakingChangeReviewLabelName",
        BreakingChangeReviewRequiredLabel,
      );
      expect(setOutput).toHaveBeenCalledWith("breakingChangeReviewLabelValue", "false");
      expect(setOutput).toHaveBeenCalledWith(
        "versioningReviewLabelName",
        VersioningReviewRequiredLabel,
      );
      expect(setOutput).toHaveBeenCalledWith("versioningReviewLabelValue", "false");
    });

    it("should handle mixed labels including one review label", async () => {
      const { setOutput } = await import("../src/log.js");

      BreakingChangeLabelsToBeAdded.add("SomeOtherLabel");
      BreakingChangeLabelsToBeAdded.add(BreakingChangeReviewRequiredLabel);

      outputBreakingChangeLabelVariables();
      expect(setOutput).toHaveBeenCalledWith(
        "breakingChangeReviewLabelName",
        BreakingChangeReviewRequiredLabel,
      );
      expect(setOutput).toHaveBeenCalledWith("breakingChangeReviewLabelValue", "true");
      expect(setOutput).toHaveBeenCalledWith(
        "versioningReviewLabelName",
        VersioningReviewRequiredLabel,
      );
      expect(setOutput).toHaveBeenCalledWith("versioningReviewLabelValue", "false");
    });
  });
});
