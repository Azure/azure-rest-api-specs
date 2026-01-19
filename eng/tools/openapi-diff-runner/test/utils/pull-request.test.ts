import { existsSync, mkdirSync } from "node:fs";
import path from "node:path";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { Context } from "../../src/types/breaking-change.js";
import { createPullRequestProperties } from "../../src/utils/pull-request.js";

// Test constants
const TEST_CONSTANTS = {
  BRANCHES: {
    MAIN: "main",
    DEVELOP: "develop",
    FEATURE: "feature-branch",
    SOURCE: "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8",
  },
  PATHS: {
    SPEC_REPO: "/path/to/spec/repo",
    WORKING_FOLDER: "/path/to/working/folder",
    LOG_FOLDER: "/path/to/log/folder",
    LOG_FILE: "/path/to/log/file.log",
    CURRENT_WORKING_DIR: "/current/working/dir",
    RESOLVED_WORKING_DIR: "/resolved/working/dir",
    CUSTOM_PREFIX_PATH: "../custom-prefix-c93b354fd9c14905bb574a8834c4d69b",
  },
  REPO: {
    NAME: "owner/repo",
    COMMIT: "abc123",
    PR_NUMBER: "123",
    PR_URL: "https://github.com/owner/repo/pull/123",
  },
  PREFIXES: {
    TEST: "test-prefix",
    CUSTOM: "custom-prefix",
  },
  SWAGGER_DIRS: ["specification/service/path"] as string[],
  ERRORS: {
    GET_REMOTES: "Failed to get remotes",
    REMOTE_EXISTS: "fatal: remote origin already exists",
    OTHER_ERROR: "Some other error",
  },
} as const;

// Helper functions
function createMockContext(overrides: Partial<Context> = {}): Context {
  return {
    localSpecRepoPath: TEST_CONSTANTS.PATHS.SPEC_REPO,
    workingFolder: TEST_CONSTANTS.PATHS.WORKING_FOLDER,
    logFileFolder: TEST_CONSTANTS.PATHS.LOG_FOLDER,
    swaggerDirs: TEST_CONSTANTS.SWAGGER_DIRS,
    baseBranch: TEST_CONSTANTS.BRANCHES.MAIN,
    headCommit: TEST_CONSTANTS.REPO.COMMIT,
    runType: "SameVersion",
    checkName: "BreakingChange",
    targetRepo: TEST_CONSTANTS.REPO.NAME,
    sourceRepo: TEST_CONSTANTS.REPO.NAME,
    prNumber: TEST_CONSTANTS.REPO.PR_NUMBER,
    prSourceBranch: TEST_CONSTANTS.BRANCHES.FEATURE,
    prTargetBranch: TEST_CONSTANTS.BRANCHES.MAIN,
    oadMessageProcessorContext: {
      logFilePath: TEST_CONSTANTS.PATHS.LOG_FILE,
      prUrl: TEST_CONSTANTS.REPO.PR_URL,
      messageCache: [],
    },
    prUrl: TEST_CONSTANTS.REPO.PR_URL,
    ...overrides,
  };
}

function setupBasicGitMocks(mockGitRepo: any) {
  mockGitRepo.branch.mockResolvedValue({
    all: [TEST_CONSTANTS.BRANCHES.MAIN, TEST_CONSTANTS.BRANCHES.SOURCE],
  });
  mockGitRepo.getRemotes.mockResolvedValue([{ name: "origin" }]);
  mockGitRepo.init.mockResolvedValue(undefined);
  mockGitRepo.addRemote.mockResolvedValue(undefined);
  mockGitRepo.pull.mockResolvedValue(undefined);
  mockGitRepo.fetch.mockResolvedValue(undefined);
  mockGitRepo.checkout.mockResolvedValue(undefined);
}

function setupCustomBranchMocks(mockGitRepo: any, branches: string[]) {
  mockGitRepo.branch.mockResolvedValue({ all: branches });
  mockGitRepo.getRemotes.mockResolvedValue([{ name: "origin" }]);
  mockGitRepo.init.mockResolvedValue(undefined);
  mockGitRepo.addRemote.mockResolvedValue(undefined);
  mockGitRepo.pull.mockResolvedValue(undefined);
  mockGitRepo.fetch.mockResolvedValue(undefined);
  mockGitRepo.checkout.mockResolvedValue(undefined);
}

function setupGitErrorMocks(mockGitRepo: any, errorType: string) {
  mockGitRepo.branch.mockResolvedValue({
    all: [TEST_CONSTANTS.BRANCHES.MAIN, TEST_CONSTANTS.BRANCHES.SOURCE],
  });
  mockGitRepo.getRemotes.mockRejectedValue(new Error(errorType));
  mockGitRepo.init.mockResolvedValue(undefined);
  mockGitRepo.pull.mockResolvedValue(undefined);
  mockGitRepo.fetch.mockResolvedValue(undefined);
  mockGitRepo.checkout.mockResolvedValue(undefined);
}

