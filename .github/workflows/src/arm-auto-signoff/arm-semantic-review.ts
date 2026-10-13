import { CommitStatusState } from "../../../shared/src/github.ts";
import { byDate, invert } from "../../../shared/src/sort.ts";

/*
 * Pure policy for the `ARM Semantic Review` commit status: how the ARM API Reviewer's structured
 * result is validated, how it maps to a status, and how the status is read back by consumers.
 * This file makes no GitHub API calls; `arm-semantic-review-workflow.ts` does the I/O.
 */

/** The commit status context that carries the semantic review result for a SHA. */
export const ARM_SEMANTIC_REVIEW_STATUS = "ARM Semantic Review";

/*
 * Both outcomes below are published as a commit status in the "error" state. The description
 * prefix is the only thing that tells them apart: a manual-review hold is deterministic (scope or
 * size limits) and adds a sticky human label, while an incomplete review is a transient failure
 * that a re-run can fix, so it never adds that label.
 */

/** Description prefix of an `error` status that requires a human reviewer (scoped or oversized). */
export const MANUAL_REVIEW_DESCRIPTION_PREFIX = "Manual review required: ";

/** Description prefix of an `error` status for a review that did not finish or could not be read. */
export const REVIEW_INCOMPLETE_DESCRIPTION_PREFIX = "Review incomplete: ";

/**
 * What a consumer concludes from the latest `ARM Semantic Review` status. Only `Passed` can
 * contribute to auto-signoff.
 */
export const SemanticReviewOutcome = Object.freeze({
  Passed: "passed",
  ChangesRequested: "changes-requested",
  ManualReviewRequired: "manual-review-required",
  ReviewIncomplete: "review-incomplete",
  Pending: "pending",
});
export type SemanticReviewOutcome =
  (typeof SemanticReviewOutcome)[keyof typeof SemanticReviewOutcome];

/** How much of the PR the reviewer covered: the whole PR, or a size-limited subset. */
export const SemanticReviewScope = Object.freeze({
  Full: "full",
  Scoped: "scoped",
});
export type SemanticReviewScope = (typeof SemanticReviewScope)[keyof typeof SemanticReviewScope];

/** Whether the reviewer and the Critic finished normally. */
export const SemanticReviewCompletion = Object.freeze({
  Complete: "complete",
  Incomplete: "incomplete",
});
export type SemanticReviewCompletion =
  (typeof SemanticReviewCompletion)[keyof typeof SemanticReviewCompletion];

/**
 * Why a review is incomplete, or `none` when it is complete. The set is closed so that model
 * output can never place free text in a public status description.
 */
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

/** The validated form of the reviewer's `record_arm_semantic_review` item. */
export type SemanticReviewResult = {
  /** Verified Blocking findings still applicable after reconciliation. */
  blockingCount: number;
  reviewScope: SemanticReviewScope;
  completion: SemanticReviewCompletion;
  incompleteReason: SemanticReviewIncompleteReason;
};

/** The fields of a commit status (`repos.listCommitStatusesForRef`) that this feature reads. */
export type CommitStatus = {
  context: string;
  state: string;
  description?: string | null;
  target_url?: string | null;
  updated_at: string;
};

/** The commit status state and description to publish for a validated result. */
export type EvaluatedSemanticReview = {
  state: CommitStatusState;
  description: string;
};

/** Narrows to a plain object, excluding `null` and arrays. */
function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

/**
 * Extracts and validates exactly one semantic result from gh-aw's agent output
 * (`agent_output.json`). The PR, head SHA, and run attempt are never read from the model's
 * output; the caller takes them from trusted artifacts.
 *
 * Every field the model supplies is checked against a closed set, so an unknown value can never
 * fall through toward a passing status.
 *
 * @param agentOutput The parsed contents of `agent_output.json`.
 * @returns The validated result.
 * @throws If the output has no `items` array, does not contain exactly one
 *   `record_arm_semantic_review` item, has a malformed or unknown field, or reports a complete
 *   review that carries an incomplete reason.
 */
