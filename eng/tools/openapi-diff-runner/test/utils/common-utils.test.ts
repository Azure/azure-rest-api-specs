import { readFile } from "node:fs/promises";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { Context } from "../../src/types/breaking-change.js";
import {
  blobHref,
  branchHref,
  checkPrTargetsProductionBranch,
  convertRawErrorToUnifiedMsg,
  cutoffMsg,
  getArgumentValue,
  getGithubStyleFilePath,
  getRelativeSwaggerPathToRepo,
  getVersionFromInputFile,
  processOadRuntimeErrorMessage,
  sourceBranchHref,
  specificBranchHref,
  specIsPreview,
  targetBranchHref,
  targetHref,
} from "../../src/utils/common-utils.js";

// Mock node:fs/promises module for async file operations
vi.mock("node:fs/promises", async (importOriginal) => {
  const actual = await importOriginal<typeof import("node:fs/promises")>();
  return {
    ...actual,
    readFile: vi.fn(),
  };
});

describe("common-utils", () => {
  let originalEnv: NodeJS.ProcessEnv;

  // Common test constants
  const TEST_CONSTANTS = {
    REPO: "owner/repo",
    COMMIT: "abc123",
    BRANCH: "main",
    FEATURE_BRANCH: "feature-branch",
    FILE_PATH: "test-file.json",
    SPEC_FILE: "specification/test.json",
    SPEC_PATH: "/home/user/specification/test.json",
    STORAGE_SPEC_PATH:
      "/home/user/azure-rest-api-specs/specification/storage/resource-manager/test.json",
    GITHUB_URL_BASE: "https://github.com/owner/repo/blob",
    VERSION: "2021-01-01",
    PREVIEW_VERSION: "2021-01-01-preview",
    DATA_PLANE_PATH:
      "specification/storage/data-plane/Microsoft.Storage/stable/2021-01-01/storage.json",
    DATA_PLANE_PREVIEW_PATH:
      "specification/storage/data-plane/Microsoft.Storage/preview/2021-01-01-preview/storage.json",
    RESOURCE_MANAGER_PATH:
      "specification/storage/resource-manager/Microsoft.Storage/2021-01-01/storage.json",
    PREVIEW_SPEC_PATH:
      "specification/maps/data-plane/Creator/preview/2022-09-01-preview/wayfind.json",
    STABLE_SPEC_PATH: "specification/maps/data-plane/Creator/stable/2022-09-01/wayfind.json",
  };

  // Helper function to create file position
  const createFilePosition = (line: number, column: number) => ({ line, column });

  // Helper function to create expected GitHub URL
  const createGithubUrl = (
    repo: string,
    branch: string,
    file: string,
    position?: { line: number; column: number },
  ) => {
    const baseUrl = `https://github.com/${repo}/blob/${branch}/${file}`;
    return position ? `${baseUrl}#L${position.line}:${position.column}` : baseUrl;
  };

  // Helper function to setup GitHub environment
  const setupGithubEnv = (repository = TEST_CONSTANTS.REPO, baseRef = TEST_CONSTANTS.BRANCH) => {
    process.env.GITHUB_REPOSITORY = repository;
    process.env.GITHUB_BASE_REF = baseRef;
    vi.spyOn(console, "log").mockImplementation(() => {});
  };

  // Helper function to setup GitHub Actions environment
  const setupGithubActionsEnv = (
    repository = TEST_CONSTANTS.REPO,
    commit = TEST_CONSTANTS.COMMIT,
  ) => {
    process.env.GITHUB_ACTIONS = "true";
    process.env.GITHUB_HEAD_REPOSITORY = repository;
    process.env.GITHUB_SHA = commit;
  };

  // Mock context for tests that require it
  const mockContext: Context = {
    localSpecRepoPath: "/path/to/repo",
    workingFolder: "/working",
    logFileFolder: "/logs",
    swaggerDirs: ["specification"],
    baseBranch: "main",
    headCommit: "abc123",
    runType: "SameVersion" as any,
    checkName: "test",
    targetRepo: "owner/repo",
    sourceRepo: "owner/repo",
    prNumber: "123",
    prSourceBranch: "feature",
    prTargetBranch: "main",
    oadMessageProcessorContext: {
      logFilePath: "/log/path",
      prUrl: "https://github.com/owner/repo/pull/123",
      messageCache: [],
    },
    prUrl: "https://github.com/owner/repo/pull/123",
  };

  beforeEach(() => {
    originalEnv = { ...process.env };
    vi.clearAllMocks();
  });

  afterEach(() => {
    process.env = originalEnv;
  });

  describe("blobHref", () => {
    it("should return GitHub blob URL", () => {
      const result = blobHref(TEST_CONSTANTS.REPO, TEST_CONSTANTS.COMMIT, TEST_CONSTANTS.FILE_PATH);
      const expected = createGithubUrl(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.COMMIT,
        TEST_CONSTANTS.FILE_PATH,
      );
      expect(result).toBe(expected);
    });

    it("should handle empty file path", () => {
      const result = blobHref(TEST_CONSTANTS.REPO, TEST_CONSTANTS.COMMIT, "");
      const expected = createGithubUrl(TEST_CONSTANTS.REPO, TEST_CONSTANTS.COMMIT, "");
      expect(result).toBe(expected);
    });
  });

  describe("targetHref", () => {
    beforeEach(() => {
      setupGithubEnv();
    });

    it("should return GitHub URL for valid file", () => {
      const result = targetHref(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.BRANCH,
        TEST_CONSTANTS.SPEC_FILE,
      );
      const expected = createGithubUrl(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.BRANCH,
        TEST_CONSTANTS.SPEC_FILE,
      );
      expect(result).toBe(expected);
    });

    it("should return empty string for empty file", () => {
      const result = targetHref(TEST_CONSTANTS.REPO, TEST_CONSTANTS.BRANCH, "");
      expect(result).toBe("");
    });
  });

  describe("branchHref", () => {
    beforeEach(() => {
      setupGithubEnv();
    });

    it("should return GitHub URL with specified branch", () => {
      const result = branchHref(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.FILE_PATH,
        TEST_CONSTANTS.FEATURE_BRANCH,
      );
      const expected = createGithubUrl(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.FEATURE_BRANCH,
        TEST_CONSTANTS.FILE_PATH,
      );
      expect(result).toBe(expected);
    });

    it("should use main as default branch", () => {
      const result = branchHref(TEST_CONSTANTS.REPO, TEST_CONSTANTS.FILE_PATH);
      const expected = createGithubUrl(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.BRANCH,
        TEST_CONSTANTS.FILE_PATH,
      );
      expect(result).toBe(expected);
    });

    it("should return empty string for empty file", () => {
      const result = branchHref(TEST_CONSTANTS.REPO, "");
      expect(result).toBe("");
    });
  });

  describe("getGithubStyleFilePath", () => {
    it("should format file path with line and column", () => {
      const position = createFilePosition(42, 5);
      const result = getGithubStyleFilePath("test.json", position);
      expect(result).toBe("test.json#L42:5");
    });

    it("should format file path with colon replacement", () => {
      const result = getGithubStyleFilePath("test.json:42:5");
      expect(result).toBe("test.json#L42:5");
    });

    it("should handle file path without FilePosition", () => {
      const result = getGithubStyleFilePath("test.json");
      expect(result).toBe("test.json");
    });
  });

  describe("getRelativeSwaggerPathToRepo", () => {
    it("should extract path from specification directory", () => {
      const result = getRelativeSwaggerPathToRepo(TEST_CONSTANTS.STORAGE_SPEC_PATH);
      expect(result).toBe("specification/storage/resource-manager/test.json");
    });

    it("should use BUILD_SOURCEDIRECTORY when pattern not found", () => {
      process.env.BUILD_SOURCEDIRECTORY = "/home/user/azure-rest-api-specs/";
      const filePath = "/home/user/azure-rest-api-specs/other/test.json";
      const result = getRelativeSwaggerPathToRepo(filePath);
      expect(result).toBe("other/test.json");
    });

    it("should handle custom patterns", () => {
      const filePath = "/home/user/azure-rest-api-specs/custom/api/test.json";
      const result = getRelativeSwaggerPathToRepo(filePath, ["custom"]);
      expect(result).toBe("custom/api/test.json");
    });
  });

  describe("getVersionFromInputFile", () => {
    beforeEach(() => {
      vi.mocked(readFile).mockReset();
    });

    it("should extract version from data-plane path", async () => {
      const result = await getVersionFromInputFile(TEST_CONSTANTS.DATA_PLANE_PATH);
      expect(result).toBe(TEST_CONSTANTS.VERSION);
    });

    it("should extract version with preview from data-plane path", async () => {
      const result = await getVersionFromInputFile(TEST_CONSTANTS.DATA_PLANE_PREVIEW_PATH, true);
      expect(result).toBe(TEST_CONSTANTS.PREVIEW_VERSION);
    });

    it("should extract version from resource-manager path", async () => {
      const result = await getVersionFromInputFile(TEST_CONSTANTS.RESOURCE_MANAGER_PATH);
      expect(result).toBe(TEST_CONSTANTS.VERSION);
    });

    it("should throw error when no version found in path", async () => {
      const mockFileContent = JSON.stringify({
        info: {
          title: "Test API",
        },
      });

      vi.mocked(readFile).mockResolvedValue(mockFileContent);

      await expect(getVersionFromInputFile("test.json")).rejects.toThrow(
        "Version not found in file: test.json",
      );
    });

    it("should throw error when no valid API version found", async () => {
      const mockFileContent = JSON.stringify({
        info: {
          title: "Test API",
        },
      });

      vi.mocked(readFile).mockResolvedValue(mockFileContent);

      await expect(getVersionFromInputFile("invalid/path.json")).rejects.toThrow(
        "Version not found in file: invalid/path.json",
      );
    });

    it("should extract version from file content when path regex fails", async () => {
      const filePath = "some/custom/path/spec.json";
      const mockFileContent = JSON.stringify({
        info: {
          version: "2023-05-01",
        },
      });

      vi.mocked(readFile).mockResolvedValue(mockFileContent);

      const result = await getVersionFromInputFile(filePath);
      expect(result).toBe("2023-05-01");
      expect(vi.mocked(readFile)).toHaveBeenCalledWith(filePath, "utf8");
    });

    it("should extract preview version from file content when includePreview is true", async () => {
      const filePath = "some/custom/path/spec.json";
      const mockFileContent = JSON.stringify({
        info: {
          version: "2023-05-01-preview",
        },
      });

      vi.mocked(readFile).mockResolvedValue(mockFileContent);

      const result = await getVersionFromInputFile(filePath, true);
      expect(result).toBe("2023-05-01-preview");
      expect(vi.mocked(readFile)).toHaveBeenCalledWith(filePath, "utf8");
    });

    it("should throw error when file content has no version", async () => {
      const filePath = "some/custom/path/spec.json";
      const mockFileContent = JSON.stringify({
        info: {
          title: "Test API",
        },
      });

      vi.mocked(readFile).mockResolvedValue(mockFileContent);

      await expect(getVersionFromInputFile(filePath)).rejects.toThrow(
        "Version not found in file: some/custom/path/spec.json",
      );
    });

    it("should throw error when file content is invalid JSON", async () => {
      const filePath = "some/custom/path/spec.json";
      const mockFileContent = "invalid json content";

      vi.mocked(readFile).mockResolvedValue(mockFileContent);

      await expect(getVersionFromInputFile(filePath)).rejects.toThrow(
        "Failed to read version from file:some/custom/path/spec.json",
      );
    });

    it("should throw error when file read fails", async () => {
      const filePath = "some/custom/path/spec.json";

      vi.mocked(readFile).mockRejectedValue(new Error("File read error"));

      await expect(getVersionFromInputFile(filePath)).rejects.toThrow(
        "Failed to read version from file:some/custom/path/spec.json",
      );
    });
  });

  describe("getArgumentValue", () => {
    it("should return argument value when flag exists", () => {
      const args = ["--input", "test.json", "--output", "result.json"];
      const result = getArgumentValue(args, "--input", "default.json");
      expect(result).toBe("test.json");
    });

    it("should return default value when flag not found", () => {
      const args = ["--output", "result.json"];
      const result = getArgumentValue(args, "--input", "default.json");
      expect(result).toBe("default.json");
    });

    it("should return default value when flag is last argument", () => {
      const args = ["--output", "result.json", "--input"];
      const result = getArgumentValue(args, "--input", "default.json");
      expect(result).toBe("default.json");
    });
  });

  describe("cutoffMsg", () => {
    it("should return original message when within size limit", () => {
      const msg = "short message";
      const result = cutoffMsg(msg, 1024);
      expect(result).toBe("short message");
    });

    it("should truncate message when exceeding size limit", () => {
      const msg = "a".repeat(2000);
      const result = cutoffMsg(msg, 1024);
      expect(result).toBe("a".repeat(1024));
    });

    it("should return empty string for undefined message", () => {
      const result = cutoffMsg(undefined);
      expect(result).toBe("");
    });

    it("should use default size of 1024", () => {
      const msg = "a".repeat(2000);
      const result = cutoffMsg(msg);
      expect(result).toBe("a".repeat(1024));
    });
  });

  describe("processOadRuntimeErrorMessage", () => {
    it("should process AutoRest runtime error", () => {
      const message =
        'Command failed: node "/path/to/autorest/dist/app.js" --v2\\nERROR: Schema violation\\nFATAL: Error occurred';
      const result = processOadRuntimeErrorMessage(message, 500);

      expect(result).toContain("Breaking change detector (OAD) invoked AutoRest");
      expect(result).toContain("1: Command failed:");
      expect(result).toContain("ERROR: Schema violation");
      expect(result).toContain("<br/>");
    });

    it("should use cutoffMsg for non-AutoRest errors", () => {
      const message = "Some other error message";
      const result = processOadRuntimeErrorMessage(message, 500);
      expect(result).toBe("Some other error message");
    });

    it("should handle empty lines in AutoRest error", () => {
      const message =
        'Command failed: node "/path/to/autorest/dist/app.js"\n\nERROR: Test\n\nFATAL: Error';
      const result = processOadRuntimeErrorMessage(message, 500);

      expect(result).toContain("1: Command failed:");
      expect(result).toContain("ERROR: Test");
      expect(result).toContain("FATAL: Error");
    });

    it("should respect stack trace max length", () => {
      const lines = Array.from({ length: 10 }, (_, i) => `Line ${i + 1}`);
      const message = `Command failed: node "/path/to/autorest/dist/app.js"\n${lines.join("\n")}`;
      const result = processOadRuntimeErrorMessage(message, 3);

      expect(result).toContain("1: Command failed:");
      expect(result).toContain("2: Line 1");
      expect(result).toContain("3: Line 2");
      // Should not contain the 4th line since max length is 3
      expect(result).not.toContain("4:");
    });
  });

  describe("specIsPreview", () => {
    it("should return true for preview spec paths", () => {
      const result = specIsPreview(TEST_CONSTANTS.PREVIEW_SPEC_PATH);
      expect(result).toBe(true);
    });

    it("should return false for stable spec paths", () => {
      const result = specIsPreview(TEST_CONSTANTS.STABLE_SPEC_PATH);
      expect(result).toBe(false);
    });

    it("should return false when both preview and stable are in path", () => {
      const specPath =
        "specification/maps/data-plane/Creator/stable/2022-09-01/preview-example.json";
      const result = specIsPreview(specPath);
      expect(result).toBe(false);
    });

    it("should return false for paths without preview", () => {
      const specPath = "specification/maps/data-plane/Creator/2022-09-01/wayfind.json";
      const result = specIsPreview(specPath);
      expect(result).toBe(false);
    });
  });

  describe("sourceBranchHref", () => {
    beforeEach(() => {
      setupGithubActionsEnv();
    });

    it("should return source branch href with file position", () => {
      const position = createFilePosition(10, 5);
      const result = sourceBranchHref(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.COMMIT,
        TEST_CONSTANTS.SPEC_PATH,
        position,
      );
      const expected = createGithubUrl(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.COMMIT,
        TEST_CONSTANTS.SPEC_FILE,
        position,
      );
      expect(result).toContain(expected);
    });

    it("should return source branch href without file position", () => {
      const result = sourceBranchHref(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.COMMIT,
        TEST_CONSTANTS.SPEC_PATH,
      );
      const expected = createGithubUrl(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.COMMIT,
        TEST_CONSTANTS.SPEC_FILE,
      );
      expect(result).toContain(expected);
    });
  });

  describe("targetBranchHref", () => {
    beforeEach(() => {
      setupGithubEnv();
    });

    it("should return target branch href with file position", () => {
      const position = createFilePosition(20, 3);
      const result = targetBranchHref(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.BRANCH,
        TEST_CONSTANTS.SPEC_PATH,
        position,
      );
      const expected = createGithubUrl(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.BRANCH,
        TEST_CONSTANTS.SPEC_FILE,
        position,
      );
      expect(result).toBe(expected);
    });

    it("should return target branch href without file position", () => {
      const result = targetBranchHref(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.BRANCH,
        TEST_CONSTANTS.SPEC_PATH,
      );
      const expected = createGithubUrl(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.BRANCH,
        TEST_CONSTANTS.SPEC_FILE,
      );
      expect(result).toBe(expected);
    });
  });

  describe("specificBranchHref", () => {
    beforeEach(() => {
      setupGithubEnv();
    });

    it("should return specific branch href with file position", () => {
      const position = createFilePosition(15, 2);
      const result = specificBranchHref(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.SPEC_PATH,
        TEST_CONSTANTS.FEATURE_BRANCH,
        position,
      );
      const expected = createGithubUrl(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.FEATURE_BRANCH,
        TEST_CONSTANTS.SPEC_FILE,
        position,
      );
      expect(result).toBe(expected);
    });

    it("should return specific branch href without file position", () => {
      const result = specificBranchHref(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.SPEC_PATH,
        TEST_CONSTANTS.FEATURE_BRANCH,
      );
      const expected = createGithubUrl(
        TEST_CONSTANTS.REPO,
        TEST_CONSTANTS.FEATURE_BRANCH,
        TEST_CONSTANTS.SPEC_FILE,
      );
      expect(result).toBe(expected);
    });
  });

  describe("convertRawErrorToUnifiedMsg", () => {
    it("should create unified error message with default level", () => {
      const result = convertRawErrorToUnifiedMsg(
        mockContext,
        "TestError",
        "This is a test error message",
      );
      const parsed = JSON.parse(result);

      expect(parsed.type).toBe("Raw");
      expect(parsed.level).toBe("Error");
      expect(parsed.message).toBe("TestError");
      expect(parsed.extra.details).toBe("This is a test error message");
      expect(parsed.time).toBeDefined();
      expect(parsed.extra.location).toBeUndefined();
    });

    it("should create unified error message with custom level", () => {
      const result = convertRawErrorToUnifiedMsg(
        mockContext,
        "TestWarning",
        "This is a warning",
        "Warning",
      );
      const parsed = JSON.parse(result);

      expect(parsed.type).toBe("Raw");
      expect(parsed.level).toBe("Warning");
      expect(parsed.message).toBe("TestWarning");
      expect(parsed.extra.details).toBe("This is a warning");
    });

    it("should create unified error message with location", () => {
      const result = convertRawErrorToUnifiedMsg(
        mockContext,
        "TestError",
        "Error with location",
        "Error",
        "specification/test/test.json",
      );
      const parsed = JSON.parse(result);

      expect(parsed.type).toBe("Raw");
      expect(parsed.level).toBe("Error");
      expect(parsed.message).toBe("TestError");
      expect(parsed.extra.details).toBe("Error with location");
      expect(parsed.extra.location).toBe(
        "https://github.com/owner/repo/blob/main/specification/test/test.json",
      );
    });

    it("should handle empty error message", () => {
      const result = convertRawErrorToUnifiedMsg(mockContext, "EmptyError", "");
      const parsed = JSON.parse(result);

      expect(parsed.extra.details).toBe("");
    });

    it("should handle special characters in error message", () => {
      const errorMsg = 'Error with "quotes" and \n newlines \t tabs';
      const result = convertRawErrorToUnifiedMsg(mockContext, "SpecialCharsError", errorMsg);
      const parsed = JSON.parse(result);

      expect(parsed.extra.details).toBe(errorMsg);
    });
  });

  describe("checkPrTargetsProductionBranch", () => {
    it("should return true for public production branch (azure-rest-api-specs + main)", () => {
      const result = checkPrTargetsProductionBranch("azure-rest-api-specs", "main");
      expect(result).toBe(true);
    });

    it("should return true for public production branch with extended repo name", () => {
      const result = checkPrTargetsProductionBranch("owner/azure-rest-api-specs", "main");
      expect(result).toBe(true);
    });

    it("should return true for private production branch (azure-rest-api-specs-pr + RPSaaSMaster)", () => {
      const result = checkPrTargetsProductionBranch("azure-rest-api-specs-pr", "RPSaaSMaster");
      expect(result).toBe(true);
    });

    it("should return true for private production branch with extended repo name", () => {
      const result = checkPrTargetsProductionBranch(
        "owner/azure-rest-api-specs-pr",
        "RPSaaSMaster",
      );
      expect(result).toBe(true);
    });

    it("should return false for public repo with non-main branch", () => {
      const result = checkPrTargetsProductionBranch("azure-rest-api-specs", "feature-branch");
      expect(result).toBe(false);
    });

    it("should return false for public repo with develop branch", () => {
      const result = checkPrTargetsProductionBranch("azure-rest-api-specs", "develop");
      expect(result).toBe(false);
    });

    it("should return false for private repo with main branch instead of RPSaaSMaster", () => {
      const result = checkPrTargetsProductionBranch("azure-rest-api-specs-pr", "main");
      expect(result).toBe(false);
    });

    it("should return false for private repo with non-RPSaaSMaster branch", () => {
      const result = checkPrTargetsProductionBranch("azure-rest-api-specs-pr", "feature-branch");
      expect(result).toBe(false);
    });

    it("should return false for unrelated repository with main branch", () => {
      const result = checkPrTargetsProductionBranch("some-other-repo", "main");
      expect(result).toBe(false);
    });

    it("should return false for unrelated repository with RPSaaSMaster branch", () => {
      const result = checkPrTargetsProductionBranch("some-other-repo", "RPSaaSMaster");
      expect(result).toBe(false);
    });

    it("should return false for empty repository name", () => {
      const result = checkPrTargetsProductionBranch("", "main");
      expect(result).toBe(false);
    });

    it("should return false for empty branch name", () => {
      const result = checkPrTargetsProductionBranch("azure-rest-api-specs", "");
      expect(result).toBe(false);
    });

    it("should return false for both empty parameters", () => {
      const result = checkPrTargetsProductionBranch("", "");
      expect(result).toBe(false);
    });

    it("should be case sensitive for branch names", () => {
      const result1 = checkPrTargetsProductionBranch("azure-rest-api-specs", "Main");
      const result2 = checkPrTargetsProductionBranch("azure-rest-api-specs-pr", "rpsaasmaster");

      expect(result1).toBe(false);
      expect(result2).toBe(false);
    });

    it("should handle partial repo name matches correctly", () => {
      const result1 = checkPrTargetsProductionBranch("azure-rest-api", "main");
      const result2 = checkPrTargetsProductionBranch("rest-api-specs", "main");
      const result3 = checkPrTargetsProductionBranch(
        "azure-rest-api-specs-private",
        "RPSaaSMaster",
      );

      expect(result1).toBe(false);
      expect(result2).toBe(false);
      expect(result3).toBe(false);
    });
  });
});
