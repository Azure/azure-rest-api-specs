import { beforeEach, describe, expect, it, vi } from "vitest";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.js";

// cspell:words jsquire xirzec

vi.mock("fs/promises", () => ({
  readFile: vi.fn(),
}));
vi.mock("js-yaml", () => ({
  default: { load: vi.fn() },
}));

import { readFile } from "fs/promises";
import yaml from "js-yaml";
import validateApproval from "../../src/namespace-approval/validate-approval.js";

/** @type {import("../../src/namespace-approval/validate-approval.js").ApproversConfig} */
const approversConfig = {
  "data-plane": {
    dotnet: ["jsquire", "m-nash"],
    java: ["JonathanGiles"],
    python: ["xirzec"],
  },
  "management-plane": {
    all: ["ArthurMa1978", "m-nash"],
  },
};

function setupMocks() {
  /** @type {ReturnType<typeof vi.fn>} */ (readFile).mockResolvedValue("yaml-content");
  /** @type {ReturnType<typeof vi.fn>} */ (yaml.load).mockReturnValue(approversConfig);
}

/**
 * @param {Object} opts
 * @param {string} opts.action
 * @param {string} opts.labelName
 * @param {string} opts.actor
 * @param {string[]} [opts.labels]
 * @param {boolean} [opts.isMgmt]
 */
function createPRLabeledPayload({ action, labelName, actor, labels, isMgmt = false }) {
  /** @type {string[]} */
  const labelNames = [...(labels ?? []), ...(isMgmt ? ["Mgmt"] : [])];
  const allLabels = labelNames.map((name) => ({ name }));
  return {
    action,
    label: { name: labelName },
    sender: { login: actor, type: "User" },
    pull_request: {
      number: 42,
      labels: allLabels,
    },
  };
}

