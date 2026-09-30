import type { Context, Core, GitHub, GitHubScriptArgs } from "../../src/github.ts";
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
import checkLabel from "../../src/protected-labels/check-label.ts";

function invokeCheckLabel(args: Partial<GitHubScriptArgs>) {
  return checkLabel(args as GitHubScriptArgs);
}

const protectedLabelsConfig = {
  "global-approvers": ["global-admin"],
  "BreakingChange-Approved-Benign": ["user1", "user2"],
  "Versioning-Approved-BugFix": ["user1", "user2"],
  "package-name-dotnet-approved": {
    "management-plane": ["mgmt-approver1"],
    "data-plane": ["dp-approver1", "dp-approver2"],
  },
  "package-name-approved-all": {
    "management-plane": ["mgmt-approver1"],
  },
  "typespec-suppressions-approved": {
    "data-plane": ["dp-approver1"],
    "management-plane": "unprotected",
  },
};

function setupMocks() {
  (readFile as ReturnType<typeof vi.fn>).mockResolvedValue("yaml-content");
  (yaml.load as ReturnType<typeof vi.fn>).mockReturnValue(protectedLabelsConfig);
}

function createLabeledPayload({
  labelName,
  actor,
  extraLabels = [],
}: {
  labelName: string;
  actor: string;
  extraLabels?: string[];
}) {
  const allLabels = [{ name: labelName }, ...extraLabels.map((n) => ({ name: n }))];
  return {
    action: "labeled",
    label: { name: labelName },
    sender: { login: actor, type: "User" },
    repository: { owner: { login: "Azure" }, name: "azure-rest-api-specs" },
    pull_request: {
      number: 100,
      head: { sha: "abc123" },
      labels: allLabels,
    },
  };
}

