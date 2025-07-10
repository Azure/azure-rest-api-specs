import { describe, it, expect, beforeEach, afterEach, vi } from "vitest";
import {
  blobHref,
  targetHref,
  branchHref,
  getGithubStyleFilePath,
  getRelativeSwaggerPathToRepo,
  sourceBranchHref,
  targetBranchHref,
  specificBranchHref,
  getVersionFromInputFile,
  getArgumentValue,
  cutoffMsg,
  processOadRuntimeErrorMessage,
  specIsPreview,
  convertRawErrorToUnifiedMsg,
} from "../../src/utils/common-utils.js";
import { Context } from "../../src/types/breaking-change.js";

describe("common-utils", () => {
  let originalEnv: NodeJS.ProcessEnv;

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
    repo: "owner/repo",
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
      const result = blobHref("owner/repo", "abc123", "test-file.json");
      expect(result).toBe("https://github.com/owner/repo/blob/abc123/test-file.json");
    });

    it("should handle empty file path", () => {
      const result = blobHref("owner/repo", "abc123", "");
      expect(result).toBe("https://github.com/owner/repo/blob/abc123/");
    });
  });

  describe("targetHref", () => {
    beforeEach(() => {
      process.env.GITHUB_REPOSITORY = "owner/repo";
      vi.spyOn(console, "log").mockImplementation(() => {});
    });

    it("should return GitHub URL for valid file", () => {
      process.env.GITHUB_BASE_REF = "main";
      const result = targetHref("owner/repo", "main", "specification/test.json");
      expect(result).toBe("https://github.com/owner/repo/blob/main/specification/test.json");
    });

    it("should return empty string for empty file", () => {
      const result = targetHref("owner/repo", "main", "");
      expect(result).toBe("");
    });
  });

  describe("branchHref", () => {
    beforeEach(() => {
      process.env.GITHUB_REPOSITORY = "owner/repo";
    });

    it("should return GitHub URL with specified branch", () => {
      const result = branchHref("owner/repo", "test-file.json", "feature-branch");
      expect(result).toBe("https://github.com/owner/repo/blob/feature-branch/test-file.json");
    });

    it("should use main as default branch", () => {
      const result = branchHref("owner/repo", "test-file.json");
      expect(result).toBe("https://github.com/owner/repo/blob/main/test-file.json");
    });

    it("should return empty string for empty file", () => {
      const result = branchHref("owner/repo", "");
      expect(result).toBe("");
    });
  });

  describe("getGithubStyleFilePath", () => {
    it("should format file path with line and column", () => {
      const result = getGithubStyleFilePath("test.json", { line: 42, column: 5 });
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
      const filePath =
        "/home/user/azure-rest-api-specs/specification/storage/resource-manager/test.json";
      const result = getRelativeSwaggerPathToRepo(filePath);
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
    it("should extract version from data-plane path", () => {
      const filePath =
        "specification/storage/data-plane/Microsoft.Storage/stable/2021-01-01/storage.json";
      const result = getVersionFromInputFile(filePath);
      expect(result).toBe("2021-01-01");
    });

    it("should extract version with preview from data-plane path", () => {
      const filePath =
        "specification/storage/data-plane/Microsoft.Storage/preview/2021-01-01-preview/storage.json";
      const result = getVersionFromInputFile(filePath, true);
      expect(result).toBe("2021-01-01-preview");
    });

    it("should extract version from resource-manager path", () => {
      const filePath =
        "specification/storage/resource-manager/Microsoft.Storage/2021-01-01/storage.json";
      const result = getVersionFromInputFile(filePath);
      expect(result).toBe("2021-01-01");
    });

    it("should return empty string when no version found in path", () => {
      const filePath = "test.json";
      const result = getVersionFromInputFile(filePath);
      expect(result).toBe("");
    });

    it("should return folder name when no valid API version found", () => {
      const filePath = "invalid/path.json";
      const result = getVersionFromInputFile(filePath);
      expect(result).toBe("invalid");
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
      const specPath =
        "specification/maps/data-plane/Creator/preview/2022-09-01-preview/wayfind.json";
      const result = specIsPreview(specPath);
      expect(result).toBe(true);
    });

    it("should return false for stable spec paths", () => {
      const specPath = "specification/maps/data-plane/Creator/stable/2022-09-01/wayfind.json";
      const result = specIsPreview(specPath);
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
      process.env.GITHUB_ACTIONS = "true";
      process.env.GITHUB_HEAD_REPOSITORY = "owner/repo";
      process.env.GITHUB_SHA = "abc123";
    });

    it("should return source branch href with file position", () => {
      const result = sourceBranchHref(
        "owner/repo",
        "abc123",
        "/home/user/specification/test.json",
        {
          line: 10,
          column: 5,
        },
      );
      expect(result).toContain(
        "https://github.com/owner/repo/blob/abc123/specification/test.json#L10:5",
      );
    });

    it("should return source branch href without file position", () => {
      const result = sourceBranchHref("owner/repo", "abc123", "/home/user/specification/test.json");
      expect(result).toContain("https://github.com/owner/repo/blob/abc123/specification/test.json");
    });
  });

  describe("targetBranchHref", () => {
    beforeEach(() => {
      process.env.GITHUB_REPOSITORY = "owner/repo";
      process.env.GITHUB_BASE_REF = "main";
      vi.spyOn(console, "log").mockImplementation(() => {});
    });

    it("should return target branch href with file position", () => {
      const result = targetBranchHref("owner/repo", "main", "/home/user/specification/test.json", {
        line: 20,
        column: 3,
      });
      expect(result).toBe("https://github.com/owner/repo/blob/main/specification/test.json#L20:3");
    });

    it("should return target branch href without file position", () => {
      const result = targetBranchHref("owner/repo", "main", "/home/user/specification/test.json");
      expect(result).toBe("https://github.com/owner/repo/blob/main/specification/test.json");
    });
  });

  describe("specificBranchHref", () => {
    beforeEach(() => {
      process.env.GITHUB_REPOSITORY = "owner/repo";
    });

    it("should return specific branch href with file position", () => {
      const result = specificBranchHref(
        "owner/repo",
        "/home/user/specification/test.json",
        "feature-branch",
        {
          line: 15,
          column: 2,
        },
      );
      expect(result).toBe(
        "https://github.com/owner/repo/blob/feature-branch/specification/test.json#L15:2",
      );
    });

    it("should return specific branch href without file position", () => {
      const result = specificBranchHref(
        "owner/repo",
        "/home/user/specification/test.json",
        "feature-branch",
      );
      expect(result).toBe(
        "https://github.com/owner/repo/blob/feature-branch/specification/test.json",
      );
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
});
