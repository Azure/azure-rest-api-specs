import { mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { describe, expect, it } from "vitest";
import { CommitStatusState, PER_PAGE_MAX } from "../../../shared/src/github.ts";
import {
  ARM_SEMANTIC_REVIEW_STATUS,
  evaluateAutomatedReviewCoverage,
  evaluateSemanticReview,
  getSemanticReviewOutcome,
  parseSemanticReviewResult,
  SemanticReviewCompletion,
  SemanticReviewOutcome,
  SemanticReviewScope,
  type ChangedFile,
  type SemanticReviewResult,
} from "../../src/arm-auto-signoff/arm-semantic-review.ts";
import { finalizeArmSemanticReview } from "../../src/arm-auto-signoff/arm-semantic-review-status.ts";
import type { GitHubScriptArgs } from "../../src/github.ts";
import { createMockCore, createMockGithub } from "../mocks.ts";

const owner = "Azure";
const repo = "azure-rest-api-specs";
const issueNumber = 123;
const headSha = "0123456789abcdef0123456789abcdef01234567";
const runId = 456;
const runAttempt = 1;
const runUrl = "https://github.com/Azure/azure-rest-api-specs/actions/runs/456";
const workflowPath = ".github/workflows/arm-api-review.lock.yml";

const passedResult: SemanticReviewResult = {
  runAttempt,
  issueNumber,
  headSha,
  blockingCount: 0,
  reviewScope: SemanticReviewScope.Full,
  completion: SemanticReviewCompletion.Complete,
};

function agentOutput(result: SemanticReviewResult = passedResult) {
  return {
    items: [
      {
        type: "record_arm_semantic_review",
        run_attempt: String(result.runAttempt),
        issue_number: String(result.issueNumber),
        head_sha: result.headSha,
        blocking_count: String(result.blockingCount),
        scope: result.reviewScope,
        completeness: result.completion,
      },
    ],
  };
}

const defaultChangedFiles: ChangedFile[] = [
  { filename: "specification/foo/foo.json", additions: 10, deletions: 5 },
];

function createFinalizeGithub() {
  const github = createMockGithub();
  github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
    data: {
      artifacts: [{ name: `head-sha=${headSha}` }, { name: `issue-number=${issueNumber}` }],
    },
  });
  // Default: small PR well within coverage limits
  github.rest.pulls.get.mockResolvedValue({
    data: { changed_files: 1, state: "open", head: { sha: headSha } },
  });
  github.rest.pulls.listFiles.mockResolvedValue({ data: defaultChangedFiles });
  return github;
}

function createContext(conclusion: string | null = "success", path = workflowPath) {
  return {
    payload: {
      workflow_run: {
        name: `ARM API Review #${issueNumber} (issue_comment)`,
        path,
        conclusion,
        id: runId,
        run_attempt: runAttempt,
        html_url: runUrl,
        repository: {
          name: repo,
          owner: { login: owner },
        },
      },
    },
  };
}

async function runFinalizer({
  conclusion = "success",
  output = agentOutput(),
  includeOutput = true,
  github = createFinalizeGithub(),
  path = workflowPath,
}: {
  conclusion?: string | null;
  output?: unknown;
  includeOutput?: boolean;
  github?: ReturnType<typeof createFinalizeGithub>;
  path?: string;
} = {}) {
  const directory = await mkdtemp(join(tmpdir(), "arm-semantic-review-"));
  const outputPath = join(directory, "agent_output.json");
  const previousOutputPath = process.env.GH_AW_AGENT_OUTPUT;
  try {
    if (includeOutput) {
      await writeFile(outputPath, JSON.stringify(output), "utf8");
    }
    process.env.GH_AW_AGENT_OUTPUT = outputPath;
    const result = await finalizeArmSemanticReview({
      github,
      context: createContext(conclusion, path),
      core: createMockCore(),
    } as unknown as GitHubScriptArgs);
    return { github, result };
  } finally {
    if (previousOutputPath === undefined) {
      delete process.env.GH_AW_AGENT_OUTPUT;
    } else {
      process.env.GH_AW_AGENT_OUTPUT = previousOutputPath;
    }
    await rm(directory, { recursive: true, force: true });
  }
}

