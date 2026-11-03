import { Octokit } from "@octokit/rest";
import { strToU8, zipSync } from "fflate";
import { marked } from "marked";
import { describe, expect, it } from "vitest";
import { execFile } from "../../../shared/src/exec.ts";
import type { GitHub } from "../../src/github.ts";
import {
  createNextStepsComment,
  getCheckInfo,
  getCheckRunTuple,
  getExistingLabels,
  getImpactAssessment,
  summarizeChecksImpl,
  updateLabels,
} from "../../src/summarize-checks/summarize-checks.ts";
import summarizeChecks from "../../src/summarize-checks/summarize-checks.ts";
import { createMockCore, createMockGithub } from "../mocks.ts";
import { fullGitSha } from "../../../shared/test/examples.ts";
import { ImpactAssessmentSchema } from "../../src/summarize-checks/labelling.ts";

export type CheckRunData = import("../../src/summarize-checks/summarize-checks.ts").CheckRunData;

const mockCore = createMockCore();
const WORKFLOW_URL = "http://github.com/a/fake/workflowrun/url";

describe("ARM review label handoff", () => {
  describe("Summarize Checks integration", () => {
    function createSummary(existingLabels: string[] = ["ARMReview"]) {
      const github = createMockGithub();
      const core = createMockCore();
      github.rest.issues.listLabelsOnIssue.mockResolvedValue({
        data: existingLabels.map((name) => ({ name })),
      });
      github.rest.pulls.get.mockResolvedValue({
        data: {
          head: { sha: fullGitSha },
          base: { ref: "main" },
          draft: false,
          labels: existingLabels.map((name) => ({ name })),
        },
      });
      github.rest.issues.createComment.mockResolvedValue({ data: { id: 1 } });
      github.rest.checks.listForRef.mockResolvedValue({
        data: {
          check_runs: [
            {
              name: "Summarize PR Impact",
              status: "completed",
              conclusion: "success",
              check_suite: { id: 1 },
            },
          ],
        },
      });
      github.rest.actions.listWorkflowRunsForRepo.mockResolvedValue({
        data: { workflow_runs: [{ id: 1, updated_at: "2026-01-01" }] },
      });
      github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
        data: { artifacts: [{ id: 1, name: "summary.json", size_in_bytes: 1024 }] },
      });
      github.rest.actions.downloadArtifact.mockImplementation(() =>
        Promise.resolve({
          data: new Response(
            JSON.stringify({
              resourceManagerRequired: true,
              dataPlaneRequired: false,
              suppressionReviewRequired: false,
              isNewApiVersion: false,
              rpaasRpNotInPrivateRepo: false,
              rpaasChange: false,
              newRP: false,
              rpaasRPMissing: false,
              typeSpecChanged: true,
              isDraft: false,
              targetBranch: "main",
            }),
          ).body,
        }),
      );

      return {
        github,
        core,
        run: () =>
          summarizeChecksImpl(
            github,
            core,
            "Azure",
            "azure-rest-api-specs",
            123,
            fullGitSha,
            "workflow_run",
            WORKFLOW_URL,
          ),
      };
    }

    it("adds the queue label and signals readiness only after completing evaluation", async () => {
      const { github, core, run } = createSummary();

      await run();

      expect(github.rest.issues.addLabels.mock.calls[0][0]).toHaveProperty(
        "labels",
        expect.arrayContaining(["WaitForARMFeedback"]),
      );
      expect(core.setOutput).toHaveBeenCalledWith("arm_review_ready", true);
      expect(github.rest.repos.createCommitStatus.mock.invocationCallOrder[0]).toBeLessThan(
        core.setOutput.mock.invocationCallOrder.at(-1) ?? 0,
      );
    });

    it("allows the dispatch job to recover an already-present queue label", async () => {
      const { core, run } = createSummary(["ARMReview", "WaitForARMFeedback"]);

      await run();

      expect(core.setOutput).toHaveBeenCalledWith("arm_review_ready", true);
    });

    it("preserves the initial-request marker during label reconciliation", async () => {
      const { github, run } = createSummary([
        "ARMReview",
        "WaitForARMFeedback",
        "ARMInitialReviewRequested",
      ]);

      await run();

      expect(github.rest.issues.removeLabel).not.toHaveBeenCalledWith(
        expect.objectContaining({ name: "ARMInitialReviewRequested" }),
      );
    });

    it("does not signal readiness when adding the queue label fails", async () => {
      const { github, core, run } = createSummary();
      github.rest.issues.addLabels.mockRejectedValue(new Error("Label write failed"));

      await expect(run()).rejects.toThrow("Label write failed");
      expect(core.setOutput).not.toHaveBeenCalledWith("arm_review_ready", true);
    });

    it("uses live PR state instead of the draft and branch snapshot in a legacy artifact", async () => {
      const { github, core, run } = createSummary();
      github.rest.pulls.get.mockResolvedValue({
        data: {
          head: { sha: fullGitSha },
          base: { ref: "feature/example" },
          draft: true,
          labels: [{ name: "ARMReview" }],
        },
      });

      await run();

      expect(github.rest.issues.addLabels.mock.calls[0]?.[0]).not.toHaveProperty(
        "labels",
        expect.arrayContaining(["WaitForARMFeedback"]),
      );
      expect(core.setOutput).toHaveBeenCalledWith("arm_review_ready", false);
      expect(github.rest.repos.getBranchRules).toHaveBeenCalledWith(
        expect.objectContaining({ branch: "feature/example" }),
      );
      expect(github.rest.pulls.get).toHaveBeenCalledTimes(1);
      expect(github.rest.issues.listLabelsOnIssue).not.toHaveBeenCalled();
    });

    it("does not apply an old head's impact to the current PR", async () => {
      const { github, run } = createSummary();
      github.rest.pulls.get.mockResolvedValue({ data: { head: { sha: "different-head" } } });

      await run();

      expect(github.rest.actions.downloadArtifact).not.toHaveBeenCalled();
      expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
      expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
    });
  });

  describe("workflow_dispatch from Update Labels", () => {
    function dispatchContext(inputs: Record<string, string>) {
      return {
        eventName: "workflow_dispatch",
        runId: 1,
        repo: { owner: "Azure", repo: "azure-rest-api-specs" },
        payload: {
          inputs,
          repository: { owner: { login: "Azure" }, name: "azure-rest-api-specs" },
        },
      } as unknown as Parameters<typeof summarizeChecks>[0]["context"];
    }

    it("evaluates the PR and head identified by the inputs", async () => {
      const github = createMockGithub();
      const core = createMockCore();
      github.rest.issues.listLabelsOnIssue.mockResolvedValue({ data: [] });
      github.rest.pulls.get.mockResolvedValue({
        data: { head: { sha: fullGitSha }, base: { ref: "main" }, draft: false, labels: [] },
      });
      github.rest.checks.listForRef.mockResolvedValue({ data: { check_runs: [] } });
      github.rest.issues.createComment.mockResolvedValue({ data: { id: 1 } });

      await summarizeChecks({
        github,
        core,
        context: dispatchContext({ pr_number: "123", head_sha: fullGitSha }),
      });

      expect(core.setOutput).toHaveBeenCalledWith("issue_number", 123);
      expect(core.setOutput).toHaveBeenCalledWith("head_sha", fullGitSha);
    });

    it("rejects malformed inputs", async () => {
      const github = createMockGithub();
      const core = createMockCore();

      await expect(
        summarizeChecks({
          github,
          core,
          context: dispatchContext({ pr_number: "abc", head_sha: "short" }),
        }),
      ).rejects.toThrow("positive PR number and full head SHA");
      expect(github.rest.pulls.get).not.toHaveBeenCalled();
    });
  });
});

