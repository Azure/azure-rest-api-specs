import { describe, expect, it } from "vitest";
import { CommitStatusState, PER_PAGE_MAX } from "../../../shared/src/github.ts";
import {
  ARM_SEMANTIC_REVIEW_STATUS,
  encodeSemanticReviewReceipt,
  evaluateAutomatedReviewCoverage,
  evaluateSemanticReview,
  getSemanticReviewOutcome,
  parseSemanticReviewReceipt,
  parseSemanticReviewResult,
  SemanticReviewOutcome,
  type SemanticReviewResult,
} from "../../src/arm-auto-signoff/arm-semantic-review.ts";
import {
  finalizeSemanticReviewWorkflow,
  validateSemanticReviewResult,
} from "../../src/arm-auto-signoff/arm-semantic-review-workflow.ts";
import { createMockCore, createMockGithub } from "../mocks.ts";

const owner = "Azure";
const repo = "azure-rest-api-specs";
const issueNumber = 123;
const headSha = "0123456789abcdef0123456789abcdef01234567";
const targetUrl = "https://github.com/Azure/azure-rest-api-specs/actions/runs/456/attempts/1";
const runId = 456;
const runAttempt = 1;

const passedResult: SemanticReviewResult = {
  issueNumber,
  headSha,
  scope: "full",
  completeness: "complete",
  blockingCount: 0,
};

function receiptName(result: SemanticReviewResult = passedResult): string {
  return `arm-semantic-review=${encodeSemanticReviewReceipt(result, runAttempt)}`;
}

function createFinalizeGithub({
  currentHeadSha = headSha,
  changedFiles = [
    {
      filename: "specification/test/resource-manager/test.json",
      additions: 10,
      deletions: 5,
    },
  ],
  statuses = [
    {
      context: ARM_SEMANTIC_REVIEW_STATUS,
      state: CommitStatusState.PENDING,
      description: "ARM API semantic review is pending",
      target_url: targetUrl,
      updated_at: "2026-01-01T00:00:00Z",
    },
  ],
}: {
  currentHeadSha?: string;
  changedFiles?: { filename: string; additions: number; deletions: number }[];
  statuses?: {
    context: string;
    state: string;
    description: string;
    target_url: string;
    updated_at: string;
  }[];
} = {}) {
  const github = createMockGithub();
  github.rest.pulls.get.mockResolvedValue({
    data: {
      state: "open",
      head: { sha: currentHeadSha },
      changed_files: changedFiles.length,
    },
  });
  github.rest.pulls.listFiles.mockResolvedValue({ data: changedFiles });
  github.rest.repos.listCommitStatusesForRef.mockResolvedValue({ data: statuses });
  return github;
}

function finalize({
  artifactNames = [receiptName()],
  workflowConclusion = "success",
  reviewerExecuted = true,
  github = createFinalizeGithub(),
}: {
  artifactNames?: string[];
  workflowConclusion?: string | null;
  reviewerExecuted?: boolean;
  github?: ReturnType<typeof createFinalizeGithub>;
} = {}) {
  return finalizeSemanticReviewWorkflow({
    owner,
    repo,
    issueNumber,
    headSha,
    runId,
    runAttempt,
    workflowConclusion,
    reviewerExecuted,
    targetUrl,
    artifactNames,
    github,
    core: createMockCore(),
  });
}

describe("parseSemanticReviewResult", () => {
  it("parses one valid semantic result", () => {
    expect(
      parseSemanticReviewResult(
        {
          items: [
            {
              type: "record_arm_semantic_review",
              issue_number: String(issueNumber),
              head_sha: headSha,
              scope: "full",
              completeness: "complete",
              blocking_count: "0",
            },
          ],
        },
        issueNumber,
      ),
    ).toEqual(passedResult);
  });

  it("rejects missing, duplicate, or untrusted correlation values", () => {
    expect(() => parseSemanticReviewResult({ items: [] }, issueNumber)).toThrow(
      "Expected one ARM semantic review result, found 0",
    );
    expect(() =>
      parseSemanticReviewResult(
        {
          items: [{ type: "record_arm_semantic_review" }, { type: "record_arm_semantic_review" }],
        },
        issueNumber,
      ),
    ).toThrow("Expected one ARM semantic review result, found 2");
    expect(() =>
      parseSemanticReviewResult(
        {
          items: [
            {
              type: "record_arm_semantic_review",
              issue_number: "456",
              head_sha: headSha,
              scope: "full",
              completeness: "complete",
              blocking_count: "0",
            },
          ],
        },
        issueNumber,
      ),
    ).toThrow("Invalid ARM semantic review PR number");
  });
});

describe("semantic review receipts", () => {
  it("round-trips an attempt-specific receipt", () => {
    const value = encodeSemanticReviewReceipt(passedResult, runAttempt);

    expect(parseSemanticReviewReceipt([`arm-semantic-review=${value}`], runAttempt)).toEqual(
      passedResult,
    );
  });

  it("ignores receipts from other attempts and rejects ambiguity", () => {
    expect(
      parseSemanticReviewReceipt(
        [`arm-semantic-review=2.${issueNumber}.${headSha}.full.complete.0`],
        1,
      ),
    ).toBeUndefined();
    expect(() => parseSemanticReviewReceipt([receiptName(), receiptName()], runAttempt)).toThrow(
      "Expected one ARM semantic review receipt, found 2",
    );
  });
});

