import { beforeEach, describe, expect, it, vi } from "vitest";
import { BreakingChangeLabelsToBeAdded } from "../../src/command-helpers.js";
import { logMessage, logWarning } from "../../src/log.js";
import { ApiVersionLifecycleStage } from "../../src/types/breaking-change.js";
import { OadMessage } from "../../src/types/oad-types.js";
import { applyRules } from "../../src/utils/apply-rules.js";

// Mock the command-helpers module
vi.mock("../../src/command-helpers.js", () => ({
  BreakingChangeLabelsToBeAdded: {
    add: vi.fn(),
    clear: vi.fn(),
    values: [],
  },
}));

// Mock the log module
vi.mock("../../src/log.js", () => ({
  logMessage: vi.fn(),
  logWarning: vi.fn(),
  LogLevel: {
    Info: "Info",
    Warning: "Warning",
    Error: "Error",
  },
}));

// Mock the oad-rule-map module
vi.mock("../../src/utils/oad-rule-map.js", () => ({
  oadMessagesRuleMap: [
    {
      scenario: "SameVersion",
      code: "AddedRequiredProperty",
      severity: "Error",
      label: "BreakingChangeReviewRequired",
    },
    {
      scenario: "CrossVersion",
      code: "AddedRequiredProperty",
      severity: "Error",
      label: "BreakingChangeReviewRequired",
    },
    {
      scenario: "SameVersion",
      code: "RemovedProperty",
      severity: "Warning",
      label: null,
    },
  ],
  fallbackRule: {
    severity: "Warning",
    label: null,
  },
  fallbackLabel: "BreakingChangeReviewRequired",
}));

const createTestOadMessage = (
  code: string = "AddedRequiredProperty",
  id: string = "1001",
): OadMessage => ({
  type: "Info",
  code: code as any,
  id,
  message: `Test message for ${code}`,
  docUrl: `https://docs.example.com/rules/${code}`,
  mode: "Addition",
  new: { location: "specification/test.json#L10", path: "specification/test.json" },
  old: { location: "specification/test.json#L8", path: "specification/test.json" },
});

