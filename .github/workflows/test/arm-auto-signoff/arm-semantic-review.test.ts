import { mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { describe, expect, it } from "vitest";
import { CommitStatusState, PER_PAGE_MAX } from "../../../shared/src/github.ts";
import {
  ARM_SEMANTIC_REVIEW_STATUS,
  evaluateSemanticReview,
  exceedsSpecificationLimits,
  isWithinAutomatedReviewLimits,
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

const smallPullRequest = { changed_files: 1, additions: 10, deletions: 5 };

function createPublisherGithub() {
  const github = createMockGithub();
  github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
    data: {
      artifacts: [{ name: `head-sha=${headSha}` }, { name: `issue-number=${issueNumber}` }],
    },
  });
  // Default: small PR well within automated review limits
  github.rest.pulls.get.mockResolvedValue({ data: smallPullRequest });
  return github;
}

async function runPublisher({
  output = agentOutput(),
  includeOutput = true,
  setOutputPath = true,
  github = createPublisherGithub(),
}: {
  output?: unknown;
  includeOutput?: boolean;
  setOutputPath?: boolean;
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
    if (setOutputPath) {
      process.env.GH_AW_AGENT_OUTPUT = outputPath;
    } else {
      delete process.env.GH_AW_AGENT_OUTPUT;
    }
    process.env.GITHUB_RUN_ATTEMPT = String(runAttempt);
    const core = createMockCore();
    const result = await publishArmSemanticReviewStatus({
      github,
      context: {
        repo: { owner, repo },
        runId,
        serverUrl: "https://github.com",
      },
      core,
    } as unknown as GitHubScriptArgs);
    return { github, result, core };
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
    expect(parseSemanticReviewResult(agentOutput())).toEqual(passedResult);
  });

  it("ignores model-supplied identifiers", () => {
    const output = agentOutput();
    Object.assign(output.items[0], {
      head_sha: "675718552ce00736684ed7a184bab",
      issue_number: "999",
      run_attempt: "99",
    });

    expect(parseSemanticReviewResult(output)).toEqual(passedResult);
  });

  it("rejects missing or duplicate semantic results", () => {
    expect(() => parseSemanticReviewResult({ items: [] })).toThrow(
      "Expected one ARM semantic review result, found 0",
    );
    expect(() =>
      parseSemanticReviewResult({
        items: [
          ...agentOutput().items,
          ...agentOutput({ ...passedResult, blockingCount: 1 }).items,
        ],
      }),
    ).toThrow("Expected one ARM semantic review result, found 2");
    expect(() => parseSemanticReviewResult({})).toThrow("missing its items array");
  });

  it.each([
    { field: "blocking_count", value: "-1", message: "Invalid ARM semantic review Blocking count" },
    { field: "blocking_count", value: 0, message: "Invalid ARM semantic review Blocking count" },
    { field: "scope", value: "partial", message: "Invalid ARM semantic review scope" },
    { field: "completeness", value: "unknown", message: "Invalid ARM semantic review completion" },
    {
      field: "incomplete_reason",
      value: "unknown",
      message: "Invalid ARM semantic review incomplete reason",
    },
  ])("rejects an invalid $field", ({ field, value, message }) => {
    expect(() =>
      parseSemanticReviewResult({ items: [{ ...agentOutput().items[0], [field]: value }] }),
    ).toThrow(message);
  });

  it("rejects a complete review that carries an incomplete reason", () => {
    expect(() =>
      parseSemanticReviewResult({
        items: [
          {
            ...agentOutput().items[0],
            incomplete_reason: SemanticReviewIncompleteReason.CriticUnavailable,
          },
        ],
      }),
    ).toThrow("completion 'complete' is inconsistent");
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
    expect(getSemanticReviewOutcome(undefined)).toBeUndefined();
    expect(getSemanticReviewOutcome({ state: "unexpected" })).toBeUndefined();
  });
});

describe("isWithinAutomatedReviewLimits", () => {
  it.each([
    { name: "a small PR", pr: smallPullRequest, expected: true },
    {
      name: "exactly the file limit",
      pr: { changed_files: 50, additions: 1, deletions: 0 },
      expected: true,
    },
    {
      name: "one file over the limit",
      pr: { changed_files: 51, additions: 1, deletions: 0 },
      expected: false,
    },
    {
      name: "exactly the line limit",
      pr: { changed_files: 1, additions: 3_000, deletions: 2_000 },
      expected: true,
    },
    {
      name: "over the line limit",
      pr: { changed_files: 1, additions: 4_000, deletions: 2_000 },
      expected: false,
    },
    // GitHub reports zero counters when the diff is too large to compute.
    {
      name: "zero reported files",
      pr: { changed_files: 0, additions: 0, deletions: 0 },
      expected: false,
    },
  ])("$name", ({ pr, expected }) => {
    expect(isWithinAutomatedReviewLimits(pr)).toBe(expected);
  });
});

