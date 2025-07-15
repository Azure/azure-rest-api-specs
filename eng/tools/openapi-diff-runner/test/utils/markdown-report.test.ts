import { describe, it, expect, vi, beforeEach } from "vitest";
import {
  createBreakingChangeMdReport,
  sortBreakingChangeMdReports,
  getReportLength,
  reportToString,
  getRowCount,
  BreakingChangeMdReport,
} from "../../src/utils/markdown-report.js";
import { BrChMsgRecord, ResultMessageRecord } from "../../src/types/message.js";
import { logMessage, LogLevel } from "../../src/log.js";

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
  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe("createBreakingChangeMdReport", () => {
    it("should create report from Result messages", () => {
      const msgs: BrChMsgRecord[] = [
        {
          type: "Result",
          id: "R001",
          level: "Error",
          message: "Test error message",
          time: new Date("2023-01-01"),
          docUrl: "https://docs.example.com/rules/R001",
          code: "TestError",
          paths: [
            {
              tag: "New",
              path: "https://github.com/owner/repo/blob/main/specification/test.json",
              jsonPath: "$.paths./test",
            },
          ],
        } as ResultMessageRecord,
      ];

      const result = createBreakingChangeMdReport(msgs);

      expect(result.msgs).toBe(msgs);
      expect(result.type).toBe("Result");
      expect(result.level).toBe("Error");
      expect(result.id).toBe("R001");
      expect(result.rawMessage).toBe("");
      expect(result.rows).toHaveLength(1);
    });

    it("should create report from Raw messages", () => {
      const msgs: BrChMsgRecord[] = [
        {
          type: "Raw",
          level: "Warning",
          message: "Runtime warning message",
          time: new Date("2023-01-01"),
          groupName: "test-group",
          extra: { details: "Additional info" },
        },
      ];

      const result = createBreakingChangeMdReport(msgs);

      expect(result.msgs).toBe(msgs);
      expect(result.type).toBe("Raw");
      expect(result.level).toBe("Warning");
      expect(result.id).toBeUndefined();
      expect(result.rawMessage).toBe("Runtime warning message");
      expect(result.rows).toHaveLength(1);
    });

    it("should validate empty message array", () => {
      const msgs: BrChMsgRecord[] = [];

      expect(() => createBreakingChangeMdReport(msgs)).toThrow();
    });

    it("should warn about mixed message types", () => {
      const msgs: BrChMsgRecord[] = [
        {
          type: "Result",
          id: "R001",
          level: "Error",
          message: "Test message",
          time: new Date("2023-01-01"),
          docUrl: "https://docs.example.com/rules/R001",
          code: "TestError",
          paths: [],
        } as ResultMessageRecord,
        {
          type: "Raw",
          level: "Error",
          message: "Raw message",
          time: new Date("2023-01-01"),
          groupName: "test-group",
        },
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
      const resultReport: BreakingChangeMdReport = {
        msgs: [
          {
            type: "Result",
            id: "R001",
            level: "Error",
            message: "Result message",
            time: new Date("2023-01-01"),
            docUrl: "https://docs.example.com",
            code: "TestError",
            paths: [],
          } as ResultMessageRecord,
        ],
        rows: ["| 1 | Result message |\\n"],
        type: "Result",
        level: "Error",
        id: "R001",
        rawMessage: "",
      };

      const rawReport: BreakingChangeMdReport = {
        msgs: [
          {
            type: "Raw",
            level: "Error",
            message: "Raw message",
            time: new Date("2023-01-01"),
            groupName: "test-group",
          },
        ],
        rows: ["| 1 | Raw message |\\n"],
        type: "Raw",
        level: "Error",
        rawMessage: "Raw message",
      };

      const result = sortBreakingChangeMdReports([resultReport, rawReport]);
      expect(result[0].type).toBe("Raw");
      expect(result[1].type).toBe("Result");
    });

    it("should sort by level (Error before Warning before Info)", () => {
      const infoReport: BreakingChangeMdReport = {
        msgs: [
          {
            type: "Result",
            id: "R001",
            level: "Info",
            message: "Info message",
            time: new Date("2023-01-01"),
            docUrl: "https://docs.example.com",
            code: "TestInfo",
            paths: [],
          } as ResultMessageRecord,
        ],
        rows: ["| 1 | Info message |\\n"],
        type: "Result",
        level: "Info",
        id: "R001",
        rawMessage: "",
      };

      const errorReport: BreakingChangeMdReport = {
        msgs: [
          {
            type: "Result",
            id: "R002",
            level: "Error",
            message: "Error message",
            time: new Date("2023-01-01"),
            docUrl: "https://docs.example.com",
            code: "TestError",
            paths: [],
          } as ResultMessageRecord,
        ],
        rows: ["| 1 | Error message |\\n"],
        type: "Result",
        level: "Error",
        id: "R002",
        rawMessage: "",
      };

      const result = sortBreakingChangeMdReports([infoReport, errorReport]);
      expect(result[0].level).toBe("Error");
      expect(result[1].level).toBe("Info");
    });

    it("should sort by ID when type and level are same", () => {
      const reportB: BreakingChangeMdReport = {
        msgs: [
          {
            type: "Result",
            id: "R002",
            level: "Error",
            message: "Message B",
            time: new Date("2023-01-01"),
            docUrl: "https://docs.example.com",
            code: "TestError",
            paths: [],
          } as ResultMessageRecord,
        ],
        rows: ["| 1 | Message B |\\n"],
        type: "Result",
        level: "Error",
        id: "R002",
        rawMessage: "",
      };

      const reportA: BreakingChangeMdReport = {
        msgs: [
          {
            type: "Result",
            id: "R001",
            level: "Error",
            message: "Message A",
            time: new Date("2023-01-01"),
            docUrl: "https://docs.example.com",
            code: "TestError",
            paths: [],
          } as ResultMessageRecord,
        ],
        rows: ["| 1 | Message A |\\n"],
        type: "Result",
        level: "Error",
        id: "R001",
        rawMessage: "",
      };

      const result = sortBreakingChangeMdReports([reportB, reportA]);
      expect(result[0].id).toBe("R001");
      expect(result[1].id).toBe("R002");
    });
  });

  describe("reportToString", () => {
    it("should convert report to markdown string", () => {
      const report: BreakingChangeMdReport = {
        msgs: [
          {
            type: "Result",
            id: "R001",
            level: "Error",
            message: "Test message",
            time: new Date("2023-01-01"),
            docUrl: "https://docs.example.com/rules/R001",
            code: "TestError",
            paths: [],
          } as ResultMessageRecord,
        ],
        rows: ["| 1 | Test message |\\n"],
        type: "Result",
        level: "Error",
        id: "R001",
        rawMessage: "",
      };

      const result = reportToString(report, 10);

      expect(result).toContain("## <code><code>❌</code></code>");
      expect(result).toContain("[R001 - TestError](https://docs.example.com/rules/R001)");
      expect(result).toContain("Displaying 1 out of 1 occurrences");
      expect(result).toContain("| Index | Description |");
      expect(result).toContain("| 1 | Test message |");
    });

    it("should include deficit row when maxRowCount is exceeded", () => {
      const msgs: BrChMsgRecord[] = Array.from(
        { length: 5 },
        (_, i) =>
          ({
            type: "Result",
            id: `R00${i + 1}`,
            level: "Error",
            message: `Test message ${i + 1}`,
            time: new Date("2023-01-01"),
            docUrl: "https://docs.example.com",
            code: "TestError",
            paths: [],
          }) as ResultMessageRecord,
      );

      const report = createBreakingChangeMdReport(msgs);
      const result = reportToString(report, 3);

      expect(result).toContain("Displaying 3 out of 5 occurrences");
      expect(result).toContain("⚠️ To view the remaining 2 occurrences");
      expect(result).toContain("⚠️ 2 occurrences omitted");
    });
  });

  describe("getReportLength", () => {
    it("should return correct length of report string", () => {
      const report: BreakingChangeMdReport = {
        msgs: [
          {
            type: "Result",
            id: "R001",
            level: "Error",
            message: "Test message",
            time: new Date("2023-01-01"),
            docUrl: "https://docs.example.com/rules/R001",
            code: "TestError",
            paths: [],
          } as ResultMessageRecord,
        ],
        rows: ["| 1 | Test message |\\n"],
        type: "Result",
        level: "Error",
        id: "R001",
        rawMessage: "",
      };

      const expectedString = reportToString(report, 10);
      const result = getReportLength(report, 10);

      expect(result).toBe(expectedString.length);
    });
  });

  describe("getRowCount", () => {
    it("should return correct number of rows", () => {
      const msgs: BrChMsgRecord[] = Array.from(
        { length: 3 },
        (_, i) =>
          ({
            type: "Result",
            id: `R00${i + 1}`,
            level: "Error",
            message: `Test message ${i + 1}`,
            time: new Date("2023-01-01"),
            docUrl: "https://docs.example.com",
            code: "TestError",
            paths: [],
          }) as ResultMessageRecord,
      );

      const report = createBreakingChangeMdReport(msgs);
      const result = getRowCount(report);

      expect(result).toBe(3);
    });
  });
});