export function parseSemanticReviewResult(agentOutput: unknown): SemanticReviewResult {
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
  if (typeof result.blocking_count !== "string" || !/^(0|[1-9]\d*)$/.test(result.blocking_count)) {
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
  // A complete review must not carry a failure reason, or it could be read as a pass.
  if (
    result.completeness === SemanticReviewCompletion.Complete &&
    result.incomplete_reason !== SemanticReviewIncompleteReason.None
  ) {
    throw new Error(
      `ARM semantic review completion 'complete' is inconsistent with ` +
        `incomplete reason '${result.incomplete_reason}'`,
    );
  }

  return {
    blockingCount: Number(result.blocking_count),
    reviewScope: result.scope,
    completion: result.completeness,
    incompleteReason: result.incomplete_reason,
  };
}

/**
 * Maps a validated result to the commit status to publish. The first matching rule wins:
 * incomplete, then scoped, then Blocking findings, then Passed. `success` is only reachable for
 * a full, complete review with no Blocking findings.
 *
 * @param result A result returned by `parseSemanticReviewResult`.
 * @returns The state and description to publish.
 */
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

/*
 * Automated-review size limits. They mirror the cap in the reviewer prompt (`arm-api-review.md`,
 * Trigger Validation); keep both in step. A PR above either limit is only partly reviewed, so a
 * human must review it. The model's own `scope` is untrusted, so these are checked independently.
 */
const MAX_SPECIFICATION_FILES = 50;
const MAX_SPECIFICATION_LINES = 5_000;

// GitHub's file-listing API returns at most this many files for a PR and does not say when it cut
// the list off, so a PR this large cannot be proven fully covered.
const MAX_LISTED_FILES = 3_000;

/** The aggregate counters on a pull request object (`pulls.get`). */
export type PullRequestCounts = {
  changed_files: number;
  additions: number;
  deletions: number;
};

/** One entry of the pull request file list (`pulls.listFiles`). */
export type ChangedFile = {
  filename: string;
  /** Set only for a renamed or moved file: the path it had before the PR. */
  previous_filename?: string;
  additions: number;
  deletions: number;
};

/** Running totals of the `specification/` changes seen so far. */
export type SpecificationTotals = { files: number; lines: number };

/** The status reason for a PR whose `specification/` changes exceed the limits. */
export const SPECIFICATION_OVER_LIMITS_REASON = `specification/ changes exceed ${MAX_SPECIFICATION_FILES} files or ${MAX_SPECIFICATION_LINES} lines`;

/** What the PR's aggregate counters alone say about its size. */
export type SizeCheck =
  | { outcome: "within" }
  | { outcome: "manual-review"; reason: string }
  | { outcome: "list-files" };

/**
 * First, cheapest step of the size check: decide from the PR's aggregate counters alone.
 *
 * - Zero changed files means GitHub could not compute the diff, and 3,000 or more means its file
 *   list is cut off. Neither can prove coverage, so a human must review.
 * - If the whole PR is within the limits, so is its `specification/` subset: nothing more to check.
 * - Otherwise the PR may still be fine (for example many docs files and few specification
 *   files), so the caller must list the files and count only `specification/` changes.
 *
 * The reasons are fixed strings because they are published in the status; never add model output.
 */
export function checkPullRequestSize(pullRequest: PullRequestCounts): SizeCheck {
  const { changed_files, additions, deletions } = pullRequest;
  if (changed_files < 1) {
    return { outcome: "manual-review", reason: "GitHub could not compute the PR's size" };
  }
  if (changed_files >= MAX_LISTED_FILES) {
    return {
      outcome: "manual-review",
      reason: `PR has ${MAX_LISTED_FILES} or more changed files`,
    };
  }
  if (
    changed_files <= MAX_SPECIFICATION_FILES &&
    additions + deletions <= MAX_SPECIFICATION_LINES
  ) {
    return { outcome: "within" };
  }
  return { outcome: "list-files" };
}

/**
 * Second step of the size check, run once per page of the file list: add that page's
 * `specification/` changes to the running `totals`. A renamed or moved file counts when its old or
 * its new path is under `specification/`, so a file moved out of it is not missed.
 *
 * Totals only grow, so once they are over the limits the answer is final and a caller can stop
 * reading pages.
 *
 * @returns `true` when the totals now exceed the limits.
 */
export function addSpecificationChanges(
  totals: SpecificationTotals,
  files: ChangedFile[],
): boolean {
  for (const file of files) {
    if (
      file.filename.startsWith("specification/") ||
      file.previous_filename?.startsWith("specification/")
    ) {
      totals.files++;
      totals.lines += file.additions + file.deletions;
    }
  }
  return totals.files > MAX_SPECIFICATION_FILES || totals.lines > MAX_SPECIFICATION_LINES;
}
/**
 * Interprets a commit status as a semantic review outcome. An `error` status is a manual-review
 * hold only when its description starts with `MANUAL_REVIEW_DESCRIPTION_PREFIX`; any other
 * `error` is an incomplete review.
 *
 * @param status The latest `ARM Semantic Review` status, if any.
 * @returns The outcome, or `undefined` when there is no status or its state is unrecognized.
 */
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

/**
 * Selects the newest `ARM Semantic Review` status. A SHA can hold many statuses for the same
 * context (pending, then a result, then a re-run), and only the newest applies.
 *
 * @param statuses All commit statuses for a SHA.
 * @returns The newest matching status, or `undefined` when there is none.
 */
export function getLatestSemanticReviewStatus(statuses: CommitStatus[]): CommitStatus | undefined {
  return statuses
    .filter((status) => status.context.toLowerCase() === ARM_SEMANTIC_REVIEW_STATUS.toLowerCase())
    .sort(invert(byDate((status) => status.updated_at)))[0];
}