describe("parseSemanticReviewResult", () => {
  it("parses one valid result", () => {
    expect(parseSemanticReviewResult(agentOutput(), issueNumber, runAttempt)).toEqual(passedResult);
  });

  it("rejects missing, duplicate, or mismatched results", () => {
    expect(() => parseSemanticReviewResult({ items: [] }, issueNumber, runAttempt)).toThrow(
      "Expected one ARM semantic review result, found 0",
    );
    expect(() =>
      parseSemanticReviewResult(
        {
          items: [
            ...agentOutput().items,
            ...agentOutput({ ...passedResult, blockingCount: 1 }).items,
          ],
        },
        issueNumber,
        runAttempt,
      ),
    ).toThrow("Expected one ARM semantic review result, found 2");
    expect(() =>
      parseSemanticReviewResult(
        agentOutput({ ...passedResult, runAttempt: 2 }),
        issueNumber,
        runAttempt,
      ),
    ).toThrow("Invalid ARM semantic review run attempt");
    expect(() =>
      parseSemanticReviewResult(
        agentOutput({ ...passedResult, issueNumber: 456 }),
        issueNumber,
        runAttempt,
      ),
    ).toThrow("Invalid ARM semantic review PR number");
    expect(() =>
      parseSemanticReviewResult(
        {
          items: [{ ...agentOutput().items[0], scope: "partial" }],
        },
        issueNumber,
        runAttempt,
      ),
    ).toThrow("Invalid ARM semantic review scope");
    expect(() =>
      parseSemanticReviewResult(
        {
          items: [{ ...agentOutput().items[0], completeness: "unknown" }],
        },
        issueNumber,
        runAttempt,
      ),
    ).toThrow("Invalid ARM semantic review completion");
  });
});

describe("evaluateSemanticReview", () => {
  it("passes when a full, complete review has no Blocking findings", () => {
    expect(evaluateSemanticReview(passedResult)).toEqual({
      state: CommitStatusState.SUCCESS,
      description: "Passed: full review completed with no Blocking findings",
    });
  });

  it("requests changes when Blocking findings remain", () => {
    expect(evaluateSemanticReview({ ...passedResult, blockingCount: 2 })).toEqual({
      state: CommitStatusState.FAILURE,
      description: "Changes requested: 2 Blocking finding(s)",
    });
  });

  it.each([
    {
      name: "scoped",
      result: { ...passedResult, reviewScope: SemanticReviewScope.Scoped },
      description: "Review incomplete: scoped review requires manual signoff",
    },
    {
      name: "incomplete",
      result: { ...passedResult, completion: SemanticReviewCompletion.Incomplete },
      description: "Review incomplete: reviewer did not complete",
    },
    {
      name: "degraded",
      result: { ...passedResult, completion: SemanticReviewCompletion.Degraded },
      description: "Review incomplete: reviewer completed in degraded mode",
    },
  ])("requires manual review when the semantic review is $name", ({ result, description }) => {
    expect(evaluateSemanticReview(result)).toEqual({
      state: CommitStatusState.ERROR,
      description,
    });
  });

  it.each([
    {
      name: "scoped with blockers",
      result: { ...passedResult, reviewScope: SemanticReviewScope.Scoped, blockingCount: 2 },
      description: "Review incomplete: scoped review requires manual signoff",
    },
    {
      name: "incomplete with blockers",
      result: {
        ...passedResult,
        completion: SemanticReviewCompletion.Incomplete,
        blockingCount: 1,
      },
      description: "Review incomplete: reviewer did not complete",
    },
    {
      name: "degraded with blockers",
      result: {
        ...passedResult,
        completion: SemanticReviewCompletion.Degraded,
        blockingCount: 3,
      },
      description: "Review incomplete: reviewer completed in degraded mode",
    },
  ])(
    "requires manual review rather than changes requested for $name",
    ({ result, description }) => {
      expect(evaluateSemanticReview(result)).toEqual({
        state: CommitStatusState.ERROR,
        description,
      });
    },
  );

  it("maps commit status states back to semantic outcomes", () => {
    expect(getSemanticReviewOutcome({ state: "pending" })).toBe(SemanticReviewOutcome.Pending);
    expect(getSemanticReviewOutcome({ state: "success" })).toBe(SemanticReviewOutcome.Passed);
    expect(getSemanticReviewOutcome({ state: "failure" })).toBe(
      SemanticReviewOutcome.ChangesRequested,
    );
    expect(getSemanticReviewOutcome({ state: "error" })).toBe(
      SemanticReviewOutcome.ReviewIncomplete,
    );
  });
});

