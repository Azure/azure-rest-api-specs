import { CommitStatusState } from "../../../shared/src/github.ts";
import { byDate, invert } from "../../../shared/src/sort.ts";
import { isFullGitSha } from "../../../shared/src/git.ts";

const MAX_SPECIFICATION_FILES = 50;
const MAX_SPECIFICATION_LINES = 5_000;

export type ChangedFile = {
  filename: string;
  additions: number;
  deletions: number;
};

export const ARM_SEMANTIC_REVIEW_STATUS = "ARM Semantic Review";

// Both outcomes are published as a commit status in the "error" state. The description prefix is
// the only thing that tells them apart: a manual-review hold is deterministic (scope or size
// limits) and adds a sticky human label, while an incomplete review is a transient failure that
// a re-run can fix, so it never adds that label.
export const MANUAL_REVIEW_DESCRIPTION_PREFIX = "Manual review required: ";
export const REVIEW_INCOMPLETE_DESCRIPTION_PREFIX = "Review incomplete: ";

export const SemanticReviewOutcome = Object.freeze({
  Passed: "passed",
  ChangesRequested: "changes-requested",
  ManualReviewRequired: "manual-review-required",
  ReviewIncomplete: "review-incomplete",
  Pending: "pending",
});
export type SemanticReviewOutcome =
  (typeof SemanticReviewOutcome)[keyof typeof SemanticReviewOutcome];

export const SemanticReviewScope = Object.freeze({
  Full: "full",
  Scoped: "scoped",
});
export type SemanticReviewScope = (typeof SemanticReviewScope)[keyof typeof SemanticReviewScope];

export const SemanticReviewCompletion = Object.freeze({
  Complete: "complete",
  Incomplete: "incomplete",
});
export type SemanticReviewCompletion =
  (typeof SemanticReviewCompletion)[keyof typeof SemanticReviewCompletion];

export const SemanticReviewIncompleteReason = Object.freeze({
  None: "none",
  CriticUnavailable: "critic-unavailable",
  RequiredEvidenceUnavailable: "required-evidence-unavailable",
  ToolFailure: "tool-failure",
  StaleSha: "stale-sha",
  DiscussionDataUnavailable: "discussion-data-unavailable",
});
export type SemanticReviewIncompleteReason =
  (typeof SemanticReviewIncompleteReason)[keyof typeof SemanticReviewIncompleteReason];

export type SemanticReviewResult = {
  runAttempt: number;
  issueNumber: number;
  headSha: string;
  blockingCount: number;
  reviewScope: SemanticReviewScope;
  completion: SemanticReviewCompletion;
  incompleteReason: SemanticReviewIncompleteReason;
};

export type SemanticReviewCorrelation = Pick<
  SemanticReviewResult,
  "runAttempt" | "issueNumber" | "headSha"
>;

export type CommitStatus = {
  context: string;
  state: string;
  description?: string | null;
  target_url?: string | null;
  updated_at: string;
};

export type EvaluatedSemanticReview = {
  state: CommitStatusState;
  description: string;
};

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

/**
 * Combines exactly one semantic result from gh-aw's agent output with trusted
 * workflow correlation.
 */
export function parseSemanticReviewResult(
  agentOutput: unknown,
  correlation: SemanticReviewCorrelation,
): SemanticReviewResult {
  if (
    !Number.isSafeInteger(correlation.runAttempt) ||
    correlation.runAttempt <= 0 ||
    !Number.isSafeInteger(correlation.issueNumber) ||
    correlation.issueNumber <= 0 ||
    !isFullGitSha(correlation.headSha)
  ) {
    throw new Error("ARM semantic review correlation is missing or invalid");
  }
  if (!isRecord(agentOutput) || !Array.isArray(agentOutput.items)) {
    throw new Error("ARM API Reviewer output is missing its items array");
  }

  const results = (agentOutput.items as unknown[]).filter(
    (item): item is Record<string, unknown> =>
      isRecord(item) && item.type === "record_arm_semantic_review",
  );
  if (results.length !== 1) {
    throw new Error(`Expected one ARM semantic review result, found ${results.length}`);
  }

  const result = results[0];
  const blockingCount = Number(result.blocking_count);
  if (
    typeof result.blocking_count !== "string" ||
    !/^(0|[1-9]\d*)$/.test(result.blocking_count) ||
    !Number.isSafeInteger(blockingCount)
  ) {
    throw new Error(
      `Invalid ARM semantic review Blocking count: '${String(result.blocking_count)}'`,
    );
  }
  if (result.scope !== SemanticReviewScope.Full && result.scope !== SemanticReviewScope.Scoped) {
    throw new Error(`Invalid ARM semantic review scope: '${String(result.scope)}'`);
  }
  if (
    result.completeness !== SemanticReviewCompletion.Complete &&
    result.completeness !== SemanticReviewCompletion.Incomplete
  ) {
    throw new Error(`Invalid ARM semantic review completion: '${String(result.completeness)}'`);
  }
  if (
    result.incomplete_reason !== SemanticReviewIncompleteReason.None &&
    result.incomplete_reason !== SemanticReviewIncompleteReason.CriticUnavailable &&
    result.incomplete_reason !== SemanticReviewIncompleteReason.RequiredEvidenceUnavailable &&
    result.incomplete_reason !== SemanticReviewIncompleteReason.ToolFailure &&
    result.incomplete_reason !== SemanticReviewIncompleteReason.StaleSha &&
    result.incomplete_reason !== SemanticReviewIncompleteReason.DiscussionDataUnavailable
  ) {
    throw new Error(
      `Invalid ARM semantic review incomplete reason: '${String(result.incomplete_reason)}'`,
    );
  }
  if (
    (result.completeness === SemanticReviewCompletion.Complete &&
      result.incomplete_reason !== SemanticReviewIncompleteReason.None) ||
    (result.completeness === SemanticReviewCompletion.Incomplete &&
      result.incomplete_reason === SemanticReviewIncompleteReason.None)
  ) {
    throw new Error(
      `ARM semantic review completion '${result.completeness}' is inconsistent with ` +
        `incomplete reason '${result.incomplete_reason}'`,
    );
  }

  return {
    ...correlation,
    blockingCount,
    reviewScope: result.scope,
    completion: result.completeness,
    incompleteReason: result.incomplete_reason,
  };
}

