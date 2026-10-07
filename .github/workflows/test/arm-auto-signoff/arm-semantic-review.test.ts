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
  SemanticReviewIncompleteReason,
  SemanticReviewOutcome,
  SemanticReviewScope,
  type ChangedFile,
  type SemanticReviewResult,
} from "../../src/arm-auto-signoff/arm-semantic-review.ts";
import publishArmSemanticReviewStatus, {
  finalizeUnpublishedArmSemanticReview,
} from "../../src/arm-auto-signoff/arm-semantic-review-workflow.ts";
import type { GitHubScriptArgs } from "../../src/github.ts";
import { createMockCore, createMockGithub } from "../mocks.ts";

const owner = "Azure";
const repo = "azure-rest-api-specs";
const issueNumber = 123;
const headSha = "0123456789abcdef0123456789abcdef01234567";
const runId = 456;
const runAttempt = 1;
const runUrl = "https://github.com/Azure/azure-rest-api-specs/actions/runs/456";

const passedResult: SemanticReviewResult = {
  runAttempt,
  issueNumber,
  headSha,
  blockingCount: 0,
  reviewScope: SemanticReviewScope.Full,
  completion: SemanticReviewCompletion.Complete,
  incompleteReason: SemanticReviewIncompleteReason.None,
};

function agentOutput(result: SemanticReviewResult = passedResult) {
  return {
    items: [
      {
        type: "record_arm_semantic_review",
        blocking_count: String(result.blockingCount),
        scope: result.reviewScope,
        completeness: result.completion,
        incomplete_reason: result.incompleteReason,
      },
    ],
  };
}

const defaultChangedFiles: ChangedFile[] = [
  { filename: "specification/foo/foo.json", additions: 10, deletions: 5 },
];