describe("evaluateAutomatedReviewCoverage", () => {
  const smallFile: ChangedFile = {
    filename: "specification/foo/foo.json",
    additions: 10,
    deletions: 5,
  };

  it("passes a small PR within limits", () => {
    expect(evaluateAutomatedReviewCoverage(1, [smallFile])).toEqual({
      manualReviewRequired: false,
    });
  });

  it("requires manual review when the file list is truncated", () => {
    expect(evaluateAutomatedReviewCoverage(10, [smallFile])).toEqual({
      manualReviewRequired: true,
      reason: "changed-file list was truncated",
    });
  });

  it("requires manual review when specification file count exceeds limit", () => {
    const manyFiles = Array.from({ length: 51 }, (_, i): ChangedFile => ({
      filename: `specification/foo/foo${i}.json`,
      additions: 1,
      deletions: 0,
    }));
    expect(evaluateAutomatedReviewCoverage(51, manyFiles)).toEqual({
      manualReviewRequired: true,
      reason: "PR exceeds automated review size limits",
    });
  });

  it("requires manual review when specification line count exceeds limit", () => {
    const bigFile: ChangedFile = {
      filename: "specification/foo/foo.json",
      additions: 4_000,
      deletions: 2_000,
    };
    expect(evaluateAutomatedReviewCoverage(1, [bigFile])).toEqual({
      manualReviewRequired: true,
      reason: "PR exceeds automated review size limits",
    });
  });
});

