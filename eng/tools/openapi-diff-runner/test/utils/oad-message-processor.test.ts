import { describe, it, expect, vi, beforeEach, afterEach } from "vitest";
import fs from "fs";
import path from "path";
import {
  convertOadMessagesToResultMessageRecords,
  createOadMessageProcessor,
  createMessageKey,
  appendToLogFile,
  appendMarkdownToLog,
  processAndAppendOadMessages,
  clearMessageCache,
  getMessageCacheSize,
  OadMessageProcessorContext,
} from "../../src/utils/oad-message-processor.js";
import { OadMessage } from "../../src/types/oad-types.js";
import { MessageLevel } from "../../src/types/message.js";
import { logMessage } from "../../src/log.js";

// Mock dependencies
vi.mock("fs");
vi.mock("../../src/log.js");
vi.mock("../../src/utils/common-utils.js", () => ({
  sourceBranchHref: vi.fn(
    (location: string) => `https://github.com/owner/repo/blob/main/${location}`,
  ),
  specificBranchHref: vi.fn(
    (location: string, branch: string) =>
      `https://github.com/owner/repo/blob/${branch}/${location}`,
  ),
}));
vi.mock("../../src/utils/breaking-change-config.js", () => ({
  logFileName: "breaking-change.log",
}));
vi.mock("../../src/command-helpers.js", () => ({
  defaultBreakingChangeBaseBranch: "main",
}));

