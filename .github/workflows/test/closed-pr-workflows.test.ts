import { describe, expect, it } from "vitest";
import { fullGitSha } from "../../shared/test/examples.ts";
import getArmLabelAction from "../src/arm-auto-signoff/arm-auto-signoff-status.ts";
import getBreakingChangeLabels from "../src/breaking-change-add-label-artifacts.ts";
import type { GitHubScriptArgs } from "../src/github.ts";
import postPackageResults from "../src/package-name-approval/post-results.ts";
import setPackageStatus from "../src/package-name-approval/status-check.ts";
import setStatus from "../src/set-status.ts";
import summarizeChecks from "../src/summarize-checks/summarize-checks.ts";
import postSuppressionsResults from "../src/typespec-suppressions/post-results.ts";
import updateLabels from "../src/update-labels.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

const consumers: [string, (args: GitHubScriptArgs) => Promise<unknown>][] = [
  ["shared status", (args) => setStatus(args, "analyzer", "status", "")],
  ["summary", summarizeChecks],
  ["legacy ARM signoff", getArmLabelAction],
  ["breaking change labels", getBreakingChangeLabels],
  ["package results", postPackageResults],
  ["package status", setPackageStatus],
  ["suppression results", postSuppressionsResults],
  ["label updates", updateLabels],
];

const labelConsumers: [string, (args: GitHubScriptArgs) => Promise<unknown>, string][] = [
  [
    "shared status",
    (args) => setStatus(args, "analyzer", "status", "Approved-Avocado"),
    "Approved-Avocado",
  ],
  ["summary", summarizeChecks, "ARMReview"],
  ["legacy ARM signoff", getArmLabelAction, "ARMAutoSignedOff-IncrementalTSP"],
];

it.each(labelConsumers)(
  "%s uses live PR labels without refetching them",
  async (name, run, label) => {
    const github = createMockGithub();
    const core = createMockCore();
    const context = createMockContext();
    context.eventName = "pull_request_target";
    context.payload = {
      action: "labeled",
      repository: { name: "repo", owner: { login: "owner" } },
      pull_request: { number: 42, head: { sha: fullGitSha }, base: { ref: "main" } },
    };
    github.rest.pulls.get.mockResolvedValue({
      data: { state: "open", labels: [{ name: label }] },
    });
    github.rest.issues.createComment.mockResolvedValue({ data: { id: 1 } });

    const result = await run({ github, context, core });

    expect(github.rest.pulls.get).toHaveBeenCalledTimes(1);
    expect(github.rest.issues.listLabelsOnIssue).not.toHaveBeenCalled();
    if (name === "shared status") {
      expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
        expect.objectContaining({ state: "success", sha: fullGitSha, context: "status" }),
      );
    } else if (name === "summary") {
      expect(github.rest.issues.createComment.mock.calls[0]?.[0]).toHaveProperty(
        "body",
        expect.stringContaining(label),
      );
    } else {
      expect(result).toMatchObject({
        labelActions: {
          ARMSignedOff: "remove",
          "ARMAutoSignedOff-IncrementalTSP": "remove",
        },
      });
    }
  },
);

describe.each(["pull_request_target", "workflow_run"])("closed PR during %s", (eventName) => {
  it.each(consumers.filter(([, run]) => eventName === "workflow_run" || run !== updateLabels))(
    "%s stops before writing or handing off work",
    async (_name, run) => {
      const github = createMockGithub();
      const core = createMockCore();
      const context = createMockContext();
      const repository = { name: "repo", owner: { login: "owner" } };
      context.eventName = eventName;
      context.payload = {
        action: eventName === "workflow_run" ? "completed" : "labeled",
        repository,
        pull_request: { number: 42, state: "open", head: { sha: fullGitSha } },
        label: { name: "package-name-approved-all" },
        workflow_run: {
          event: "pull_request",
          repository,
          head_sha: fullGitSha,
          id: 123,
          pull_requests: [{ number: 42 }],
        },
      };
      github.rest.pulls.get.mockResolvedValue({ data: { state: "closed" } });

      await run({ github, context, core });

      expect(github.rest.pulls.get).toHaveBeenCalledWith({
        owner: "owner",
        repo: "repo",
        pull_number: 42,
      });
      expect(github.rest.actions.listWorkflowRunArtifacts).not.toHaveBeenCalled();
      expect(github.rest.actions.listWorkflowRunsForRepo).not.toHaveBeenCalled();
      expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
      expect(github.rest.issues.createComment).not.toHaveBeenCalled();
      expect(github.rest.issues.updateComment).not.toHaveBeenCalled();
      expect(github.rest.issues.deleteComment).not.toHaveBeenCalled();
      expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
      expect(core.setOutput).not.toHaveBeenCalled();
    },
  );
});