describe("finalizeArmSemanticReview", () => {
  it("publishes Passed for a clean reviewer result", async () => {
    const { github, result } = await runFinalizer();

    expect(result).toEqual({ headSha, issueNumber, statusPublished: true });
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith({
      owner,
      repo,
      sha: headSha,
      state: CommitStatusState.SUCCESS,
      context: ARM_SEMANTIC_REVIEW_STATUS,
      description: "Passed: full review completed with no Blocking findings",
      target_url: `${runUrl}/attempts/${runAttempt}`,
    });
    expect(github.rest.actions.listWorkflowRunArtifacts).toHaveBeenCalledOnce();
    expect(github.rest.actions.listWorkflowRunArtifacts).toHaveBeenCalledWith({
      owner,
      repo,
      run_id: runId,
      per_page: PER_PAGE_MAX,
    });
  });

  it("rejects a completion from another workflow", async () => {
    const github = createFinalizeGithub();
    await expect(
      runFinalizer({
        github,
        path: ".github/workflows/other-workflow.yaml",
      }),
    ).rejects.toThrow(
      "Unexpected triggering workflow path: expected " +
        "'.github/workflows/arm-api-review.lock.yml', " +
        "received '.github/workflows/other-workflow.yaml'",
    );
    expect(github.rest.actions.listWorkflowRunArtifacts).not.toHaveBeenCalled();
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it("publishes Changes requested for Blocking findings", async () => {
    const { github } = await runFinalizer({
      output: agentOutput({ ...passedResult, blockingCount: 3 }),
    });

    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.FAILURE,
        description: "Changes requested: 3 Blocking finding(s)",
      }),
    );
  });

  it("publishes Review incomplete for a scoped clean review", async () => {
    const { github } = await runFinalizer({
      output: agentOutput({ ...passedResult, reviewScope: SemanticReviewScope.Scoped }),
    });

    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Review incomplete: scoped review requires manual signoff",
      }),
    );
  });

  it.each([
    {
      name: "failed workflow",
      options: { conclusion: "failure" },
      description: "Review incomplete: workflow concluded with failure",
    },
    {
      name: "missing agent output",
      options: { includeOutput: false },
      description: "Review incomplete: ENOENT",
    },
    {
      name: "missing semantic item",
      options: { output: { items: [] } },
      description: "Review incomplete: Expected one ARM semantic review result, found 0",
    },
    {
      name: "wrong SHA",
      options: { output: agentOutput({ ...passedResult, headSha: "f".repeat(40) }) },
      description: "Review incomplete: semantic result SHA does not match reviewer correlation",
    },
  ])("publishes Review incomplete for $name", async ({ options, description }) => {
    const { github } = await runFinalizer(options);

    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
      }),
    );
    const status = github.rest.repos.createCommitStatus.mock.calls[0]?.[0] as {
      description: string;
    };
    expect(status.description).toContain(description);
  });

  it("leaves Pending unchanged when the reviewer run is canceled", async () => {
    const { github, result } = await runFinalizer({ conclusion: "cancelled" });

    expect(result).toEqual({ headSha, issueNumber, statusPublished: false });
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it("does nothing when trusted PR/SHA correlation is missing", async () => {
    const github = createFinalizeGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: { artifacts: [] },
    });

    const execution = await runFinalizer({ github });
    expect(execution.result).toEqual({
      headSha: "",
      issueNumber: 0,
      statusPublished: false,
    });
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it.each([
    {
      name: "closed",
      pullRequest: { changed_files: 1, state: "closed", head: { sha: headSha } },
    },
    {
      name: "stale",
      pullRequest: { changed_files: 1, state: "open", head: { sha: "f".repeat(40) } },
    },
  ])("does not publish a status when the pull request is $name", async ({ pullRequest }) => {
    const github = createFinalizeGithub();
    github.rest.pulls.get.mockResolvedValue({ data: pullRequest });

    const execution = await runFinalizer({ github });

    expect(execution.result).toEqual({
      headSha,
      issueNumber,
      statusPublished: false,
    });
    expect(github.rest.pulls.listFiles).not.toHaveBeenCalled();
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it("publishes Review incomplete when the PR exceeds automated review size limits", async () => {
    const github = createFinalizeGithub();
    const oversizedFiles = Array.from({ length: 51 }, (_, i): ChangedFile => ({
      filename: `specification/foo/foo${i}.json`,
      additions: 1,
      deletions: 0,
    }));
    github.rest.pulls.get.mockResolvedValue({
      data: { changed_files: 51, state: "open", head: { sha: headSha } },
    });
    github.rest.pulls.listFiles.mockResolvedValue({ data: oversizedFiles });

    const { github: g } = await runFinalizer({ github });
    expect(g.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Review incomplete: PR exceeds automated review size limits",
      }),
    );
  });

  it("truncates an overly long error description to 140 characters", async () => {
    const longValue = "x".repeat(200);
    const { github } = await runFinalizer({
      output: { items: [{ ...agentOutput().items[0], run_attempt: longValue }] },
    });

    const call = github.rest.repos.createCommitStatus.mock.calls[0]?.[0] as {
      description: string;
    };
    expect(call.description.length).toBeLessThanOrEqual(140);
    expect(call.description).toMatch(/^Review incomplete:/);
  });

  it("does not overwrite a newer review of the same SHA", async () => {
    const github = createFinalizeGithub();
    github.rest.repos.listCommitStatusesForRef.mockResolvedValue({
      data: [
        {
          context: ARM_SEMANTIC_REVIEW_STATUS,
          state: CommitStatusState.PENDING,
          target_url: "https://github.com/Azure/azure-rest-api-specs/actions/runs/789/attempts/1",
          updated_at: "2026-01-02T00:00:00Z",
        },
      ],
    });

    const execution = await runFinalizer({ github });
    expect(execution.result).toEqual({
      headSha,
      issueNumber,
      statusPublished: false,
    });
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it("does not overwrite a newer attempt of the same run", async () => {
    const github = createFinalizeGithub();
    github.rest.repos.listCommitStatusesForRef.mockResolvedValue({
      data: [
        {
          context: ARM_SEMANTIC_REVIEW_STATUS,
          state: CommitStatusState.PENDING,
          target_url: `https://github.com/Azure/azure-rest-api-specs/actions/runs/${runId}/attempts/2`,
          updated_at: "2026-01-02T00:00:00Z",
        },
      ],
    });

    const execution = await runFinalizer({ github });
    expect(execution.result).toEqual({
      headSha,
      issueNumber,
      statusPublished: false,
    });
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });
});
