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

export const SemanticReviewOutcome = Object.freeze({
  Passed: "passed",
  ChangesRequested: "changes-requested",
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
  Degraded: "degraded",
});
export type SemanticReviewCompletion =
  (typeof SemanticReviewCompletion)[keyof typeof SemanticReviewCompletion];

export type SemanticReviewResult = {
  runAttempt: number;
  issueNumber: number;
  headSha: string;
  blockingCount: number;
  reviewScope: SemanticReviewScope;
  completion: SemanticReviewCompletion;
};

export type CommitStatus = {
  context: string;
  state: string;
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
 * Extracts exactly one semantic result from gh-aw's agent output and validates
 * that it belongs to the completed reviewer run.
 */
export function parseSemanticReviewResult(
  agentOutput: unknown,
  expectedIssueNumber: number,
  expectedRunAttempt: number,
): SemanticReviewResult {
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
  const runAttempt = Number(result.run_attempt);
  const issueNumber = Number(result.issue_number);
  const blockingCount = Number(result.blocking_count);
  if (
    typeof result.run_attempt !== "string" ||
    !/^[1-9]\d*$/.test(result.run_attempt) ||
    !Number.isSafeInteger(runAttempt) ||
    runAttempt !== expectedRunAttempt
  ) {
    throw new Error(`Invalid ARM semantic review run attempt: '${String(result.run_attempt)}'`);
  }
  if (
    typeof result.issue_number !== "string" ||
    !/^[1-9]\d*$/.test(result.issue_number) ||
    !Number.isSafeInteger(issueNumber) ||
    issueNumber !== expectedIssueNumber
  ) {
    throw new Error(`Invalid ARM semantic review PR number: '${String(result.issue_number)}'`);
  }
  if (typeof result.head_sha !== "string" || !isFullGitSha(result.head_sha)) {
    throw new Error(`Invalid ARM semantic review head SHA: '${String(result.head_sha)}'`);
  }
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
    result.completeness !== SemanticReviewCompletion.Incomplete &&
    result.completeness !== SemanticReviewCompletion.Degraded
  ) {
    throw new Error(`Invalid ARM semantic review completion: '${String(result.completeness)}'`);
  }

  return {
    runAttempt,
    issueNumber,
    headSha: result.head_sha,
    blockingCount,
    reviewScope: result.scope,
    completion: result.completeness,
  };
}

export function evaluateSemanticReview(result: SemanticReviewResult): EvaluatedSemanticReview {
  // Scope and completeness are checked first: Changes requested applies only to
  // full, complete reviews. A scoped or incomplete review requires manual signoff
  // regardless of the blocking count.
  if (result.reviewScope === SemanticReviewScope.Scoped) {
    return {
      state: CommitStatusState.ERROR,
      description: "Review incomplete: scoped review requires manual signoff",
    };
  }
  if (result.completion === SemanticReviewCompletion.Incomplete) {
    return {
      state: CommitStatusState.ERROR,
      description: "Review incomplete: reviewer did not complete",
    };
  }
  if (result.completion === SemanticReviewCompletion.Degraded) {
    return {
      state: CommitStatusState.ERROR,
      description: "Review incomplete: reviewer completed in degraded mode",
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
  status: Pick<CommitStatus, "state"> | undefined,
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
    return SemanticReviewOutcome.ReviewIncomplete;
  }
  return undefined;
}

export function getLatestSemanticReviewStatus(statuses: CommitStatus[]): CommitStatus | undefined {
  return statuses
    .filter((status) => status.context.toLowerCase() === ARM_SEMANTIC_REVIEW_STATUS.toLowerCase())
    .sort(invert(byDate((status) => status.updated_at)))[0];
}
