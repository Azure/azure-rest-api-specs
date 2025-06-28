import { describe, it, expect, vi, beforeEach, afterEach } from "vitest";
import { generateBreakingChangeResultSummary } from "../src/generate-report.js";
import { Context } from "../src/types/breaking-change.js";
import { RawMessageRecord, ResultMessageRecord } from "../src/types/message.js";
import { addToSummary, logMessage, logWarning } from "../src/log.js";
import {
  BreakingChangeMdReport,
  createBreakingChangeMdReport,
  reportToString,
  sortBreakingChangeMdReports,
} from "../src/utils/markdown-report.js";

// Mock dependencies
vi.mock("../src/log.js");
vi.mock("../src/utils/markdown-report.js");

describe("generate-report", () => {
  const mockAddToSummary = vi.mocked(addToSummary);
  const mockLogMessage = vi.mocked(logMessage);
  const mockLogWarning = vi.mocked(logWarning);
  const mockCreateBreakingChangeMdReport = vi.mocked(createBreakingChangeMdReport);
  const mockReportToString = vi.mocked(reportToString);
  const mockSortBreakingChangeMdReports = vi.mocked(sortBreakingChangeMdReports);

  beforeEach(() => {
    vi.clearAllMocks();

    // Mock environment variable for GitHub Actions
    vi.stubEnv("GITHUB_STEP_SUMMARY", "/path/to/summary");

    // Setup default mock implementations
    mockCreateBreakingChangeMdReport.mockReturnValue({
      msgs: [],
      rows: [],
      type: "Result",
      level: "Error",
      rawMessage: "Test report",
    } as BreakingChangeMdReport);

    mockReportToString.mockReturnValue("Mock report string");
    mockSortBreakingChangeMdReports.mockImplementation((reports) => reports);
  });

  afterEach(() => {
    vi.resetAllMocks();
    vi.unstubAllEnvs();
  });

  const createMockContext = (overrides: Partial<Context> = {}): Context => ({
    localSpecRepoPath: "/path/to/repo",
    workingFolder: "/working",
    logFileFolder: "/logs",
    swaggerDirs: ["specification"],
    baseBranch: "main",
    headCommit: "HEAD",
    runType: "SameVersion",
    checkName: "Swagger BreakingChange",
    repo: "test/repo",
    prNumber: "123",
    prSourceBranch: "feature",
    prTargetBranch: "main",
    oadMessageProcessorContext: {
      logFilePath: "/log/path",
      prUrl: "https://github.com/test/repo/pull/123",
      messageCache: [],
    },
    prUrl: "https://github.com/test/repo/pull/123",
    ...overrides,
  });

  const createMockResultMessage = (
    overrides: Partial<ResultMessageRecord> = {},
  ): ResultMessageRecord => ({
    type: "Result",
    level: "Error",
    message: "Test error message",
    time: new Date("2023-01-01"),
    paths: [],
    groupName: "stable",
    ...overrides,
  });

  const createMockRawMessage = (overrides: Partial<RawMessageRecord> = {}): RawMessageRecord => ({
    type: "Raw",
    level: "Error",
    message: "Test raw error",
    time: new Date("2023-01-01"),
    groupName: "stable",
    extra: {},
    ...overrides,
  });

  describe("generateBreakingChangeResultSummary", () => {
    it("should generate summary with success status", async () => {
      const context = createMockContext();
      const messages: ResultMessageRecord[] = [];
      const runtimeErrors: RawMessageRecord[] = [];
      const comparedSpecsTableContent =
        "| Spec | Status |\n|------|--------|\n| test.json | Modified |";
      const summaryDataSuppressionAndDetailsText = "\n\nAdditional details...";

      await generateBreakingChangeResultSummary(
        context,
        messages,
        runtimeErrors,
        comparedSpecsTableContent,
        summaryDataSuppressionAndDetailsText,
      );

      expect(mockLogMessage).toHaveBeenCalledWith(expect.stringContaining("Successfully wrote"));
    });

    it("should generate summary with failure status", async () => {
      const context = createMockContext();
      const messages: ResultMessageRecord[] = [
        createMockResultMessage({ level: "Error" }),
        createMockResultMessage({ level: "Warning" }),
      ];
      const runtimeErrors: RawMessageRecord[] = [];
      const comparedSpecsTableContent = "";
      const summaryDataSuppressionAndDetailsText = "";

      await generateBreakingChangeResultSummary(
        context,
        messages,
        runtimeErrors,
        comparedSpecsTableContent,
        summaryDataSuppressionAndDetailsText,
      );

      expect(mockAddToSummary).toHaveBeenCalledWith(
        expect.stringContaining("Detected: 1 Errors, 1 Warnings"),
      );
    });

    it("should handle messages with only warnings", async () => {
      const context = createMockContext();
      const messages: ResultMessageRecord[] = [
        createMockResultMessage({ level: "Warning" }),
        createMockResultMessage({ level: "Warning" }),
      ];
      const runtimeErrors: RawMessageRecord[] = [];
      const comparedSpecsTableContent = "";
      const summaryDataSuppressionAndDetailsText = "";

      await generateBreakingChangeResultSummary(
        context,
        messages,
        runtimeErrors,
        comparedSpecsTableContent,
        summaryDataSuppressionAndDetailsText,
      );

      expect(mockAddToSummary).toHaveBeenCalledWith(
        expect.stringContaining("Detected: 2 Warnings"),
      );
    });

    it("should include compared specs table content", async () => {
      const context = createMockContext();
      const messages: ResultMessageRecord[] = [];
      const runtimeErrors: RawMessageRecord[] = [];
      const comparedSpecsTableContent =
        "| Spec | Status |\n|------|--------|\n| test.json | Modified |";
      const summaryDataSuppressionAndDetailsText = "";

      await generateBreakingChangeResultSummary(
        context,
        messages,
        runtimeErrors,
        comparedSpecsTableContent,
        summaryDataSuppressionAndDetailsText,
      );

      expect(mockAddToSummary).toHaveBeenCalledWith(expect.stringContaining("| Spec | Status |"));
    });

    it("should handle runtime errors", async () => {
      const context = createMockContext();
      const messages: ResultMessageRecord[] = [];
      const runtimeErrors: RawMessageRecord[] = [createMockRawMessage({ level: "Error" })];
      const comparedSpecsTableContent = "";
      const summaryDataSuppressionAndDetailsText = "";

      await generateBreakingChangeResultSummary(
        context,
        messages,
        runtimeErrors,
        comparedSpecsTableContent,
        summaryDataSuppressionAndDetailsText,
      );

      expect(mockLogMessage).toHaveBeenCalledWith(
        expect.stringContaining("messageRecords# raw/result/all: 1/0/1"),
      );
    });

    it("should handle different check names", async () => {
      const context = createMockContext({
        checkName: "BreakingChange(Cross-Version)",
      });
      const messages: ResultMessageRecord[] = [
        createMockResultMessage({ groupName: "stable" }),
        createMockResultMessage({ groupName: "preview" }),
      ];
      const runtimeErrors: RawMessageRecord[] = [];
      const comparedSpecsTableContent = "";
      const summaryDataSuppressionAndDetailsText = "";

      await generateBreakingChangeResultSummary(
        context,
        messages,
        runtimeErrors,
        comparedSpecsTableContent,
        summaryDataSuppressionAndDetailsText,
      );

      expect(mockAddToSummary).toHaveBeenCalledWith(expect.stringContaining("Detected"));
    });

    it("should handle mixed stable and preview messages", async () => {
      const context = createMockContext();
      const messages: ResultMessageRecord[] = [
        createMockResultMessage({ level: "Error", groupName: "stable" }),
        createMockResultMessage({ level: "Warning", groupName: "preview" }),
        createMockResultMessage({ level: "Error", groupName: "preview" }),
      ];
      const runtimeErrors: RawMessageRecord[] = [];
      const comparedSpecsTableContent = "";
      const summaryDataSuppressionAndDetailsText = "";

      mockCreateBreakingChangeMdReport.mockReturnValue({
        msgs: [],
        rows: [],
        type: "Result",
        level: "Error",
        rawMessage: "Test report with messages",
      } as BreakingChangeMdReport);

      await generateBreakingChangeResultSummary(
        context,
        messages,
        runtimeErrors,
        comparedSpecsTableContent,
        summaryDataSuppressionAndDetailsText,
      );

      expect(mockCreateBreakingChangeMdReport).toHaveBeenCalled();
      expect(mockSortBreakingChangeMdReports).toHaveBeenCalled();
    });

    it("should handle empty message lists", async () => {
      const context = createMockContext();
      const messages: ResultMessageRecord[] = [];
      const runtimeErrors: RawMessageRecord[] = [];
      const comparedSpecsTableContent = "";
      const summaryDataSuppressionAndDetailsText = "";

      await generateBreakingChangeResultSummary(
        context,
        messages,
        runtimeErrors,
        comparedSpecsTableContent,
        summaryDataSuppressionAndDetailsText,
      );

      expect(mockAddToSummary).toHaveBeenCalledWith(
        expect.stringContaining("No breaking changes detected"),
      );
    });

    it("should handle cross-version check with different API versions", async () => {
      const context = createMockContext({
        checkName: "BreakingChange(Cross-Version)",
      });
      const messages: ResultMessageRecord[] = [
        createMockResultMessage({ groupName: "stable" }),
        createMockResultMessage({ groupName: "preview" }),
      ];
      const runtimeErrors: RawMessageRecord[] = [];
      const comparedSpecsTableContent = "";
      const summaryDataSuppressionAndDetailsText = "";

      await generateBreakingChangeResultSummary(
        context,
        messages,
        runtimeErrors,
        comparedSpecsTableContent,
        summaryDataSuppressionAndDetailsText,
      );

      expect(mockAddToSummary).toHaveBeenCalledWith(
        expect.stringContaining(
          "The following breaking changes have been detected in comparison to the latest stable version",
        ),
      );
      expect(mockAddToSummary).toHaveBeenCalledWith(
        expect.stringContaining(
          "The following breaking changes have been detected in comparison to the latest preview version",
        ),
      );
    });

    it.skip("should handle comment data length exceeding limit", async () => {
      const context = createMockContext();
      const messages: ResultMessageRecord[] = [createMockResultMessage()];
      const runtimeErrors: RawMessageRecord[] = [];
      const comparedSpecsTableContent = "x".repeat(60000); // Very long table content
      const summaryDataSuppressionAndDetailsText = "";

      // Mock a very long report string
      mockReportToString.mockReturnValue("x".repeat(10000));

      await generateBreakingChangeResultSummary(
        context,
        messages,
        runtimeErrors,
        comparedSpecsTableContent,
        summaryDataSuppressionAndDetailsText,
      );

      expect(mockLogWarning).toHaveBeenCalledWith(
        expect.stringContaining("ASSERTION VIOLATION! commentData.length"),
      );
      expect(mockAddToSummary).toHaveBeenCalledWith(expect.stringContaining("⚠️ TRUNCATED ⚠️"));
    });

    it.skip("should iteratively reduce max row count to fit within limits", async () => {
      const context = createMockContext();
      const messages: ResultMessageRecord[] = [
        createMockResultMessage(),
        createMockResultMessage(),
        createMockResultMessage(),
      ];
      const runtimeErrors: RawMessageRecord[] = [];
      const comparedSpecsTableContent = "";
      const summaryDataSuppressionAndDetailsText = "";

      // First call returns long string, subsequent calls return shorter strings
      mockReportToString
        .mockReturnValueOnce("x".repeat(70000)) // Too long
        .mockReturnValueOnce("x".repeat(60000)) // Still too long
        .mockReturnValueOnce("x".repeat(50000)); // Finally fits

      await generateBreakingChangeResultSummary(
        context,
        messages,
        runtimeErrors,
        comparedSpecsTableContent,
        summaryDataSuppressionAndDetailsText,
      );

      expect(mockLogMessage).toHaveBeenCalledWith(
        expect.stringContaining("maxRowCount reduced/current/max"),
      );
    });

    it("should include suppression and details text in summary", async () => {
      const context = createMockContext();
      const messages: ResultMessageRecord[] = [];
      const runtimeErrors: RawMessageRecord[] = [];
      const comparedSpecsTableContent = "";
      const summaryDataSuppressionAndDetailsText =
        "\n\n**Suppression Info:**\nSome details about suppressions.";

      await generateBreakingChangeResultSummary(
        context,
        messages,
        runtimeErrors,
        comparedSpecsTableContent,
        summaryDataSuppressionAndDetailsText,
      );

      expect(mockAddToSummary).toHaveBeenCalledWith(
        expect.stringContaining("**Suppression Info:**\nSome details about suppressions."),
      );
    });

    it("should include important notice in summary", async () => {
      const context = createMockContext();
      const messages: ResultMessageRecord[] = [];
      const runtimeErrors: RawMessageRecord[] = [];
      const comparedSpecsTableContent = "";
      const summaryDataSuppressionAndDetailsText = "";

      await generateBreakingChangeResultSummary(
        context,
        messages,
        runtimeErrors,
        comparedSpecsTableContent,
        summaryDataSuppressionAndDetailsText,
      );

      expect(mockAddToSummary).toHaveBeenCalledWith(
        expect.stringContaining("> [!IMPORTANT]\n> Browse to the job logs to see the details."),
      );
    });
  });
});
