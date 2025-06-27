import { describe, it, expect, vi, beforeEach, afterEach } from "vitest";
import { existsSync, mkdirSync } from "node:fs";
import path from "node:path";
import { simpleGit } from "simple-git";
import { createPullRequestProperties } from "../../src/utils/pull-request.js";
import { Context } from "../../src/types/breaking-change.js";

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
    mockPath.resolve.mockImplementation((...paths) => paths.join("/"));
    mockPath.join.mockImplementation((...paths) => paths.join("/"));

    // Mock console.log to avoid test output noise
    vi.spyOn(console, "log").mockImplementation(() => {});
  });

  afterEach(() => {
    vi.resetAllMocks();
  });

  describe("createPullRequestProperties", () => {
    const createMockContext = (overrides: Partial<Context> = {}): Context => ({
      localSpecRepoPath: "/path/to/spec/repo",
      workingFolder: "/path/to/working/folder",
      logFileFolder: "/path/to/log/folder",
      swaggerDirs: ["specification/service/path"],
      baseBranch: "main",
      headCommit: "abc123",
      runType: "SameVersion",
      checkName: "BreakingChange",
      repo: "owner/repo",
      prNumber: "123",
      prSourceBranch: "feature-branch",
      prTargetBranch: "main",
      oadMessageProcessorContext: {
        logFilePath: "/path/to/log/file.log",
        prUrl: "https://github.com/owner/repo/pull/123",
        messageCache: [],
      },
      prUrl: "https://github.com/owner/repo/pull/123",
      ...overrides,
    });

    it("should return undefined when baseBranch is undefined", async () => {
      const context = createMockContext({ baseBranch: undefined });

      const result = await createPullRequestProperties(context, "test-prefix");

      expect(result).toBeUndefined();
    });

    it("should create pull request properties successfully", async () => {
      const context = createMockContext();
      const prefix = "test-prefix";

      // Mock branch listing
      mockGitRepo.branch.mockResolvedValue({
        all: ["main", "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8"],
      });

      // Mock directory operations
      mockExistsSync.mockReturnValue(false);
      mockPath.resolve.mockReturnValue("/resolved/working/dir");

      // Mock git operations
      mockGitRepo.getRemotes.mockResolvedValue([]);
      mockGitRepo.init.mockResolvedValue(undefined);
      mockGitRepo.addRemote.mockResolvedValue(undefined);
      mockGitRepo.pull.mockResolvedValue(undefined);
      mockGitRepo.fetch.mockResolvedValue(undefined);
      mockGitRepo.checkout.mockResolvedValue(undefined);

      const result = await createPullRequestProperties(context, prefix);

      expect(result).toBeDefined();
      expect(result!.baseBranch).toBe("main");
      expect(result!.targetBranch).toBe("main");
      expect(result!.sourceBranch).toBe("source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8");
      expect(result!.workingDir).toBe("/resolved/working/dir");
      expect(result!.currentBranch).toBe("main");
      expect(typeof result!.checkout).toBe("function");
    });

    it("should create source branch if it doesn't exist", async () => {
      const context = createMockContext();

      mockGitRepo.branch.mockResolvedValue({
        all: ["main"], // Source branch doesn't exist
      });
      mockExistsSync.mockReturnValue(true);
      mockGitRepo.getRemotes.mockResolvedValue([{ name: "origin" }]);

      await createPullRequestProperties(context, "test-prefix");

      expect(mockGitRepo.branch).toHaveBeenCalledWith([
        "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8",
      ]);
    });

    it("should create base branch if it doesn't exist and skipInitializeBase is false", async () => {
      const context = createMockContext({ baseBranch: "develop" });

      mockGitRepo.branch.mockResolvedValue({
        all: ["main", "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8"], // Base branch doesn't exist
      });
      mockExistsSync.mockReturnValue(true);
      mockGitRepo.getRemotes.mockResolvedValue([{ name: "origin" }]);

      await createPullRequestProperties(context, "test-prefix", false);

      expect(mockGitRepo.branch).toHaveBeenCalledWith(["develop", "remotes/origin/develop"]);
    });

    it("should not create base branch if skipInitializeBase is true", async () => {
      const context = createMockContext({ baseBranch: "develop" });

      mockGitRepo.branch.mockResolvedValue({
        all: ["main", "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8"],
      });
      mockExistsSync.mockReturnValue(true);
      mockGitRepo.getRemotes.mockResolvedValue([{ name: "origin" }]);

      await createPullRequestProperties(context, "test-prefix", true);

      expect(mockGitRepo.branch).not.toHaveBeenCalledWith(["develop", "remotes/origin/develop"]);
      expect(mockGitRepo.fetch).not.toHaveBeenCalledWith("origin", "develop");
    });

    it("should create target branch if it doesn't exist", async () => {
      const context = createMockContext({ prTargetBranch: "feature-branch" });

      mockGitRepo.branch.mockResolvedValue({
        all: ["main", "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8"], // Target branch doesn't exist
      });
      mockExistsSync.mockReturnValue(true);
      mockGitRepo.getRemotes.mockResolvedValue([{ name: "origin" }]);

      await createPullRequestProperties(context, "test-prefix");

      expect(mockGitRepo.branch).toHaveBeenCalledWith([
        "feature-branch",
        "remotes/origin/feature-branch",
      ]);
    });

    it("should create working directory if it doesn't exist", async () => {
      const context = createMockContext();

      mockGitRepo.branch.mockResolvedValue({
        all: ["main", "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8"],
      });
      mockExistsSync.mockReturnValue(false); // Directory doesn't exist
      mockGitRepo.getRemotes.mockResolvedValue([{ name: "origin" }]);

      await createPullRequestProperties(context, "test-prefix");

      expect(mockMkdirSync).toHaveBeenCalledWith(expect.any(String));
    });

    it("should add origin remote if it doesn't exist", async () => {
      const context = createMockContext();

      mockGitRepo.branch.mockResolvedValue({
        all: ["main", "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8"],
      });
      mockExistsSync.mockReturnValue(true);
      mockGitRepo.getRemotes.mockResolvedValue([]); // No remotes exist

      await createPullRequestProperties(context, "test-prefix");

      expect(mockGitRepo.addRemote).toHaveBeenCalledWith("origin", context.localSpecRepoPath);
    });

    it("should not add origin remote if it already exists", async () => {
      const context = createMockContext();

      mockGitRepo.branch.mockResolvedValue({
        all: ["main", "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8"],
      });
      mockExistsSync.mockReturnValue(true);
      mockGitRepo.getRemotes.mockResolvedValue([{ name: "origin" }]); // Origin exists

      await createPullRequestProperties(context, "test-prefix");

      expect(mockGitRepo.addRemote).not.toHaveBeenCalled();
    });

    it("should handle getRemotes error and try to add origin anyway", async () => {
      const context = createMockContext();

      mockGitRepo.branch.mockResolvedValue({
        all: ["main", "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8"],
      });
      mockExistsSync.mockReturnValue(true);
      mockGitRepo.getRemotes.mockRejectedValue(new Error("Failed to get remotes"));
      mockGitRepo.addRemote.mockResolvedValue(undefined);

      await createPullRequestProperties(context, "test-prefix");

      expect(mockGitRepo.addRemote).toHaveBeenCalledWith("origin", context.localSpecRepoPath);
    });

    it("should ignore 'remote origin already exists' error when adding remote", async () => {
      const context = createMockContext();

      mockGitRepo.branch.mockResolvedValue({
        all: ["main", "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8"],
      });
      mockExistsSync.mockReturnValue(true);
      mockGitRepo.getRemotes.mockRejectedValue(new Error("Failed to get remotes"));
      mockGitRepo.addRemote.mockRejectedValue(new Error("fatal: remote origin already exists"));

      // Should not throw an error
      await expect(createPullRequestProperties(context, "test-prefix")).resolves.toBeDefined();
    });

    it("should throw error if addRemote fails with other error", async () => {
      const context = createMockContext();

      mockGitRepo.branch.mockResolvedValue({
        all: ["main", "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8"],
      });
      mockExistsSync.mockReturnValue(true);
      mockGitRepo.getRemotes.mockRejectedValue(new Error("Failed to get remotes"));
      mockGitRepo.addRemote.mockRejectedValue(new Error("Some other error"));

      await expect(createPullRequestProperties(context, "test-prefix")).rejects.toThrow(
        "Some other error",
      );
    });

    it("should perform git operations in correct order", async () => {
      const context = createMockContext();

      mockGitRepo.branch.mockResolvedValue({
        all: ["main", "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8"],
      });
      mockExistsSync.mockReturnValue(true);
      mockGitRepo.getRemotes.mockResolvedValue([{ name: "origin" }]);

      await createPullRequestProperties(context, "test-prefix");

      // Verify order of operations
      expect(mockGitRepo.init).toHaveBeenCalled();
      expect(mockGitRepo.pull).toHaveBeenCalledWith("origin", "main");
      expect(mockGitRepo.fetch).toHaveBeenCalledWith(
        "origin",
        "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8",
      );
      expect(mockGitRepo.fetch).toHaveBeenCalledWith("origin", "main");
      expect(mockGitRepo.checkout).toHaveBeenCalledWith("main");
    });

    describe("checkout function", () => {
      it("should checkout to different branch", async () => {
        const context = createMockContext();

        mockGitRepo.branch.mockResolvedValue({
          all: ["main", "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8"],
        });
        mockExistsSync.mockReturnValue(true);
        mockGitRepo.getRemotes.mockResolvedValue([{ name: "origin" }]);

        const result = await createPullRequestProperties(context, "test-prefix");

        expect(result).toBeDefined();
        expect(result!.currentBranch).toBe("main");

        // Test checkout function
        await result!.checkout("feature-branch");

        expect(mockGitRepo.checkout).toHaveBeenCalledWith(["feature-branch"]);
        expect(result!.currentBranch).toBe("feature-branch");
      });

      it("should not checkout if already on the target branch", async () => {
        const context = createMockContext();

        mockGitRepo.branch.mockResolvedValue({
          all: ["main", "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8"],
        });
        mockExistsSync.mockReturnValue(true);
        mockGitRepo.getRemotes.mockResolvedValue([{ name: "origin" }]);

        const result = await createPullRequestProperties(context, "test-prefix");

        expect(result).toBeDefined();
        expect(result!.currentBranch).toBe("main");

        // Clear previous checkout calls
        mockGitRepo.checkout.mockClear();

        // Test checkout to same branch
        await result!.checkout("main");

        expect(mockGitRepo.checkout).not.toHaveBeenCalled();
        expect(result!.currentBranch).toBe("main");
      });

      it("should update currentBranch after successful checkout", async () => {
        const context = createMockContext();

        mockGitRepo.branch.mockResolvedValue({
          all: ["main", "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8"],
        });
        mockExistsSync.mockReturnValue(true);
        mockGitRepo.getRemotes.mockResolvedValue([{ name: "origin" }]);

        const result = await createPullRequestProperties(context, "test-prefix");

        expect(result).toBeDefined();
        expect(result!.currentBranch).toBe("main");

        // Test multiple checkouts
        await result!.checkout("feature-branch");
        expect(result!.currentBranch).toBe("feature-branch");

        await result!.checkout("develop");
        expect(result!.currentBranch).toBe("develop");

        // Verify checkout was called for each different branch
        expect(mockGitRepo.checkout).toHaveBeenCalledTimes(3); // 1 initial + 2 from tests
      });
    });

    it("should use correct working directory path", async () => {
      const context = createMockContext();
      const prefix = "custom-prefix";

      mockGitRepo.branch.mockResolvedValue({
        all: ["main", "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8"],
      });
      mockExistsSync.mockReturnValue(true);
      mockGitRepo.getRemotes.mockResolvedValue([{ name: "origin" }]);

      // Mock path operations
      vi.spyOn(process, "cwd").mockReturnValue("/current/working/dir");
      mockPath.join.mockReturnValue("../custom-prefix-c93b354fd9c14905bb574a8834c4d69b");
      mockPath.resolve.mockReturnValue("/resolved/working/dir");

      const result = await createPullRequestProperties(context, prefix);

      expect(mockPath.join).toHaveBeenCalledWith(
        "/current/working/dir",
        "..",
        "custom-prefix-c93b354fd9c14905bb574a8834c4d69b",
      );
      expect(mockPath.resolve).toHaveBeenCalledWith(
        "../custom-prefix-c93b354fd9c14905bb574a8834c4d69b",
      );
      expect(result!.workingDir).toBe("/resolved/working/dir");
    });

    it("should use correct git options", async () => {
      const context = createMockContext();

      mockGitRepo.branch.mockResolvedValue({
        all: ["main", "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8"],
      });
      mockExistsSync.mockReturnValue(true);
      mockGitRepo.getRemotes.mockResolvedValue([{ name: "origin" }]);

      await createPullRequestProperties(context, "test-prefix");

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
