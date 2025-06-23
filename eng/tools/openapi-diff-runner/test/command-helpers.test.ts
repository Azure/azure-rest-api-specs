import { describe, it, expect, vi, beforeEach, afterEach } from "vitest";
import { existsSync, mkdirSync, readFileSync, writeFileSync, rmSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  initContext,
  BreakingChangeLabels,
  getSwaggerDiffs,
  buildPrInfo,
  changeBaseBranch,
  logFullOadMessagesList,
  createDummySwagger,
  cleanDummySwagger,
  isSameVersionBreakingType,
  getCreatedDummySwaggerCount,
} from "../src/command-helpers.js";
import { Context } from "../src/types/breaking-change.js";
import { ResultMessageRecord } from "../src/types/message.js";
import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";

// Mock dependencies
vi.mock("node:fs");
vi.mock("node:path");
vi.mock("node:url");
vi.mock("../src/utils/common-utils.js");
vi.mock("../src/utils/oad-message-processor.js");
vi.mock("../src/utils/pull-request.js");
vi.mock("../src/log.js");
vi.mock("@azure-tools/specs-shared/changed-files");

describe("command-helpers", () => {
  const mockExistsSync = vi.mocked(existsSync);
  const mockMkdirSync = vi.mocked(mkdirSync);
  const mockReadFileSync = vi.mocked(readFileSync);
  const mockWriteFileSync = vi.mocked(writeFileSync);
  const mockRmSync = vi.mocked(rmSync);
  const mockPath = vi.mocked(path);
  const mockFileURLToPath = vi.mocked(fileURLToPath);
  const mockGetChangedFilesStatuses = vi.mocked(getChangedFilesStatuses);

  beforeEach(() => {
    vi.clearAllMocks();

    // Setup default mocks
    mockPath.resolve.mockImplementation((...paths) => paths.join("/"));
    mockPath.join.mockImplementation((...paths) => paths.join("/"));
    mockPath.dirname.mockImplementation((p) => p.split("/").slice(0, -1).join("/"));
    mockFileURLToPath.mockReturnValue("/path/to/file.js");

    // Mock console methods to avoid test output noise
    vi.spyOn(console, "log").mockImplementation(() => {});
    vi.spyOn(console, "error").mockImplementation(() => {});

    // Clear BreakingChangeLabels set
    BreakingChangeLabels.clear();

    // Clean up any dummy swagger files between tests
    cleanDummySwagger();
  });

  afterEach(() => {
    vi.resetAllMocks();
  });

  describe("initContext", () => {
    beforeEach(() => {
      // Mock process.argv
      vi.stubGlobal("process", {
        ...process,
        argv: ["node", "script.js", "--repo=test/repo", "--number=123"],
      });
    });

    afterEach(() => {
      vi.unstubAllGlobals();
    });

    it("should initialize context with default values", async () => {
      const { getArgumentValue } = await import("../src/utils/common-utils.js");
      const { createOadMessageProcessor } = await import("../src/utils/oad-message-processor.js");

      vi.mocked(getArgumentValue).mockImplementation((_args, key, defaultValue) => {
        const argMap: Record<string, string> = {
          "--repo": "test/repo",
          "--number": "123",
          "--rt": "SameVersion",
          "--bb": "main",
          "--hc": "HEAD",
          "--sb": "",
          "--tb": "",
        };
        return argMap[key] || defaultValue || "";
      });

      mockExistsSync.mockReturnValue(false);
      vi.mocked(createOadMessageProcessor).mockReturnValue({
        logFilePath: "/log/path",
        prUrl: "https://github.com/test/repo/pull/123",
        messageCache: [],
      });

      const context = initContext();

      expect(context.repo).toBe("test/repo");
      expect(context.prNumber).toBe("123");
      expect(context.runType).toBe("SameVersion");
      expect(context.baseBranch).toBe("main");
      expect(context.headCommit).toBe("HEAD");
      expect(context.checkName).toBe("Swagger BreakingChange");
      expect(context.prUrl).toBe("https://github.com/test/repo/pull/123");
      expect(mockMkdirSync).toHaveBeenCalledWith(expect.any(String), { recursive: true });
    });

    it("should use custom values when provided", async () => {
      const { getArgumentValue } = await import("../src/utils/common-utils.js");
      const { createOadMessageProcessor } = await import("../src/utils/oad-message-processor.js");

      vi.mocked(getArgumentValue).mockImplementation((_args, key, defaultValue) => {
        const argMap: Record<string, string> = {
          "--repo": "custom/repo",
          "--number": "456",
          "--rt": "CrossVersion",
          "--bb": "develop",
          "--hc": "abc123",
          "--sb": "feature-branch",
          "--tb": "main",
        };
        return argMap[key] || defaultValue || "";
      });

      mockExistsSync.mockReturnValue(true);
      vi.mocked(createOadMessageProcessor).mockReturnValue({
        logFilePath: "/log/path",
        prUrl: "https://github.com/custom/repo/pull/456",
        messageCache: [],
      });

      const context = initContext();

      expect(context.repo).toBe("custom/repo");
      expect(context.prNumber).toBe("456");
      expect(context.runType).toBe("CrossVersion");
      expect(context.baseBranch).toBe("develop");
      expect(context.headCommit).toBe("abc123");
      expect(context.prSourceBranch).toBe("feature-branch");
      expect(context.prTargetBranch).toBe("main");
      expect(context.checkName).toBe("BreakingChange(Cross-Version)");
      expect(mockMkdirSync).not.toHaveBeenCalled();
    });

    it("should create log file folder if it doesn't exist", async () => {
      const { getArgumentValue } = await import("../src/utils/common-utils.js");
      const { createOadMessageProcessor } = await import("../src/utils/oad-message-processor.js");

      vi.mocked(getArgumentValue).mockReturnValue("");
      mockExistsSync.mockReturnValue(false);
      vi.mocked(createOadMessageProcessor).mockReturnValue({
        logFilePath: "/log/path",
        prUrl: "https://github.com/test/repo/pull/123",
        messageCache: [],
      });

      initContext();

      expect(mockMkdirSync).toHaveBeenCalledWith(expect.any(String), { recursive: true });
    });
  });

  describe("BreakingChangeLabels", () => {
    it("should be a Set that can be modified", () => {
      expect(BreakingChangeLabels).toBeInstanceOf(Set);
      expect(BreakingChangeLabels.size).toBe(0);

      BreakingChangeLabels.add("test-label");
      expect(BreakingChangeLabels.has("test-label")).toBe(true);
      expect(BreakingChangeLabels.size).toBe(1);

      BreakingChangeLabels.clear();
      expect(BreakingChangeLabels.size).toBe(0);
    });
  });

  describe("getSwaggerDiffs", () => {
    it("should return changed files successfully", async () => {
      const mockResult = {
        additions: ["file1.json", "file2.json"],
        modifications: ["file3.json"],
        deletions: ["file4.json"],
        renames: [{ from: "old.json", to: "new.json" }],
        total: 4,
      };

      mockGetChangedFilesStatuses.mockResolvedValue(mockResult);

      const result = await getSwaggerDiffs({
        baseCommitish: "main",
        cwd: "/test/path",
        headCommitish: "HEAD",
      });

      expect(result).toEqual(mockResult);
      expect(mockGetChangedFilesStatuses).toHaveBeenCalledWith({
        baseCommitish: "main",
        cwd: "/test/path",
        headCommitish: "HEAD",
      });
    });

    it("should return empty result on error", async () => {
      mockGetChangedFilesStatuses.mockRejectedValue(new Error("Git error"));

      const result = await getSwaggerDiffs();

      expect(result).toEqual({
        additions: [],
        modifications: [],
        deletions: [],
        renames: [],
        total: 0,
      });
      expect(console.error).toHaveBeenCalledWith(
        "Error getting categorized changed files:",
        expect.any(Error),
      );
    });

    it("should use default options when none provided", async () => {
      const mockResult = {
        additions: [],
        modifications: [],
        deletions: [],
        renames: [],
        total: 0,
      };

      mockGetChangedFilesStatuses.mockResolvedValue(mockResult);

      await getSwaggerDiffs();

      expect(mockGetChangedFilesStatuses).toHaveBeenCalledWith({
        baseCommitish: undefined,
        cwd: undefined,
        headCommitish: undefined,
      });
    });
  });

  describe("buildPrInfo", () => {
    it("should build PR info successfully", async () => {
      const { createPullRequestProperties } = await import("../src/utils/pull-request.js");

      const mockContext: Context = {
        localSpecRepoPath: "/path/to/repo",
        workingFolder: "/working",
        logFileFolder: "/logs",
        swaggerDirs: ["specification"],
        baseBranch: "main",
        headCommit: "HEAD",
        runType: "SameVersion",
        checkName: "test",
        repo: "test/repo",
        prNumber: "123",
        prSourceBranch: "feature",
        prTargetBranch: "main",
        logger: {
          logFilePath: "/log/path",
          prUrl: "https://github.com/test/repo/pull/123",
          messageCache: [],
        },
        prUrl: "https://github.com/test/repo/pull/123",
      };

      const mockPrInfo = {
        baseBranch: "main",
        targetBranch: "main",
        sourceBranch: "feature",
        workingDir: "/working/dir",
        currentBranch: "main",
        checkout: vi.fn(),
      };

      vi.mocked(createPullRequestProperties).mockResolvedValue(mockPrInfo);

      await buildPrInfo(mockContext);

      expect(mockContext.prInfo).toBe(mockPrInfo);
      expect(createPullRequestProperties).toHaveBeenCalledWith(mockContext, "same-version");
    });

    it("should use cross-version prefix for CrossVersion run type", async () => {
      const { createPullRequestProperties } = await import("../src/utils/pull-request.js");

      const mockContext: Context = {
        localSpecRepoPath: "/path/to/repo",
        workingFolder: "/working",
        logFileFolder: "/logs",
        swaggerDirs: ["specification"],
        baseBranch: "main",
        headCommit: "HEAD",
        runType: "CrossVersion",
        checkName: "test",
        repo: "test/repo",
        prNumber: "123",
        prSourceBranch: "feature",
        prTargetBranch: "main",
        logger: {
          logFilePath: "/log/path",
          prUrl: "https://github.com/test/repo/pull/123",
          messageCache: [],
        },
        prUrl: "https://github.com/test/repo/pull/123",
      };

      const mockPrInfo = {
        baseBranch: "main",
        targetBranch: "main",
        sourceBranch: "feature",
        workingDir: "/working/dir",
        currentBranch: "main",
        checkout: vi.fn(),
      };

      vi.mocked(createPullRequestProperties).mockResolvedValue(mockPrInfo);

      await buildPrInfo(mockContext);

      expect(createPullRequestProperties).toHaveBeenCalledWith(mockContext, "cross-version");
    });

    it("should throw error when PR info creation fails", async () => {
      const { createPullRequestProperties } = await import("../src/utils/pull-request.js");

      const mockContext: Context = {
        localSpecRepoPath: "/path/to/repo",
        workingFolder: "/working",
        logFileFolder: "/logs",
        swaggerDirs: ["specification"],
        baseBranch: "main",
        headCommit: "HEAD",
        runType: "SameVersion",
        checkName: "test",
        repo: "test/repo",
        prNumber: "123",
        prSourceBranch: "feature",
        prTargetBranch: "main",
        logger: {
          logFilePath: "/log/path",
          prUrl: "https://github.com/test/repo/pull/123",
          messageCache: [],
        },
        prUrl: "https://github.com/test/repo/pull/123",
      };

      vi.mocked(createPullRequestProperties).mockResolvedValue(undefined);

      await expect(buildPrInfo(mockContext)).rejects.toThrow("create PR failed!");
    });

    it("should throw error when PR info has no target branch", async () => {
      const { createPullRequestProperties } = await import("../src/utils/pull-request.js");

      const mockContext: Context = {
        localSpecRepoPath: "/path/to/repo",
        workingFolder: "/working",
        logFileFolder: "/logs",
        swaggerDirs: ["specification"],
        baseBranch: "main",
        headCommit: "HEAD",
        runType: "SameVersion",
        checkName: "test",
        repo: "test/repo",
        prNumber: "123",
        prSourceBranch: "feature",
        prTargetBranch: "main",
        logger: {
          logFilePath: "/log/path",
          prUrl: "https://github.com/test/repo/pull/123",
          messageCache: [],
        },
        prUrl: "https://github.com/test/repo/pull/123",
      };

      const mockPrInfo = {
        baseBranch: "main",
        targetBranch: "", // Empty target branch
        sourceBranch: "feature",
        workingDir: "/working/dir",
        currentBranch: "main",
        checkout: vi.fn(),
      };

      vi.mocked(createPullRequestProperties).mockResolvedValue(mockPrInfo);

      await expect(buildPrInfo(mockContext)).rejects.toThrow("create PR failed!");
    });
  });

  describe("changeBaseBranch", () => {
    it("should change base branch when different from target and not whitelisted", async () => {
      const { logMessage } = await import("../src/log.js");

      const mockContext: Context = {
        localSpecRepoPath: "/path/to/repo",
        workingFolder: "/working",
        logFileFolder: "/logs",
        swaggerDirs: ["specification"],
        baseBranch: "main",
        headCommit: "HEAD",
        runType: "SameVersion",
        checkName: "test",
        repo: "test/repo",
        prNumber: "123",
        prSourceBranch: "feature",
        prTargetBranch: "develop", // Different from baseBranch
        logger: {
          logFilePath: "/log/path",
          prUrl: "https://github.com/test/repo/pull/123",
          messageCache: [],
        },
        prUrl: "https://github.com/test/repo/pull/123",
        prInfo: {
          baseBranch: "develop",
          targetBranch: "develop",
          sourceBranch: "feature",
          workingDir: "/working/dir",
          currentBranch: "develop",
          checkout: vi.fn(),
        },
      };

      changeBaseBranch(mockContext);

      expect(mockContext.prInfo!.baseBranch).toBe("main");
      expect(logMessage).toHaveBeenCalledWith("switch target branch to main");
    });

    it("should not change base branch when same as target", () => {
      const mockContext: Context = {
        localSpecRepoPath: "/path/to/repo",
        workingFolder: "/working",
        logFileFolder: "/logs",
        swaggerDirs: ["specification"],
        baseBranch: "main",
        headCommit: "HEAD",
        runType: "SameVersion",
        checkName: "test",
        repo: "test/repo",
        prNumber: "123",
        prSourceBranch: "feature",
        prTargetBranch: "main", // Same as baseBranch
        logger: {
          logFilePath: "/log/path",
          prUrl: "https://github.com/test/repo/pull/123",
          messageCache: [],
        },
        prUrl: "https://github.com/test/repo/pull/123",
        prInfo: {
          baseBranch: "main",
          targetBranch: "main",
          sourceBranch: "feature",
          workingDir: "/working/dir",
          currentBranch: "main",
          checkout: vi.fn(),
        },
      };

      const originalBaseBranch = mockContext.prInfo!.baseBranch;
      changeBaseBranch(mockContext);

      expect(mockContext.prInfo!.baseBranch).toBe(originalBaseBranch);
    });

    it("should not change base branch for whitelisted branches", () => {
      const mockContext: Context = {
        localSpecRepoPath: "/path/to/repo",
        workingFolder: "/working",
        logFileFolder: "/logs",
        swaggerDirs: ["specification"],
        baseBranch: "main",
        headCommit: "HEAD",
        runType: "SameVersion",
        checkName: "test",
        repo: "test/repo",
        prNumber: "123",
        prSourceBranch: "feature",
        prTargetBranch: "ARMCoreRPDev", // Whitelisted branch
        logger: {
          logFilePath: "/log/path",
          prUrl: "https://github.com/test/repo/pull/123",
          messageCache: [],
        },
        prUrl: "https://github.com/test/repo/pull/123",
        prInfo: {
          baseBranch: "ARMCoreRPDev",
          targetBranch: "ARMCoreRPDev",
          sourceBranch: "feature",
          workingDir: "/working/dir",
          currentBranch: "ARMCoreRPDev",
          checkout: vi.fn(),
        },
      };

      const originalBaseBranch = mockContext.prInfo!.baseBranch;
      changeBaseBranch(mockContext);

      expect(mockContext.prInfo!.baseBranch).toBe(originalBaseBranch);
    });

    it("should change base branch for CrossVersion run type when different from target", async () => {
      const { logMessage } = await import("../src/log.js");

      const mockContext: Context = {
        localSpecRepoPath: "/path/to/repo",
        workingFolder: "/working",
        logFileFolder: "/logs",
        swaggerDirs: ["specification"],
        baseBranch: "main",
        headCommit: "HEAD",
        runType: "CrossVersion", // CrossVersion type
        checkName: "test",
        repo: "test/repo",
        prNumber: "123",
        prSourceBranch: "feature",
        prTargetBranch: "develop", // Different from baseBranch
        logger: {
          logFilePath: "/log/path",
          prUrl: "https://github.com/test/repo/pull/123",
          messageCache: [],
        },
        prUrl: "https://github.com/test/repo/pull/123",
        prInfo: {
          baseBranch: "develop",
          targetBranch: "develop",
          sourceBranch: "feature",
          workingDir: "/working/dir",
          currentBranch: "develop",
          checkout: vi.fn(),
        },
      };

      changeBaseBranch(mockContext);

      // CrossVersion also changes base branch when different from target
      expect(mockContext.prInfo!.baseBranch).toBe("main");
      expect(logMessage).toHaveBeenCalledWith("switch target branch to main");
    });
  });

  describe("logFullOadMessagesList", () => {
    it("should log all messages individually", async () => {
      const { logMessage } = await import("../src/log.js");

      const msgs: ResultMessageRecord[] = [
        {
          type: "Result",
          level: "Error",
          message: "Test error message",
          time: new Date("2023-01-01"),
          paths: [],
        },
        {
          type: "Result",
          level: "Warning",
          message: "Test warning message",
          time: new Date("2023-01-02"),
          paths: [],
        },
      ];

      logFullOadMessagesList(msgs);

      expect(logMessage).toHaveBeenCalledWith("---- Full list of messages ----");
      expect(logMessage).toHaveBeenCalledWith("[");
      expect(logMessage).toHaveBeenCalledWith(JSON.stringify(msgs[0], null, 4) + ",");
      expect(logMessage).toHaveBeenCalledWith(JSON.stringify(msgs[1], null, 4) + ",");
      expect(logMessage).toHaveBeenCalledWith("]");
      expect(logMessage).toHaveBeenCalledWith("---- End of full list of messages ----");
    });

    it("should handle empty message list", async () => {
      const { logMessage } = await import("../src/log.js");

      logFullOadMessagesList([]);

      expect(logMessage).toHaveBeenCalledWith("---- Full list of messages ----");
      expect(logMessage).toHaveBeenCalledWith("[");
      expect(logMessage).toHaveBeenCalledWith("]");
      expect(logMessage).toHaveBeenCalledWith("---- End of full list of messages ----");
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
});