function setupPathMocks(mockPath: any, mockExistsSync: any, exists: boolean = true) {
  mockExistsSync.mockReturnValue(exists);
  mockPath.resolve.mockReturnValue(TEST_CONSTANTS.PATHS.RESOLVED_WORKING_DIR);
  mockPath.join.mockImplementation((...paths: string[]) => paths.join("/"));
}

function expectPullRequestResult(result: any, expectedProps: Partial<any>) {
  expect(result).toBeDefined();
  if (expectedProps.baseBranch) expect(result!.baseBranch).toBe(expectedProps.baseBranch);
  if (expectedProps.targetBranch) expect(result!.targetBranch).toBe(expectedProps.targetBranch);
  if (expectedProps.sourceBranch) expect(result!.sourceBranch).toBe(expectedProps.sourceBranch);
  if (expectedProps.tempRepoFolder)
    expect(result!.tempRepoFolder).toBe(expectedProps.tempRepoFolder);
  if (expectedProps.currentBranch) expect(result!.currentBranch).toBe(expectedProps.currentBranch);
  if (expectedProps.hasCheckout) expect(typeof result!.checkout).toBe("function");
}

function expectGitOperationCalls(mockGitRepo: any, operations: string[]) {
  operations.forEach((operation) => {
    expect(mockGitRepo[operation]).toHaveBeenCalled();
  });
}

function expectCheckoutResult(result: any, expectedBranch: string) {
  expect(result).toBeDefined();
  expect(result!.currentBranch).toBe(expectedBranch);
}

// Mock dependencies
vi.mock("node:fs");
vi.mock("node:path");
vi.mock("simple-git");

