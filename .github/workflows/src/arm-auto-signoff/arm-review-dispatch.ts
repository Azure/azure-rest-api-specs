import { isFullGitSha } from "../../../shared/src/git.ts";
import { getLatestCommitStatuses } from "../commit-statuses.ts";
import type { GitHubScriptArgs } from "../github.ts";
import { armReviewAllowed } from "./arm-review-policy.ts";
import { ARM_REVIEW_WORKFLOW } from "./arm-review-run.ts";
import {
  ARM_SEMANTIC_REVIEW_STATUS,
  getLatestSemanticReviewStatus,
  getSemanticReviewOutcome,
  SemanticReviewOutcome,
} from "./arm-semantic-review.ts";

const DISPATCH_FAILED = "Review incomplete: reviewer dispatch failed";

/** Called in a PR-scoped, non-cancelling job after Summarize Checks has reconciled labels. */
export default async function dispatchArmReview({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<void> {
  const issueNumber = Number(process.env.ARM_REVIEW_PR_NUMBER);
  const headSha = process.env.ARM_REVIEW_HEAD_SHA ?? "";
  if (!Number.isSafeInteger(issueNumber) || issueNumber <= 0 || !isFullGitSha(headSha)) {
    throw new Error("ARM review dispatch requires a PR number and full head SHA");
  }
  const { owner, repo } = context.repo;
  const { data: pull } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: issueNumber,
  });
  const labels = pull.labels.map((label) => label.name);
  if (
    pull.state !== "open" ||
    pull.draft ||
    pull.head.sha !== headSha ||
    !labels.includes("WaitForARMFeedback") ||
    labels.includes("ARMSignedOff") ||
    !armReviewAllowed(labels)
  ) {
    core.info("ARM reviewer dispatch skipped: PR head/readiness or policy has changed");
    return;
  }

  const latest = getLatestSemanticReviewStatus(
    await getLatestCommitStatuses(github, owner, repo, headSha),
  );
  // Do not loop on failed/incomplete reviews. Maintainers can explicitly rerun /arm-review.
  if (latest && latest.description !== DISPATCH_FAILED) {
    if (getSemanticReviewOutcome(latest) === SemanticReviewOutcome.Passed) {
      await github.rest.actions.createWorkflowDispatch({
        owner,
        repo,
        workflow_id: "arm-universal-auto-signoff.yaml",
        ref: pull.base.repo.default_branch,
        inputs: { pr_number: String(issueNumber), head_sha: headSha },
      });
    }
    core.info("ARM review has already been queued or evaluated for this head");
    return;
  }

  const status = {
    owner,
    repo,
    sha: headSha,
    context: ARM_SEMANTIC_REVIEW_STATUS,
    target_url: `${context.serverUrl}/${owner}/${repo}/actions/runs/${context.runId}`,
  };
  await github.rest.repos.createCommitStatus({
    ...status,
    state: "pending",
    description: "ARM API semantic review is queued",
  });
  try {
    await github.rest.actions.createWorkflowDispatch({
      owner,
      repo,
      workflow_id: ARM_REVIEW_WORKFLOW,
      ref: pull.base.repo.default_branch,
      inputs: { pr_number: String(issueNumber), head_sha: headSha },
    });
  } catch (error) {
    await github.rest.repos.createCommitStatus({
      ...status,
      state: "error",
      description: DISPATCH_FAILED,
    });
    throw error;
  }
  core.info(`Dispatched ARM reviewer for PR #${issueNumber} at ${headSha}`);
}