describe("validate-approval", () => {
  /** @type {ReturnType<typeof createMockGithub>} */
  let github;
  /** @type {ReturnType<typeof createMockContext>} */
  let context;
  /** @type {ReturnType<typeof createMockCore>} */
  let core;

  /** @returns {import("@actions/github-script").AsyncFunctionArguments} */
  function args() {
    return /** @type {import("@actions/github-script").AsyncFunctionArguments} */ (
      /** @type {unknown} */ ({ github, context, core })
    );
  }

  beforeEach(() => {
    vi.clearAllMocks();
    setupMocks();
    github = createMockGithub();
    context = createMockContext();
    core = createMockCore();

    /** @type {any} */ (github.rest.issues).createComment = vi.fn();
    /** @type {any} */ (github.rest.issues).getLabel = vi.fn();
    /** @type {any} */ (github.rest.issues).createLabel = vi.fn();
    /** @type {any} */ (github.rest.issues).listComments = vi.fn().mockResolvedValue({ data: [] });
  });

  describe("labeled - per-language approval", () => {
    it("should skip when namespace-review-required label is absent", async () => {
      context.payload = createPRLabeledPayload({
        action: "labeled",
        labelName: "java-namespace-approved",
        actor: "JonathanGiles",
        labels: ["java-namespace-pending"],
      });

      await validateApproval(args());

      expect(core.info).toHaveBeenCalledWith("No namespace review, skipping");
      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    });

    it("should skip non-namespace labels", async () => {
      context.payload = createPRLabeledPayload({
        action: "labeled",
        labelName: "some-other-label",
        actor: "anyone",
        labels: ["namespace-review-required"],
      });

      await validateApproval(args());

      expect(core.info).toHaveBeenCalledWith(
        expect.stringContaining("is not a namespace approval label"),
      );
    });

    it("should allow authorized approver to approve their language", async () => {
      context.payload = createPRLabeledPayload({
        action: "labeled",
        labelName: "java-namespace-approved",
        actor: "JonathanGiles",
        labels: ["namespace-review-required", "java-namespace-pending"],
      });

      github.rest.pulls.get.mockResolvedValue({
        data: { labels: [{ name: "namespace-review-required" }] },
      });
      /** @type {any} */ (github.rest.issues).listComments = vi
        .fn()
        .mockResolvedValue({ data: [] });

      await validateApproval(args());

      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: "java-namespace-pending" }),
      );
    });

    it("should reject unauthorized approver and remove label", async () => {
      context.payload = createPRLabeledPayload({
        action: "labeled",
        labelName: "java-namespace-approved",
        actor: "random-user",
        labels: ["namespace-review-required", "java-namespace-pending"],
      });

      await validateApproval(args());

      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: "java-namespace-approved" }),
      );
      expect(github.rest.issues.createComment).toHaveBeenCalled();
      const calls = vi.mocked(github.rest.issues.createComment).mock.calls;
      const commentBody = String(/** @type {Record<string, unknown>} */ (calls[0][0]).body);
      expect(commentBody).toContain("not authorized");
    });

    it("should allow mgmt-plane approver for mgmt PR", async () => {
      context.payload = createPRLabeledPayload({
        action: "labeled",
        labelName: "dotnet-namespace-approved",
        actor: "ArthurMa1978",
        labels: ["namespace-review-required", "dotnet-namespace-pending"],
        isMgmt: true,
      });

      github.rest.pulls.get.mockResolvedValue({
        data: { labels: [{ name: "namespace-review-required" }] },
      });
      /** @type {any} */ (github.rest.issues).listComments = vi
        .fn()
        .mockResolvedValue({ data: [] });

      await validateApproval(args());

      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: "dotnet-namespace-pending" }),
      );
    });
  });

  describe("labeled - namespace-approved-all shortcut", () => {
    it("should approve all pending languages for authorized user", async () => {
      context.payload = createPRLabeledPayload({
        action: "labeled",
        labelName: "namespace-approved-all",
        actor: "ArthurMa1978",
        labels: ["namespace-review-required", "dotnet-namespace-pending", "java-namespace-pending"],
      });

      github.rest.pulls.get.mockResolvedValue({
        data: { labels: [] },
      });
      /** @type {any} */ (github.rest.issues).listComments = vi
        .fn()
        .mockResolvedValue({ data: [] });

      await validateApproval(args());

      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: "dotnet-namespace-pending" }),
      );
      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: "java-namespace-pending" }),
      );
    });

    it("should reject namespace-approved-all from unauthorized user", async () => {
      context.payload = createPRLabeledPayload({
        action: "labeled",
        labelName: "namespace-approved-all",
        actor: "random-user",
        labels: ["namespace-review-required", "dotnet-namespace-pending"],
      });

      await validateApproval(args());

      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: "namespace-approved-all" }),
      );
      expect(github.rest.issues.createComment).toHaveBeenCalled();
      const calls = vi.mocked(github.rest.issues.createComment).mock.calls;
      const commentBody = String(/** @type {Record<string, unknown>} */ (calls[0][0]).body);
      expect(commentBody).toContain("not authorized");
    });
  });

  describe("unlabeled - guard against unauthorized removal", () => {
    it("should re-apply pending label when removed by unauthorized user", async () => {
      context.payload = createPRLabeledPayload({
        action: "unlabeled",
        labelName: "java-namespace-pending",
        actor: "random-user",
        labels: ["namespace-review-required"],
      });

      await validateApproval(args());

      expect(github.rest.issues.addLabels).toHaveBeenCalledWith(
        expect.objectContaining({
          labels: ["java-namespace-pending"],
        }),
      );
      expect(github.rest.issues.createComment).toHaveBeenCalled();
      const calls = vi.mocked(github.rest.issues.createComment).mock.calls;
      const commentBody = String(/** @type {Record<string, unknown>} */ (calls[0][0]).body);
      expect(commentBody).toContain("not authorized to remove");
    });

    it("should allow trusted bot to remove pending label", async () => {
      context.payload = createPRLabeledPayload({
        action: "unlabeled",
        labelName: "java-namespace-pending",
        actor: "github-actions[bot]",
        labels: ["namespace-review-required"],
      });

      await validateApproval(args());

      expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
      const infoArgs = core.info.mock.calls.map((/** @type {unknown[]} */ call) => String(call[0]));
      expect(
        infoArgs.some((/** @type {string} */ message) => message.includes("trusted bot")),
      ).toBe(true);
    });

    it("should allow authorized approver to remove pending label", async () => {
      context.payload = createPRLabeledPayload({
        action: "unlabeled",
        labelName: "dotnet-namespace-pending",
        actor: "jsquire",
        labels: ["namespace-review-required"],
      });

      await validateApproval(args());

      expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
      const infoArgs = core.info.mock.calls.map((/** @type {unknown[]} */ call) => String(call[0]));
      expect(
        infoArgs.some((/** @type {string} */ message) => message.includes("authorized approver")),
      ).toBe(true);
    });

    it("should ignore non-namespace labels on unlabeled", async () => {
      context.payload = createPRLabeledPayload({
        action: "unlabeled",
        labelName: "some-other-label",
        actor: "random-user",
        labels: ["namespace-review-required"],
      });

      await validateApproval(args());

      expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
      const infoArgs = core.info.mock.calls.map((/** @type {unknown[]} */ call) => String(call[0]));
      expect(
        infoArgs.some((/** @type {string} */ message) => message.includes("not a namespace label")),
      ).toBe(true);
    });

    it("should guard namespace-review-required label too", async () => {
      context.payload = createPRLabeledPayload({
        action: "unlabeled",
        labelName: "namespace-review-required",
        actor: "random-user",
        labels: [],
      });

      await validateApproval(args());

      expect(github.rest.issues.addLabels).toHaveBeenCalledWith(
        expect.objectContaining({
          labels: ["namespace-review-required"],
        }),
      );
    });
  });
});
