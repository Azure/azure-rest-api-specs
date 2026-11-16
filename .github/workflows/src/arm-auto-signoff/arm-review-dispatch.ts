import { isFullGitSha } from "../../../shared/src/git.ts";
import { getLatestCommitStatuses } from "../commit-statuses.ts";
import type { Core, GitHub, GitHubScriptArgs } from "../github.ts";
import {
  ARM_SEMANTIC_REVIEW_STATUS,
  getLatestSemanticReviewStatus,
} from "./arm-semantic-review.ts";

const REVIEW_WORKFLOW = "arm-api-review.lock.yml";
const DISPATCH_FAILED = "Review incomplete: reviewer dispatch failed; retry with /arm-review";
export const ARM_INITIAL_REVIEW_REQUESTED_LABEL = "ARMInitialReviewRequested";

export default async function dispatchInitialArmReview({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<void> {
  await dispatchArmReview(
    github,
    core,
    context.repo.owner,
    context.repo.repo,
    Number(process.env.ARM_REVIEW_PR_NUMBER),
    process.env.ARM_REVIEW_HEAD_SHA ?? "",
    `${context.serverUrl}/${context.repo.owner}/${context.repo.repo}/actions/runs/${context.runId}`,
  );
}

/** Runs in a serialized PR-scoped job. Explicit reviewer triggers bypass this initial-only gate. */
export async function dispatchArmReview(
  github: GitHub,
  core: Core,
  owner: string,
  repo: string,
  issueNumber: number,
  headSha: string,
  sourceUrl: string,
): Promise<void> {
  if (!Number.isSafeInteger(issueNumber) || issueNumber <= 0 || !isFullGitSha(headSha)) {
    throw new Error("ARM review dispatch requires a PR number and full head SHA");
  }

  const getPull = () => github.rest.pulls.get({ owner, repo, pull_number: issueNumber });
  const { data: pull } = await getPull();
  const isQueued = (candidate: typeof pull) => {
    const labels = candidate.labels.map((label) => label.name);
    return (
      candidate.state === "open" &&
      !candidate.draft &&
      candidate.head.sha === headSha &&
      labels.includes("ARMReview") &&
      labels.includes("WaitForARMFeedback") &&
      ![
        "NotReadyForARMReview",
        "ARMChangesRequested",
        "ARMManualSignoffRequired",
        "ARMSignedOff",
        "skip-arm-review",
      ].some((label) => labels.includes(label))
    );
  };
  if (!isQueued(pull)) {
    core.info("ARM review dispatch skipped: the review request is no longer current or ready");
    return;
  }

  if (pull.labels.some((label) => label.name === ARM_INITIAL_REVIEW_REQUESTED_LABEL)) {
    core.info(
      "ARM review already requested for this PR; use a label addition or /arm-review to rerun",
    );
    return;
  }

  const latest = getLatestSemanticReviewStatus(
    await getLatestCommitStatuses(github, owner, repo, headSha),
  );
  if (latest) {
    await github.rest.issues.addLabels({
      owner,
      repo,
      issue_number: issueNumber,
      labels: [ARM_INITIAL_REVIEW_REQUESTED_LABEL],
    });
    core.info("ARM review already reserved or evaluated; recording the PR-level request marker");
    return;
  }
  const { data: currentPull } = await getPull();
  if (
    !isQueued(currentPull) ||
    currentPull.labels.some((label) => label.name === ARM_INITIAL_REVIEW_REQUESTED_LABEL)
  ) {
    core.info("ARM review request changed before dispatch; nothing is queued");
    return;
  }

  // Reserve before dispatch. Never clear on timeout: GitHub may already have accepted the request.
  await github.rest.issues.addLabels({
    owner,
    repo,
    issue_number: issueNumber,
    labels: [ARM_INITIAL_REVIEW_REQUESTED_LABEL],
  });
  const status = {
    owner,
    repo,
    sha: headSha,
    context: ARM_SEMANTIC_REVIEW_STATUS,
    target_url: sourceUrl,
  };
  try {
    await github.rest.repos.createCommitStatus({
      ...status,
      state: "pending",
      description: "ARM API semantic review is queued",
    });
    await github.rest.actions.createWorkflowDispatch({
      owner,
      repo,
      workflow_id: REVIEW_WORKFLOW,
      ref: currentPull.base.repo.default_branch,
      inputs: { pr_number: String(issueNumber), head_sha: headSha, reservation_url: sourceUrl },
    });
  } catch (error) {
    core.error(
      `ARM reviewer handoff failed for PR #${issueNumber}: ` +
        `${error instanceof Error ? error.message : String(error)}. ` +
        `Keep ${ARM_INITIAL_REVIEW_REQUESTED_LABEL} to prevent duplicate automatic requests. ` +
        `Check for a queued or running reviewer before retrying with /arm-review, ` +
        `removing and re-adding WaitForARMFeedback, or manually dispatching ${REVIEW_WORKFLOW} ` +
        `with the PR number and no head_sha.`,
    );
    // A timeout may have accepted the dispatch. Do not overwrite a review that has already started.
    try {
      const current = getLatestSemanticReviewStatus(
        await getLatestCommitStatuses(github, owner, repo, headSha),
      );
      if (current?.state === "pending" && current.target_url === sourceUrl) {
        await github.rest.repos.createCommitStatus({
          ...status,
          state: "error",
          description: DISPATCH_FAILED,
        });
      }
    } catch (cleanupError) {
      throw new AggregateError(
        [error, cleanupError],
        "ARM reviewer dispatch and queued-status cleanup both failed",
        { cause: cleanupError },
      );
    }
    throw error;
  }
  core.info(`Dispatched initial ARM review for PR #${issueNumber} at ${headSha}`);
}