describe("checkLabel", () => {
  let github: GitHub & ReturnType<typeof createMockGithub>;

  let core: Core;

  let context: Context;

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

  it("rejects a labeled event without a label", async () => {
    context.payload = {
      ...createLabeledPayload({
        labelName: "BreakingChange-Approved-Benign",
        actor: "user1",
      }),
      label: undefined,
    };

    await expect(invokeCheckLabel({ github, context, core })).rejects.toThrow(
      "Pull request label event is missing a label name.",
    );
    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
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

    it("allows global approver to apply any protected label", async () => {
      context.payload = createLabeledPayload({
        labelName: "Versioning-Approved-BugFix",
        actor: "global-admin",
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
      expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    });

    it("mentions the actor and directs them to the merge process before a collapsed approver list", async () => {
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
      expect(github.rest.issues.createComment).toHaveBeenCalledWith({
        owner: "Azure",
        repo: "azure-rest-api-specs",
        issue_number: 100,
        body:
          "⚠️ @unauthorized-user is not authorized to apply `BreakingChange-Approved-Benign`. Label removed.\n\n" +
          "Please follow the **Next Steps to Merge** comment on this PR and the " +
          "[review and merge process](https://aka.ms/azsdk/specreview/merge).\n\n" +
          "<details><summary>See allowed approvers</summary>\n\n" +
          "Only [user1](https://github.com/user1), [user2](https://github.com/user2), " +
          "[global-admin](https://github.com/global-admin) can apply this label.\n\n</details>",
      });
    });

    it("handles 404 race condition on removeLabel gracefully", async () => {
      const error = new Error("Not Found");
      (error as Error & { status: number }).status = 404;
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
      (error as Error & { status: number }).status = 500;
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
      (yaml.load as ReturnType<typeof vi.fn>).mockReturnValue(null);

      context.payload = createLabeledPayload({
        labelName: "BreakingChange-Approved-Benign",
        actor: "someone",
      });

      await expect(invokeCheckLabel({ github, context, core })).rejects.toThrow(
        "expected a YAML object",
      );
    });

    it("throws on invalid entry (not an array)", async () => {
      (yaml.load as ReturnType<typeof vi.fn>).mockReturnValue({
        "BreakingChange-Approved-Benign": "not-an-array",
      });

      context.payload = createLabeledPayload({
        labelName: "BreakingChange-Approved-Benign",
        actor: "someone",
      });

      await expect(invokeCheckLabel({ github, context, core })).rejects.toThrow(
        "must map to an array or a plane-aware object",
      );
    });

    it("throws on invalid plane value (not an array or 'unprotected')", async () => {
      (yaml.load as ReturnType<typeof vi.fn>).mockReturnValue({
        "package-name-dotnet-approved": {
          "management-plane": "open",
        },
      });

      context.payload = createLabeledPayload({
        labelName: "package-name-dotnet-approved",
        actor: "someone",
        extraLabels: ["resource-manager"],
      });

      await expect(invokeCheckLabel({ github, context, core })).rejects.toThrow(
        'array of logins or the literal "unprotected"',
      );
    });
  });

  describe("plane-aware labels", () => {
    it("uses data-plane approvers when PR has data-plane label", async () => {
      context.payload = createLabeledPayload({
        labelName: "package-name-dotnet-approved",
        actor: "dp-approver1",
        extraLabels: ["data-plane"],
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    });

    it("rejects mgmt-only approver on data-plane PR", async () => {
      context.payload = createLabeledPayload({
        labelName: "package-name-dotnet-approved",
        actor: "mgmt-approver1",
        extraLabels: ["data-plane"],
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: "package-name-dotnet-approved" }),
      );
      expect(github.rest.issues.createComment).toHaveBeenCalledWith({
        owner: "Azure",
        repo: "azure-rest-api-specs",
        issue_number: 100,
        body:
          "⚠️ @mgmt-approver1 is not authorized to apply `package-name-dotnet-approved`. Label removed.\n\n" +
          "Please follow the **Next Steps to Merge** comment on this PR and the " +
          "[review and merge process](https://aka.ms/azsdk/specreview/merge).\n\n" +
          "<details><summary>See allowed approvers</summary>\n\n" +
          "Only [dp-approver1](https://github.com/dp-approver1), [dp-approver2](https://github.com/dp-approver2), " +
          "[global-admin](https://github.com/global-admin) can apply this label.\n\n</details>",
      });
    });

    it("uses mgmt approvers when PR has resource-manager label", async () => {
      context.payload = createLabeledPayload({
        labelName: "package-name-dotnet-approved",
        actor: "mgmt-approver1",
        extraLabels: ["resource-manager"],
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    });

    it("does not treat a stale add-only Mgmt label as a plane (#46785)", async () => {
      // A data-plane approver on a PR whose only plane-ish label is a stale "Mgmt":
      // "Mgmt" is no longer a plane signal, so the label is left untouched rather than
      // rejected against the mgmt approver list.
      context.payload = createLabeledPayload({
        labelName: "package-name-dotnet-approved",
        actor: "dp-approver1",
        extraLabels: ["Mgmt"],
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    });

    it("rejects data-plane approver on mgmt PR", async () => {
      context.payload = createLabeledPayload({
        labelName: "package-name-dotnet-approved",
        actor: "dp-approver1",
        extraLabels: ["resource-manager"],
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: "package-name-dotnet-approved" }),
      );
    });

    it("global approver can apply plane-aware label on any plane", async () => {
      context.payload = createLabeledPayload({
        labelName: "package-name-dotnet-approved",
        actor: "global-admin",
        extraLabels: ["resource-manager"],
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    });

    it("skips enforcement for plane-aware label when PR has no plane label", async () => {
      context.payload = createLabeledPayload({
        labelName: "package-name-dotnet-approved",
        actor: "random-user",
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    });

    it("mgmt-only label rejects everyone on data-plane PR (except global)", async () => {
      context.payload = createLabeledPayload({
        labelName: "package-name-approved-all",
        actor: "mgmt-approver1",
        extraLabels: ["data-plane"],
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: "package-name-approved-all" }),
      );
    });

    it("mgmt-only label allows mgmt approver on mgmt PR", async () => {
      context.payload = createLabeledPayload({
        labelName: "package-name-approved-all",
        actor: "mgmt-approver1",
        extraLabels: ["resource-manager"],
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    });
  });

  describe("per-plane unprotected opt-out (#46728)", () => {
    it("does not enforce an unprotected plane (anyone may apply)", async () => {
      context.payload = createLabeledPayload({
        labelName: "typespec-suppressions-approved",
        actor: "random-user",
        extraLabels: ["resource-manager"],
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
      expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    });

    it("still enforces the gated plane on the same label", async () => {
      context.payload = createLabeledPayload({
        labelName: "typespec-suppressions-approved",
        actor: "random-user",
        extraLabels: ["data-plane"],
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
        expect.objectContaining({ name: "typespec-suppressions-approved" }),
      );
    });

    it("allows the gated plane's approver", async () => {
      context.payload = createLabeledPayload({
        labelName: "typespec-suppressions-approved",
        actor: "dp-approver1",
        extraLabels: ["data-plane"],
      });

      await invokeCheckLabel({ github, context, core });

      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    });
  });
});
