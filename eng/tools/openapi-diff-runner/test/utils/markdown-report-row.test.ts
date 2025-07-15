import { describe, it, expect } from "vitest";
import {
  createBreakingChangeMdRows,
  getMdTableHeader,
  getDeficitRow,
  rowToString,
  BreakingChangeMdRow,
} from "../../src/utils/markdown-report-row.js";
import { BrChMsgRecord, ResultMessageRecord } from "../../src/types/message.js";

describe("markdown-report-row", () => {
  describe("createBreakingChangeMdRows", () => {
    it("should create rows from Result messages", () => {
      const msgs: BrChMsgRecord[] = [
        {
          type: "Result",
          id: "test-id",
          level: "Error",
          message: "Test error message",
          time: new Date("2023-01-01"),
          paths: [
            {
              tag: "New",
              path: "https://github.com/owner/repo/blob/main/specification/test.json#L10:5",
              jsonPath: "$.paths./test.get",
            },
            {
              tag: "Old",
              path: "https://github.com/owner/repo/blob/old/specification/test.json#L8:3",
              jsonPath: "$.paths./test.get.old",
            },
          ],
        } as ResultMessageRecord,
      ];

      const result = createBreakingChangeMdRows(msgs);

      expect(result).toHaveLength(1);
      expect(result[0].index).toBe(1);
      expect(result[0].msg).toBe(msgs[0]);
      expect(result[0].description).toContain("Test error message");
    });

    it("should create rows from Raw messages", () => {
      const msgs: BrChMsgRecord[] = [
        {
          type: "Raw",
          level: "Error",
          message: "Raw error message",
          time: new Date("2023-01-01"),
          groupName: "test-group",
          extra: {
            details: "Additional details",
            code: "ERROR_CODE",
          },
        },
      ];

      const result = createBreakingChangeMdRows(msgs);

      expect(result).toHaveLength(1);
      expect(result[0].index).toBe(1);
      expect(result[0].description).toContain('"details":"Additional details"');
      expect(result[0].description).toContain('"code":"ERROR_CODE"');
    });

    it("should sort rows by description", () => {
      const msgs: BrChMsgRecord[] = [
        {
          type: "Result",
          id: "test-id-2",
          level: "Error",
          message: "Z message",
          time: new Date("2023-01-01"),
          paths: [],
        } as ResultMessageRecord,
        {
          type: "Result",
          id: "test-id-1",
          level: "Error",
          message: "A message",
          time: new Date("2023-01-01"),
          paths: [],
        } as ResultMessageRecord,
      ];

      const result = createBreakingChangeMdRows(msgs);

      expect(result[0].msg.message).toBe("A message");
      expect(result[1].msg.message).toBe("Z message");
    });
  });

  describe("getMdTableHeader", () => {
    it("should return markdown table header", () => {
      const result = getMdTableHeader();
      expect(result).toBe("| Index | Description |\n|-|-|\n");
    });
  });

  describe("getDeficitRow", () => {
    it("should return singular deficit row", () => {
      const result = getDeficitRow(1);
      expect(result).toBe("|| ⚠️ 1 occurrence omitted. See the build log.|\n");
    });

    it("should return plural deficit row", () => {
      const result = getDeficitRow(5);
      expect(result).toBe("|| ⚠️ 5 occurrences omitted. See the build log.|\n");
    });
  });

  describe("rowToString", () => {
    it("should convert row to markdown string", () => {
      const row: BreakingChangeMdRow = {
        index: 1,
        description: "Test description with <br/> tags",
        msg: {
          type: "Result",
          id: "test-id",
          level: "Error",
          message: "Test message",
          time: new Date("2023-01-01"),
          paths: [],
        } as ResultMessageRecord,
      };

      const result = rowToString(row);
      expect(result).toBe("| 1 | Test description with <br/> tags |\n");
    });
  });

  describe("integration with complex messages", () => {
    it("should handle Result message with multiple paths", () => {
      const msgs: BrChMsgRecord[] = [
        {
          type: "Result",
          id: "test-id",
          level: "Error",
          message: "Property 'test' was removed",
          time: new Date("2023-01-01"),
          paths: [
            {
              tag: "New",
              path: "https://github.com/owner/repo/blob/main/specification/storage/resource-manager/Microsoft.Storage/stable/2021-01-01/storage.json#L100:5",
              jsonPath: "$.definitions.StorageAccount.properties.test",
            },
            {
              tag: "Old",
              path: "https://github.com/owner/repo/blob/old/specification/storage/resource-manager/Microsoft.Storage/stable/2021-01-01/storage.json#L95:3",
              jsonPath: "$.definitions.StorageAccount.properties.test.old",
            },
          ],
        } as ResultMessageRecord,
      ];

      const result = createBreakingChangeMdRows(msgs);
      const description = result[0].description;

      expect(description).toContain("Property 'test' was removed");
      expect(description).toContain("New: [Microsoft.Storage/stable/2021-01-01/storage.json");
      expect(description).toContain("Old: [Microsoft.Storage/stable/2021-01-01/storage.json");
      expect(description).toContain("<code>$.definitions.StorageAccount.properties.test</code>");
    });

    it("should handle message with newlines and tabs", () => {
      const msgs: BrChMsgRecord[] = [
        {
          type: "Result",
          id: "test-id",
          level: "Error",
          message: "Test message\nwith newlines\tand tabs\r",
          time: new Date("2023-01-01"),
          paths: [],
        } as ResultMessageRecord,
      ];

      const result = createBreakingChangeMdRows(msgs);
      expect(result[0].description).toBe("Test message with newlines and tabs <br/>");
    });
  });
});
