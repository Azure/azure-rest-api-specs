import { beforeEach, describe, expect, it, vi } from "vitest";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.js";

vi.mock("fs/promises", () => ({
  readFile: vi.fn(),
}));
vi.mock("js-yaml", () => ({
  default: { load: vi.fn() },
}));

import { readFile } from "fs/promises";
import yaml from "js-yaml";
import checkLabel from "../../src/protected-labels/check-label.js";

/**
 * @param {Partial<import("@actions/github-script").AsyncFunctionArguments>} args
 */
function invokeCheckLabel(args) {
  return checkLabel(
    /** @type {import("@actions/github-script").AsyncFunctionArguments} */ (args),
  );
}

const protectedLabelsConfig = {
  "BreakingChange-Approved-Benign": ["user1", "user2"],
  "Versioning-Approved-BugFix": ["user1", "user2"],
};

function setupMocks() {
  /** @type {ReturnType<typeof vi.fn>} */ (readFile).mockResolvedValue("yaml-content");
  /** @type {ReturnType<typeof vi.fn>} */ (yaml.load).mockReturnValue(protectedLabelsConfig);
}

/**
 * @param {Object} opts
 * @param {string} opts.labelName
 * @param {string} opts.actor
 */
function createLabeledPayload({ labelName, actor }) {
  return {
    action: "labeled",
    label: { name: labelName },
    sender: { login: actor, type: "User" },
    repository: { owner: { login: "Azure" }, name: "azure-rest-api-specs" },
    pull_request: {
      number: 100,
      head: { sha: "abc123" },
      labels: [{ name: labelName }],
    },
  };
}

describe("checkLabel", () => {
  /** @type {import("../mocks.js").GitHub & ReturnType<typeof createMockGithub>} */
  let github;
  /** @type {import("../mocks.js").Core} */
  let core;
  /** @type {import("../mocks.js").Context} */
  let context;

  beforeEach(() => {
    vi.resetAllMocks();
    github = createMockGithub();
    core = createMockCore();
    context = createMockContext();
    context.eventName = "pull_request_target";
    github.rest.issues.removeLabel.mockResolvedValue({});
    // @ts-expect-error - createComment not in mock type but needed by check-label
    github.rest.issues.createComment = vi.fn().mockResolvedValue({});
    setupMocks();
  });

  describe("bot bypass", () => {
    it("skips github-actions[bot]", async () => {
      context.payload = createLabeledPayload({
        labelName: "BreakingChange-Approved-Benign",
        actor: "github-actions[bot]",
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    });

    it("skips azure-sdk machine user", async () => {
      context.payload = createLabeledPayload({
        labelName: "BreakingChange-Approved-Benign",
        actor: "azure-sdk",
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    });
  });

  describe("non-protected labels", () => {
    it("skips labels not in config", async () => {
      context.payload = createLabeledPayload({ labelName: "SomeRandomLabel", actor: "anyone" });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
      expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    });
  });

  describe("authorization enforcement", () => {
    it("allows authorized user to keep label", async () => {
      context.payload = createLabeledPayload({
        labelName: "BreakingChange-Approved-Benign",
        actor: "user1",
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
      expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    });

    it("is case-insensitive for username comparison", async () => {
      context.payload = createLabeledPayload({
        labelName: "BreakingChange-Approved-Benign",
        actor: "User1",
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    });

    it("removes label and posts warning for unauthorized user", async () => {
      context.payload = createLabeledPayload({
        labelName: "BreakingChange-Approved-Benign",
        actor: "unauthorized-user",
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith({
        owner: "Azure",
        repo: "azure-rest-api-specs",
        issue_number: 100,
        name: "BreakingChange-Approved-Benign",
      });
      expect(github.rest.issues.createComment).toHaveBeenCalledWith(
        expect.objectContaining({
          // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
          body: expect.stringContaining("@unauthorized-user is not authorized"),
        }),
      );
    });

    it("handles 404 race condition on removeLabel gracefully", async () => {
      const error = new Error("Not Found");
      /** @type {any} */ (error).status = 404;
      github.rest.issues.removeLabel.mockRejectedValue(error);

      context.payload = createLabeledPayload({
        labelName: "Versioning-Approved-BugFix",
        actor: "unauthorized-user",
      });

      await invokeCheckLabel({ github, context, core });

      // Still posts comment even if label was already removed
      expect(github.rest.issues.createComment).toHaveBeenCalled();
    });

    it("rethrows non-404 errors from removeLabel", async () => {
      const error = new Error("Server Error");
      /** @type {any} */ (error).status = 500;
      github.rest.issues.removeLabel.mockRejectedValue(error);

      context.payload = createLabeledPayload({
        labelName: "Versioning-Approved-BugFix",
        actor: "unauthorized-user",
      });

      await expect(invokeCheckLabel({ github, context, core })).rejects.toThrow("Server Error");
    });
  });

  describe("config validation", () => {
    it("throws on invalid config (not an object)", async () => {
      /** @type {ReturnType<typeof vi.fn>} */ (yaml.load).mockReturnValue(null);

      context.payload = createLabeledPayload({
        labelName: "BreakingChange-Approved-Benign",
        actor: "someone",
      });

      await expect(invokeCheckLabel({ github, context, core })).rejects.toThrow("expected a YAML object");
    });

    it("throws on invalid entry (not an array)", async () => {
      /** @type {ReturnType<typeof vi.fn>} */ (yaml.load).mockReturnValue({
        "BreakingChange-Approved-Benign": "not-an-array",
      });

      context.payload = createLabeledPayload({
        labelName: "BreakingChange-Approved-Benign",
        actor: "someone",
      });

      await expect(invokeCheckLabel({ github, context, core })).rejects.toThrow(
        "must map to an array of non-empty strings",
      );
    });
  });
});