describe("evaluateSemanticReview", () => {
  it("distinguishes every semantic outcome", () => {
    expect(evaluateSemanticReview(passedResult).outcome).toBe(SemanticReviewOutcome.Passed);
    expect(evaluateSemanticReview({ ...passedResult, blockingCount: 2 }).outcome).toBe(
      SemanticReviewOutcome.ChangesRequested,
    );
    expect(evaluateSemanticReview({ ...passedResult, scope: "scoped" }).outcome).toBe(
      SemanticReviewOutcome.ManualReviewRequired,
    );
    expect(evaluateSemanticReview({ ...passedResult, completeness: "incomplete" }).outcome).toBe(
      SemanticReviewOutcome.ReviewIncomplete,
    );
    expect(evaluateSemanticReview({ ...passedResult, completeness: "degraded" }).outcome).toBe(
      SemanticReviewOutcome.ReviewIncomplete,
    );
  });

  describe("evaluateAutomatedReviewCoverage", () => {
    it("requires manual review for oversized or truncated changes", () => {
      const tooManyFiles = Array.from({ length: 51 }, (_, index) => ({
        filename: `specification/test/resource-manager/file-${index}.json`,
        additions: 1,
        deletions: 0,
      }));
      expect(evaluateAutomatedReviewCoverage(tooManyFiles.length, tooManyFiles)).toEqual({
        manualReviewRequired: true,
        reason: "PR exceeds automated review size limits",
      });
      expect(
        evaluateAutomatedReviewCoverage(1, [
          {
            filename: "specification/test/resource-manager/test.json",
            additions: 5_001,
            deletions: 0,
          },
        ]),
      ).toEqual({
        manualReviewRequired: true,
        reason: "PR exceeds automated review size limits",
      });
      expect(evaluateAutomatedReviewCoverage(3_100, tooManyFiles)).toEqual({
        manualReviewRequired: true,
        reason: "changed-file list was truncated",
      });
    });

    it("allows a complete review within the trusted limits", () => {
      expect(
        evaluateAutomatedReviewCoverage(1, [
          {
            filename: "specification/test/resource-manager/test.json",
            additions: 100,
            deletions: 20,
          },
        ]),
      ).toEqual({ manualReviewRequired: false });
    });
  });

  it("routes scoped reviews to manual review even when execution was degraded", () => {
    expect(
      evaluateSemanticReview({
        ...passedResult,
        scope: "scoped",
        completeness: "degraded",
      }).outcome,
    ).toBe(SemanticReviewOutcome.ManualReviewRequired);
  });

  it("reads outcomes from commit statuses", () => {
    expect(getSemanticReviewOutcome({ state: "pending" })).toBe(SemanticReviewOutcome.Pending);
    expect(getSemanticReviewOutcome({ state: "success" })).toBe(SemanticReviewOutcome.Passed);
    expect(getSemanticReviewOutcome({ state: "failure" })).toBe(
      SemanticReviewOutcome.ChangesRequested,
    );
    expect(
      getSemanticReviewOutcome({
        state: "error",
        description: "Manual review required: automated review was scoped",
      }),
    ).toBe(SemanticReviewOutcome.ManualReviewRequired);
    expect(
      getSemanticReviewOutcome({
        state: "error",
        description: "Review incomplete: semantic result was missing",
      }),
    ).toBe(SemanticReviewOutcome.ReviewIncomplete);
  });
});

describe("validateSemanticReviewResult", () => {
  it("accepts only the current open PR head", async () => {
    const github = createFinalizeGithub();
    await expect(
      validateSemanticReviewResult({ owner, repo, result: passedResult, github }),
    ).resolves.toBeUndefined();

    github.rest.pulls.get.mockResolvedValue({
      data: { state: "open", head: { sha: "fedcba9876543210fedcba9876543210fedcba98" } },
    });
    await expect(
      validateSemanticReviewResult({ owner, repo, result: passedResult, github }),
    ).rejects.toThrow("The reviewed pull request head is no longer current");
  });
});