describe("exceedsSpecificationLimits", () => {
  const specFile = (name: string, additions = 1, deletions = 0): ChangedFile => ({
    filename: `specification/foo/${name}.json`,
    additions,
    deletions,
  });
  const otherFile = (name: string, additions = 1): ChangedFile => ({
    filename: `documentation/${name}.md`,
    additions,
    deletions: 0,
  });

  it("ignores files and lines outside specification/", () => {
    const files = [
      specFile("a"),
      ...Array.from({ length: 60 }, (_, i) => otherFile(`doc${i}`, 200)),
    ];
    expect(exceedsSpecificationLimits(files.length, files)).toBe(false);
  });

  it("allows exactly the specification file limit", () => {
    const files = Array.from({ length: 50 }, (_, i) => specFile(`f${i}`));
    expect(exceedsSpecificationLimits(files.length, files)).toBe(false);
  });

  it("flags more specification files than the limit", () => {
    const files = Array.from({ length: 51 }, (_, i) => specFile(`f${i}`));
    expect(exceedsSpecificationLimits(files.length, files)).toBe(true);
  });

  it("flags more specification lines than the limit", () => {
    const files = [specFile("big", 4_000, 2_000)];
    expect(exceedsSpecificationLimits(files.length, files)).toBe(true);
  });

  it("flags a truncated file list", () => {
    expect(exceedsSpecificationLimits(10, [specFile("a")])).toBe(true);
    const capped = Array.from({ length: 3_000 }, (_, i) => otherFile(`d${i}`));
    expect(exceedsSpecificationLimits(3_000, capped)).toBe(true);
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

  it("does not list files when the PR is within the aggregate limits", async () => {
    const { github } = await runPublisher();

    expect(github.rest.pulls.listFiles).not.toHaveBeenCalled();
  });

  it("publishes Passed when only non-specification files push the PR over the limits", async () => {
    const github = createPublisherGithub();
    const files = [
      { filename: "specification/foo/foo.json", additions: 10, deletions: 5 },
      ...Array.from({ length: 60 }, (_, i) => ({
        filename: `documentation/doc${i}.md`,
        additions: 1,
        deletions: 0,
      })),
    ];
    github.rest.pulls.get.mockResolvedValue({
      data: { changed_files: files.length, additions: 70, deletions: 5 },
    });
    github.rest.pulls.listFiles.mockResolvedValue({ data: files });

    const { github: g } = await runPublisher({ github });
    expect(g.rest.pulls.listFiles).toHaveBeenCalled();
    expect(g.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: CommitStatusState.SUCCESS }),
    );
  });

  it.each([
    {
      name: "too many specification files",
      pr: { changed_files: 51, additions: 51, deletions: 0 },
      files: Array.from({ length: 51 }, (_, i) => ({
        filename: `specification/foo/f${i}.json`,
        additions: 1,
        deletions: 0,
      })),
    },
    {
      name: "a truncated file list",
      pr: { changed_files: 51, additions: 51, deletions: 0 },
      files: [{ filename: "specification/foo/foo.json", additions: 1, deletions: 0 }],
    },
  ])("publishes Manual review required for $name", async ({ pr, files }) => {
    const github = createPublisherGithub();
    github.rest.pulls.get.mockResolvedValue({ data: pr });
    github.rest.pulls.listFiles.mockResolvedValue({ data: files });

    const { github: g } = await runPublisher({ github });
    expect(g.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Manual review required: PR exceeds automated review size limits",
      }),
    );
  });

  it("publishes Manual review required without listing files when the PR reports zero files", async () => {
    const github = createPublisherGithub();
    github.rest.pulls.get.mockResolvedValue({
      data: { changed_files: 0, additions: 0, deletions: 0 },
    });

    const { github: g } = await runPublisher({ github });
    expect(g.rest.pulls.listFiles).not.toHaveBeenCalled();
    expect(g.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Manual review required: PR exceeds automated review size limits",
      }),
    );
  });

  it.each([
    {
      name: "missing agent output",
      options: { includeOutput: false },
      logged: "ENOENT",
    },
    {
      name: "missing semantic item",
      options: { output: { items: [] } },
      logged: "Expected one ARM semantic review result, found 0",
    },
    {
      name: "invalid Blocking count",
      options: {
        output: {
          items: [{ ...agentOutput().items[0], blocking_count: "not-a-number" }],
        },
      },
      logged: "Invalid ARM semantic review Blocking count",
    },
  ])("publishes Review incomplete for $name", async ({ options, logged }) => {
    const { github, core } = await runPublisher(options);

    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Review incomplete: result could not be validated",
      }),
    );
    // The details go to the run log, not the public status description.
    expect(core.warning).toHaveBeenCalledWith(expect.stringContaining(logged));
  });

  it("publishes Review incomplete when the output path is not set", async () => {
    const { github } = await runPublisher({ setOutputPath: false });

    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Review incomplete: result could not be validated",
      }),
    );
  });

  it("logs a thrown value that is not an Error", async () => {
    const github = createPublisherGithub();
    github.rest.pulls.get.mockRejectedValue("plain string failure");

    const { github: g, core } = await runPublisher({ github });
    expect(g.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: CommitStatusState.ERROR }),
    );
    expect(core.warning).toHaveBeenCalledWith("plain string failure");
  });

  it("publishes Review incomplete without exposing the error when the PR cannot be read", async () => {
    const github = createPublisherGithub();
    github.rest.pulls.get.mockRejectedValue(new Error("boom: /home/runner/work/_temp/secret"));

    const { github: g, core } = await runPublisher({ github });
    expect(g.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Review incomplete: result could not be validated",
      }),
    );
    expect(core.warning).toHaveBeenCalledWith(expect.stringContaining("boom"));
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
