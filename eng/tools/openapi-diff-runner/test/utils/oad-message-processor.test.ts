import fs from "node:fs";
import path from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { logMessage, logMessageSafe } from "../../src/log.js";
import { ApiVersionLifecycleStage, Context } from "../../src/types/breaking-change.js";
import { MessageLevel } from "../../src/types/message.js";
import { OadMessage } from "../../src/types/oad-types.js";
import {
  appendMarkdownToLog,
  appendToLogFile,
  clearMessageCache,
  convertOadMessagesToResultMessageRecords,
  createMessageKey,
  createOadMessageProcessor,
  getMessageCacheSize,
  OadMessageProcessorContext,
  processAndAppendOadMessages,
} from "../../src/utils/oad-message-processor.js";

// Test constants
const TEST_CONSTANTS = {
  REPO: "owner/repo",
  COMMIT: "abc123",
  LOG_PATH: "/path/to/log.txt",
  PR_URL: "https://github.com/owner/repo/pull/123",
  PR_NUMBER: "123",
  BRANCH: {
    MAIN: "main",
    FEATURE: "feature",
    TARGET: "main",
    CUSTOM: "feature-branch",
    DEVELOP: "develop",
  },
  PATHS: {
    NEW: "specification/test/new.json",
    OLD: "specification/test/old.json",
    DIFFERENT: "specification/test/different.json",
    WORKING: "/working",
    LOGS: "/logs",
    REPO: "/path/to/repo",
    CUSTOM: "/custom/path",
  },
  MESSAGES: {
    TEST: "Test error message",
    WARNING: "Test markdown warning",
    ERROR: "Test markdown error",
  },
  RULES: {
    REMOVED_PROPERTY: "RemovedProperty",
    ADDED_PROPERTY: "AddedPropertyInResponse",
  },
  JSON_PATHS: {
    TEST_MODEL: "$.definitions.TestModel",
    DIFFERENT_MODEL: "$.definitions.DifferentModel",
    PATH: "$.path",
    PATH2: "$.path2",
  },
  LOCATIONS: {
    NEW: "new.json",
    OLD: "old.json",
    NEW2: "new2.json",
    OLD2: "old2.json",
  },
} as const;

// Helper functions
function createMockOadMessage(overrides: Partial<OadMessage> = {}): OadMessage {
  return {
    type: "Error",
    code: TEST_CONSTANTS.RULES.REMOVED_PROPERTY,
    message: TEST_CONSTANTS.MESSAGES.TEST,
    id: "test-id",
    docUrl: `https://docs.example.com/rules/${TEST_CONSTANTS.RULES.REMOVED_PROPERTY}`,
    mode: "test",
    groupName: ApiVersionLifecycleStage.STABLE,
    new: {
      location: TEST_CONSTANTS.PATHS.NEW,
      path: TEST_CONSTANTS.JSON_PATHS.TEST_MODEL,
    },
    old: {
      location: TEST_CONSTANTS.PATHS.OLD,
      path: TEST_CONSTANTS.JSON_PATHS.TEST_MODEL,
    },
    ...overrides,
  };
}

function createMockContext(): Context {
  return {
    sourceRepo: TEST_CONSTANTS.REPO,
    headCommit: TEST_CONSTANTS.COMMIT,
    targetRepo: TEST_CONSTANTS.REPO,
    localSpecRepoPath: TEST_CONSTANTS.PATHS.REPO,
    workingFolder: TEST_CONSTANTS.PATHS.WORKING,
    logFileFolder: TEST_CONSTANTS.PATHS.LOGS,
    swaggerDirs: ["specification"],
    baseBranch: TEST_CONSTANTS.BRANCH.MAIN,
    runType: "SameVersion",
    checkName: "test",
    prNumber: TEST_CONSTANTS.PR_NUMBER,
    prSourceBranch: TEST_CONSTANTS.BRANCH.FEATURE,
    prTargetBranch: TEST_CONSTANTS.BRANCH.TARGET,
    oadMessageProcessorContext: {
      logFilePath: TEST_CONSTANTS.LOG_PATH,
      prUrl: TEST_CONSTANTS.PR_URL,
      messageCache: [],
    },
    prUrl: TEST_CONSTANTS.PR_URL,
  } as Context;
}

function createProcessorContext(
  logFilePath: string = TEST_CONSTANTS.LOG_PATH,
  prUrl: string = TEST_CONSTANTS.PR_URL,
  messageCache: OadMessage[] = [],
): OadMessageProcessorContext {
  return {
    logFilePath,
    prUrl,
    messageCache,
  };
}