function createPublisherGithub() {
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

async function runPublisher({
  output = agentOutput(),
  includeOutput = true,
  github = createPublisherGithub(),
}: {
  output?: unknown;
  includeOutput?: boolean;
  github?: ReturnType<typeof createPublisherGithub>;
} = {}) {
  const directory = await mkdtemp(join(tmpdir(), "arm-semantic-review-"));
  const outputPath = join(directory, "agent_output.json");
  const previousOutputPath = process.env.GH_AW_AGENT_OUTPUT;
  const previousRunAttempt = process.env.GITHUB_RUN_ATTEMPT;
  try {
    if (includeOutput) {
      await writeFile(outputPath, JSON.stringify(output), "utf8");
    }
    process.env.GH_AW_AGENT_OUTPUT = outputPath;
    process.env.GITHUB_RUN_ATTEMPT = String(runAttempt);
    const result = await publishArmSemanticReviewStatus({
      github,
      context: {
        repo: { owner, repo },
        runId,
        serverUrl: "https://github.com",
      },
      core: createMockCore(),
    } as unknown as GitHubScriptArgs);
    return { github, result };
  } finally {
    if (previousOutputPath === undefined) {
      delete process.env.GH_AW_AGENT_OUTPUT;
    } else {
      process.env.GH_AW_AGENT_OUTPUT = previousOutputPath;
    }
    if (previousRunAttempt === undefined) {
      delete process.env.GITHUB_RUN_ATTEMPT;
    } else {
      process.env.GITHUB_RUN_ATTEMPT = previousRunAttempt;
    }
    await rm(directory, { recursive: true, force: true });
  }
}

describe("parseSemanticReviewResult", () => {
  it("parses one valid result", () => {
    expect(parseSemanticReviewResult(agentOutput(), { headSha, issueNumber, runAttempt })).toEqual(
      passedResult,
    );
  });

  it("uses trusted correlation instead of model-supplied identifiers", () => {
    const output = agentOutput();
    Object.assign(output.items[0], {
      head_sha: "675718552ce00736684ed7a184bab",
      issue_number: "999",
      run_attempt: "99",
    });

    expect(parseSemanticReviewResult(output, { headSha, issueNumber, runAttempt })).toEqual(
      passedResult,
    );
  });

  it("rejects missing, duplicate, or invalid semantic results", () => {
    expect(() =>
      parseSemanticReviewResult({ items: [] }, { headSha, issueNumber, runAttempt }),
    ).toThrow("Expected one ARM semantic review result, found 0");
    expect(() =>
      parseSemanticReviewResult(
        {
          items: [
            ...agentOutput().items,
            ...agentOutput({ ...passedResult, blockingCount: 1 }).items,
          ],
        },
        { headSha, issueNumber, runAttempt },
      ),
    ).toThrow("Expected one ARM semantic review result, found 2");
    expect(() =>
      parseSemanticReviewResult(
        {
          items: [{ ...agentOutput().items[0], scope: "partial" }],
        },
        { headSha, issueNumber, runAttempt },
      ),
    ).toThrow("Invalid ARM semantic review scope");
    expect(() =>
      parseSemanticReviewResult(
        {
          items: [{ ...agentOutput().items[0], completeness: "unknown" }],
        },
        { headSha, issueNumber, runAttempt },
      ),
    ).toThrow("Invalid ARM semantic review completion");
    expect(() =>
      parseSemanticReviewResult(
        {
          items: [{ ...agentOutput().items[0], incomplete_reason: "unknown" }],
        },
        { headSha, issueNumber, runAttempt },
      ),
    ).toThrow("Invalid ARM semantic review incomplete reason");
  });

  it("rejects inconsistent completeness and reason combinations", () => {
    expect(() =>
      parseSemanticReviewResult(
        {
          items: [
            {
              ...agentOutput().items[0],
              incomplete_reason: SemanticReviewIncompleteReason.CriticUnavailable,
            },
          ],
        },
        { headSha, issueNumber, runAttempt },
      ),
    ).toThrow("completion 'complete' is inconsistent");
    expect(() =>
      parseSemanticReviewResult(
        {
          items: [
            {
              ...agentOutput().items[0],
              completeness: SemanticReviewCompletion.Incomplete,
            },
          ],
        },
        { headSha, issueNumber, runAttempt },
      ),
    ).toThrow("completion 'incomplete' is inconsistent");
  });

  it("rejects invalid trusted correlation", () => {
    expect(() =>
      parseSemanticReviewResult(agentOutput(), {
        headSha: "675718552ce00736684ed7a184bab",
        issueNumber,
        runAttempt,
      }),
    ).toThrow("ARM semantic review correlation is missing or invalid");
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

  it("requires manual review when the semantic review is scoped", () => {
    const result = { ...passedResult, reviewScope: SemanticReviewScope.Scoped };
    const description = "Manual review required: scoped review requires manual signoff";

    expect(evaluateSemanticReview(result)).toEqual({
      state: CommitStatusState.ERROR,
      description,
    });
  });

  it.each([
    SemanticReviewIncompleteReason.CriticUnavailable,
    SemanticReviewIncompleteReason.RequiredEvidenceUnavailable,
    SemanticReviewIncompleteReason.ToolFailure,
    SemanticReviewIncompleteReason.StaleSha,
    SemanticReviewIncompleteReason.DiscussionDataUnavailable,
  ])("includes incomplete reason %s in the status", (incompleteReason) => {
    const result = {
      ...passedResult,
      completion: SemanticReviewCompletion.Incomplete,
      incompleteReason,
    };

    expect(evaluateSemanticReview(result)).toEqual({
      state: CommitStatusState.ERROR,
      description: `Review incomplete: ${incompleteReason}`,
    });
  });

  it.each([
    {
      name: "scoped with blockers",
      result: { ...passedResult, reviewScope: SemanticReviewScope.Scoped, blockingCount: 2 },
      description: "Manual review required: scoped review requires manual signoff",
    },
    {
      name: "incomplete with blockers",
      result: {
        ...passedResult,
        completion: SemanticReviewCompletion.Incomplete,
        incompleteReason: SemanticReviewIncompleteReason.CriticUnavailable,
        blockingCount: 1,
      },
      description: "Review incomplete: critic-unavailable",
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
    expect(
      getSemanticReviewOutcome({
        state: "error",
        description: "Review incomplete: tool-failure",
      }),
    ).toBe(SemanticReviewOutcome.ReviewIncomplete);
    expect(
      getSemanticReviewOutcome({
        state: "error",
        description: "Manual review required: scoped review requires manual signoff",
      }),
    ).toBe(SemanticReviewOutcome.ManualReviewRequired);
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

describe("publishArmSemanticReviewStatus", () => {
  it("publishes Passed for a clean reviewer result", async () => {
    const { github, result } = await runPublisher();

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

  it("publishes Changes requested for Blocking findings", async () => {
    const { github } = await runPublisher({
      output: agentOutput({ ...passedResult, blockingCount: 3 }),
    });

    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.FAILURE,
        description: "Changes requested: 3 Blocking finding(s)",
      }),
    );
  });

  it("publishes Manual review required for a scoped clean review", async () => {
    const { github } = await runPublisher({
      output: agentOutput({ ...passedResult, reviewScope: SemanticReviewScope.Scoped }),
    });

    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Manual review required: scoped review requires manual signoff",
      }),
    );
  });

  it.each([
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
      name: "invalid Blocking count",
      options: {
        output: {
          items: [{ ...agentOutput().items[0], blocking_count: "not-a-number" }],
        },
      },
      description: "Review incomplete: Invalid ARM semantic review Blocking count",
    },
  ])("publishes Review incomplete for $name", async ({ options, description }) => {
    const { github } = await runPublisher(options);

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

  it("does nothing when trusted PR/SHA correlation is missing", async () => {
    const github = createPublisherGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: { artifacts: [] },
    });

    const execution = await runPublisher({ github });
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
    const github = createPublisherGithub();
    github.rest.pulls.get.mockResolvedValue({ data: pullRequest });

    const execution = await runPublisher({ github });

    expect(execution.result).toEqual({
      headSha,
      issueNumber,
      statusPublished: false,
    });
    expect(github.rest.pulls.listFiles).not.toHaveBeenCalled();
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it("publishes Manual review required when the PR exceeds automated review size limits", async () => {
    const github = createPublisherGithub();
    const oversizedFiles = Array.from({ length: 51 }, (_, i): ChangedFile => ({
      filename: `specification/foo/foo${i}.json`,
      additions: 1,
      deletions: 0,
    }));
    github.rest.pulls.get.mockResolvedValue({
      data: { changed_files: 51, state: "open", head: { sha: headSha } },
    });
    github.rest.pulls.listFiles.mockResolvedValue({ data: oversizedFiles });

    const { github: g } = await runPublisher({ github });
    expect(g.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Manual review required: PR exceeds automated review size limits",
      }),
    );
  });

  it("truncates an overly long error description to 140 characters", async () => {
    const longValue = "x".repeat(200);
    const { github } = await runPublisher({
      output: { items: [{ ...agentOutput().items[0], scope: longValue }] },
    });

    const call = github.rest.repos.createCommitStatus.mock.calls[0]?.[0] as {
      description: string;
    };
    expect(call.description.length).toBeLessThanOrEqual(140);
    expect(call.description).toMatch(/^Review incomplete:/);
  });

  it("does not overwrite a newer review of the same SHA", async () => {
    const github = createPublisherGithub();
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

    const execution = await runPublisher({ github });
    expect(execution.result).toEqual({
      headSha,
      issueNumber,
      statusPublished: false,
    });
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it("checks for a newer run only after reading the PR and its files", async () => {
    const github = createPublisherGithub();

    await runPublisher({ github });

    const [listStatuses] = github.rest.repos.listCommitStatusesForRef.mock.invocationCallOrder;
    const [getPullRequest] = github.rest.pulls.get.mock.invocationCallOrder;
    const [listFiles] = github.rest.pulls.listFiles.mock.invocationCallOrder;
    const [createStatus] = github.rest.repos.createCommitStatus.mock.invocationCallOrder;
    expect(listStatuses).toBeGreaterThan(getPullRequest);
    expect(listStatuses).toBeGreaterThan(listFiles);
    expect(listStatuses).toBeLessThan(createStatus);
  });
  it("does not overwrite a newer attempt of the same run", async () => {
    const github = createPublisherGithub();
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

    const execution = await runPublisher({ github });
    expect(execution.result).toEqual({
      headSha,
      issueNumber,
      statusPublished: false,
    });
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });
});

describe("finalizeUnpublishedArmSemanticReview", () => {
  const ownedPending = {
    context: ARM_SEMANTIC_REVIEW_STATUS,
    state: CommitStatusState.PENDING,
    target_url: `${runUrl}/attempts/${runAttempt}`,
    updated_at: "2026-01-01T00:00:00Z",
  };

  async function runFinalizer(statuses: unknown[], github = createPublisherGithub()) {
    github.rest.repos.listCommitStatusesForRef.mockResolvedValue({ data: statuses });
    const previousRunAttempt = process.env.GITHUB_RUN_ATTEMPT;
    process.env.GITHUB_RUN_ATTEMPT = String(runAttempt);
    try {
      const result = await finalizeUnpublishedArmSemanticReview({
        github,
        context: { repo: { owner, repo }, runId, serverUrl: "https://github.com" },
        core: createMockCore(),
      } as unknown as GitHubScriptArgs);
      return { github, result };
    } finally {
      if (previousRunAttempt === undefined) {
        delete process.env.GITHUB_RUN_ATTEMPT;
      } else {
        process.env.GITHUB_RUN_ATTEMPT = previousRunAttempt;
      }
    }
  }

  it("resolves a Pending status owned by this run as Review incomplete", async () => {
    const { github, result } = await runFinalizer([ownedPending]);

    expect(result).toEqual({ statusPublished: true });
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith({
      owner,
      repo,
      sha: headSha,
      state: CommitStatusState.ERROR,
      context: ARM_SEMANTIC_REVIEW_STATUS,
      description: "Review incomplete: reviewer did not publish a result",
      target_url: `${runUrl}/attempts/${runAttempt}`,
    });
  });

  it("never publishes a manual-review hold for an unpublished result", async () => {
    const { github } = await runFinalizer([ownedPending]);

    const status = github.rest.repos.createCommitStatus.mock.calls[0]?.[0] as {
      description: string;
    };
    expect(getSemanticReviewOutcome({ state: "error", description: status.description })).toBe(
      SemanticReviewOutcome.ReviewIncomplete,
    );
  });

  it.each([
    { name: "there is no status", statuses: [] },
    {
      name: "the record job already published a result",
      statuses: [
        {
          ...ownedPending,
          state: CommitStatusState.SUCCESS,
          updated_at: "2026-01-01T00:00:01Z",
        },
        ownedPending,
      ],
    },
    {
      name: "a newer run owns the newest status",
      statuses: [
        {
          ...ownedPending,
          target_url: "https://github.com/Azure/azure-rest-api-specs/actions/runs/789/attempts/1",
          updated_at: "2026-01-01T00:00:01Z",
        },
        ownedPending,
      ],
    },
    {
      name: "a newer attempt of this run owns the newest status",
      statuses: [
        {
          ...ownedPending,
          target_url: `${runUrl}/attempts/2`,
          updated_at: "2026-01-01T00:00:01Z",
        },
        ownedPending,
      ],
    },
  ])("leaves the status unchanged when $name", async ({ statuses }) => {
    const { github, result } = await runFinalizer(statuses);

    expect(result).toEqual({ statusPublished: false });
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it("leaves the status unchanged when the run has no trusted head SHA", async () => {
    const github = createPublisherGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({ data: { artifacts: [] } });

    const { result } = await runFinalizer([ownedPending], github);

    expect(result).toEqual({ statusPublished: false });
    expect(github.rest.repos.listCommitStatusesForRef).not.toHaveBeenCalled();
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });
});
