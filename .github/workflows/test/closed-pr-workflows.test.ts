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