// Mock dependencies
vi.mock("node:fs");
vi.mock("../../src/log.js");
vi.mock("../../src/utils/common-utils.js", () => ({
  sourceBranchHref: vi.fn(
    (repo: string, sha: string, file: string) => `https://github.com/${repo}/blob/${sha}/${file}`,
  ),
  specificBranchHref: vi.fn(
    (repo: string, file: string, branchName: string) =>
      `https://github.com/${repo}/blob/${branchName}/${file}`,
  ),
}));
vi.mock("../../src/types/breaking-change.js", async (importOriginal) => {
  const actual = (await importOriginal()) as any;
  return {
    ...actual,
    logFileName: "breaking-change.log",
  };
});

describe("oad-message-processor", () => {
  const mockAppendFileSync = vi.mocked(fs.appendFileSync);
  const mockLogMessage = vi.mocked(logMessage);
  const mockLogMessageSafe = vi.mocked(logMessageSafe);
  const mockContext = createMockContext();

  // Helper functions with access to mocks
  function expectAppendFileSync(callIndex: number, filePath: string, content: string) {
    expect(mockAppendFileSync).toHaveBeenNthCalledWith(callIndex, filePath, content);
  }

  function expectLogMessage(message: string) {
    expect(mockLogMessage).toHaveBeenCalledWith(expect.stringContaining(message));
  }
  function expectLogMessageSafe(message: string) {
    expect(mockLogMessageSafe).toHaveBeenCalledWith(expect.stringContaining(message));
  }

  beforeEach(() => {
    vi.clearAllMocks();
  });

  afterEach(() => {
    vi.resetAllMocks();
  });

  describe("convertOadMessagesToResultMessageRecords", () => {
    it("should convert OAD messages to result message records", () => {
      const oadMessages: OadMessage[] = [createMockOadMessage()];

      const result = convertOadMessagesToResultMessageRecords(
        mockContext,
        oadMessages,
        TEST_CONSTANTS.BRANCH.MAIN,
      );

      expect(result).toHaveLength(1);
      expect(result[0]).toEqual({
        type: "Result",
        level: "Error",
        message: TEST_CONSTANTS.MESSAGES.TEST,
        code: TEST_CONSTANTS.RULES.REMOVED_PROPERTY,
        id: "test-id",
        docUrl: `https://docs.example.com/rules/${TEST_CONSTANTS.RULES.REMOVED_PROPERTY}`,
        time: expect.any(Date),
        groupName: ApiVersionLifecycleStage.STABLE,
        extra: {
          mode: "test",
        },
        paths: [
          {
            tag: "New",
            path: `https://github.com/${TEST_CONSTANTS.REPO}/blob/${TEST_CONSTANTS.COMMIT}/${TEST_CONSTANTS.PATHS.NEW}`,
            jsonPath: TEST_CONSTANTS.JSON_PATHS.TEST_MODEL,
          },
          {
            tag: "Old",
            path: `https://github.com/${TEST_CONSTANTS.REPO}/blob/${TEST_CONSTANTS.BRANCH.MAIN}/${TEST_CONSTANTS.PATHS.OLD}`,
            jsonPath: TEST_CONSTANTS.JSON_PATHS.TEST_MODEL,
          },
        ],
      });
    });

    it("should handle custom base branch name", () => {
      const oadMessages: OadMessage[] = [createMockOadMessage()];

      const result = convertOadMessagesToResultMessageRecords(
        mockContext,
        oadMessages,
        TEST_CONSTANTS.BRANCH.CUSTOM,
      );

      expect(result[0].paths[1].path).toBe(
        `https://github.com/${TEST_CONSTANTS.REPO}/blob/${TEST_CONSTANTS.BRANCH.CUSTOM}/${TEST_CONSTANTS.PATHS.OLD}`,
      );
    });

    it("should handle messages with missing new location", () => {
      const oadMessages: OadMessage[] = [
        createMockOadMessage({
          new: { location: "", path: "" },
        }),
      ];

      const result = convertOadMessagesToResultMessageRecords(
        mockContext,
        oadMessages,
        TEST_CONSTANTS.BRANCH.MAIN,
      );

      expect(result[0].paths).toHaveLength(1);
      expect(result[0].paths[0].tag).toBe("Old");
    });

    it("should handle messages with missing old location", () => {
      const oadMessages: OadMessage[] = [
        createMockOadMessage({
          old: { location: "", path: "" },
        }),
      ];

      const result = convertOadMessagesToResultMessageRecords(
        mockContext,
        oadMessages,
        TEST_CONSTANTS.BRANCH.MAIN,
      );

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

      const result = convertOadMessagesToResultMessageRecords(
        mockContext,
        oadMessages,
        TEST_CONSTANTS.BRANCH.MAIN,
      );

      expect(result[0].paths).toHaveLength(0);
    });

    it("should handle different message levels", () => {
      const levels: MessageLevel[] = ["Error", "Warning", "Info"];
      const oadMessages: OadMessage[] = levels.map((level) =>
        createMockOadMessage({ type: level }),
      );

      const result = convertOadMessagesToResultMessageRecords(
        mockContext,
        oadMessages,
        TEST_CONSTANTS.BRANCH.MAIN,
      );

      expect(result).toHaveLength(3);
      result.forEach((msg, index) => {
        expect(msg.level).toBe(levels[index]);
      });
    });
  });

  describe("createOadMessageProcessor", () => {
    it("should create processor context with default folder", () => {
      const context = createOadMessageProcessor("", TEST_CONSTANTS.PR_URL);

      expect(context.logFilePath).toBe(path.join(".", "breaking-change.log"));
      expect(context.prUrl).toBe(TEST_CONSTANTS.PR_URL);
      expect(context.messageCache).toEqual([]);
    });

    it("should create processor context with custom folder", () => {
      const customPrUrl = "https://github.com/owner/repo/pull/456";
      const context = createOadMessageProcessor(TEST_CONSTANTS.PATHS.CUSTOM, customPrUrl);

      expect(context.logFilePath).toBe(
        path.join(TEST_CONSTANTS.PATHS.CUSTOM, "breaking-change.log"),
      );
      expect(context.prUrl).toBe(customPrUrl);
      expect(context.messageCache).toEqual([]);
    });
  });

  describe("createMessageKey", () => {
    it("should create consistent keys for identical messages", () => {
      const message1 = createMockOadMessage();
      const message2 = createMockOadMessage();

      const key1 = createMessageKey(message1);
      const key2 = createMessageKey(message2);

      expect(key1).toBe(key2);
    });

    it("should create different keys for different messages", () => {
      const message1 = createMockOadMessage();
      const message2 = createMockOadMessage({ code: TEST_CONSTANTS.RULES.ADDED_PROPERTY });

      const key1 = createMessageKey(message1);
      const key2 = createMessageKey(message2);

      expect(key1).not.toBe(key2);
    });

    it("should create different keys for different locations", () => {
      const message1 = createMockOadMessage();
      const message2 = createMockOadMessage({
        new: {
          location: TEST_CONSTANTS.PATHS.DIFFERENT,
          path: TEST_CONSTANTS.JSON_PATHS.TEST_MODEL,
        },
      });

      const key1 = createMessageKey(message1);
      const key2 = createMessageKey(message2);

      expect(key1).not.toBe(key2);
    });

    it("should create different keys for different paths", () => {
      const message1 = createMockOadMessage();
      const message2 = createMockOadMessage({
        new: {
          location: TEST_CONSTANTS.PATHS.NEW,
          path: TEST_CONSTANTS.JSON_PATHS.DIFFERENT_MODEL,
        },
      });

      const key1 = createMessageKey(message1);
      const key2 = createMessageKey(message2);

      expect(key1).not.toBe(key2);
    });
  });

  describe("appendToLogFile", () => {
    it("should append message to log file with newline", () => {
      const message = "Test log message";

      appendToLogFile(TEST_CONSTANTS.LOG_PATH, message);

      expect(mockAppendFileSync).toHaveBeenCalledTimes(2);
      expectAppendFileSync(1, TEST_CONSTANTS.LOG_PATH, message);
      expectAppendFileSync(2, TEST_CONSTANTS.LOG_PATH, "\n");
      expectLogMessageSafe("oad-message-processor.appendMsg: " + message);
    });
  });

  describe("appendMarkdownToLog", () => {
    it("should append markdown with default error level", () => {
      const context = createProcessorContext();

      appendMarkdownToLog(context, TEST_CONSTANTS.MESSAGES.ERROR);

      expect(mockAppendFileSync).toHaveBeenCalledTimes(2);
      const appendedContent = mockAppendFileSync.mock.calls[0][1] as string;
      const parsedContent = JSON.parse(appendedContent);

      expect(parsedContent).toEqual({
        type: "Markdown",
        mode: "append",
        level: "Error",
        message: TEST_CONSTANTS.MESSAGES.ERROR,
        time: expect.any(String),
      });
    });

    it("should append markdown with custom level", () => {
      const context = createProcessorContext();

      appendMarkdownToLog(context, TEST_CONSTANTS.MESSAGES.WARNING, "Warning");

      const appendedContent = mockAppendFileSync.mock.calls[0][1] as string;
      const parsedContent = JSON.parse(appendedContent);

      expect(parsedContent.level).toBe("Warning");
    });
  });

  describe("processAndAppendOadMessages", () => {
    it("should process and append new messages", () => {
      // Reset message cache for this test
      mockContext.oadMessageProcessorContext.messageCache = [];

      const oadMessages = [createMockOadMessage()];

      const result = processAndAppendOadMessages(
        mockContext,
        oadMessages,
        TEST_CONSTANTS.BRANCH.MAIN,
      );

      expect(result).toHaveLength(1);
      expect(mockContext.oadMessageProcessorContext.messageCache).toHaveLength(1);
      expect(mockAppendFileSync).toHaveBeenCalledTimes(2);
      expectLogMessage("oad-message-processor.processAndAppendOadMessages");
    });

    it("should deduplicate messages", () => {
      // Reset message cache for this test
      mockContext.oadMessageProcessorContext.messageCache = [];

      const baseMessage = createMockOadMessage();
      const differentMessage = createMockOadMessage({ code: TEST_CONSTANTS.RULES.ADDED_PROPERTY });
      const oadMessages = [baseMessage, differentMessage];

      const result = processAndAppendOadMessages(
        mockContext,
        oadMessages,
        TEST_CONSTANTS.BRANCH.MAIN,
      );

      expect(result).toHaveLength(2); // Both unique messages
      expect(mockContext.oadMessageProcessorContext.messageCache).toHaveLength(2);
      expectLogMessage("duplicateOadMessages.length: 0");
    });

    it("should test actual deduplication with cache", () => {
      // First, add a message to the cache
      const existingMessage = createMockOadMessage();
      mockContext.oadMessageProcessorContext.messageCache = [existingMessage];

      // Create new messages including one that matches the cached message
      const sameMessage = { ...existingMessage };
      const differentMessage = createMockOadMessage({ code: TEST_CONSTANTS.RULES.ADDED_PROPERTY });
      const oadMessages = [sameMessage, differentMessage];

      const result = processAndAppendOadMessages(
        mockContext,
        oadMessages,
        TEST_CONSTANTS.BRANCH.MAIN,
      );

      expect(result).toHaveLength(1); // Only the different message should be processed
      expect(mockContext.oadMessageProcessorContext.messageCache).toHaveLength(2); // Original + new different message
      expectLogMessage("duplicateOadMessages.length: 1");
    });

    it("should not process messages already in cache", () => {
      const existingMessage = createMockOadMessage();
      mockContext.oadMessageProcessorContext.messageCache = [existingMessage];

      const oadMessages = [createMockOadMessage()]; // Same as existing

      const result = processAndAppendOadMessages(
        mockContext,
        oadMessages,
        TEST_CONSTANTS.BRANCH.MAIN,
      );

      expect(result).toHaveLength(0); // No new messages
      expect(mockContext.oadMessageProcessorContext.messageCache).toHaveLength(1); // Cache unchanged
      expectLogMessage("duplicateOadMessages.length: 1");
    });

    it("should log processing statistics", () => {
      mockContext.oadMessageProcessorContext.messageCache = [];

      const message1 = createMockOadMessage();
      const message2 = createMockOadMessage({ code: TEST_CONSTANTS.RULES.ADDED_PROPERTY });
      const oadMessages = [message1, message2];

      processAndAppendOadMessages(mockContext, oadMessages, TEST_CONSTANTS.BRANCH.DEVELOP);

      expect(mockLogMessage).toHaveBeenCalledWith(
        `oad-message-processor.processAndAppendOadMessages: PR:${TEST_CONSTANTS.PR_URL}, ` +
          `baseBranch: ${TEST_CONSTANTS.BRANCH.DEVELOP}, oadMessages.length: 2, duplicateOadMessages.length: 0, messageCache.length: 0.`,
      );
    });
  });

  describe("clearMessageCache", () => {
    it("should clear the message cache", () => {
      const context = createProcessorContext(TEST_CONSTANTS.LOG_PATH, TEST_CONSTANTS.PR_URL, [
        createMockOadMessage(),
      ]);

      clearMessageCache(context);

      expect(context.messageCache).toHaveLength(0);
    });
  });

  describe("getMessageCacheSize", () => {
    it("should return the size of message cache", () => {
      const context = createProcessorContext(TEST_CONSTANTS.LOG_PATH, TEST_CONSTANTS.PR_URL, [
        createMockOadMessage({
          message: "Test 1",
          id: "test-id-1",
        }),
        createMockOadMessage({
          type: "Warning",
          code: TEST_CONSTANTS.RULES.ADDED_PROPERTY,
          message: "Test 2",
          id: "test-id-2",
          groupName: ApiVersionLifecycleStage.PREVIEW,
          new: { location: TEST_CONSTANTS.LOCATIONS.NEW2, path: TEST_CONSTANTS.JSON_PATHS.PATH2 },
          old: { location: TEST_CONSTANTS.LOCATIONS.OLD2, path: TEST_CONSTANTS.JSON_PATHS.PATH2 },
        }),
      ]);

      const size = getMessageCacheSize(context);

      expect(size).toBe(2);
    });

    it("should return 0 for empty cache", () => {
      const context = createProcessorContext();

      const size = getMessageCacheSize(context);

      expect(size).toBe(0);
    });
  });
});
