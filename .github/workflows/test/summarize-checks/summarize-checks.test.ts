import { Octokit } from "@octokit/rest";
import { strToU8, zipSync } from "fflate";
import { marked, type Tokens } from "marked";
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
  it("preserves the latest provider URLs and keeps legacy pending statuses ambiguous", async () => {
    const github = createMockGithub();
    const core = createMockCore();
    github.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          {
            name: "Swagger LintDiff",
            status: "completed",
            conclusion: "failure",
            completed_at: "2026-01-01T00:00:00Z",
            details_url: "https://checks.example/old",
          },
          {
            name: "Swagger LintDiff",
            status: "in_progress",
            conclusion: null,
            started_at: "2026-01-02T00:00:00Z",
            details_url: "https://checks.example/current",
            html_url: "https://github.com/owner/repo/runs/2",
          },
          {
            name: "Swagger BreakingChange",
            status: "completed",
            conclusion: "success",
            details_url: "",
            html_url: "https://github.com/owner/repo/runs/3",
          },
        ],
      },
    });
    github.rest.repos.listCommitStatusesForRef.mockResolvedValue({
      data: [
        {
          context: "SDK Validation Status",
          state: "pending",
          target_url: "https://dev.azure.com/owner/project/_build/results?buildId=9",
          updated_at: "2026-01-02T00:00:00Z",
        },
      ],
    });

    const [, checks] = await getCheckRunTuple(
      github,
      core,
      "owner",
      "repo",
      fullGitSha,
      "main",
      [],
    );

    expect(checks.map(({ name, status, url }) => ({ name, status, url }))).toEqual([
      { name: "Swagger LintDiff", status: "in_progress", url: "https://checks.example/current" },
      {
        name: "Swagger BreakingChange",
        status: "completed",
        url: "https://github.com/owner/repo/runs/3",
      },
      {
        name: "SDK Validation Status",
        status: "pending",
        url: "https://dev.azure.com/owner/project/_build/results?buildId=9",
      },
    ]);
    const legacy = checks.filter((check) => check.name === "SDK Validation Status");
    const [comment, result] = createNextStepsComment(
      core,
      "repo",
      [],
      "main",
      legacy,
      [],
      true,
      WORKFLOW_URL,
    );
    expect(comment).toContain("Wait for this required check's result.");
    expect(comment).not.toContain("/running.svg");
    expect(result.result).toBe("pending");
  });

  describe("check result processing", () => {
    function run(
      name: string,
      status = "completed",
      conclusion: string | null = "success",
      url?: string,
    ): CheckRunData {
      return { name, status, conclusion, checkInfo: getCheckInfo(name), ...(url ? { url } : {}) };
    }

    function summarize({
      labels = [],
      required = [],
      fyi = [],
      assessmentCompleted = true,
      repo = "azure-rest-api-specs",
      targetBranch = "main",
      sdkSummary = "",
    }: {
      labels?: string[];
      required?: CheckRunData[];
      fyi?: CheckRunData[];
      assessmentCompleted?: boolean;
      repo?: string;
      targetBranch?: string;
      sdkSummary?: string;
    } = {}) {
      return createNextStepsComment(
        mockCore,
        repo,
        labels,
        targetBranch,
        required,
        fyi,
        assessmentCompleted,
        WORKFLOW_URL,
        sdkSummary,
      );
    }

    function rows(comment: string) {
      const token = marked
        .lexer(comment)
        .find((token): token is Tokens.Table => token.type === "table");
      expect(token).toBeDefined();
      return token?.rows.map((row) =>
        row.map((cell, index) =>
          index === 1 ? cell.text.replace(/<\/?picture>|<img\b[^>]*>/g, "").trim() : cell.text,
        ),
      );
    }

    it.each([
      { description: "no required checks", result: "SUCCESS" },
      {
        description: "completed required checks",
        required: [run("TypeSpec Validation")],
        result: "SUCCESS",
      },
      {
        description: "pending FYI checks",
        required: [run("TypeSpec Validation")],
        fyi: [run("Swagger LintDiff", "in_progress", null)],
        result: "SUCCESS",
      },
      {
        description: "only pending FYI checks",
        fyi: [run("Swagger LintDiff", "in_progress", null)],
        result: "SUCCESS",
      },
      {
        description: "failed FYI checks",
        fyi: [run("license/cla", "completed", "failure")],
        result: "SUCCESS",
      },
      {
        description: "an approved RPaaS exception",
        labels: ["CI-NewRPNamespaceWithoutRPaaS", "RPaaSException"],
        result: "SUCCESS",
      },
      {
        description: "partially completed required checks",
        required: [run("TypeSpec Validation"), run("license/cla", "QUEUED", null)],
        result: "pending",
      },
      {
        description: "pending required checks",
        required: [run("TypeSpec Validation", "IN_PROGRESS", null)],
        result: "pending",
      },
      {
        description: "an incomplete impact assessment",
        required: [run("TypeSpec Validation")],
        assessmentCompleted: false,
        result: "pending",
      },
      {
        description: "FYI failures while assessment is incomplete",
        fyi: [run("Swagger LintDiff", "completed", "failure")],
        assessmentCompleted: false,
        result: "pending",
      },
      {
        description: "a required check failure",
        required: [run("Swagger BreakingChange", "completed", "FAILURE")],
        result: "FAILURE",
      },
      {
        description: "required and FYI failures",
        required: [run("Swagger BreakingChange", "completed", "failure")],
        fyi: [run("TypeSpec Validation", "completed", "failure")],
        result: "FAILURE",
      },
      {
        description: "a required failure and pending FYI checks",
        required: [run("Swagger BreakingChange", "completed", "failure")],
        fyi: [run("TypeSpec Validation", "in_progress", null)],
        result: "FAILURE",
      },
      {
        description: "an RPaaS requirement without an exception",
        labels: ["CI-NewRPNamespaceWithoutRPaaS"],
        result: "FAILURE",
      },
      {
        description: "versioning blockers in the private repo",
        repo: "azure-rest-api-specs-pr",
        targetBranch: "RPSaaSMaster",
        labels: [
          "ARMReview",
          "NotReadyForARMReview",
          "PublishToCustomers",
          "VersioningReviewRequired",
        ],
        result: "FAILURE",
      },
      {
        description: "publication and versioning requirements",
        labels: ["data-plane", "VersioningReviewRequired"],
        result: "FAILURE",
      },
    ])("preserves merge status for $description", ({ result, ...options }) => {
      const [, status] = summarize(options);
      expect(status.result).toBe(result);
    });

    it("shows a clear success row without implying that review requirements can be skipped", () => {
      const [comment] = summarize();

      expect(comment).toContain("**All automated merging requirements have been met.**");
      expect(comment).toMatch(
        /passed\.svg"[^>]*><\/picture> \*\*All automated merging requirements/,
      );
      expect(rows(comment)).toEqual([
        ["Automated requirements", "Met", "Follow the merge process linked below."],
      ]);
      expect(comment).toContain("[Merge guide](https://aka.ms/azsdk/specreview/merge)");
      expect(comment).not.toContain("<details>");
    });

    it("shows concise actions and status icons while keeping full guidance collapsed", () => {
      const [comment, status] = summarize({
        labels: ["data-plane"],
        required: [run("TypeSpec Validation", "completed", "failure")],
      });
      const visible = comment.split("<details>")[0];
      const table = marked
        .lexer(comment)
        .find((token): token is Tokens.Table => token.type === "table");

      expect(table?.header.map((cell) => cell.text)).toEqual([
        "Requirement",
        "Status",
        "Next step",
      ]);
      expect(rows(comment)?.map((row) => row.slice(0, 2))).toEqual([
        ["Publication intent", "Action required"],
        ["`TypeSpec Validation`", "Failed"],
      ]);
      expect(visible).toMatch(/action-required\.svg"[^>]*><\/picture> Action required/);
      expect(visible).toMatch(/failed\.svg"[^>]*><\/picture> Failed/);
      expect(marked.parse(visible)).toContain(
        '<picture><img src="https://img.shields.io/github/labels/Azure/azure-rest-api-specs/PublishToCustomers" alt="PublishToCustomers"></picture>',
      );
      expect(marked.parse(visible)).not.toContain(
        'href="https://github.com/Azure/azure-rest-api-specs/labels/',
      );
      expect(visible).toContain("Open the failed check, address its diagnostics");
      expect(visible).not.toContain("These branches are not intended for iterative development");
      expect(comment).toContain("<summary>Details and troubleshooting</summary>");
      expect(comment).toContain("These branches are not intended for iterative development");
      expect(status.result).toBe("FAILURE");
    });

    it("links failed and running checks and keeps successful check links in collapsed details", () => {
      const failedUrl = "https://checks.example/failed?filter=(all)";
      const runningUrl = "https://checks.example/running";
      const passedUrl = "https://checks.example/passed";
      const [comment, result] = summarize({
        required: [
          run("Failed check", "completed", "failure", failedUrl),
          run("Running check", "in_progress", null, runningUrl),
          run("Passed check", "completed", "success", passedUrl),
          run("Skipped check", "completed", "skipped"),
          run("Neutral check", "completed", "neutral"),
        ],
      });
      const visible = comment.split("<details>")[0];
      const completed = comment
        .split("<summary>Completed checks (1)</summary>")[1]
        ?.split("</details>")[0];

      expect(marked.parse(visible)).toContain(`href="${failedUrl}"`);
      expect(marked.parse(visible)).toContain(`href="${runningUrl}"`);
      expect(visible).not.toContain(passedUrl);
      expect(completed).toContain(passedUrl);
      expect(completed).toContain("Passed check");
      expect(completed).not.toContain("Skipped check");
      expect(completed).not.toContain("Neutral check");
      expect(result.result).toBe("FAILURE");
    });

    it("shows all blocking approvals and failures in the main table regardless of priority", () => {
      const [comment, status] = summarize({
        labels: [
          "data-plane",
          "PublishToCustomers",
          "data-plane-review-requested",
          "package-name-review-required",
          "typespec-suppressions-review-required",
        ],
        required: ["TypeSpec Validation", "Swagger Avocado", "Swagger BreakingChange"].map((name) =>
          run(name, "completed", "failure"),
        ),
      });

      expect(rows(comment)?.map((row) => row[0])).toEqual([
        "Data-plane API review",
        "SDK package names",
        "TypeSpec suppressions",
        "`TypeSpec Validation`",
        "`Swagger Avocado`",
        "`Swagger BreakingChange`",
      ]);
      expect(comment).not.toContain("Other outstanding requirements");
      expect(comment.split("<details>")[0]).toContain("6 requirements need attention");
      expect(comment).toContain("typespec-suppressions-approved");
      expect(status.result).toBe("FAILURE");
    });

    it("removes resolved requirements and their guidance from the next summary", () => {
      const [comment, status] = summarize({
        labels: [
          "data-plane",
          "PublishToCustomers",
          "data-plane-review-requested",
          "data-plane-review-signoff",
          "package-name-review-required",
          "package-name-approved",
          "typespec-suppressions-review-required",
          "typespec-suppressions-approved",
        ],
        required: [
          run("TypeSpec Validation"),
          run("Swagger Avocado"),
          run("Swagger BreakingChange"),
        ],
      });

      expect(status.result).toBe("SUCCESS");
      expect(comment).not.toContain("Other outstanding requirements");
      expect(comment).not.toContain("Details and troubleshooting");
      expect(comment).not.toContain("SDK package names");
    });

    it("keeps incomplete evaluation visible even when known failures block merging", () => {
      const [comment, status] = summarize({
        assessmentCompleted: false,
        required: [
          run("TypeSpec Validation", "in_progress", null),
          run("Swagger Avocado", "queued", null),
          run("Swagger BreakingChange", "completed", "failure"),
        ],
      });

      expect(rows(comment)?.map((row) => row.slice(0, 2))).toEqual([
        ["`Swagger BreakingChange`", "Failed"],
        ["PR impact assessment", "Pending"],
        ["`TypeSpec Validation`", "Running"],
        ["`Swagger Avocado`", "Pending"],
      ]);
      expect(comment.split("<details>")[0]).toContain("additional requirements may be identified");
      expect(status.result).toBe("FAILURE");
    });

    it("distinguishes ARM reviewer waits, author actions, running checks and queued checks", () => {
      const [comment, status] = summarize({
        labels: ["resource-manager", "ARMReview", "WaitForARMFeedback"],
        required: [
          run("TypeSpec Validation", "IN_PROGRESS", null),
          run("Swagger Avocado", "QUEUED", null),
        ],
      });

      expect(rows(comment)?.map((row) => row.slice(0, 2))).toEqual([
        ["Publication intent", "Action required"],
        ["ARM API review", "Awaiting review"],
        ["`TypeSpec Validation`", "Running"],
        ["`Swagger Avocado`", "Pending"],
      ]);
      expect(comment).toMatch(/awaiting-review\.svg"[^>]*><\/picture> Awaiting review/);
      expect(comment).toMatch(/running\.svg"[^>]*><\/picture> Running/);
      expect(comment).toMatch(/pending\.svg"[^>]*><\/picture> Pending/);
      expect(comment).not.toContain("ARM review workflow label is missing");
      expect(comment).toContain("Wait for this required check to start.");
      expect(status.result).toBe("FAILURE");
    });

    it.each([
      { label: "NotReadyForARMReview", result: "FAILURE" },
      { label: "ARMChangesRequested", result: "FAILURE" },
      { label: "ARMSignedOff", result: "SUCCESS" },
    ])(
      "does not claim the ARM workflow state is missing when $label is present",
      ({ label, result }) => {
        const [comment, status] = summarize({ labels: ["ARMReview", label] });

        expect(comment).not.toContain("ARM review workflow label is missing");
        expect(rows(comment)?.map((row) => row[0])).not.toContain("ARM review workflow");
        expect(status.result).toBe(result);
      },
    );

    it("retains ARM workflow repair guidance when the state label is genuinely missing", () => {
      const [comment, status] = summarize({ labels: ["ARMReview"] });

      expect(rows(comment)?.map((row) => row[0])).toContain("ARM review workflow");
      expect(comment).toContain("ARM review workflow label is missing");
      expect(comment).toContain("`/azp run`");
      expect(status.result).toBe("FAILURE");
    });

    it.each([["Swagger Avocado"], ["Swagger Avocado", "Swagger BreakingChange"]])(
      "keeps FYI warnings collapsed without blocking merging %#",
      (...names) => {
        const [comment, status] = summarize({
          fyi: ["license/cla", ...names].map((name) => run(name, "completed", "failure")),
        });

        const summary = `<summary>Warnings (${names.length + 1})</summary>`;
        expect(comment).toContain(summary);
        expect(comment).toContain("| `license/cla` |");
        const warningDetails = comment.split(summary)[1]?.split("</details>")[0] ?? "";
        expect(marked.parse(warningDetails)).toContain(
          '<span title="Needs attention, but does not block automated merge requirements.">Warning</span>',
        );
        expect(comment.split("<details>")[0]).not.toContain("license/cla");
        expect(comment).not.toContain("Other outstanding requirements");
        expect(status.result).toBe("SUCCESS");
      },
    );

    it.each(["pending", "required", "fyi"])(
      "renders external %s check names as literal table content",
      (kind) => {
        const name = "<check> & `unsafe` | [label](https://bad.example) @reviewers";
        const check = run(
          name,
          kind === "pending" ? "queued" : "completed",
          kind === "pending" ? null : "failure",
          kind === "pending" ? "not a URL" : "javascript:alert(1)",
        );
        const [comment, status] = summarize(
          kind === "fyi" ? { fyi: [check] } : { required: [check] },
        );
        const html = marked.parse(comment);

        expect(html).toContain(
          "<code>&lt;check&gt; &amp; `unsafe` | [label](https://bad.example) @reviewers</code>",
        );
        expect(html).not.toContain('<a href="https://bad.example">');
        expect(html).not.toContain('href="javascript:');
        expect(status.result).toBe(
          kind === "pending" ? "pending" : kind === "required" ? "FAILURE" : "SUCCESS",
        );
      },
    );

    it("keeps ARM modeling steps short without losing office-hours and lease guidance", () => {
      const [comment] = summarize({
        repo: "azure-rest-api-specs-pr",
        targetBranch: "RPSaaSMaster",
        labels: ["ARMReview", "NotReadyForARMReview", "ARMModelingReviewRequired"],
      });
      const visible = comment.split("<details>")[0];

      expect(visible).toContain("| ARM modeling review |");
      expect(visible).toContain("[office hours](https://aka.ms/apimodelingreview)");
      expect(visible).not.toContain("9:30");
      expect(visible).not.toContain("lease file");
      expect(comment).toContain("Every Tuesday and Thursday, 9:30");
      expect(comment).toContain("`/model-rp-contract`");
      expect(comment).toContain("lease file PR has been merged");
    });

    it.each([false, true])(
      "keeps SDK reports collapsed and before a single workflow link (assessment complete: %s)",
      (assessmentCompleted) => {
        const sdkSummary =
          "### SDK Breaking Change Detection and Mitigation\n\nCurrent-commit reports";
        const [comment] = summarize({ assessmentCompleted, sdkSummary });

        expect(comment).toContain(
          "<summary>SDK breaking-change reports</summary>\n\n" + sdkSummary,
        );
        expect(comment.split("<details>")[0]).not.toContain("Current-commit reports");
        expect(comment.match(/\[Workflow run\]/g)).toHaveLength(1);
        expect(comment.endsWith("[Workflow run](" + WORKFLOW_URL + ")")).toBe(true);
      },
    );
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