describe("pull-request", () => {
  const mockExistsSync = vi.mocked(existsSync);
  const mockMkdirSync = vi.mocked(mkdirSync);
  const mockPath = vi.mocked(path);
  const mockSimpleGit = vi.mocked(simpleGit);

  // Mock git repository instance
  const mockGitRepo = {
    branch: vi.fn(),
    init: vi.fn(),
    getRemotes: vi.fn(),
    addRemote: vi.fn(),
    pull: vi.fn(),
    fetch: vi.fn(),
    checkout: vi.fn(),
  };

  beforeEach(() => {
    vi.clearAllMocks();

    // Setup default mocks
    mockSimpleGit.mockReturnValue(mockGitRepo as any);
    mockPath.resolve.mockImplementation((...paths: string[]) => paths.join("/"));
    mockPath.join.mockImplementation((...paths: string[]) => paths.join("/"));

    // Mock console.log to avoid test output noise
    vi.spyOn(console, "log").mockImplementation(() => {});
  });

  afterEach(() => {
    vi.resetAllMocks();
  });

  describe("createPullRequestProperties", () => {
    it("should return undefined when baseBranch is undefined", async () => {
      const context = createMockContext({ baseBranch: undefined });

      const result = await createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST);

      expect(result).toBeUndefined();
    });

    it("should create pull request properties successfully", async () => {
      const context = createMockContext();

      setupBasicGitMocks(mockGitRepo);
      setupPathMocks(mockPath, mockExistsSync, false);

      const result = await createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST);

      expectPullRequestResult(result, {
        baseBranch: TEST_CONSTANTS.BRANCHES.MAIN,
        targetBranch: TEST_CONSTANTS.BRANCHES.MAIN,
        sourceBranch: TEST_CONSTANTS.BRANCHES.SOURCE,
        tempRepoFolder: TEST_CONSTANTS.PATHS.RESOLVED_WORKING_DIR,
        currentBranch: TEST_CONSTANTS.BRANCHES.MAIN,
        hasCheckout: true,
      });
    });

    it("should create source branch if it doesn't exist", async () => {
      const context = createMockContext();

      setupCustomBranchMocks(mockGitRepo, [TEST_CONSTANTS.BRANCHES.MAIN]); // Source branch doesn't exist
      setupPathMocks(mockPath, mockExistsSync);

      await createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST);

      expect(mockGitRepo.branch).toHaveBeenCalledWith([TEST_CONSTANTS.BRANCHES.SOURCE]);
    });

    it("should create base branch if it doesn't exist and skipInitializeBase is false", async () => {
      const context = createMockContext({ baseBranch: TEST_CONSTANTS.BRANCHES.DEVELOP });

      setupCustomBranchMocks(mockGitRepo, [
        TEST_CONSTANTS.BRANCHES.MAIN,
        TEST_CONSTANTS.BRANCHES.SOURCE,
      ]); // Base branch doesn't exist
      setupPathMocks(mockPath, mockExistsSync);

      await createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST, false);

      expect(mockGitRepo.branch).toHaveBeenCalledWith([
        TEST_CONSTANTS.BRANCHES.DEVELOP,
        `remotes/origin/${TEST_CONSTANTS.BRANCHES.DEVELOP}`,
      ]);
    });

    it("should not create base branch if skipInitializeBase is true", async () => {
      const context = createMockContext({ baseBranch: TEST_CONSTANTS.BRANCHES.DEVELOP });

      setupBasicGitMocks(mockGitRepo);
      setupPathMocks(mockPath, mockExistsSync);

      await createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST, true);

      expect(mockGitRepo.branch).not.toHaveBeenCalledWith([
        TEST_CONSTANTS.BRANCHES.DEVELOP,
        `remotes/origin/${TEST_CONSTANTS.BRANCHES.DEVELOP}`,
      ]);
      expect(mockGitRepo.fetch).not.toHaveBeenCalledWith("origin", TEST_CONSTANTS.BRANCHES.DEVELOP);
    });

    it("should create target branch if it doesn't exist", async () => {
      const context = createMockContext({ prTargetBranch: TEST_CONSTANTS.BRANCHES.FEATURE });

      setupCustomBranchMocks(mockGitRepo, [
        TEST_CONSTANTS.BRANCHES.MAIN,
        TEST_CONSTANTS.BRANCHES.SOURCE,
      ]); // Target branch doesn't exist
      setupPathMocks(mockPath, mockExistsSync);

      await createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST);

      expect(mockGitRepo.branch).toHaveBeenCalledWith([
        TEST_CONSTANTS.BRANCHES.FEATURE,
        `remotes/origin/${TEST_CONSTANTS.BRANCHES.FEATURE}`,
      ]);
    });

    it("should create working directory if it doesn't exist", async () => {
      const context = createMockContext();

      setupBasicGitMocks(mockGitRepo);
      setupPathMocks(mockPath, mockExistsSync, false); // Directory doesn't exist

      await createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST);

      expect(mockMkdirSync).toHaveBeenCalledWith(expect.any(String));
    });

    it("should add origin remote if it doesn't exist", async () => {
      const context = createMockContext();

      mockGitRepo.branch.mockResolvedValue({
        all: [TEST_CONSTANTS.BRANCHES.MAIN, TEST_CONSTANTS.BRANCHES.SOURCE],
      });
      mockGitRepo.getRemotes.mockResolvedValue([]); // No remotes exist
      setupPathMocks(mockPath, mockExistsSync);

      await createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST);

      expect(mockGitRepo.addRemote).toHaveBeenCalledWith("origin", context.localSpecRepoPath);
    });

    it("should not add origin remote if it already exists", async () => {
      const context = createMockContext();

      setupBasicGitMocks(mockGitRepo);
      setupPathMocks(mockPath, mockExistsSync);

      await createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST);

      expect(mockGitRepo.addRemote).not.toHaveBeenCalled();
    });

    it("should handle getRemotes error and try to add origin anyway", async () => {
      const context = createMockContext();

      setupGitErrorMocks(mockGitRepo, TEST_CONSTANTS.ERRORS.GET_REMOTES);
      mockGitRepo.addRemote.mockResolvedValue(undefined);
      setupPathMocks(mockPath, mockExistsSync);

      await createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST);

      expect(mockGitRepo.addRemote).toHaveBeenCalledWith("origin", context.localSpecRepoPath);
    });

    it("should ignore 'remote origin already exists' error when adding remote", async () => {
      const context = createMockContext();

      setupGitErrorMocks(mockGitRepo, TEST_CONSTANTS.ERRORS.GET_REMOTES);
      mockGitRepo.addRemote.mockRejectedValue(new Error(TEST_CONSTANTS.ERRORS.REMOTE_EXISTS));
      setupPathMocks(mockPath, mockExistsSync);

      // Should not throw an error
      await expect(
        createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST),
      ).resolves.toBeDefined();
    });

    it("should throw error if addRemote fails with other error", async () => {
      const context = createMockContext();

      setupGitErrorMocks(mockGitRepo, TEST_CONSTANTS.ERRORS.GET_REMOTES);
      mockGitRepo.addRemote.mockRejectedValue(new Error(TEST_CONSTANTS.ERRORS.OTHER_ERROR));
      setupPathMocks(mockPath, mockExistsSync);

      await expect(
        createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST),
      ).rejects.toThrow(TEST_CONSTANTS.ERRORS.OTHER_ERROR);
    });

    it("should perform git operations in correct order", async () => {
      const context = createMockContext();

      setupBasicGitMocks(mockGitRepo);
      setupPathMocks(mockPath, mockExistsSync);

      await createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST);

      // Verify order of operations
      expectGitOperationCalls(mockGitRepo, ["init"]);
      expect(mockGitRepo.pull).toHaveBeenCalledWith("origin", TEST_CONSTANTS.BRANCHES.MAIN);
      expect(mockGitRepo.fetch).toHaveBeenCalledWith("origin", TEST_CONSTANTS.BRANCHES.SOURCE);
      expect(mockGitRepo.fetch).toHaveBeenCalledWith("origin", TEST_CONSTANTS.BRANCHES.MAIN);
      expect(mockGitRepo.checkout).toHaveBeenCalledWith(TEST_CONSTANTS.BRANCHES.MAIN);
    });

    describe("checkout function", () => {
      it("should checkout to different branch", async () => {
        const context = createMockContext();

        setupBasicGitMocks(mockGitRepo);
        setupPathMocks(mockPath, mockExistsSync);

        const result = await createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST);

        expectCheckoutResult(result, TEST_CONSTANTS.BRANCHES.MAIN);

        // Test checkout function
        await result!.checkout(TEST_CONSTANTS.BRANCHES.FEATURE);

        expect(mockGitRepo.checkout).toHaveBeenCalledWith([TEST_CONSTANTS.BRANCHES.FEATURE]);
        expect(result!.currentBranch).toBe(TEST_CONSTANTS.BRANCHES.FEATURE);
      });

      it("should not checkout if already on the target branch", async () => {
        const context = createMockContext();

        setupBasicGitMocks(mockGitRepo);
        setupPathMocks(mockPath, mockExistsSync);

        const result = await createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST);

        expectCheckoutResult(result, TEST_CONSTANTS.BRANCHES.MAIN);

        // Clear previous checkout calls
        mockGitRepo.checkout.mockClear();

        // Test checkout to same branch
        await result!.checkout(TEST_CONSTANTS.BRANCHES.MAIN);

        expect(mockGitRepo.checkout).not.toHaveBeenCalled();
        expect(result!.currentBranch).toBe(TEST_CONSTANTS.BRANCHES.MAIN);
      });

      it("should update currentBranch after successful checkout", async () => {
        const context = createMockContext();

        setupBasicGitMocks(mockGitRepo);
        setupPathMocks(mockPath, mockExistsSync);

        const result = await createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST);

        expectCheckoutResult(result, TEST_CONSTANTS.BRANCHES.MAIN);

        // Test multiple checkouts
        await result!.checkout(TEST_CONSTANTS.BRANCHES.FEATURE);
        expect(result!.currentBranch).toBe(TEST_CONSTANTS.BRANCHES.FEATURE);

        await result!.checkout(TEST_CONSTANTS.BRANCHES.DEVELOP);
        expect(result!.currentBranch).toBe(TEST_CONSTANTS.BRANCHES.DEVELOP);

        // Verify checkout was called for each different branch
        expect(mockGitRepo.checkout).toHaveBeenCalledTimes(3); // 1 initial + 2 from tests
      });
    });

    it("should use correct working directory path", async () => {
      const context = createMockContext();
      const prefix = TEST_CONSTANTS.PREFIXES.CUSTOM;

      setupBasicGitMocks(mockGitRepo);
      setupPathMocks(mockPath, mockExistsSync);

      // Mock path operations
      vi.spyOn(process, "cwd").mockReturnValue(TEST_CONSTANTS.PATHS.CURRENT_WORKING_DIR);
      mockPath.join.mockReturnValue(TEST_CONSTANTS.PATHS.CUSTOM_PREFIX_PATH);
      mockPath.resolve.mockReturnValue(TEST_CONSTANTS.PATHS.RESOLVED_WORKING_DIR);

      const result = await createPullRequestProperties(context, prefix);

      expect(mockPath.join).toHaveBeenCalledWith(
        TEST_CONSTANTS.PATHS.CURRENT_WORKING_DIR,
        "..",
        "custom-prefix-c93b354fd9c14905bb574a8834c4d69b",
      );
      expect(mockPath.resolve).toHaveBeenCalledWith(TEST_CONSTANTS.PATHS.CUSTOM_PREFIX_PATH);
      expect(result!.tempRepoFolder).toBe(TEST_CONSTANTS.PATHS.RESOLVED_WORKING_DIR);
    });

    it("should use correct git options", async () => {
      const context = createMockContext();

      setupBasicGitMocks(mockGitRepo);
      setupPathMocks(mockPath, mockExistsSync);

      await createPullRequestProperties(context, TEST_CONSTANTS.PREFIXES.TEST);

      // Verify simpleGit was called with correct options
      expect(mockSimpleGit).toHaveBeenCalledWith({
        baseDir: context.localSpecRepoPath,
        binary: "git",
        maxConcurrentProcesses: 1,
      });

      expect(mockSimpleGit).toHaveBeenCalledWith({
        baseDir: expect.any(String), // working directory
        binary: "git",
        maxConcurrentProcesses: 1,
      });
    });
  });
});