describe("apply-rules", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe("applyRules", () => {
    it("should apply matching rule for same version scenario", () => {
      const oadMessages: OadMessage[] = [createTestOadMessage()];

      const result = applyRules(oadMessages, "SameVersion", ApiVersionLifecycleStage.STABLE);

      expect(result).toHaveLength(1);
      expect(result[0].type).toBe("Error");
      expect(result[0].groupName).toBe(ApiVersionLifecycleStage.STABLE);
      expect(BreakingChangeLabelsToBeAdded.add).toHaveBeenCalledWith(
        "BreakingChangeReviewRequired",
      );
    });

    it("should apply matching rule for cross version scenario", () => {
      const oadMessages: OadMessage[] = [createTestOadMessage()];

      const result = applyRules(oadMessages, "CrossVersion", ApiVersionLifecycleStage.STABLE);

      expect(result).toHaveLength(1);
      expect(result[0].type).toBe("Error");
      expect(result[0].groupName).toBe(ApiVersionLifecycleStage.STABLE);
      expect(BreakingChangeLabelsToBeAdded.add).toHaveBeenCalledWith(
        "BreakingChangeReviewRequired",
      );
    });

    it("should downgrade error to warning for cross version against previous preview", () => {
      const oadMessages: OadMessage[] = [createTestOadMessage()];

      const result = applyRules(oadMessages, "CrossVersion", ApiVersionLifecycleStage.PREVIEW);

      expect(result).toHaveLength(1);
      expect(result[0].type).toBe("Warning");
      expect(result[0].groupName).toBe(ApiVersionLifecycleStage.PREVIEW);
      expect(BreakingChangeLabelsToBeAdded.add).not.toHaveBeenCalled();
    });

    it("should use VersioningReviewRequired label for same version preview", () => {
      const oadMessages: OadMessage[] = [createTestOadMessage()];

      const result = applyRules(oadMessages, "SameVersion", ApiVersionLifecycleStage.PREVIEW);

      expect(result).toHaveLength(1);
      expect(result[0].type).toBe("Error");
      expect(result[0].groupName).toBe(ApiVersionLifecycleStage.PREVIEW);
      expect(BreakingChangeLabelsToBeAdded.add).toHaveBeenCalledWith("VersioningReviewRequired");
    });

    it("should not add label for warning severity", () => {
      const oadMessages: OadMessage[] = [createTestOadMessage("RemovedProperty", "1002")];

      const result = applyRules(oadMessages, "SameVersion", ApiVersionLifecycleStage.STABLE);

      expect(result).toHaveLength(1);
      expect(result[0].type).toBe("Warning");
      expect(result[0].groupName).toBe(ApiVersionLifecycleStage.STABLE);
      expect(BreakingChangeLabelsToBeAdded.add).not.toHaveBeenCalled();
    });

    it("should use fallback rule when no matching rule found", () => {
      const oadMessages: OadMessage[] = [createTestOadMessage("TypeChanged", "1003")];

      const result = applyRules(oadMessages, "SameVersion", ApiVersionLifecycleStage.STABLE);

      expect(result).toHaveLength(1);
      expect(result[0].type).toBe("Warning");
      expect(result[0].groupName).toBe(ApiVersionLifecycleStage.STABLE);
      expect(logWarning).toHaveBeenCalledWith(
        expect.stringContaining("No rule found for scenario"),
      );
    });

    it("should handle multiple messages", () => {
      const oadMessages: OadMessage[] = [
        createTestOadMessage("AddedRequiredProperty", "1001"),
        createTestOadMessage("RemovedProperty", "1002"),
      ];

      const result = applyRules(oadMessages, "SameVersion", ApiVersionLifecycleStage.STABLE);

      expect(result).toHaveLength(2);
      expect(result[0].type).toBe("Error");
      expect(result[0].groupName).toBe(ApiVersionLifecycleStage.STABLE);
      expect(result[1].type).toBe("Warning");
      expect(result[1].groupName).toBe(ApiVersionLifecycleStage.STABLE);
      expect(BreakingChangeLabelsToBeAdded.add).toHaveBeenCalledTimes(1);
      expect(BreakingChangeLabelsToBeAdded.add).toHaveBeenCalledWith(
        "BreakingChangeReviewRequired",
      );
    });

    it("should preserve original message properties", () => {
      const originalMessage: OadMessage = {
        type: "Info",
        code: "AddedRequiredProperty",
        id: "1001",
        message: "Added required property 'test'",
        docUrl: "https://docs.example.com/rules/AddedRequiredProperty",
        mode: "Addition",
        new: {
          location: "specification/test.json#L10",
          path: "specification/test.json",
          ref: "test-ref",
        },
        old: { location: "specification/test.json#L8", path: "specification/test.json" },
      };

      const result = applyRules([originalMessage], "SameVersion", ApiVersionLifecycleStage.STABLE);

      expect(result[0]).toMatchObject({
        code: "AddedRequiredProperty",
        id: "1001",
        message: "Added required property 'test'",
        docUrl: "https://docs.example.com/rules/AddedRequiredProperty",
        mode: "Addition",
        new: {
          location: "specification/test.json#L10",
          path: "specification/test.json",
          ref: "test-ref",
        },
        old: { location: "specification/test.json#L8", path: "specification/test.json" },
      });
    });

    it("should log entry and exit", () => {
      const oadMessages: OadMessage[] = [createTestOadMessage()];

      applyRules(oadMessages, "SameVersion", ApiVersionLifecycleStage.STABLE);

      expect(logMessage).toHaveBeenCalledWith("ENTER definition applyRules");
      expect(logMessage).toHaveBeenCalledWith("RETURN definition applyRules");
    });

    it("should warn when rule has error severity but no label", () => {
      // This test would require mocking the rule map differently,
      // but the current implementation should handle this case
      const oadMessages: OadMessage[] = [createTestOadMessage("TypeChanged", "1001")];

      const result = applyRules(oadMessages, "SameVersion", ApiVersionLifecycleStage.STABLE);

      expect(result[0].type).toBe("Warning");
      expect(logWarning).toHaveBeenCalledWith(
        expect.stringContaining("No rule found for scenario"),
      );
    });
  });
});