describe("finalizeSemanticReviewWorkflow", () => {
  it("publishes Passed only after the reviewer workflow succeeds", async () => {
    const github = createFinalizeGithub();

    await expect(finalize({ github })).resolves.toBe(true);
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith({
      owner,
      repo,
      sha: headSha,
      state: CommitStatusState.SUCCESS,
      context: ARM_SEMANTIC_REVIEW_STATUS,
      description: "Passed: full review completed with no Blocking findings",
      target_url: targetUrl,
    });
  });

  it("publishes Manual review required for scoped coverage", async () => {
    const github = createFinalizeGithub();
    const result = { ...passedResult, scope: "scoped" as const };

    await finalize({ github, artifactNames: [receiptName(result)] });
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Manual review required: automated review was scoped",
      }),
    );
  });

  it("requires manual review when trusted size checks find limited coverage", async () => {
    const changedFiles = Array.from({ length: 51 }, (_, index) => ({
      filename: `specification/test/resource-manager/file-${index}.json`,
      additions: 1,
      deletions: 0,
    }));
    const github = createFinalizeGithub({ changedFiles });

    await finalize({ github });
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Manual review required: PR exceeds automated review size limits",
      }),
    );

    const failedGithub = createFinalizeGithub({ changedFiles });
    await finalize({
      github: failedGithub,
      artifactNames: [],
      workflowConclusion: "failure",
    });
    expect(failedGithub.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        description: "Manual review required: PR exceeds automated review size limits",
      }),
    );
  });

  it("publishes Review incomplete for missing or failed review execution", async () => {
    const missingGithub = createFinalizeGithub();
    await finalize({ github: missingGithub, artifactNames: [] });
    expect(missingGithub.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Review incomplete: semantic result was missing",
      }),
    );

    const failedGithub = createFinalizeGithub();
    await finalize({ github: failedGithub, workflowConclusion: "failure" });
    expect(failedGithub.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Review incomplete: workflow concluded with failure",
      }),
    );

    const malformedGithub = createFinalizeGithub();
    await finalize({
      github: malformedGithub,
      artifactNames: [`arm-semantic-review=${runAttempt}.malformed`],
    });
    expect(malformedGithub.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        description: "Review incomplete: semantic result was invalid",
      }),
    );

    const mismatchedGithub = createFinalizeGithub();
    const mismatchedReceipt = {
      ...passedResult,
      issueNumber: 456,
    };
    await finalize({
      github: mismatchedGithub,
      artifactNames: [receiptName(mismatchedReceipt)],
    });
    expect(mismatchedGithub.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        description: "Review incomplete: semantic result was invalid",
      }),
    );
  });

  it("does not finalize a canceled pending review", async () => {
    const github = createFinalizeGithub();

    await expect(finalize({ github, workflowConclusion: "cancelled" })).resolves.toBe(false);
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it("ignores a successful workflow where the reviewer did not execute", async () => {
    const github = createFinalizeGithub({
      statuses: [
        {
          context: ARM_SEMANTIC_REVIEW_STATUS,
          state: CommitStatusState.SUCCESS,
          description: "Passed: full review completed with no Blocking findings",
          target_url: "https://github.com/Azure/azure-rest-api-specs/actions/runs/123/attempts/1",
          updated_at: "2026-01-01T00:00:00Z",
        },
      ],
    });

    await expect(
      finalize({
        github,
        artifactNames: [],
        reviewerExecuted: false,
      }),
    ).resolves.toBe(false);
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it("invalidates a final result if its workflow is later canceled", async () => {
    const github = createFinalizeGithub({
      statuses: [
        {
          context: ARM_SEMANTIC_REVIEW_STATUS,
          state: CommitStatusState.SUCCESS,
          description: "Passed: full review completed with no Blocking findings",
          target_url: targetUrl,
          updated_at: "2026-01-01T00:00:00Z",
        },
      ],
    });

    await expect(finalize({ github, workflowConclusion: "cancelled" })).resolves.toBe(true);
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.PENDING,
        description: "Review canceled; rerun required",
      }),
    );
  });

  it("ignores stale heads and superseded runs", async () => {
    const staleGithub = createFinalizeGithub({
      currentHeadSha: "fedcba9876543210fedcba9876543210fedcba98",
    });
    await expect(finalize({ github: staleGithub })).resolves.toBe(false);
    expect(staleGithub.rest.repos.createCommitStatus).not.toHaveBeenCalled();

    const supersededGithub = createFinalizeGithub({
      statuses: [
        {
          context: ARM_SEMANTIC_REVIEW_STATUS,
          state: CommitStatusState.PENDING,
          description: "ARM API semantic review is pending",
          target_url: "https://github.com/Azure/azure-rest-api-specs/actions/runs/789/attempts/1",
          updated_at: "2026-01-02T00:00:00Z",
        },
      ],
    });
    await expect(finalize({ github: supersededGithub })).resolves.toBe(false);
    expect(supersededGithub.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it("overrides an older Passed status when a newer review fails before setting pending", async () => {
    const github = createFinalizeGithub({
      statuses: [
        {
          context: ARM_SEMANTIC_REVIEW_STATUS,
          state: CommitStatusState.SUCCESS,
          description: "Passed: full review completed with no Blocking findings",
          target_url: "https://github.com/Azure/azure-rest-api-specs/actions/runs/123/attempts/1",
          updated_at: "2026-01-01T00:00:00Z",
        },
      ],
    });

    await finalize({
      github,
      artifactNames: [],
      workflowConclusion: "failure",
    });
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Review incomplete: workflow concluded with failure",
      }),
    );
  });

  it("lists commit statuses for the exact reviewed head", async () => {
    const github = createFinalizeGithub();

    await finalize({ github });
    expect(github.rest.repos.listCommitStatusesForRef).toHaveBeenCalledWith({
      owner,
      repo,
      ref: headSha,
      per_page: PER_PAGE_MAX,
    });
  });
});