describe("oad-message-processor", () => {
  const mockAppendFileSync = vi.mocked(fs.appendFileSync);
  const mockLogMessage = vi.mocked(logMessage);

  beforeEach(() => {
    vi.clearAllMocks();
  });

  afterEach(() => {
    vi.resetAllMocks();
  });

  describe("convertOadMessagesToResultMessageRecords", () => {
    const createMockOadMessage = (overrides: Partial<OadMessage> = {}): OadMessage => ({
      type: "Error",
      code: "RemovedProperty",
      message: "Test error message",
      id: "test-id",
      docUrl: "https://docs.example.com/rules/RemovedProperty",
      mode: "test",
      groupName: "stable",
      new: {
        location: "specification/test/new.json",
        path: "$.definitions.TestModel",
      },
      old: {
        location: "specification/test/old.json",
        path: "$.definitions.TestModel",
      },
      ...overrides,
    });

    it("should convert OAD messages to result message records", () => {
      const oadMessages: OadMessage[] = [createMockOadMessage()];

      const result = convertOadMessagesToResultMessageRecords(oadMessages);

      expect(result).toHaveLength(1);
      expect(result[0]).toEqual({
        type: "Result",
        level: "Error",
        message: "Test error message",
        code: "RemovedProperty",
        id: "test-id",
        docUrl: "https://docs.example.com/rules/RemovedProperty",
        time: expect.any(Date),
        groupName: "stable",
        extra: {
          mode: "test",
        },
        paths: [
          {
            tag: "New",
            path: "https://github.com/owner/repo/blob/main/specification/test/new.json",
            jsonPath: "$.definitions.TestModel",
          },
          {
            tag: "Old",
            path: "https://github.com/owner/repo/blob/main/specification/test/old.json",
            jsonPath: "$.definitions.TestModel",
          },
        ],
      });
    });

    it("should handle custom base branch name", () => {
      const oadMessages: OadMessage[] = [createMockOadMessage()];
      const customBaseBranch = "feature-branch";

      const result = convertOadMessagesToResultMessageRecords(oadMessages, customBaseBranch);

      expect(result[0].paths[1].path).toBe(
        "https://github.com/owner/repo/blob/feature-branch/specification/test/old.json",
      );
    });

    it("should handle messages with missing new location", () => {
      const oadMessages: OadMessage[] = [
        createMockOadMessage({
          new: { location: "", path: "" },
        }),
      ];

      const result = convertOadMessagesToResultMessageRecords(oadMessages);

      expect(result[0].paths).toHaveLength(1);
      expect(result[0].paths[0].tag).toBe("Old");
    });

    it("should handle messages with missing old location", () => {
      const oadMessages: OadMessage[] = [
        createMockOadMessage({
          old: { location: "", path: "" },
        }),
      ];

      const result = convertOadMessagesToResultMessageRecords(oadMessages);

      expect(result[0].paths).toHaveLength(1);
      expect(result[0].paths[0].tag).toBe("New");
    });

    it("should handle messages with no locations", () => {
      const oadMessages: OadMessage[] = [
        createMockOadMessage({
          new: { location: "", path: "" },
          old: { location: "", path: "" },
        }),
      ];

      const result = convertOadMessagesToResultMessageRecords(oadMessages);

      expect(result[0].paths).toHaveLength(0);
    });

    it("should handle different message levels", () => {
      const levels: MessageLevel[] = ["Error", "Warning", "Info"];
      const oadMessages: OadMessage[] = levels.map((level) =>
        createMockOadMessage({ type: level }),
      );

      const result = convertOadMessagesToResultMessageRecords(oadMessages);

      expect(result).toHaveLength(3);
      result.forEach((msg, index) => {
        expect(msg.level).toBe(levels[index]);
      });
    });
  });

  describe("createOadMessageProcessor", () => {
    it("should create processor context with default folder", () => {
      const context = createOadMessageProcessor("", "https://github.com/owner/repo/pull/123");

      expect(context.logFilePath).toBe(path.join(".", "breaking-change.log"));
      expect(context.prUrl).toBe("https://github.com/owner/repo/pull/123");
      expect(context.messageCache).toEqual([]);
    });

    it("should create processor context with custom folder", () => {
      const context = createOadMessageProcessor(
        "/custom/path",
        "https://github.com/owner/repo/pull/456",
      );

      expect(context.logFilePath).toBe(path.join("/custom/path", "breaking-change.log"));
      expect(context.prUrl).toBe("https://github.com/owner/repo/pull/456");
      expect(context.messageCache).toEqual([]);
    });
  });

  describe("createMessageKey", () => {
    const createMockOadMessage = (overrides: Partial<OadMessage> = {}): OadMessage => ({
      type: "Error",
      code: "RemovedProperty",
      message: "Test error message",
      mode: "test",
      groupName: "stable",
      id: "test-id",
      docUrl: "https://docs.example.com/rules/RemovedProperty",
      new: {
        location: "specification/test/new.json",
        path: "$.definitions.TestModel",
      },
      old: {
        location: "specification/test/old.json",
        path: "$.definitions.TestModel",
      },
      ...overrides,
    });

    it("should create consistent keys for identical messages", () => {
      const message1 = createMockOadMessage();
      const message2 = createMockOadMessage();

      const key1 = createMessageKey(message1);
      const key2 = createMessageKey(message2);

      expect(key1).toBe(key2);
    });

    it("should create different keys for different messages", () => {
      const message1 = createMockOadMessage();
      const message2 = createMockOadMessage({ code: "AddedPropertyInResponse" });

      const key1 = createMessageKey(message1);
      const key2 = createMessageKey(message2);

      expect(key1).not.toBe(key2);
    });

    it("should create different keys for different locations", () => {
      const message1 = createMockOadMessage();
      const message2 = createMockOadMessage({
        new: { location: "specification/test/different.json", path: "$.definitions.TestModel" },
      });

      const key1 = createMessageKey(message1);
      const key2 = createMessageKey(message2);

      expect(key1).not.toBe(key2);
    });

    it("should create different keys for different paths", () => {
      const message1 = createMockOadMessage();
      const message2 = createMockOadMessage({
        new: { location: "specification/test/new.json", path: "$.definitions.DifferentModel" },
      });

      const key1 = createMessageKey(message1);
      const key2 = createMessageKey(message2);

      expect(key1).not.toBe(key2);
    });
  });

  describe("appendToLogFile", () => {
    it("should append message to log file with newline", () => {
      const logFilePath = "/path/to/log.txt";
      const message = "Test log message";

      appendToLogFile(logFilePath, message);

      expect(mockAppendFileSync).toHaveBeenCalledTimes(2);
      expect(mockAppendFileSync).toHaveBeenNthCalledWith(1, logFilePath, message);
      expect(mockAppendFileSync).toHaveBeenNthCalledWith(2, logFilePath, "\n");
      expect(mockLogMessage).toHaveBeenCalledWith("oad-message-processor.appendMsg: " + message);
    });
  });

  describe("appendMarkdownToLog", () => {
    it("should append markdown with default error level", () => {
      const context: OadMessageProcessorContext = {
        logFilePath: "/path/to/log.txt",
        prUrl: "https://github.com/owner/repo/pull/123",
        messageCache: [],
      };
      const errorMsg = "Test markdown error";

      appendMarkdownToLog(context, errorMsg);

      expect(mockAppendFileSync).toHaveBeenCalledTimes(2);
      const appendedContent = mockAppendFileSync.mock.calls[0][1] as string;
      const parsedContent = JSON.parse(appendedContent);

      expect(parsedContent).toEqual({
        type: "Markdown",
        mode: "append",
        level: "Error",
        message: errorMsg,
        time: expect.any(String),
      });
    });

    it("should append markdown with custom level", () => {
      const context: OadMessageProcessorContext = {
        logFilePath: "/path/to/log.txt",
        prUrl: "https://github.com/owner/repo/pull/123",
        messageCache: [],
      };
      const errorMsg = "Test markdown warning";
      const levelType = "Warning";

      appendMarkdownToLog(context, errorMsg, levelType);

      const appendedContent = mockAppendFileSync.mock.calls[0][1] as string;
      const parsedContent = JSON.parse(appendedContent);

      expect(parsedContent.level).toBe(levelType);
    });
  });

  describe("processAndAppendOadMessages", () => {
    const createMockOadMessage = (overrides: Partial<OadMessage> = {}): OadMessage => ({
      type: "Error",
      code: "RemovedProperty",
      message: "Test error message",
      id: "test-id",
      docUrl: "https://docs.example.com/rules/RemovedProperty",
      mode: "test",
      groupName: "stable",
      new: {
        location: "specification/test/new.json",
        path: "$.definitions.TestModel",
      },
      old: {
        location: "specification/test/old.json",
        path: "$.definitions.TestModel",
      },
      ...overrides,
    });

    it("should process and append new messages", () => {
      const context: OadMessageProcessorContext = {
        logFilePath: "/path/to/log.txt",
        prUrl: "https://github.com/owner/repo/pull/123",
        messageCache: [],
      };
      const oadMessages = [createMockOadMessage()];
      const baseBranch = "main";

      const result = processAndAppendOadMessages(context, oadMessages, baseBranch);

      expect(result).toHaveLength(1);
      expect(context.messageCache).toHaveLength(1);
      expect(mockAppendFileSync).toHaveBeenCalledTimes(2);
      expect(mockLogMessage).toHaveBeenCalledWith(
        expect.stringContaining("oad-message-processor.processAndAppendOadMessages"),
      );
    });

    it("should deduplicate messages", () => {
      const context: OadMessageProcessorContext = {
        logFilePath: "/path/to/log.txt",
        prUrl: "https://github.com/owner/repo/pull/123",
        messageCache: [],
      };

      const baseMessage = createMockOadMessage();
      const differentMessage = createMockOadMessage({ code: "AddedPropertyInResponse" });
      const oadMessages = [baseMessage, differentMessage];
      const baseBranch = "main";

      const result = processAndAppendOadMessages(context, oadMessages, baseBranch);

      expect(result).toHaveLength(2); // Both unique messages
      expect(context.messageCache).toHaveLength(2);
      expect(mockLogMessage).toHaveBeenCalledWith(
        expect.stringContaining("duplicateOadMessages.length: 0"),
      );
    });

    it("should test actual deduplication with cache", () => {
      // First, add a message to the cache
      const existingMessage = createMockOadMessage();
      const context: OadMessageProcessorContext = {
        logFilePath: "/path/to/log.txt",
        prUrl: "https://github.com/owner/repo/pull/123",
        messageCache: [existingMessage],
      };

      // Create new messages including one that matches the cached message
      const sameMessage = { ...existingMessage };
      const differentMessage = createMockOadMessage({ code: "AddedPropertyInResponse" });
      const oadMessages = [sameMessage, differentMessage];
      const baseBranch = "main";

      const result = processAndAppendOadMessages(context, oadMessages, baseBranch);

      expect(result).toHaveLength(1); // Only the different message should be processed
      expect(context.messageCache).toHaveLength(2); // Original + new different message
      expect(mockLogMessage).toHaveBeenCalledWith(
        expect.stringContaining("duplicateOadMessages.length: 1"),
      );
    });

    it("should not process messages already in cache", () => {
      const existingMessage = createMockOadMessage();
      const context: OadMessageProcessorContext = {
        logFilePath: "/path/to/log.txt",
        prUrl: "https://github.com/owner/repo/pull/123",
        messageCache: [existingMessage],
      };
      const oadMessages = [createMockOadMessage()]; // Same as existing
      const baseBranch = "main";

      const result = processAndAppendOadMessages(context, oadMessages, baseBranch);

      expect(result).toHaveLength(0); // No new messages
      expect(context.messageCache).toHaveLength(1); // Cache unchanged
      expect(mockLogMessage).toHaveBeenCalledWith(
        expect.stringContaining("duplicateOadMessages.length: 1"),
      );
    });

    it("should log processing statistics", () => {
      const context: OadMessageProcessorContext = {
        logFilePath: "/path/to/log.txt",
        prUrl: "https://github.com/owner/repo/pull/123",
        messageCache: [],
      };

      const message1 = createMockOadMessage();
      const message2 = createMockOadMessage({ code: "AddedPropertyInResponse" });
      const oadMessages = [message1, message2];
      const baseBranch = "develop";

      processAndAppendOadMessages(context, oadMessages, baseBranch);

      expect(mockLogMessage).toHaveBeenCalledWith(
        "oad-message-processor.processAndAppendOadMessages: PR:https://github.com/owner/repo/pull/123, " +
          "baseBranch: develop, oadMessages.length: 2, duplicateOadMessages.length: 0, messageCache.length: 0.",
      );
    });
  });

  describe("clearMessageCache", () => {
    it("should clear the message cache", () => {
      const context: OadMessageProcessorContext = {
        logFilePath: "/path/to/log.txt",
        prUrl: "https://github.com/owner/repo/pull/123",
        messageCache: [
          {
            type: "Error",
            code: "RemovedProperty",
            message: "Test",
            id: "test-id",
            docUrl: "https://docs.example.com/rules/RemovedProperty",
            mode: "test",
            groupName: "stable",
            new: { location: "new.json", path: "$.path" },
            old: { location: "old.json", path: "$.path" },
          },
        ],
      };

      clearMessageCache(context);

      expect(context.messageCache).toHaveLength(0);
    });
  });

  describe("getMessageCacheSize", () => {
    it("should return the size of message cache", () => {
      const context: OadMessageProcessorContext = {
        logFilePath: "/path/to/log.txt",
        prUrl: "https://github.com/owner/repo/pull/123",
        messageCache: [
          {
            type: "Error",
            code: "RemovedProperty",
            message: "Test 1",
            id: "test-id-1",
            docUrl: "https://docs.example.com/rules/RemovedProperty",
            mode: "test",
            groupName: "stable",
            new: { location: "new.json", path: "$.path" },
            old: { location: "old.json", path: "$.path" },
          },
          {
            type: "Warning",
            code: "AddedPropertyInResponse",
            message: "Test 2",
            id: "test-id-2",
            docUrl: "https://docs.example.com/rules/AddedPropertyInResponse",
            mode: "test",
            groupName: "preview",
            new: { location: "new2.json", path: "$.path2" },
            old: { location: "old2.json", path: "$.path2" },
          },
        ],
      };

      const size = getMessageCacheSize(context);

      expect(size).toBe(2);
    });

    it("should return 0 for empty cache", () => {
      const context: OadMessageProcessorContext = {
        logFilePath: "/path/to/log.txt",
        prUrl: "https://github.com/owner/repo/pull/123",
        messageCache: [],
      };

      const size = getMessageCacheSize(context);

      expect(size).toBe(0);
    });
  });
});
