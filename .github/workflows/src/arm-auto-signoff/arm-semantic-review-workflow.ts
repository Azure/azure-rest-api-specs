import { readFile } from "node:fs/promises";
import { CommitStatusState, PER_PAGE_MAX } from "../../../shared/src/github.ts";
import { getWorkflowRunArtifactInputs } from "../context.ts";
import type { GitHubScriptArgs } from "../github.ts";
import {
  ARM_SEMANTIC_REVIEW_STATUS,
  evaluateSemanticReview,
  exceedsSpecificationLimits,
  getLatestSemanticReviewStatus,
  isWithinAutomatedReviewLimits,
  MANUAL_REVIEW_DESCRIPTION_PREFIX,
  parseSemanticReviewResult,
  REVIEW_INCOMPLETE_DESCRIPTION_PREFIX,
  type CommitStatus,
  type PullRequestCounts,
  type EvaluatedSemanticReview,
} from "./arm-semantic-review.ts";

/*
 * I/O for the `ARM Semantic Review` commit status. These functions run in trusted reviewer jobs
 * (`record_arm_semantic_review` and the `conclusion` job) and treat the model's output as
 * untrusted data. The PR number, head SHA, and run attempt always come from the run's own
 * artifacts and environment, never from the model.
 *
 * GitHub caps commit status descriptions at 140 characters. Every description published here is a
 * short fixed string, so none can exceed it.
 */

/** Returned when the run has no trusted PR/SHA correlation and no status was published. */
const EMPTY_RESULT = {
  headSha: "",
  issueNumber: 0,
  statusPublished: false,
};

/**
 * Builds the `target_url` of this run and attempt. It is published on every status this run
 * writes and is how a later reader tells whether a status belongs to this exact run, which is what
 * lets the finalizer avoid overwriting a newer run.
 *
 * Reads the attempt from `GITHUB_RUN_ATTEMPT`, which GitHub Actions always sets.
 */
function getRunStatusUrl(
  { serverUrl, runId }: GitHubScriptArgs["context"],
  owner: string,
  repo: string,
) {
  return `${serverUrl}/${owner}/${repo}/actions/runs/${runId}/attempts/${process.env.GITHUB_RUN_ATTEMPT}`;
}

/**
 * Independently checks the PR against the automated-review limits, since the model's `scope` is
 * untrusted. The file list is fetched only when the PR's aggregate counters are over the limits.
 *
 * @param issueNumber The PR number, from trusted artifacts.
 * @param pullRequest The aggregate counters from `pulls.get`.
 * @returns `true` when a human must review because the `specification/` changes exceed the limits.
 */
async function requiresManualReview(
  github: GitHubScriptArgs["github"],
  owner: string,
  repo: string,
  issueNumber: number,
  pullRequest: PullRequestCounts,
): Promise<boolean> {
  if (isWithinAutomatedReviewLimits(pullRequest)) {
    return false;
  }
  if (pullRequest.changed_files < 1) {
    return true;
  }
  const changedFiles = await github.paginate(github.rest.pulls.listFiles, {
    owner,
    repo,
    pull_number: issueNumber,
    per_page: PER_PAGE_MAX,
  });
  return exceedsSpecificationLimits(pullRequest.changed_files, changedFiles);
}

/**
 * Writes one `ARM Semantic Review` commit status on the reviewed SHA.
 *
 * @param targetUrl The `target_url` identifying this run and attempt.
 * @param status The state and description to publish.
 */
async function publishStatus(
  { github, core }: Pick<GitHubScriptArgs, "github" | "core">,
  owner: string,
  repo: string,
  headSha: string,
  targetUrl: string,
  status: EvaluatedSemanticReview,
): Promise<void> {
  core.info(`${ARM_SEMANTIC_REVIEW_STATUS}: ${status.state} - ${status.description}`);
  await github.rest.repos.createCommitStatus({
    owner,
    repo,
    sha: headSha,
    state: status.state,
    context: ARM_SEMANTIC_REVIEW_STATUS,
    description: status.description,
    target_url: targetUrl,
  });
}

