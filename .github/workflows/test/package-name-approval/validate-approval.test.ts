import { beforeEach, describe, expect, it, vi } from "vitest";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";

vi.mock("fs/promises", () => ({
  readFile: vi.fn(),
}));
vi.mock("js-yaml", () => ({
  default: { load: vi.fn() },
}));

import { readFile } from "fs/promises";
import yaml from "js-yaml";
import validateApproval from "../../src/package-name-approval/validate-approval.ts";

/** Mock protected-labels.yml content (as yaml.load would return) */
const protectedLabelsYaml = {
  "global-approvers": ["global-admin1", "global-admin2"],
  "BreakingChange-Approved-Benign": ["someone"],
  "package-name-dotnet-approved": {
    "management-plane": ["approver3", "approver4"],
    "data-plane": ["approver2", "approver4"],
  },
  "package-name-java-approved": {
    "management-plane": ["approver3", "approver4"],
    "data-plane": ["approver1"],
  },
  "package-name-python-approved": {
    "management-plane": ["approver3", "approver4"],
    "data-plane": ["approver3"],
  },
  "package-name-approved-all": {
    "management-plane": ["approver3", "approver4"],
    "data-plane": ["global-admin1", "global-admin2"],
  },
};

function setupMocks() {
  (readFile as ReturnType<typeof vi.fn>).mockResolvedValue("yaml-content");
  (yaml.load as ReturnType<typeof vi.fn>).mockReturnValue(protectedLabelsYaml);
}

function createPRLabeledPayload({
  action,
  labelName,
  actor,
  labels,
  isMgmt = false,
}: {
  action: string;
  labelName: string;
  actor: string;
  labels?: string[];
  isMgmt?: boolean;
}) {
  const labelNames: string[] = [...(labels ?? []), ...(isMgmt ? ["Mgmt"] : [])];
  const allLabels = labelNames.map((name) => ({ name }));
  return {
    action,
    label: { name: labelName },
    sender: { login: actor, type: "User" },
    repository: { owner: { login: "owner" }, name: "repo" },
    pull_request: {
      number: 42,
      head: { sha: "abc123" },
      labels: allLabels,
    },
  };
}

