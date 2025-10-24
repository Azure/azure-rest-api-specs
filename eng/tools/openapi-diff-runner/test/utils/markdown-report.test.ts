import { beforeEach, describe, expect, it, vi } from "vitest";
import { LogLevel, logMessage } from "../../src/log.js";
import { BrChMsgRecord, ResultMessageRecord } from "../../src/types/message.js";
import {
  BreakingChangeMdReport,
  createBreakingChangeMdReport,
  getReportLength,
  getRowCount,
  reportToString,
  sortBreakingChangeMdReports,
} from "../../src/utils/markdown-report.js";

// Mock the log module
vi.mock("../../src/log.js", () => ({
  logMessage: vi.fn(),
  LogLevel: {
    Info: "Info",
    Warning: "Warning",
    Error: "Error",
  },
}));

describe("markdown-report", () => {
  // Test constants
  const DATE = new Date("2023-01-01");
  const IDS = {
    r001: "R001",
    r002: "R002",
  };
  const MESSAGES = {
    testError: "Test error message",
    runtimeWarning: "Runtime warning message",
    testMessage: "Test message",
    rawMessage: "Raw message",
    resultMessage: "Result message",
    infoMessage: "Info message",
    errorMessage: "Error message",
    messageA: "Message A",
    messageB: "Message B",
  };
  const URLS = {
    docs: "https://docs.example.com",
    docsWithRules: "https://docs.example.com/rules/R001",
    github: "https://github.com/owner/repo/blob/main/specification/test.json",
  };
  const CODES = {
    testError: "TestError",
    testInfo: "TestInfo",
  };
  const LEVELS = {
    error: "Error" as const,
    warning: "Warning" as const,
    info: "Info" as const,
  };

  // Helper functions for creating messages
  const createResultMessage = (overrides: Partial<ResultMessageRecord> = {}): ResultMessageRecord =>
    ({
      type: "Result",
      id: IDS.r001,
      level: LEVELS.error,
      message: MESSAGES.testError,
      time: DATE,
      docUrl: URLS.docsWithRules,
      code: CODES.testError,
      paths: [
        {
          tag: "New",
          path: URLS.github,
          jsonPath: "$.paths./test",
        },
      ],
      ...overrides,
    }) as ResultMessageRecord;

  const createRawMessage = (overrides: Partial<BrChMsgRecord> = {}) =>
    ({
      type: "Raw" as const,
      level: LEVELS.warning,
      message: MESSAGES.runtimeWarning,
      time: DATE,
      groupName: "test-group",
      extra: { details: "Additional info" },
      ...overrides,
    }) as BrChMsgRecord;

  const createReport = (
    overrides: Partial<BreakingChangeMdReport> = {},
  ): BreakingChangeMdReport => ({
    msgs: [createResultMessage()],
    rows: ["| 1 | Test message |\\n"],
    type: "Result",
    level: LEVELS.error,
    id: IDS.r001,
    rawMessage: "",
    ...overrides,
  });

  const createMultipleResultMessages = (count: number): ResultMessageRecord[] =>
    Array.from({ length: count }, (_, i) =>
      createResultMessage({
        id: `R00${i + 1}`,
        message: `Test message ${i + 1}`,
      }),
    );

  const expectReportStructure = (
    result: BreakingChangeMdReport,
    expected: Partial<BreakingChangeMdReport>,
  ) => {
    expect(result).toMatchObject(expected);
    expect(result.rows).toHaveLength(expected.rows?.length || 1);
  };

  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe("createBreakingChangeMdReport", () => {
    it("should create report from Result messages", () => {
      const msgs = [createResultMessage()];

      const result = createBreakingChangeMdReport(msgs);

      expectReportStructure(result, {
        msgs,
        type: "Result",
        level: LEVELS.error,
        id: IDS.r001,
        rawMessage: "",
      });
    });

    it("should create report from Raw messages", () => {
      const msgs = [createRawMessage()];

      const result = createBreakingChangeMdReport(msgs);

      expectReportStructure(result, {
        msgs,
        type: "Raw",
        level: LEVELS.warning,
        id: undefined,
        rawMessage: MESSAGES.runtimeWarning,
      });
    });

    it("should validate empty message array", () => {
      const msgs: BrChMsgRecord[] = [];

      expect(() => createBreakingChangeMdReport(msgs)).toThrow();
    });

    it("should warn about mixed message types", () => {
      const msgs = [
        createResultMessage({ message: MESSAGES.testMessage, paths: [] }),
        createRawMessage({ level: LEVELS.error, message: MESSAGES.rawMessage }),
      ];

      createBreakingChangeMdReport(msgs);
      expect(logMessage).toHaveBeenCalledWith(
        expect.stringContaining("Not all messages have the same type"),
        LogLevel.Warn,
      );
    });
  });

  describe("sortBreakingChangeMdReports", () => {
    it("should sort by type (Raw before Result)", () => {
      const resultReport = createReport({
        msgs: [createResultMessage({ message: MESSAGES.resultMessage, paths: [] })],
        rows: ["| 1 | Result message |\\n"],
        type: "Result",
        level: LEVELS.error,
        id: IDS.r001,
        rawMessage: "",
      });

      const rawReport = createReport({
        msgs: [createRawMessage({ level: LEVELS.error, message: MESSAGES.rawMessage })],
        rows: ["| 1 | Raw message |\\n"],
        type: "Raw",
        level: LEVELS.error,
        rawMessage: MESSAGES.rawMessage,
        id: undefined,
      });

      const result = sortBreakingChangeMdReports([resultReport, rawReport]);
      expect(result[0].type).toBe("Raw");
      expect(result[1].type).toBe("Result");
    });

    it("should sort by level (Error before Warning before Info)", () => {
      const infoReport = createReport({
        msgs: [
          createResultMessage({
            id: IDS.r001,
            level: LEVELS.info,
            message: MESSAGES.infoMessage,
            code: CODES.testInfo,
            paths: [],
          }),
        ],
        rows: ["| 1 | Info message |\\n"],
        type: "Result",
        level: LEVELS.info,
        id: IDS.r001,
        rawMessage: "",
      });

      const errorReport = createReport({
        msgs: [
          createResultMessage({
            id: IDS.r002,
            level: LEVELS.error,
            message: MESSAGES.errorMessage,
            paths: [],
          }),
        ],
        rows: ["| 1 | Error message |\\n"],
        type: "Result",
        level: LEVELS.error,
        id: IDS.r002,
        rawMessage: "",
      });

      const result = sortBreakingChangeMdReports([infoReport, errorReport]);
      expect(result[0].level).toBe("Error");
      expect(result[1].level).toBe("Info");
    });

    it("should sort by ID when type and level are same", () => {
      const reportB = createReport({
        msgs: [
          createResultMessage({
            id: IDS.r002,
            message: MESSAGES.messageB,
            paths: [],
          }),
        ],
        rows: ["| 1 | Message B |\\n"],
        type: "Result",
        level: LEVELS.error,
        id: IDS.r002,
        rawMessage: "",
      });

      const reportA = createReport({
        msgs: [
          createResultMessage({
            id: IDS.r001,
            message: MESSAGES.messageA,
            paths: [],
          }),
        ],
        rows: ["| 1 | Message A |\\n"],
        type: "Result",
        level: LEVELS.error,
        id: IDS.r001,
        rawMessage: "",
      });

      const result = sortBreakingChangeMdReports([reportB, reportA]);
      expect(result[0].id).toBe("R001");
      expect(result[1].id).toBe("R002");
    });
  });

  describe("reportToString", () => {
    it("should convert report to markdown string", () => {
      const report = createReport({
        msgs: [createResultMessage({ message: MESSAGES.testMessage, paths: [] })],
        rows: ["| 1 | Test message |\\n"],
      });

      const result = reportToString(report, 10);

      expect(result).toContain("## <code><code>❌</code></code>");
      expect(result).toContain("[R001 - TestError](https://docs.example.com/rules/R001)");
      expect(result).toContain("Displaying 1 out of 1 occurrences");
      expect(result).toContain("| Index | Description |");
      expect(result).toContain("| 1 | Test message |");
    });

    it("should include deficit row when maxRowCount is exceeded", () => {
      const msgs = createMultipleResultMessages(5);
      const report = createBreakingChangeMdReport(msgs);
      const result = reportToString(report, 3);

      expect(result).toContain("Displaying 3 out of 5 occurrences");
      expect(result).toContain("⚠️ To view the remaining 2 occurrences");
      expect(result).toContain("⚠️ 2 occurrences omitted");
    });
  });

  describe("getReportLength", () => {
    it("should return correct length of report string", () => {
      const report = createReport({
        msgs: [createResultMessage({ message: MESSAGES.testMessage, paths: [] })],
        rows: ["| 1 | Test message |\\n"],
      });

      const expectedString = reportToString(report, 10);
      const result = getReportLength(report, 10);

      expect(result).toBe(expectedString.length);
    });
  });

  describe("getRowCount", () => {
    it("should return correct number of rows", () => {
      const msgs = createMultipleResultMessages(3);
      const report = createBreakingChangeMdReport(msgs);
      const result = getRowCount(report);

      expect(result).toBe(3);
    });
  });
});