/**
 * Find and extract the "Next Steps to Merge" existing comment on a PR.
 * Used in the integration test.
 */
async function getNextStepsComment(github: GitHub, owner: string, repo: string, prNumber: number) {
  try {
    const { data: comments } = await github.rest.issues.listComments({
      owner: owner,
      repo: repo,
      issue_number: prNumber,
    });

    // Find comment containing "Next Steps to Merge"
    const nextStepsComment = comments.find((comment) =>
      comment.body?.includes(`## Next Steps to Merge`),
    );

    return nextStepsComment ? nextStepsComment.body : null;
  } catch (error) {
    console.error(`Error getting comments for PR #${prNumber}:`, error);
    return null;
  }
}

describe("Summarize Checks Integration Tests", () => {
  describe("Repro a PR summarize-checks invocation", () => {
    it.skipIf(!process.env.GITHUB_TOKEN || !process.env.INTEGRATION_TEST)(
      "Should fetch real pr data and check the next steps to merge and final labels against what is actually there.",
      async () => {
        const issue_number = 24021;
        const owner = "Azure";
        const repo = "azure-rest-api-specs-pr";

        const ignorableLabels = [
          "VersioningReviewRequired",
          "BreakingChangeReviewRequired",
          "customer-reported",
          "dependencies",
          "javascript",
          "Monitor",
        ];

        const github = new Octokit({
          auth: process.env.GITHUB_TOKEN,
        }) as unknown as GitHub;

        const { data: pr } = await github.rest.pulls.get({
          owner: owner,
          repo: repo,
          pull_number: issue_number,
        });

        // Get current PR labels and Next Steps comment
        const expectedNextStepsComment = await getNextStepsComment(
          github,
          owner,
          repo,
          issue_number,
        );

        const head_sha = "961faf0dd048e0b846026bc84fdd795f4b46e9e8";
        const expectedLabels = await getExistingLabels(github, owner, repo, issue_number);

        const [requiredCheckRuns, fyiCheckRuns, impactAssessment] = await getCheckRunTuple(
          github,
          mockCore,
          owner,
          repo,
          head_sha,
          pr.base.ref,
          [],
        );

        let adjustedStartLabels = expectedLabels.filter((x) => ignorableLabels.includes(x));
        const labelContext = updateLabels(adjustedStartLabels, impactAssessment, {
          isDraft: pr.draft ?? false,
          targetBranch: pr.base.ref,
        });

        adjustedStartLabels = adjustedStartLabels.filter(
          (name) => !labelContext.toRemove.has(name),
        );
        for (const label of labelContext.toAdd) {
          if (!adjustedStartLabels.includes(label)) {
            adjustedStartLabels.push(label);
          }
        }

        const [commentBody, automatedChecksMet] = createNextStepsComment(
          mockCore,
          repo,
          adjustedStartLabels,
          pr.base.ref,
          requiredCheckRuns,
          fyiCheckRuns,
          impactAssessment !== undefined,
          WORKFLOW_URL,
        );

        const actualLabels = [...labelContext.toAdd, ...labelContext.present];
        expect(actualLabels.sort()).toEqual(expectedLabels.sort());
        expect(commentBody).toEqual(expectedNextStepsComment);
        expect(automatedChecksMet).toBeTruthy();
      },
      600000,
    );
  });
});