describe("validate-approval", () => {
  let github: ReturnType<typeof createMockGithub>;

  let context: ReturnType<typeof createMockContext>;

  let core: ReturnType<typeof createMockCore>;

  function args(): import("../../src/github.ts").WorkflowArguments {
    return {
      github,
      context,
      core,
    };
  }

  beforeEach(() => {
    vi.clearAllMocks();
    setupMocks();
    github = createMockGithub();
    context = createMockContext();
    context.eventName = "pull_request_target";
    core = createMockCore();

    (github.rest.issues as Record<string, unknown>).createComment = vi.fn();
    (github.rest.issues as Record<string, unknown>).getLabel = vi.fn();
    (github.rest.issues as Record<string, unknown>).createLabel = vi.fn();
    (github.rest.issues as Record<string, unknown>).listComments = vi
      .fn()
      .mockResolvedValue({ data: [] });
  });

  describe("labeled - per-language approval", () => {
    it("should skip when package-name-review-required label is absent", async () => {
      context.payload = createPRLabeledPayload({
        action: "labeled",
        labelName: "package-name-java-approved",
        actor: "approver1",
        labels: ["package-name-java-pending"],
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
        labels: ["package-name-review-required"],
      });

      await validateApproval(args());

      expect(core.info).toHaveBeenCalledWith(
        expect.stringContaining("is not a namespace approval label"),
      );
    });

    it("should allow authorized approver to approve their language", async () => {
      context.payload = createPRLabeledPayload({
        action: "labeled",
        labelName: "package-name-java-approved",
        actor: "approver1",
        labels: ["package-name-review-required", "package-name-java-pending"],
      });

      github.rest.pulls.get.mockResolvedValue({
        data: { labels: [{ name: "package-name-review-required" }] },
      });
      (github.rest.issues as Record<string, unknown>).listComments = vi
        .fn()
        .mockResolvedValue({ data: [] });

      await validateApproval(args());

      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: "package-name-java-pending" }),
      );
    });

    it("should allow global approver to approve any language", async () => {
      context.payload = createPRLabeledPayload({
        action: "labeled",
        labelName: "package-name-java-approved",
        actor: "global-admin1",
        labels: ["package-name-review-required", "package-name-java-pending"],
      });

      github.rest.pulls.get.mockResolvedValue({
        data: { labels: [{ name: "package-name-review-required" }] },
      });
      (github.rest.issues as Record<string, unknown>).listComments = vi
        .fn()
        .mockResolvedValue({ data: [] });

      await validateApproval(args());

      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: "package-name-java-pending" }),
      );
    });

    it("should allow mgmt-plane approver for mgmt PR", async () => {
      context.payload = createPRLabeledPayload({
        action: "labeled",
        labelName: "package-name-dotnet-approved",
        actor: "approver3",
        labels: ["package-name-review-required", "package-name-dotnet-pending"],
        isMgmt: true,
      });

      github.rest.pulls.get.mockResolvedValue({
        data: { labels: [{ name: "package-name-review-required" }] },
      });
      (github.rest.issues as Record<string, unknown>).listComments = vi
        .fn()
        .mockResolvedValue({ data: [] });

      await validateApproval(args());

      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: "package-name-dotnet-pending" }),
      );
    });
  });

  describe("labeled - package-name-approved-all shortcut", () => {
    it("should approve all pending languages for authorized user", async () => {
      context.payload = createPRLabeledPayload({
        action: "labeled",
        labelName: "package-name-approved-all",
        actor: "approver3",
        labels: [
          "package-name-review-required",
          "package-name-dotnet-pending",
          "package-name-java-pending",
        ],
        isMgmt: true,
      });

      github.rest.pulls.get.mockResolvedValue({
        data: { labels: [] },
      });
      (github.rest.issues as Record<string, unknown>).listComments = vi
        .fn()
        .mockResolvedValue({ data: [] });

      await validateApproval(args());

      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: "package-name-dotnet-pending" }),
      );
      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: "package-name-java-pending" }),
      );
    });

    it("should reject package-name-approved-all on data-plane PR", async () => {
      context.payload = createPRLabeledPayload({
        action: "labeled",
        labelName: "package-name-approved-all",
        actor: "approver3",
        labels: ["package-name-review-required", "package-name-dotnet-pending"],
      });

      await validateApproval(args());

      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: "package-name-approved-all" }),
      );
      expect(github.rest.issues.createComment).toHaveBeenCalledWith(
        expect.objectContaining({
          body: expect.stringContaining("only available on management-plane") as unknown,
        }),
      );
    });
  });

  describe("unlabeled - guard against unauthorized removal", () => {
    it("should re-apply pending label when removed by unauthorized user", async () => {
      context.payload = createPRLabeledPayload({
        action: "unlabeled",
        labelName: "package-name-java-pending",
        actor: "random-user",
        labels: ["package-name-review-required"],
      });

      await validateApproval(args());

      expect(github.rest.issues.addLabels).toHaveBeenCalledWith(
        expect.objectContaining({
          labels: ["package-name-java-pending"],
        }),
      );
      expect(github.rest.issues.createComment).toHaveBeenCalledWith(
        expect.objectContaining({
          body: expect.stringContaining("not authorized to remove") as unknown,
        }),
      );
    });

    it("should allow trusted bot to remove pending label", async () => {
      context.payload = createPRLabeledPayload({
        action: "unlabeled",
        labelName: "package-name-java-pending",
        actor: "github-actions[bot]",
        labels: ["package-name-review-required"],
      });

      await validateApproval(args());

      expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
      const infoArgs = core.info.mock.calls.map((call: unknown[]) => String(call[0]));
      expect(infoArgs.some((message: string) => message.includes("trusted bot"))).toBe(true);
    });

    it("should allow authorized approver to remove pending label", async () => {
      context.payload = createPRLabeledPayload({
        action: "unlabeled",
        labelName: "package-name-dotnet-pending",
        actor: "approver2",
        labels: ["package-name-review-required"],
      });

      await validateApproval(args());

      expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
      const infoArgs = core.info.mock.calls.map((call: unknown[]) => String(call[0]));
      expect(infoArgs.some((message: string) => message.includes("authorized approver"))).toBe(
        true,
      );
    });

    it("should ignore non-namespace labels on unlabeled", async () => {
      context.payload = createPRLabeledPayload({
        action: "unlabeled",
        labelName: "some-other-label",
        actor: "random-user",
        labels: ["package-name-review-required"],
      });

      await validateApproval(args());

      expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
      const infoArgs = core.info.mock.calls.map((call: unknown[]) => String(call[0]));
      expect(infoArgs.some((message: string) => message.includes("not a namespace label"))).toBe(
        true,
      );
    });

    it("should guard package-name-review-required label too", async () => {
      context.payload = createPRLabeledPayload({
        action: "unlabeled",
        labelName: "package-name-review-required",
        actor: "random-user",
        labels: [],
      });

      await validateApproval(args());

      expect(github.rest.issues.addLabels).toHaveBeenCalledWith(
        expect.objectContaining({
          labels: ["package-name-review-required"],
        }),
      );
    });
  });
});
