import { BREAKING_CHANGES_CHECK_TYPES } from "@azure-tools/specs-shared/breaking-change";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { generateBreakingChangeResultSummary } from "../src/generate-report.js";
import { addToSummary, logMessage } from "../src/log.js";
import { Context } from "../src/types/breaking-change.js";
import { RawMessageRecord, ResultMessageRecord } from "../src/types/message.js";
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
  // Test constants
  const TEST_CONSTANTS = {
    PATHS: {
      REPO: "/path/to/repo",
      WORKING: "/working",
      LOGS: "/logs",
      LOG_FILE: "/log/path",
      SUMMARY: "/path/to/summary",
    },
    MESSAGES: {
      SUCCESS_LOG: "Successfully wrote",
      DETECTED_ERRORS_WARNINGS: "Detected: 1 Errors, 1 Warnings",
      DETECTED_WARNINGS: "Detected: 2 Warnings",
      NO_BREAKING_CHANGES: "No breaking changes detected",
      IMPORTANT_NOTICE: "> [!IMPORTANT]\n> Browse to the job logs to see the details.",
      STABLE_VERSION_COMPARISON:
        "The following breaking changes have been detected in comparison to the latest stable version",
      PREVIEW_VERSION_COMPARISON:
        "The following breaking changes have been detected in comparison to the latest preview version",
      MESSAGE_RECORDS_LOG: "messageRecords# raw/result/all: 1/0/1",
    },
    TABLE_CONTENT: {
      SPECS: "| Spec | Status |\n|------|--------|\n| test.json | Modified |",
      SPECS_HEADER: "| Spec | Status |",
    },
    TEXTS: {
      ADDITIONAL_DETAILS: "\n\nAdditional details...",
      SUPPRESSION_INFO: "\n\n**Suppression Info:**\nSome details about suppressions.",
    },
    CHECK_NAMES: {
      SWAGGER: "Swagger BreakingChange",
      CROSS_VERSION: "BreakingChange(Cross-Version)",
    },
    REPO: "test/repo",
    PR_NUMBER: "123",
    BRANCHES: {
      MAIN: "main",
      FEATURE: "feature",
    },
    TEST_TIME: new Date("2023-01-01"),
  };

  const mockAddToSummary = vi.mocked(addToSummary);
  const mockLogMessage = vi.mocked(logMessage);
  const mockCreateBreakingChangeMdReport = vi.mocked(createBreakingChangeMdReport);
  const mockReportToString = vi.mocked(reportToString);
  const mockSortBreakingChangeMdReports = vi.mocked(sortBreakingChangeMdReports);

  beforeEach(() => {
    vi.clearAllMocks();

    // Mock environment variable for GitHub Actions
    vi.stubEnv("GITHUB_STEP_SUMMARY", TEST_CONSTANTS.PATHS.SUMMARY);

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

  // Factory functions
  const createMockContext = (overrides: Partial<Context> = {}): Context => ({
    localSpecRepoPath: TEST_CONSTANTS.PATHS.REPO,
    workingFolder: TEST_CONSTANTS.PATHS.WORKING,
    logFileFolder: TEST_CONSTANTS.PATHS.LOGS,
    swaggerDirs: ["specification"],
    baseBranch: TEST_CONSTANTS.BRANCHES.MAIN,
    headCommit: "HEAD",
    runType: BREAKING_CHANGES_CHECK_TYPES.SAME_VERSION,
    checkName: TEST_CONSTANTS.CHECK_NAMES.SWAGGER,
    targetRepo: TEST_CONSTANTS.REPO,
    sourceRepo: TEST_CONSTANTS.REPO,
    prNumber: TEST_CONSTANTS.PR_NUMBER,
    prSourceBranch: TEST_CONSTANTS.BRANCHES.FEATURE,
    prTargetBranch: TEST_CONSTANTS.BRANCHES.MAIN,
    oadMessageProcessorContext: {
      logFilePath: TEST_CONSTANTS.PATHS.LOG_FILE,
      prUrl: `https://github.com/${TEST_CONSTANTS.REPO}/pull/${TEST_CONSTANTS.PR_NUMBER}`,
      messageCache: [],
    },
    prUrl: `https://github.com/${TEST_CONSTANTS.REPO}/pull/${TEST_CONSTANTS.PR_NUMBER}`,
    ...overrides,
  });

  const createMockResultMessage = (
    overrides: Partial<ResultMessageRecord> = {},
  ): ResultMessageRecord => ({
    type: "Result",
    level: "Error",
    message: "Test error message",
    time: TEST_CONSTANTS.TEST_TIME,
    paths: [],
    groupName: "stable",
    ...overrides,
  });

  const createMockRawMessage = (overrides: Partial<RawMessageRecord> = {}): RawMessageRecord => ({
    type: "Raw",
    level: "Error",
    message: "Test raw error",
    time: TEST_CONSTANTS.TEST_TIME,
    groupName: "stable",
    extra: {},
    ...overrides,
  });

  // Test parameter factory
  interface TestParameters {
    context?: Context;
    messages?: ResultMessageRecord[];
    runtimeErrors?: RawMessageRecord[];
    comparedSpecsTableContent?: string;
    summaryDataSuppressionAndDetailsText?: string;
  }

  const createTestParameters = (overrides: TestParameters = {}) => ({
    context: overrides.context || createMockContext(),
    messages: overrides.messages || [],
    runtimeErrors: overrides.runtimeErrors || [],
    comparedSpecsTableContent: overrides.comparedSpecsTableContent || "",
    summaryDataSuppressionAndDetailsText: overrides.summaryDataSuppressionAndDetailsText || "",
  });

  // Helper functions
  const callGenerateBreakingChangeResultSummary = async (params: TestParameters = {}) => {
    const testParams = createTestParameters(params);
    return generateBreakingChangeResultSummary(
      testParams.context,
      testParams.messages,
      testParams.runtimeErrors,
      testParams.comparedSpecsTableContent,
      testParams.summaryDataSuppressionAndDetailsText,
    );
  };

  const expectSummaryContains = (content: string) => {
    expect(mockAddToSummary).toHaveBeenCalledWith(expect.stringContaining(content));
  };

  const expectLogMessage = (content: string) => {
    expect(mockLogMessage).toHaveBeenCalledWith(expect.stringContaining(content));
  };

  describe("generateBreakingChangeResultSummary", () => {
    it("should generate summary with success status", async () => {
      await callGenerateBreakingChangeResultSummary({
        comparedSpecsTableContent: TEST_CONSTANTS.TABLE_CONTENT.SPECS,
        summaryDataSuppressionAndDetailsText: TEST_CONSTANTS.TEXTS.ADDITIONAL_DETAILS,
      });

      expectLogMessage(TEST_CONSTANTS.MESSAGES.SUCCESS_LOG);
    });

    it("should generate summary with failure status", async () => {
      const messages = [
        createMockResultMessage({ level: "Error" }),
        createMockResultMessage({ level: "Warning" }),
      ];

      await callGenerateBreakingChangeResultSummary({ messages });

      expectSummaryContains(TEST_CONSTANTS.MESSAGES.DETECTED_ERRORS_WARNINGS);
    });

    it("should handle messages with only warnings", async () => {
      const messages = [
        createMockResultMessage({ level: "Warning" }),
        createMockResultMessage({ level: "Warning" }),
      ];

      await callGenerateBreakingChangeResultSummary({ messages });

      expectSummaryContains(TEST_CONSTANTS.MESSAGES.DETECTED_WARNINGS);
    });

    it("should include compared specs table content", async () => {
      await callGenerateBreakingChangeResultSummary({
        comparedSpecsTableContent: TEST_CONSTANTS.TABLE_CONTENT.SPECS,
      });

      expectSummaryContains(TEST_CONSTANTS.TABLE_CONTENT.SPECS_HEADER);
    });

    it("should handle runtime errors", async () => {
      const runtimeErrors = [createMockRawMessage({ level: "Error" })];

      await callGenerateBreakingChangeResultSummary({ runtimeErrors });

      expectLogMessage(TEST_CONSTANTS.MESSAGES.MESSAGE_RECORDS_LOG);
    });

    it("should handle different check names", async () => {
      const context = createMockContext({
        checkName: TEST_CONSTANTS.CHECK_NAMES.CROSS_VERSION,
      });
      const messages = [
        createMockResultMessage({ groupName: "stable" }),
        createMockResultMessage({ groupName: "preview" }),
      ];

      await callGenerateBreakingChangeResultSummary({ context, messages });

      expectSummaryContains("Detected");
    });

    it("should handle mixed stable and preview messages", async () => {
      const messages = [
        createMockResultMessage({ level: "Error", groupName: "stable" }),
        createMockResultMessage({ level: "Warning", groupName: "preview" }),
        createMockResultMessage({ level: "Error", groupName: "preview" }),
      ];

      mockCreateBreakingChangeMdReport.mockReturnValue({
        msgs: [],
        rows: [],
        type: "Result",
        level: "Error",
        rawMessage: "Test report with messages",
      } as BreakingChangeMdReport);

      await callGenerateBreakingChangeResultSummary({ messages });

      expect(mockCreateBreakingChangeMdReport).toHaveBeenCalled();
      expect(mockSortBreakingChangeMdReports).toHaveBeenCalled();
    });

    it("should handle empty message lists", async () => {
      await callGenerateBreakingChangeResultSummary();

      expectSummaryContains(TEST_CONSTANTS.MESSAGES.NO_BREAKING_CHANGES);
    });

    it("should handle cross-version check with different API versions", async () => {
      const context = createMockContext({
        checkName: TEST_CONSTANTS.CHECK_NAMES.CROSS_VERSION,
      });
      const messages = [
        createMockResultMessage({ groupName: "stable" }),
        createMockResultMessage({ groupName: "preview" }),
      ];

      await callGenerateBreakingChangeResultSummary({ context, messages });

      expectSummaryContains(TEST_CONSTANTS.MESSAGES.STABLE_VERSION_COMPARISON);
      expectSummaryContains(TEST_CONSTANTS.MESSAGES.PREVIEW_VERSION_COMPARISON);
    });

    it("should include suppression and details text in summary", async () => {
      await callGenerateBreakingChangeResultSummary({
        summaryDataSuppressionAndDetailsText: TEST_CONSTANTS.TEXTS.SUPPRESSION_INFO,
      });

      expectSummaryContains("**Suppression Info:**\nSome details about suppressions.");
    });

    it("should include important notice in summary", async () => {
      await callGenerateBreakingChangeResultSummary();

      expectSummaryContains(TEST_CONSTANTS.MESSAGES.IMPORTANT_NOTICE);
    });
  });
});