describe("Summarize Checks Unit Tests", () => {
  describe("check result processing", () => {
    it.each([false, true])(
      "places the SDK summary and pending guidance before a single footer (assessment complete: %s)",
      (assessmentCompleted) => {
        const sdkSummary = `### SDK Breaking Change Detection and Mitigation`;
        const [comment] = createNextStepsComment(
          mockCore,
          "azure-rest-api-specs",
          [],
          "main",
          [],
          [],
          assessmentCompleted,
          WORKFLOW_URL,
          sdkSummary,
        );
        const footer = `Comment generated by [summarize-checks](${WORKFLOW_URL}) workflow run.`;

        expect(comment.split(footer)).toHaveLength(2);
        expect(comment.endsWith(`${sdkSummary}\n\n${footer}`)).toBe(true);
        if (assessmentCompleted) {
          expect(comment).not.toContain(`### Still evaluating`);
        } else {
          expect(comment).toContain(`### Still evaluating`);
          expect(comment.indexOf(`### Still evaluating`)).toBeLessThan(comment.indexOf(sdkSummary));
        }
      },
    );

    it("shows later-priority approvals and failures without displacing immediate next steps", () => {
      const [comment, status] = createNextStepsComment(
        mockCore,
        "azure-rest-api-specs",
        [
          "data-plane",
          "PublishToCustomers",
          "data-plane-review-requested",
          "package-name-review-required",
          "typespec-suppressions-review-required",
        ],
        "main",
        ["TypeSpec Validation", "Swagger Avocado", "Swagger BreakingChange"].map((name) => ({
          name,
          status: "completed",
          conclusion: "failure",
          checkInfo: getCheckInfo(name),
        })),
        [],
        true,
        WORKFLOW_URL,
      );

      const remainingIndex = comment.indexOf(
        "<details><summary>Other outstanding requirements (4)</summary>",
      );
      expect(remainingIndex).toBeGreaterThan(-1);
      expect(comment).toContain("data-plane-review-signoff");
      expect(comment).toContain(`\`TypeSpec Validation\``);
      expect(comment.indexOf("data-plane-review-signoff")).toBeLessThan(remainingIndex);
      expect(comment.indexOf(`\`TypeSpec Validation\``)).toBeLessThan(remainingIndex);
      const remaining = comment.slice(remainingIndex);
      expect(remaining).toContain("Package Name Review Required");
      expect(remaining).toContain("typespec-suppressions-approved");
      expect(remaining).toContain(`\`Swagger Avocado\``);
      expect(remaining).toContain(`\`Swagger BreakingChange\``);
      expect(comment.match(/`TypeSpec Validation`/g)).toHaveLength(1);
      expect(status.result).toBe("FAILURE");
    });

    it.each([
      {
        kind: "approval",
        labels: [
          "PublishToCustomers",
          "data-plane-review-requested",
          "package-name-review-required",
        ],
        checkNames: [],
      },
      {
        kind: "check",
        labels: [],
        checkNames: ["TypeSpec Validation", "Swagger Avocado"],
      },
    ])(
      "counts later-priority $kind requirements without counting immediate steps",
      ({ labels, checkNames }) => {
        const [comment] = createNextStepsComment(
          mockCore,
          "azure-rest-api-specs",
          labels,
          "main",
          checkNames.map((name) => ({
            name,
            status: "completed",
            conclusion: "failure",
            checkInfo: getCheckInfo(name),
          })),
          [],
          true,
          WORKFLOW_URL,
        );

        expect(comment).toContain("<summary>Other outstanding requirements (1)</summary>");
      },
    );

    it("removes resolved requirements from the next summary", () => {
      const [comment, status] = createNextStepsComment(
        mockCore,
        "azure-rest-api-specs",
        [
          "data-plane",
          "PublishToCustomers",
          "data-plane-review-requested",
          "data-plane-review-signoff",
          "package-name-review-required",
          "package-name-approved",
          "typespec-suppressions-review-required",
          "typespec-suppressions-approved",
        ],
        "main",
        ["TypeSpec Validation", "Swagger Avocado", "Swagger BreakingChange"].map((name) => ({
          name,
          status: "completed",
          conclusion: "success",
          checkInfo: getCheckInfo(name),
        })),
        [],
        true,
        WORKFLOW_URL,
      );

      expect(comment).toContain("All automated merging requirements have been met");
      expect(comment).not.toContain("Other outstanding requirements");
      expect(comment).not.toContain("Still evaluating");
      expect(comment).not.toContain("Package Name Review Required");
      expect(status.result).toBe("SUCCESS");
    });

    it("identifies incomplete evaluation even while known blockers are displayed", () => {
      const [comment, status] = createNextStepsComment(
        mockCore,
        "azure-rest-api-specs",
        [],
        "main",
        [
          {
            name: "TypeSpec Validation",
            status: "in_progress",
            conclusion: null,
            checkInfo: getCheckInfo("TypeSpec Validation"),
          },
          {
            name: "Swagger Avocado",
            status: "queued",
            conclusion: null,
            checkInfo: getCheckInfo("Swagger Avocado"),
          },
          {
            name: "Swagger BreakingChange",
            status: "completed",
            conclusion: "failure",
            checkInfo: getCheckInfo("Swagger BreakingChange"),
          },
        ],
        [],
        false,
        WORKFLOW_URL,
      );

      expect(comment).toContain(`\`Swagger BreakingChange\` has failed`);
      expect(comment).toContain(`### Still evaluating`);
      expect(comment).toContain("PR impact assessment is not complete");
      expect(comment).toContain("Additional requirements may be identified");
      expect(comment).toContain(`Waiting for required check \`TypeSpec Validation\` to complete`);
      expect(comment).toContain(`Waiting for required check \`Swagger Avocado\` to complete`);
      expect(status.result).toBe("FAILURE");
    });

    it.each([
      { remainingChecks: ["Swagger Avocado"], count: 1 },
      { remainingChecks: ["Swagger Avocado", "Swagger BreakingChange"], count: 2 },
    ])(
      "counts $count later-priority FYI failures without making them blockers",
      ({ remainingChecks, count }) => {
        const [comment, status] = createNextStepsComment(
          mockCore,
          "azure-rest-api-specs",
          [],
          "main",
          [],
          ["license/cla", ...remainingChecks].map((name) => ({
            name,
            status: "completed",
            conclusion: "failure",
            checkInfo: getCheckInfo(name),
          })),
          true,
          WORKFLOW_URL,
        );

        expect(comment).toContain(`\`license/cla\``);
        expect(comment).toContain(
          `<details><summary>Other failing non-blocking checks (${count})</summary>`,
        );
        expect(comment).toContain(`\`Swagger Avocado\``);
        expect(comment).not.toContain("Other outstanding requirements");
        expect(status.result).toBe("SUCCESS");
      },
    );

    it.each([
      { runStatus: "queued", conclusion: null, expectedResult: "pending" },
      { runStatus: "completed", conclusion: "failure", expectedResult: "FAILURE" },
    ])(
      "renders $runStatus check names as literal code",
      ({ runStatus, conclusion, expectedResult }) => {
        const name = "<check> & `unsafe`";
        const [comment, status] = createNextStepsComment(
          mockCore,
          "azure-rest-api-specs",
          [],
          "main",
          [
            {
              name,
              status: runStatus,
              conclusion,
              checkInfo: getCheckInfo(name),
            },
          ],
          [],
          true,
          WORKFLOW_URL,
        );

        expect(marked.parse(comment)).toContain("<code>&lt;check&gt; &amp; `unsafe`</code>");
        expect(status.result).toBe(expectedResult);
      },
    );

    it("should generate success summary for no matched check suites (completed impactAssessment)", () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";

      const labelNames: string[] = [];

      const fyiCheckRuns: CheckRunData[] = [];

      const requiredCheckRuns: CheckRunData[] = [];
      const expectedOutput = [
        `## Next Steps to Merge

✅ All automated merging requirements have been met! To get your PR merged, see [aka.ms/azsdk/specreview/merge](https://aka.ms/azsdk/specreview/merge).

Comment generated by [summarize-checks](http://github.com/a/fake/workflowrun/url) workflow run.`,
        {
          name: "Automated merging requirements met",
          result: "SUCCESS",
          summary: `✅ All automated merging requirements have been met.

To merge this PR, refer to [aka.ms/azsdk/specreview/merge](https://aka.ms/azsdk/specreview/merge).

For help, consult comments on this PR and see [aka.ms/azsdk/pr-getting-help](https://aka.ms/azsdk/pr-getting-help).`,
        },
      ];

      const output = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
        WORKFLOW_URL,
      );

      expect(output).toEqual(expectedOutput);
    });

    it("should generate success summary for all completed check suites", () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";

      const labelNames: string[] = [];

      const fyiCheckRuns: CheckRunData[] = [];
      const expectedOutput = [
        `## Next Steps to Merge

✅ All automated merging requirements have been met! To get your PR merged, see [aka.ms/azsdk/specreview/merge](https://aka.ms/azsdk/specreview/merge).

Comment generated by [summarize-checks](http://github.com/a/fake/workflowrun/url) workflow run.`,
        {
          name: "Automated merging requirements met",
          result: "SUCCESS",
          summary: `✅ All automated merging requirements have been met.

To merge this PR, refer to [aka.ms/azsdk/specreview/merge](https://aka.ms/azsdk/specreview/merge).

For help, consult comments on this PR and see [aka.ms/azsdk/pr-getting-help](https://aka.ms/azsdk/pr-getting-help).`,
        },
      ];

      const requiredCheckRuns = [
        {
          name: "SpellCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("SpellCheck"),
        },
        {
          name: "TypeSpec Requirement",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("TypeSpec Requirement"),
        },
        {
          name: "Protected Files",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Protected Files"),
        },
        {
          name: "TypeSpec Validation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("TypeSpec Validation"),
        },
        {
          name: "Swagger BreakingChange",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger BreakingChange"),
        },
        {
          name: "Breaking Change(Cross-Version)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Breaking Change(Cross-Version)"),
        },
        {
          name: "Swagger Avocado",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger Avocado"),
        },
        {
          name: "Swagger ModelValidation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger ModelValidation"),
        },
        {
          name: "Swagger SemanticValidation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger SemanticValidation"),
        },
        {
          name: "Swagger Lint(RPaaS)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger Lint(RPaaS)"),
        },
        {
          name: "Automated merging requirements met",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Automated merging requirements met"),
        },
        {
          name: "license/cla",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("license/cla"),
        },
        {
          name: "Swagger PrettierCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger PrettierCheck"),
        },
      ];

      const output = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
        WORKFLOW_URL,
      );

      expect(output).toEqual(expectedOutput);
    });

    it("should generate success summary with completed required checks but in-progress FYI", () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";

      const labelNames: string[] = [];
      const expectedOutput = [
        `## Next Steps to Merge

✅ All automated merging requirements have been met! To get your PR merged, see [aka.ms/azsdk/specreview/merge](https://aka.ms/azsdk/specreview/merge).

Comment generated by [summarize-checks](http://github.com/a/fake/workflowrun/url) workflow run.`,
        {
          name: "Automated merging requirements met",
          result: "SUCCESS",
          summary: `✅ All automated merging requirements have been met.

To merge this PR, refer to [aka.ms/azsdk/specreview/merge](https://aka.ms/azsdk/specreview/merge).

For help, consult comments on this PR and see [aka.ms/azsdk/pr-getting-help](https://aka.ms/azsdk/pr-getting-help).`,
        },
      ];

      const requiredCheckRuns = [
        {
          name: "SpellCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("SpellCheck"),
        },
        {
          name: "TypeSpec Requirement",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("TypeSpec Requirement"),
        },
      ];

      const fyiCheckRuns = [
        {
          name: "Swagger Avocado",
          status: "QUEUED",
          conclusion: null,
          checkInfo: {
            precedence: 1,
            name: "Swagger Avocado",
            suppressionLabels: [],
            troubleshootingGuide: `Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the [aka.ms/ci-fix](https://aka.ms/ci-fix) guide`,
          },
        },
        {
          name: "license/cla",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: {
            precedence: 0,
            name: "license/cla",
            suppressionLabels: [],
            troubleshootingGuide: `Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the [aka.ms/ci-fix](https://aka.ms/ci-fix) guide`,
          },
        },
      ];

      const output = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
        WORKFLOW_URL,
      );

      expect(output).toEqual(expectedOutput);
    });

    // this case should NEVER occur in practice, due to Summarize PR Impact being made a "required" check, but in cases
    // where the user is targeting a branch that is not the main branch, we may have no required checks
    // but still have FYI checks in progress. This is a regression test to ensure we handle this case correctly.
    it("should generate success summary with 0 required checks but in-progress FYI", () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";

      const labelNames: string[] = [];
      const expectedOutput = [
        `## Next Steps to Merge

✅ All automated merging requirements have been met! To get your PR merged, see [aka.ms/azsdk/specreview/merge](https://aka.ms/azsdk/specreview/merge).

Comment generated by [summarize-checks](http://github.com/a/fake/workflowrun/url) workflow run.`,
        {
          name: "Automated merging requirements met",
          result: "SUCCESS",
          summary: `✅ All automated merging requirements have been met.

To merge this PR, refer to [aka.ms/azsdk/specreview/merge](https://aka.ms/azsdk/specreview/merge).

For help, consult comments on this PR and see [aka.ms/azsdk/pr-getting-help](https://aka.ms/azsdk/pr-getting-help).`,
        },
      ];

      const requiredCheckRuns: CheckRunData[] = [];

      const fyiCheckRuns = [
        {
          name: "Swagger Avocado",
          status: "QUEUED",
          conclusion: null,
          checkInfo: {
            precedence: 1,
            name: "Swagger Avocado",
            suppressionLabels: [],
            troubleshootingGuide: `Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the [aka.ms/ci-fix](https://aka.ms/ci-fix) guide`,
          },
        },
        {
          name: "license/cla",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: {
            precedence: 0,
            name: "license/cla",
            suppressionLabels: [],
            troubleshootingGuide: `Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the [aka.ms/ci-fix](https://aka.ms/ci-fix) guide`,
          },
        },
      ];

      const output = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
        WORKFLOW_URL,
      );

      expect(output).toEqual(expectedOutput);
    });

    it("should generate success with warning for error FYI", () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";

      const labelNames: string[] = [];
      const expectedOutput = [
        `## Next Steps to Merge

Important checks have failed. As of today they are not blocking this PR, but in near future they may.

Addressing the following failures is highly recommended:

- ⚠️ The check named \`license/cla\` has failed. Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the [aka.ms/ci-fix](https://aka.ms/ci-fix) guide

If you still want to proceed merging this PR without addressing the above failures, refer to step 4 in the [PR workflow diagram](https://aka.ms/azsdk/pr-diagram).

Comment generated by [summarize-checks](http://github.com/a/fake/workflowrun/url) workflow run.`,
        {
          name: "Automated merging requirements met",
          result: "SUCCESS",
          summary: `⚠️ Some important automated merging requirements have failed. As of today you can still merge this PR, but soon these requirements will be blocking.

See \`Next Steps to merge\` comment on this PR for details on how to address them.

If you want to proceed with merging this PR without fixing them, refer to [aka.ms/azsdk/specreview/merge](https://aka.ms/azsdk/specreview/merge).`,
        },
      ];
      const requiredCheckRuns = [
        {
          name: "SpellCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("SpellCheck"),
        },
      ];

      const fyiCheckRuns = [
        {
          name: "license/cla",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("license/cla"),
        },
      ];

      const output = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
        WORKFLOW_URL,
      );

      expect(output).toEqual(expectedOutput);
    });

    it("should generate success summary when CI-NewRPNamespaceWithoutRPaaS is present, and RPaaSException is as well.", () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";
      const labelNames = ["CI-NewRPNamespaceWithoutRPaaS", "RPaaSException"];

      const fyiCheckRuns: CheckRunData[] = [];
      const expectedCommentBody = `## Next Steps to Merge

✅ All automated merging requirements have been met! To get your PR merged, see [aka.ms/azsdk/specreview/merge](https://aka.ms/azsdk/specreview/merge).

Comment generated by [summarize-checks](target_url) workflow run.`;
      const expectedCheckOutput = {
        name: "Automated merging requirements met",
        result: "SUCCESS",
        summary: `✅ All automated merging requirements have been met.

To merge this PR, refer to [aka.ms/azsdk/specreview/merge](https://aka.ms/azsdk/specreview/merge).

For help, consult comments on this PR and see [aka.ms/azsdk/pr-getting-help](https://aka.ms/azsdk/pr-getting-help).`,
      };

      const requiredCheckRuns = [
        {
          name: "SpellCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("SpellCheck"),
        },
      ];

      const [commentBody, automatedCheckOutput] = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
        "target_url",
      );

      expect(commentBody).toEqual(expectedCommentBody);
      expect(automatedCheckOutput).toEqual(expectedCheckOutput);
    });

    it("should generate pending summary when checks are partially in progress", () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";

      const labelNames: string[] = [];

      const fyiCheckRuns: CheckRunData[] = [];
      const expectedOutput = [
        `## Next Steps to Merge

⌛ Please wait. Next steps to merge this PR are being evaluated by automation. ⌛

### Still evaluating

- Waiting for required check \`TypeSpec Validation\` to complete.
- Waiting for required check \`license/cla\` to complete.

Comment generated by [summarize-checks](${WORKFLOW_URL}) workflow run.`,
        {
          name: "Automated merging requirements met",
          result: "pending",
          summary: "The requirements for merging this PR are still being evaluated. Please wait.",
        },
      ];

      const requiredCheckRuns = [
        {
          name: "TypeSpec Validation",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: getCheckInfo("TypeSpec Validation"),
        },
        {
          name: "Swagger Avocado",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger Avocado"),
        },
        {
          name: "license/cla",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: getCheckInfo("license/cla"),
        },
      ];

      const output = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
        WORKFLOW_URL,
      );

      expect(output).toEqual(expectedOutput);
    });

    it("should generate pending summary when checks are in progress", () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";

      const labelNames: string[] = [];

      const fyiCheckRuns: CheckRunData[] = [];
      const expectedOutput = [
        `## Next Steps to Merge

⌛ Please wait. Next steps to merge this PR are being evaluated by automation. ⌛

### Still evaluating

- Waiting for required check \`TypeSpec Validation\` to complete.
- Waiting for required check \`Swagger Avocado\` to complete.
- Waiting for required check \`license/cla\` to complete.

Comment generated by [summarize-checks](${WORKFLOW_URL}) workflow run.`,
        {
          name: "Automated merging requirements met",
          result: "pending",
          summary: "The requirements for merging this PR are still being evaluated. Please wait.",
        },
      ];

      const requiredCheckRuns = [
        {
          name: "TypeSpec Validation",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: getCheckInfo("TypeSpec Validation"),
        },
        {
          name: "Swagger Avocado",
          status: "QUEUED",
          conclusion: null,
          checkInfo: getCheckInfo("Swagger Avocado"),
        },
        {
          name: "license/cla",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: getCheckInfo("license/cla"),
        },
      ];

      const output = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
        WORKFLOW_URL,
      );

      expect(output).toEqual(expectedOutput);
    });

    it("should generate pending summary when impact assessment is not completed", () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";

      const labelNames: string[] = [];

      const fyiCheckRuns: CheckRunData[] = [];
      const expectedOutput = [
        `## Next Steps to Merge

⌛ Please wait. Next steps to merge this PR are being evaluated by automation. ⌛

### Still evaluating

- PR impact assessment is not complete. Additional requirements may be identified.

Comment generated by [summarize-checks](${WORKFLOW_URL}) workflow run.`,
        {
          name: "Automated merging requirements met",
          result: "pending",
          summary: "The requirements for merging this PR are still being evaluated. Please wait.",
        },
      ];

      const requiredCheckRuns = [
        {
          name: "SpellCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("SpellCheck"),
        },
        {
          name: "TypeSpec Requirement",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("TypeSpec Requirement"),
        },
        {
          name: "Protected Files",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Protected Files"),
        },
        {
          name: "TypeSpec Validation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("TypeSpec Validation"),
        },
        {
          name: "Swagger BreakingChange",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger BreakingChange"),
        },
        {
          name: "Breaking Change(Cross-Version)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Breaking Change(Cross-Version)"),
        },
        {
          name: "Swagger Avocado",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger Avocado"),
        },
        {
          name: "Swagger ModelValidation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger ModelValidation"),
        },
        {
          name: "Swagger SemanticValidation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger SemanticValidation"),
        },
        {
          name: "Swagger Lint(RPaaS)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger Lint(RPaaS)"),
        },
        {
          name: "Automated merging requirements met",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Automated merging requirements met"),
        },
        {
          name: "license/cla",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("license/cla"),
        },
        {
          name: "Swagger PrettierCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger PrettierCheck"),
        },
      ];

      const output = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        false, // assessmentCompleted
        WORKFLOW_URL,
      );

      expect(output).toEqual(expectedOutput);
    });

    it("should generate pending summary when checks are in progress", () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";

      const labelNames: string[] = [];

      const fyiCheckRuns: CheckRunData[] = [];
      const expectedOutput = [
        `## Next Steps to Merge

⌛ Please wait. Next steps to merge this PR are being evaluated by automation. ⌛

### Still evaluating

- Waiting for required check \`TypeSpec Validation\` to complete.
- Waiting for required check \`Swagger Avocado\` to complete.
- Waiting for required check \`license/cla\` to complete.

Comment generated by [summarize-checks](${WORKFLOW_URL}) workflow run.`,
        {
          name: "Automated merging requirements met",
          result: "pending",
          summary: "The requirements for merging this PR are still being evaluated. Please wait.",
        },
      ];

      const requiredCheckRuns = [
        {
          name: "TypeSpec Validation",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: {
            precedence: 0,
            name: "TypeSpec Validation",
            suppressionLabels: [],
            troubleshootingGuide: `Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the [aka.ms/ci-fix](https://aka.ms/ci-fix) guide`,
          },
        },
        {
          name: "Swagger Avocado",
          status: "QUEUED",
          conclusion: null,
          checkInfo: {
            precedence: 1,
            name: "Swagger Avocado",
            suppressionLabels: [],
            troubleshootingGuide: `Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the [aka.ms/ci-fix](https://aka.ms/ci-fix) guide`,
          },
        },
        {
          name: "license/cla",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: {
            precedence: 0,
            name: "license/cla",
            suppressionLabels: [],
            troubleshootingGuide: `Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the [aka.ms/ci-fix](https://aka.ms/ci-fix) guide`,
          },
        },
      ];

      const output = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
        WORKFLOW_URL,
      );

      expect(output).toEqual(expectedOutput);
    });

    it("should generate pending summary when checks there are no required checks blocking or completed, but successful FYI checks", () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";
      const labelNames = [
        "ARMReview",
        "ARMAutoSignedOff",
        "resource-manager",
        "TypeSpec",
        "RPaaS",
        "ARMSignedOff",
        "PublishToCustomers",
      ];
      const expectedOutput = [
        `## Next Steps to Merge

Important checks have failed. As of today they are not blocking this PR, but in near future they may.

Addressing the following failures is highly recommended:

- ⚠️ The check named \`Swagger LintDiff\` has failed. Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the [aka.ms/ci-fix](https://aka.ms/ci-fix) guide

### Still evaluating

- PR impact assessment is not complete. Additional requirements may be identified.
- Waiting for required check \`Summarize PR Impact\` to complete.

Comment generated by [summarize-checks](${WORKFLOW_URL}) workflow run.`,
        {
          name: "Automated merging requirements met",
          result: "pending",
          summary: "The requirements for merging this PR are still being evaluated. Please wait.",
        },
      ];

      const fyiCheckRuns = [
        {
          name: "Swagger BreakingChange",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger BreakingChange"),
        },
        {
          name: "Swagger LintDiff",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("Swagger LintDiff"),
        },
      ];

      const requiredCheckRuns = [
        {
          name: "Summarize PR Impact",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: getCheckInfo("Summarize PR Impact"),
        },
      ];

      const output = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        false, // assessmentCompleted
        WORKFLOW_URL,
      );

      expect(output).toEqual(expectedOutput);
    });

    it("Should generate error summary for a PR scenario where NotReadyForARMReview is present", () => {
      const repo = "azure-rest-api-specs-pr";
      const targetBranch = "RPSaaSMaster";
      const labelNames = [
        "ARMReview",
        "NotReadyForARMReview",
        "PipelineBotTrigger",
        "PublishToCustomers",
        "resource-manager",
        "RPaaS",
        "TypeSpec",
        "VersioningReviewRequired",
      ];

      const fyiCheckRuns: CheckRunData[] = [];
      const expectedComment = `## Next Steps to Merge

Next steps that must be taken to merge this PR:

- ❌ This PR is in purview of the ARM review (label: \`ARMReview\`). This PR must get \`ARMSignedOff\` label from an ARM reviewer.
\x20\x20
  This PR is not ready for ARM review (label: \`NotReadyForARMReview\`). This PR will not be reviewed by ARM until relevant problems are fixed. Consult the rest of this \`Next Steps to Merge\` comment for details.
\x20\x20
  Once the blocking problems are addressed, add to the PR a comment with contents \`/azp run\`. Automation will re-evaluate this PR and if everything looks good, it will add \`WaitForARMFeedback\` label which will put this PR on the ARM review queue.
\x20\x20
  For details of the ARM review, see [aka.ms/azsdk/pr-arm-review](https://aka.ms/azsdk/pr-arm-review)
- ❌ This PR is \`NotReadyForARMReview\` because it has the \`VersioningReviewRequired\` label.
- ❌ This PR has at least one change violating Azure versioning policy (label: \`VersioningReviewRequired\`).
\x20\x20
  To unblock this PR, either a) introduce a new API version with these changes instead of modifying an existing API version, or b) follow the process at [aka.ms/brch](https://aka.ms/brch).
- ❌ The required check named \`Swagger BreakingChange\` has failed. To unblock this PR, follow the process at [aka.ms/brch](https://aka.ms/brch).

Comment generated by [summarize-checks](http://github.com/a/fake/workflowrun/url) workflow run.`;

      const expectedOutput = [
        expectedComment,
        {
          name: "Automated merging requirements met",
          result: "FAILURE",
          summary:
            "❌ This PR cannot be merged because some requirements are not met. See the details.",
        },
      ];

      const requiredCheckRuns = [
        {
          name: "license/cla",
          status: "QUEUED",
          conclusion: null,
          checkInfo: getCheckInfo("license/cla"),
        },
        {
          name: "Swagger PrettierCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger PrettierCheck"),
        },
        {
          name: "TypeSpec Validation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("TypeSpec Validation"),
        },
        {
          name: "Swagger SemanticValidation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger SemanticValidation"),
        },
        {
          name: "TypeSpec Requirement",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("TypeSpec Requirement"),
        },
        {
          name: "Protected Files",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Protected Files"),
        },
        {
          name: "SpellCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("SpellCheck"),
        },
        {
          name: "Swagger ModelValidation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger ModelValidation"),
        },
        {
          name: "SDK Validation Status",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("SDK Validation Status"),
        },
        {
          name: "Breaking Change(Cross-Version)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Breaking Change(Cross-Version)"),
        },
        {
          name: "Swagger BreakingChange",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("Swagger BreakingChange"),
        },
        {
          name: "Swagger Avocado",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger Avocado"),
        },
        {
          name: "Swagger LintDiff",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger LintDiff"),
        },
      ];

      const output = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
        WORKFLOW_URL,
      );

      expect(output[0]).toContain(
        expectedComment.slice(0, expectedComment.indexOf(`Comment generated`)),
      );
      expect(output[1]).toEqual(expectedOutput[1]);
    });

    it("should prioritize ARM modeling review guidance in Next Steps to Merge", () => {
      const [comment] = createNextStepsComment(
        mockCore,
        "azure-rest-api-specs-pr",
        ["ARMReview", "NotReadyForARMReview", "ARMModelingReviewRequired"],
        "RPSaaSMaster",
        [],
        [],
        true,
        WORKFLOW_URL,
      );

      const modelingReviewIndex = comment.indexOf(`This PR has \`ARMModelingReviewRequired\``);
      const notReadyReviewIndex = comment.indexOf("This PR is not ready for ARM review");
      expect(modelingReviewIndex).toBeGreaterThan(-1);
      expect(modelingReviewIndex).toBeLessThan(notReadyReviewIndex);
      expect(comment).toContain(
        `- **Required Doc:** Please use the [RP Agent](https://aka.ms/rpagent) and run the \`/model-rp-contract\` skill.`,
      );
      expect(comment).toContain(
        `**an HTML review package with open questions. For Office Hours:** bring the HTML review package, and we'll use the open questions as the basis for discussion so we can focus on design decisions and gaps instead of starting from scratch.`,
      );
      expect(comment).toContain(
        "Please join the ARM API Modeling Review Office Hours - a drop-in, first-come, first-served " +
          "session (no booking required):",
      );
      expect(comment).toContain("- **When:** Every Tuesday and Thursday, 9:30–10:30 AM PST");
      expect(comment).toContain(`[Join via Teams](https://aka.ms/apimodelingreview)`);
      expect(comment).toContain(`\`/rp-agent-feedback\``);
      expect(comment).toContain(`[RP Agent Feedback](https://aka.ms/rpagent/feedback)`);
      expect(comment).toContain(
        `[API Review Workflow | ARM Wiki](https://armwiki.azurewebsites.net/rp_onboarding/process/api_review.html#arm-api-modeling-review-office-hours)`,
      );
    });

    it("Should generate error summary for a PR scenario with labeling issues", () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";
      const labelNames = [
        "Cognitive Services",
        "data-plane",
        "TypeSpec",
        "VersioningReviewRequired",
      ];

      const fyiCheckRuns: CheckRunData[] = [];
      const expectedComment = `## Next Steps to Merge

Next steps that must be taken to merge this PR:

- ❌ This PR targets either the \`main\` branch of the public specs repo or the \`RPSaaSMaster\` branch of the private specs repo. These branches are not intended for iterative development. Therefore, you must acknowledge you understand that after this PR is merged, the APIs are considered shipped to Azure customers. Any further attempts at in-place modifications to the APIs will be subject to Azure's versioning and breaking change policies. **Additionally, for control plane APIs, you must acknowledge that you are following all the best practices documented by ARM at [aka.ms/armapibestpractices](https://aka.ms/armapibestpractices).** If you do intend to release the APIs to your customers by merging this PR, add the \`PublishToCustomers\` label to your PR in acknowledgement of the above. Otherwise, retarget this PR onto a feature branch, i.e. with prefix \`release-\` (see [aka.ms/azsdk/api-versions#release--branches](https://aka.ms/azsdk/api-versions#release--branches)).
- ❌ This PR has at least one change violating Azure versioning policy (label: \`VersioningReviewRequired\`).
\x20\x20
  To unblock this PR, either a) introduce a new API version with these changes instead of modifying an existing API version, or b) follow the process at [aka.ms/brch](https://aka.ms/brch).
- ❌ The required check named \`TypeSpec Validation\` has failed. Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the [aka.ms/ci-fix](https://aka.ms/ci-fix) guide

Comment generated by [summarize-checks](http://github.com/a/fake/workflowrun/url) workflow run.`;
      const expectedOutput = [
        expectedComment,
        {
          name: "Automated merging requirements met",
          result: "FAILURE",
          summary:
            "❌ This PR cannot be merged because some requirements are not met. See the details.",
        },
      ];

      const requiredCheckRuns = [
        {
          name: "SpellCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("SpellCheck"),
        },
        {
          name: "TypeSpec Requirement",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("TypeSpec Requirement"),
        },
        {
          name: "Protected Files",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Protected Files"),
        },
        {
          name: "TypeSpec Validation",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("TypeSpec Validation"),
        },
        {
          name: "Swagger BreakingChange",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("Swagger BreakingChange"),
        },
        {
          name: "Breaking Change(Cross-Version)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Breaking Change(Cross-Version)"),
        },
        {
          name: "Swagger Avocado",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger Avocado"),
        },
        {
          name: "Swagger ModelValidation",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("Swagger ModelValidation"),
        },
        {
          name: "Swagger SemanticValidation",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger SemanticValidation"),
        },
        {
          name: "Swagger Lint(RPaaS)",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger Lint(RPaaS)"),
        },
        {
          name: "Automated merging requirements met",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("Automated merging requirements met"),
        },
        {
          name: "license/cla",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("license/cla"),
        },
        {
          name: "Swagger PrettierCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("Swagger PrettierCheck"),
        },
      ];

      const output = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
        WORKFLOW_URL,
      );

      expect(output[0]).toContain(
        expectedComment.slice(0, expectedComment.indexOf(`Comment generated`)),
      );
      expect(output[1]).toEqual(expectedOutput[1]);
    });

    it("should generate error summary with a failed required check, and failed FYI checks", () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";

      const labelNames: string[] = [];
      const expectedCheckOutput = {
        name: "Automated merging requirements met",
        result: "FAILURE",
        summary:
          "❌ This PR cannot be merged because some requirements are not met. See the details.",
      };
      const expectedCommentOutput = `## Next Steps to Merge

Next steps that must be taken to merge this PR:

- ❌ The required check named \`Swagger BreakingChange\` has failed. To unblock this PR, follow the process at [aka.ms/brch](https://aka.ms/brch).

Important checks have failed. As of today they are not blocking this PR, but in near future they may.

Addressing the following failures is highly recommended:

- ⚠️ The check named \`TypeSpec Validation\` has failed. Refer to the check in the PR's 'Checks' tab for details on how to fix it and consult the [aka.ms/ci-fix](https://aka.ms/ci-fix) guide

Comment generated by [summarize-checks](http://github.com/a/fake/workflowrun/url) workflow run.`;

      const fyiCheckRuns = [
        {
          name: "TypeSpec Validation",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("TypeSpec Validation"),
        },
      ];

      const requiredCheckRuns = [
        {
          name: "Swagger BreakingChange",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("Swagger BreakingChange"),
        },
      ];

      const [commentOutput, automatedCheckOutput] = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
        WORKFLOW_URL,
      );

      expect(automatedCheckOutput).toEqual(expectedCheckOutput);
      expect(commentOutput).toEqual(expectedCommentOutput);
    });

    it("should generate error summary with a failed required check, and in-progress FYI checks", () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";

      const labelNames: string[] = [];
      const expectedCheckOutput = {
        name: "Automated merging requirements met",
        result: "FAILURE",
        summary:
          "❌ This PR cannot be merged because some requirements are not met. See the details.",
      };

      const fyiCheckRuns = [
        {
          name: "TypeSpec Validation",
          status: "IN_PROGRESS",
          conclusion: null,
          checkInfo: getCheckInfo("TypeSpec Validation"),
        },
      ];

      const requiredCheckRuns = [
        {
          name: "Swagger BreakingChange",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("Swagger BreakingChange"),
        },
      ];

      const [, automatedCheckOutput] = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
        "target_url",
      );

      expect(automatedCheckOutput).toEqual(expectedCheckOutput);
    });

    it("should generate error summary when CI-NewRPNamespaceWithoutRPaaS is present, but RPaaSException is not.", () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";
      const labelNames = ["CI-NewRPNamespaceWithoutRPaaS"];

      const fyiCheckRuns: CheckRunData[] = [];
      const expectedCommentBody = `## Next Steps to Merge

Next steps that must be taken to merge this PR:

- ❌ This PR has \`CI-NewRPNamespaceWithoutRPaaS\` label. This means it is introducing a new RP (Resource Provider) namespace that has not been onboarded with [RPaaS](https://armwiki.azurewebsites.net/rpaas/overview.html). Merging this PR to the \`main\` branch is blocked as RPaaS is required for new RPs.
\x20\x20
  To resolve, [use RPaaS to onboard the new RP](https://armwiki.azurewebsites.net/rpaas/gettingstarted.html). To apply for exception, see [aka.ms/RPaaSException](https://aka.ms/RPaaSException).

Comment generated by [summarize-checks](target_url) workflow run.`;
      const expectedCheckOutput = {
        name: "Automated merging requirements met",
        result: "FAILURE",
        summary:
          "❌ This PR cannot be merged because some requirements are not met. See the details.",
      };

      const requiredCheckRuns = [
        {
          name: "SpellCheck",
          status: "COMPLETED",
          conclusion: "SUCCESS",
          checkInfo: getCheckInfo("SpellCheck"),
        },
      ];

      const [commentBody, automatedCheckOutput] = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
        "target_url",
      );

      expect(commentBody).toEqual(expectedCommentBody);
      expect(automatedCheckOutput).toEqual(expectedCheckOutput);
    });

    it("should generate error summary when checks are in error state", () => {
      const repo = "azure-rest-api-specs";
      const targetBranch = "main";

      const labelNames: string[] = [];

      const fyiCheckRuns: CheckRunData[] = [];
      const expectedCheckOutput = {
        name: "Automated merging requirements met",
        result: "FAILURE",
        summary:
          "❌ This PR cannot be merged because some requirements are not met. See the details.",
      };

      const requiredCheckRuns = [
        {
          name: "Swagger BreakingChange",
          status: "COMPLETED",
          conclusion: "FAILURE",
          checkInfo: getCheckInfo("Swagger BreakingChange"),
        },
      ];

      const [, automatedCheckOutput] = createNextStepsComment(
        mockCore,
        repo,
        labelNames,
        targetBranch,
        requiredCheckRuns,
        fyiCheckRuns,
        true, // assessmentCompleted
        "target_url",
      );

      expect(automatedCheckOutput).toEqual(expectedCheckOutput);
    });
  });

  describe("getImpactAssessment", async () => {
    const unzipExists = await execFile("unzip")
      .then(() => true)
      .catch(() => false);
    const legacyImpactAssessment = {
      resourceManagerRequired: false,
      dataPlaneRequired: true,
      suppressionReviewRequired: false,
      isNewApiVersion: true,
      rpaasRpNotInPrivateRepo: true,
      rpaasChange: false,
      newRP: true,
      rpaasRPMissing: false,
      typeSpecChanged: true,
      isDraft: false,
      targetBranch: "test-\u00e9-\u65e5\u672c",
    };
    const impactAssessment = ImpactAssessmentSchema.parse(legacyImpactAssessment);
    const summaryJson = JSON.stringify(impactAssessment);

    function mockArtifactDownload(
      content: string | Uint8Array,
      name = "summary.json",
      sizeInBytes = Buffer.byteLength(content),
    ) {
      const github = createMockGithub();
      github.rest.actions.downloadArtifact.mockImplementation(() =>
        Promise.resolve({
          data: new Response(typeof content === "string" ? content : Uint8Array.from(content)).body,
        }),
      );
      github.rest.actions.listWorkflowRunArtifacts.mockImplementation((params: { name?: string }) =>
        Promise.resolve({
          data: {
            artifacts: params.name === name ? [{ id: 1, name, size_in_bytes: sizeInBytes }] : [],
          },
        }),
      );
      return github;
    }

    it("prefers raw JSON without looking up the legacy ZIP", async () => {
      const github = mockArtifactDownload(summaryJson);

      await expect(
        getImpactAssessment(github, mockCore, "test-owner", "test-repo", 123),
      ).resolves.toEqual(impactAssessment);

      expect(github.rest.actions.listWorkflowRunArtifacts).toHaveBeenCalledExactlyOnceWith({
        owner: "test-owner",
        repo: "test-repo",
        run_id: 123,
        name: "summary.json",
        per_page: 100,
      });

      expect(github.rest.actions.downloadArtifact).toHaveBeenCalledExactlyOnceWith({
        owner: "test-owner",
        repo: "test-repo",
        artifact_id: 1,
        archive_format: "zip",
        request: { parseSuccessResponseBody: false },
      });
    });

    it("normalizes artifacts produced before the service-scoped schema", async () => {
      const github = mockArtifactDownload(JSON.stringify(legacyImpactAssessment));
      await expect(
        getImpactAssessment(github, mockCore, "test-owner", "test-repo", 123),
      ).resolves.toEqual(impactAssessment);
    });

    it("reads cached service-scoped artifacts without affected-README metadata", async () => {
      const github = mockArtifactDownload(
        JSON.stringify({
          ...impactAssessment,
          services: impactAssessment.services.map((service) => ({
            ...service,
            hasAffectedReadme: undefined,
          })),
        }),
      );
      await expect(
        getImpactAssessment(github, mockCore, "test-owner", "test-repo", 123),
      ).resolves.toEqual(impactAssessment);
    });

    it.each(["application/json", "text/plain", "application/octet-stream"])(
      "reads raw bytes through Octokit with Content-Type %s",
      async (contentType) => {
        const github = mockArtifactDownload(summaryJson);
        const octokit = new Octokit({
          request: {
            fetch: () =>
              Promise.resolve(
                new Response(summaryJson, { headers: { "content-type": contentType } }),
              ),
          },
        });
        github.rest.actions.downloadArtifact.mockImplementation(
          octokit.rest.actions.downloadArtifact,
        );

        await expect(
          getImpactAssessment(github, mockCore, "test-owner", "test-repo", 123),
        ).resolves.toEqual(impactAssessment);
      },
    );

    it.each(["summary.json", "job-summary"])("selects the latest %s artifact", async (name) => {
      const github = mockArtifactDownload(summaryJson);
      github.rest.actions.listWorkflowRunArtifacts.mockImplementation((params: { name?: string }) =>
        Promise.resolve({
          data: {
            artifacts:
              params.name === name
                ? [
                    { id: 1, name },
                    { id: 2, name, updated_at: "2026-10-02" },
                    { id: 3, name, updated_at: "2026-10-01" },
                  ]
                : [],
          },
        }),
      );
      // Stop after selection so this test doesn't depend on legacy extraction.
      github.rest.actions.downloadArtifact.mockRejectedValue(new Error("download stopped"));

      await expect(
        getImpactAssessment(github, mockCore, "test-owner", "test-repo", 123),
      ).rejects.toThrow("download stopped");
      expect(github.rest.actions.downloadArtifact).toHaveBeenCalledWith({
        owner: "test-owner",
        repo: "test-repo",
        artifact_id: 2,
        archive_format: "zip",
        request: { parseSuccessResponseBody: false },
      });
    });

    it.each(["not JSON", "{}"])(
      "rejects invalid raw summaries without a ZIP fallback: %s",
      async (json) => {
        const github = mockArtifactDownload(json);

        await expect(
          getImpactAssessment(github, mockCore, "test-owner", "test-repo", 123),
        ).rejects.toThrow();
        expect(github.rest.actions.listWorkflowRunArtifacts).toHaveBeenCalledTimes(1);
      },
    );

    it.each([0, 1])(
      "checks the advertised size before downloading with %i extra bytes",
      async (extraBytes) => {
        const github = mockArtifactDownload(
          summaryJson,
          "summary.json",
          16 * 1024 * 1024 + extraBytes,
        );
        const result = getImpactAssessment(github, mockCore, "test-owner", "test-repo", 123);

        if (extraBytes === 0) {
          await expect(result).resolves.toEqual(impactAssessment);
          expect(github.rest.actions.downloadArtifact).toHaveBeenCalledTimes(1);
        } else {
          await expect(result).rejects.toThrow("summary.json in artifact ID: 1 exceeds 16 MiB.");
          expect(github.rest.actions.downloadArtifact).not.toHaveBeenCalled();
        }
      },
    );

    it.each([0, 1])(
      "checks actual bytes when metadata understates the size with %i extra bytes",
      async (extraBytes) => {
        const json =
          summaryJson + " ".repeat(16 * 1024 * 1024 + extraBytes - Buffer.byteLength(summaryJson));
        const github = mockArtifactDownload(json, "summary.json", Buffer.byteLength(summaryJson));
        const result = getImpactAssessment(github, mockCore, "test-owner", "test-repo", 123);

        if (extraBytes === 0) {
          await expect(result).resolves.toEqual(impactAssessment);
        } else {
          await expect(result).rejects.toThrow("summary.json in artifact ID: 1 exceeds 16 MiB.");
        }
      },
    );

    it("rejects a missing download stream", async () => {
      const github = mockArtifactDownload(summaryJson);
      github.rest.actions.downloadArtifact.mockResolvedValue({ data: null });

      await expect(
        getImpactAssessment(github, mockCore, "test-owner", "test-repo", 123),
      ).rejects.toThrow("Missing download stream for artifact ID: 1.");
    });

    it.runIf(unzipExists)("reads legacy ZIPs when the raw summary is absent", async () => {
      const github = mockArtifactDownload(
        zipSync({
          "unrelated.json": strToU8("{}"),
          "summary.json": strToU8(summaryJson),
        }),
        "job-summary",
      );

      await expect(
        getImpactAssessment(github, mockCore, "test-owner", "test-repo", 123),
      ).resolves.toEqual(impactAssessment);

      expect(github.rest.actions.listWorkflowRunArtifacts).toHaveBeenNthCalledWith(2, {
        owner: "test-owner",
        repo: "test-repo",
        run_id: 123,
        name: "job-summary",
        per_page: 100,
      });
    });

    it
      .runIf(unzipExists)
      .each([
        strToU8("not a ZIP"),
        zipSync({ "other.json": strToU8(summaryJson) }),
        zipSync({ "summary.json": strToU8("{}") }),
      ])("rejects invalid legacy artifacts %#", async (zip) => {
      const github = mockArtifactDownload(zip, "job-summary");

      await expect(
        getImpactAssessment(github, mockCore, "test-owner", "test-repo", 123),
      ).rejects.toThrow();
    });

    it("throws if neither raw nor legacy artifacts exist", async () => {
      const github = createMockGithub();

      await expect(
        getImpactAssessment(github, mockCore, "test-owner", "test-repo", 123),
      ).rejects.toThrowErrorMatchingInlineSnapshot(
        `[Error: Unable to find summary.json or legacy job-summary artifact for run ID: 123.]`,
      );
    });
  });
});
