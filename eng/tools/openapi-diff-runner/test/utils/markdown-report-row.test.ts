import { describe, expect, it } from "vitest";
import { BrChMsgRecord, ResultMessageRecord } from "../../src/types/message.js";
import {
  BreakingChangeMdRow,
  createBreakingChangeMdRows,
  getDeficitRow,
  getMdTableHeader,
  rowToString,
} from "../../src/utils/markdown-report-row.js";

describe("markdown-report-row", () => {
  // Test constants
  const DATE = new Date("2023-01-01");
  const IDS = {
    test: "test-id",
    test1: "test-id-1",
    test2: "test-id-2",
  };
  const MESSAGES = {
    error: "Test error message",
    rawError: "Raw error message",
    aMessage: "A message",
    zMessage: "Z message",
    removedProperty: "Property 'test' was removed",
    withSpecialChars: "Test message\nwith newlines\tand tabs\r",
    testMessage: "Test message",
  };
  const PATHS = {
    newSimple: "https://github.com/owner/repo/blob/main/specification/test.json#L10:5",
    oldSimple: "https://github.com/owner/repo/blob/old/specification/test.json#L8:3",
    newStorage:
      "https://github.com/owner/repo/blob/main/specification/storage/resource-manager/Microsoft.Storage/stable/2021-01-01/storage.json#L100:5",
    oldStorage:
      "https://github.com/owner/repo/blob/old/specification/storage/resource-manager/Microsoft.Storage/stable/2021-01-01/storage.json#L95:3",
  };
  const JSON_PATHS = {
    simple: "$.paths./test.get",
    simpleOld: "$.paths./test.get.old",
    storageProperty: "$.definitions.StorageAccount.properties.test",
    storagePropertyOld: "$.definitions.StorageAccount.properties.test.old",
  };

  // Helper functions
  const createPath = (tag: string, path: string, jsonPath: string) => ({ tag, path, jsonPath });

  const createResultMessage = (
    message: string,
    paths: Array<{ tag: string; path: string; jsonPath: string }> = [],
    id = IDS.test,
  ): ResultMessageRecord =>
    ({
      type: "Result",
      id,
      level: "Error",
      message,
      time: DATE,
      paths,
    }) as ResultMessageRecord;

  const createRawMessage = (message: string, extra: Record<string, any> = {}): BrChMsgRecord => ({
    type: "Raw",
    level: "Error",
    message,
    time: DATE,
    groupName: "test-group",
    extra,
  });

  const createRow = (
    index: number,
    description: string,
    msg: BrChMsgRecord,
  ): BreakingChangeMdRow => ({
    index,
    description,
    msg,
  });

  const expectRowStructure = (result: BreakingChangeMdRow[], expectedLength: number) => {
    expect(result).toHaveLength(expectedLength);
    if (expectedLength > 0) {
      expect(result[0]).toMatchObject({
        index: 1,
        msg: expect.any(Object),
        description: expect.any(String),
      });
    }
  };

  const createSimplePaths = () => [
    createPath("New", PATHS.newSimple, JSON_PATHS.simple),
    createPath("Old", PATHS.oldSimple, JSON_PATHS.simpleOld),
  ];

  const createStoragePaths = () => [
    createPath("New", PATHS.newStorage, JSON_PATHS.storageProperty),
    createPath("Old", PATHS.oldStorage, JSON_PATHS.storagePropertyOld),
  ];
  describe("createBreakingChangeMdRows", () => {
    it("should create rows from Result messages", () => {
      const paths = createSimplePaths();
      const msgs = [createResultMessage(MESSAGES.error, paths)];

      const result = createBreakingChangeMdRows(msgs);

      expectRowStructure(result, 1);
      expect(result[0].msg).toBe(msgs[0]);
      expect(result[0].description).toContain(MESSAGES.error);
    });

    it("should create rows from Raw messages", () => {
      const extra = { details: "Additional details", code: "ERROR_CODE" };
      const msgs = [createRawMessage(MESSAGES.rawError, extra)];

      const result = createBreakingChangeMdRows(msgs);

      expectRowStructure(result, 1);
      expect(result[0].description).toContain('"details":"Additional details"');
      expect(result[0].description).toContain('"code":"ERROR_CODE"');
    });

    it("should sort rows by description", () => {
      const msgs = [
        createResultMessage(MESSAGES.zMessage, [], IDS.test2),
        createResultMessage(MESSAGES.aMessage, [], IDS.test1),
      ];

      const result = createBreakingChangeMdRows(msgs);

      expect(result[0].msg.message).toBe(MESSAGES.zMessage);
      expect(result[1].msg.message).toBe(MESSAGES.aMessage);
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
      const msg = createResultMessage(MESSAGES.testMessage);
      const row = createRow(1, "Test description with <br/> tags", msg);

      const result = rowToString(row);
      expect(result).toBe("| 1 | Test description with <br/> tags |\n");
    });
  });

  describe("integration with complex messages", () => {
    it("should handle Result message with multiple paths", () => {
      const paths = createStoragePaths();
      const msgs = [createResultMessage(MESSAGES.removedProperty, paths)];

      const result = createBreakingChangeMdRows(msgs);
      const description = result[0].description;

      expect(description).toContain("Property 'test' was removed");
      expect(description).toContain("New: [Microsoft.Storage/stable/2021-01-01/storage.json");
      expect(description).toContain("Old: [Microsoft.Storage/stable/2021-01-01/storage.json");
      expect(description).toContain("<code>$.definitions.StorageAccount.properties.test</code>");
    });

    it("should handle message with newlines and tabs", () => {
      const msgs = [createResultMessage(MESSAGES.withSpecialChars)];

      const result = createBreakingChangeMdRows(msgs);
      expect(result[0].description).toBe("Test message with newlines and tabs <br/>");
    });
  });
});