export function evaluateSemanticReview(result: SemanticReviewResult): EvaluatedSemanticReview {
  // Completeness and scope are checked first: Changes requested applies only to
  // full, complete reviews. An incomplete or scoped review never authorizes signoff
  // regardless of the blocking count.
  if (result.completion === SemanticReviewCompletion.Incomplete) {
    return {
      state: CommitStatusState.ERROR,
      description: `${REVIEW_INCOMPLETE_DESCRIPTION_PREFIX}${result.incompleteReason}`,
    };
  }
  if (result.reviewScope === SemanticReviewScope.Scoped) {
    return {
      state: CommitStatusState.ERROR,
      description: `${MANUAL_REVIEW_DESCRIPTION_PREFIX}scoped review requires manual signoff`,
    };
  }
  if (result.blockingCount > 0) {
    return {
      state: CommitStatusState.FAILURE,
      description: `Changes requested: ${result.blockingCount} Blocking finding(s)`,
    };
  }
  return {
    state: CommitStatusState.SUCCESS,
    description: "Passed: full review completed with no Blocking findings",
  };
}

/**
 * Independently verifies that the PR is within automated-review coverage limits.
 * A full-and-complete agent result must still be rejected if the trusted file list
 * shows the PR was too large or the list was truncated.
 */
export function evaluateAutomatedReviewCoverage(
  changedFileCount: number,
  changedFiles: ChangedFile[],
): { manualReviewRequired: boolean; reason?: string } {
  const fileListTruncated =
    changedFiles.length >= 3_000 ||
    (changedFileCount === 0 && changedFiles.length > 0) ||
    changedFileCount > changedFiles.length;
  if (fileListTruncated) {
    return {
      manualReviewRequired: true,
      reason: "changed-file list was truncated",
    };
  }

  const specificationFiles = changedFiles.filter((file) =>
    file.filename.startsWith("specification/"),
  );
  const specificationLines = specificationFiles.reduce(
    (total, file) => total + file.additions + file.deletions,
    0,
  );
  if (
    specificationFiles.length > MAX_SPECIFICATION_FILES ||
    specificationLines > MAX_SPECIFICATION_LINES
  ) {
    return {
      manualReviewRequired: true,
      reason: "PR exceeds automated review size limits",
    };
  }
  return { manualReviewRequired: false };
}

export function getSemanticReviewOutcome(
  status: Pick<CommitStatus, "state" | "description"> | undefined,
): SemanticReviewOutcome | undefined {
  if (!status) {
    return undefined;
  }
  if (status.state === CommitStatusState.PENDING) {
    return SemanticReviewOutcome.Pending;
  }
  if (status.state === CommitStatusState.SUCCESS) {
    return SemanticReviewOutcome.Passed;
  }
  if (status.state === CommitStatusState.FAILURE) {
    return SemanticReviewOutcome.ChangesRequested;
  }
  if (status.state === CommitStatusState.ERROR) {
    return status.description?.startsWith(MANUAL_REVIEW_DESCRIPTION_PREFIX)
      ? SemanticReviewOutcome.ManualReviewRequired
      : SemanticReviewOutcome.ReviewIncomplete;
  }
  return undefined;
}

export function getLatestSemanticReviewStatus(statuses: CommitStatus[]): CommitStatus | undefined {
  return statuses
    .filter((status) => status.context.toLowerCase() === ARM_SEMANTIC_REVIEW_STATUS.toLowerCase())
    .sort(invert(byDate((status) => status.updated_at)))[0];
}
