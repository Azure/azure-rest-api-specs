import { isFullGitSha } from "../../../shared/src/git.ts";
import { CommitStatusState } from "../../../shared/src/github.ts";
import { byDate, invert } from "../../../shared/src/sort.ts";

export const ARM_SEMANTIC_REVIEW_STATUS = "ARM Semantic Review";

export const SemanticReviewOutcome = Object.freeze({
  Passed: "passed",
  ChangesRequested: "changes-requested",
  ManualReviewRequired: "manual-review-required",
  ReviewIncomplete: "review-incomplete",
  Pending: "pending",
});
export type SemanticReviewOutcome =
  (typeof SemanticReviewOutcome)[keyof typeof SemanticReviewOutcome];

export type SemanticReviewScope = "full" | "scoped";
export type SemanticReviewCompleteness = "complete" | "incomplete" | "degraded";

export type SemanticReviewResult = {
  issueNumber: number;
  headSha: string;
  scope: SemanticReviewScope;
  completeness: SemanticReviewCompleteness;
  blockingCount: number;
};

export type CommitStatus = {
  context: string;
  state: string;
  description?: string | null;
  target_url: string | null;
  updated_at: string;
};

export type EvaluatedSemanticReview = {
  outcome: Exclude<SemanticReviewOutcome, "pending">;
  state: CommitStatusState;
  description: string;
};

const RECEIPT_PATTERN =
  /^([1-9]\d*)\.([1-9]\d*)\.([0-9a-f]{40})\.(full|scoped)\.(complete|incomplete|degraded)\.(0|[1-9]\d*)$/i;
const MANUAL_REVIEW_REQUIRED_PREFIX = "Manual review required:";
const REVIEW_INCOMPLETE_PREFIX = "Review incomplete:";
const MAX_SPECIFICATION_FILES = 50;
const MAX_SPECIFICATION_LINES = 5_000;

type ChangedFile = {
  filename: string;
  additions: number;
  deletions: number;
};

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function isSemanticReviewOutput(value: unknown): value is Record<string, unknown> {
  return isRecord(value) && value.type === "record_arm_semantic_review";
}

export function parseSemanticReviewResult(
  agentOutput: unknown,
  expectedIssueNumber: number,
): SemanticReviewResult {
  if (!isRecord(agentOutput) || !Array.isArray(agentOutput.items)) {
    throw new Error("ARM API Reviewer output is missing its items array");
  }

  const items: unknown[] = agentOutput.items;
  const results = items.filter(isSemanticReviewOutput);
  if (results.length !== 1) {
    throw new Error(`Expected one ARM semantic review result, found ${results.length}`);
  }

  const result = results[0];
  const issueNumber = Number(result.issue_number);
  const blockingCount = Number(result.blocking_count);
  if (
    !Number.isSafeInteger(issueNumber) ||
    issueNumber <= 0 ||
    issueNumber !== expectedIssueNumber
  ) {
    throw new Error(`Invalid ARM semantic review PR number: '${String(result.issue_number)}'`);
  }
  if (typeof result.head_sha !== "string" || !isFullGitSha(result.head_sha)) {
    throw new Error(`Invalid ARM semantic review head SHA: '${String(result.head_sha)}'`);
  }
  if (result.scope !== "full" && result.scope !== "scoped") {
    throw new Error(`Invalid ARM semantic review scope: '${String(result.scope)}'`);
  }
  if (
    result.completeness !== "complete" &&
    result.completeness !== "incomplete" &&
    result.completeness !== "degraded"
  ) {
    throw new Error(`Invalid ARM semantic review completeness: '${String(result.completeness)}'`);
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

  return {
    issueNumber,
    headSha: result.head_sha,
    scope: result.scope,
    completeness: result.completeness,
    blockingCount,
  };
}

export function encodeSemanticReviewReceipt(
  result: SemanticReviewResult,
  runAttempt: number,
): string {
  if (!Number.isSafeInteger(runAttempt) || runAttempt <= 0) {
    throw new Error(`Invalid workflow run attempt: '${runAttempt}'`);
  }
  return [
    runAttempt,
    result.issueNumber,
    result.headSha,
    result.scope,
    result.completeness,
    result.blockingCount,
  ].join(".");
}

export function parseSemanticReviewReceipt(
  artifactNames: string[],
  runAttempt: number,
): SemanticReviewResult | undefined {
  const prefix = `arm-semantic-review=${runAttempt}.`;
  const receiptNames = artifactNames.filter((name) => name.startsWith(prefix));
  if (receiptNames.length === 0) {
    return undefined;
  }
  if (receiptNames.length !== 1) {
    throw new Error(`Expected one ARM semantic review receipt, found ${receiptNames.length}`);
  }

  const value = receiptNames[0].substring("arm-semantic-review=".length);
  const match = RECEIPT_PATTERN.exec(value);
  if (!match || Number(match[1]) !== runAttempt) {
    throw new Error(`Invalid ARM semantic review receipt: '${receiptNames[0]}'`);
  }

  const issueNumber = Number(match[2]);
  const blockingCount = Number(match[6]);
  if (!Number.isSafeInteger(issueNumber) || !Number.isSafeInteger(blockingCount)) {
    throw new Error(`Invalid ARM semantic review receipt: '${receiptNames[0]}'`);
  }

  return {
    issueNumber,
    headSha: match[3],
    scope: match[4] as SemanticReviewScope,
    completeness: match[5] as SemanticReviewCompleteness,
    blockingCount,
  };
}

export function manualReviewRequiredStatus(reason: string): EvaluatedSemanticReview {
  return {
    outcome: SemanticReviewOutcome.ManualReviewRequired,
    state: CommitStatusState.ERROR,
    description: `${MANUAL_REVIEW_REQUIRED_PREFIX} ${reason}`,
  };
}

export function reviewIncompleteStatus(reason: string): EvaluatedSemanticReview {
  return {
    outcome: SemanticReviewOutcome.ReviewIncomplete,
    state: CommitStatusState.ERROR,
    description: `${REVIEW_INCOMPLETE_PREFIX} ${reason}`,
  };
}

export function evaluateSemanticReview(result: SemanticReviewResult): EvaluatedSemanticReview {
  if (result.scope === "scoped") {
    return manualReviewRequiredStatus("automated review was scoped");
  }
  if (result.completeness !== "complete") {
    return reviewIncompleteStatus(`automated review was ${result.completeness}`);
  }
  if (result.blockingCount > 0) {
    return {
      outcome: SemanticReviewOutcome.ChangesRequested,
      state: CommitStatusState.FAILURE,
      description: `Changes requested: ${result.blockingCount} Blocking finding(s)`,
    };
  }
  return {
    outcome: SemanticReviewOutcome.Passed,
    state: CommitStatusState.SUCCESS,
    description: "Passed: full review completed with no Blocking findings",
  };
}

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
  if (
    status.state === CommitStatusState.ERROR &&
    status.description?.startsWith(MANUAL_REVIEW_REQUIRED_PREFIX)
  ) {
    return SemanticReviewOutcome.ManualReviewRequired;
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