/**
 * Validates one trusted ARM reviewer safe output and publishes its head-bound status.
 * This runs inside the reviewer workflow, before workflow_run consumers are triggered.
 *
 * Steps: read the trusted `head-sha` and `issue-number` artifacts; parse and validate the model's
 * result; independently check the PR's size; map the evidence to a status; publish it. Any failure
 * while validating or reading the PR is published as `Review incomplete` with a fixed description,
 * and the details go to the run log.
 *
 * The status is bound to the reviewed SHA, so a result for a commit that is no longer the PR head
 * is harmless: Universal Auto-Signoff reads only the current head's statuses.
 *
 * Requires `GH_AW_AGENT_OUTPUT` (the path to `agent_output.json`) in the environment.
 *
 * @returns The correlation used and whether a status was published. Nothing is published when the
 *   run has no trusted PR/SHA correlation.
 * @throws If the trusted artifacts conflict with each other.
 */
export default async function publishArmSemanticReviewStatus({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<{
  headSha: string;
  issueNumber: number;
  statusPublished: boolean;
}> {
  const { owner, repo } = context.repo;
  const { headSha, issueNumber } = await getWorkflowRunArtifactInputs({
    github,
    core,
    owner,
    repo,
    runId: context.runId,
  });
  if (!headSha || !(issueNumber > 0)) {
    core.info("The reviewer run has no trusted PR/SHA correlation; status is unchanged");
    return EMPTY_RESULT;
  }

  let status: EvaluatedSemanticReview;
  try {
    const agentOutput = JSON.parse(
      await readFile(process.env.GH_AW_AGENT_OUTPUT ?? "", "utf8"),
    ) as unknown;
    const result = parseSemanticReviewResult(agentOutput);

    const { data: pullRequest } = await github.rest.pulls.get({
      owner,
      repo,
      pull_number: issueNumber,
    });
    status = (await requiresManualReview(github, owner, repo, issueNumber, pullRequest))
      ? {
          state: CommitStatusState.ERROR,
          description: `${MANUAL_REVIEW_DESCRIPTION_PREFIX}PR exceeds automated review size limits`,
        }
      : evaluateSemanticReview(result);
  } catch (error) {
    // Any failure here, including a transient GitHub API error, is reported as incomplete rather
    // than as a manual-review hold, so a re-run can still produce a passing result. The details go
    // to the run log: raw error text can include runner paths and must not reach a public status.
    core.warning(error instanceof Error ? error.message : String(error));
    status = {
      state: CommitStatusState.ERROR,
      description: `${REVIEW_INCOMPLETE_DESCRIPTION_PREFIX}result could not be validated`,
    };
  }

  await publishStatus(
    { github, core },
    owner,
    repo,
    headSha,
    getRunStatusUrl(context, owner, repo),
    status,
  );
  return { headSha, issueNumber, statusPublished: true };
}

/**
 * Resolves this run's Pending status when the record job never published a result: the agent
 * failed, took a noop path, was cancelled, or threat detection did not pass. It reads no agent
 * output and only acts when this exact run and attempt still owns the newest status, so a newer
 * run's status is never overwritten. The resulting status is Review incomplete, never a
 * manual-review hold, because these outcomes are not a property of the PR.
 *
 * @returns Whether a status was published.
 * @throws If the trusted artifacts conflict with each other.
 */
export async function finalizeUnpublishedArmSemanticReview({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<{ statusPublished: boolean }> {
  const { owner, repo } = context.repo;
  const { headSha } = await getWorkflowRunArtifactInputs({
    github,
    core,
    owner,
    repo,
    runId: context.runId,
  });
  if (!headSha) {
    core.info("The reviewer run has no trusted head SHA; status is unchanged");
    return { statusPublished: false };
  }

  const targetUrl = getRunStatusUrl(context, owner, repo);
  const statuses: CommitStatus[] = await github.paginate(
    github.rest.repos.listCommitStatusesForRef,
    { owner, repo, ref: headSha, per_page: PER_PAGE_MAX },
  );
  const latestStatus = getLatestSemanticReviewStatus(statuses);
  if (latestStatus?.state !== CommitStatusState.PENDING || latestStatus.target_url !== targetUrl) {
    core.info("This run does not own a Pending ARM Semantic Review status; status is unchanged");
    return { statusPublished: false };
  }

  await publishStatus({ github, core }, owner, repo, headSha, targetUrl, {
    state: CommitStatusState.ERROR,
    description: `${REVIEW_INCOMPLETE_DESCRIPTION_PREFIX}reviewer did not publish a result`,
  });
  return { statusPublished: true };
}
