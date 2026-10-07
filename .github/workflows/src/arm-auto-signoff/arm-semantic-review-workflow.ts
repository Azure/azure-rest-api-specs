import { readFile } from "node:fs/promises";
import { isFullGitSha } from "../../../shared/src/git.ts";
import { CommitStatusState, PER_PAGE_MAX } from "../../../shared/src/github.ts";
import { getWorkflowRunArtifactInputs } from "../context.ts";
import type { GitHubScriptArgs } from "../github.ts";
import {
  ARM_SEMANTIC_REVIEW_STATUS,
  evaluateAutomatedReviewCoverage,
  evaluateSemanticReview,
  getLatestSemanticReviewStatus,
  MANUAL_REVIEW_DESCRIPTION_PREFIX,
  parseSemanticReviewResult,
  REVIEW_INCOMPLETE_DESCRIPTION_PREFIX,
  type ChangedFile,
  type CommitStatus,
  type EvaluatedSemanticReview,
} from "./arm-semantic-review.ts";

const MAX_STATUS_DESCRIPTION = 140;

const EMPTY_RESULT = {
  headSha: "",
  issueNumber: 0,
  statusPublished: false,
};

function getRunStatusUrl(
  { serverUrl, runId }: Pick<GitHubScriptArgs["context"], "serverUrl" | "runId">,
  owner: string,
  repo: string,
  runAttempt: number | string,
): string {
  return `${serverUrl}/${owner}/${repo}/actions/runs/${runId}/attempts/${runAttempt}`;
}

async function getLatestSemanticStatus(
  github: GitHubScriptArgs["github"],
  owner: string,
  repo: string,
  headSha: string,
): Promise<CommitStatus | undefined> {
  const statuses: CommitStatus[] = await github.paginate(
    github.rest.repos.listCommitStatusesForRef,
    {
      owner,
      repo,
      ref: headSha,
      per_page: PER_PAGE_MAX,
    },
  );
  return getLatestSemanticReviewStatus(statuses);
}

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

function isSuperseded(
  latestStatus: CommitStatus | undefined,
  runId: number,
  runAttempt: number,
): boolean {
  const match = /\/actions\/runs\/([1-9]\d*)\/attempts\/([1-9]\d*)(?:\/|$)/.exec(
    latestStatus?.target_url ?? "",
  );
  if (!match) {
    return false;
  }
  const latestRunId = Number(match[1]);
  const latestAttempt = Number(match[2]);
  return latestRunId > runId || (latestRunId === runId && latestAttempt > runAttempt);
}

/**
 * Validates one trusted ARM reviewer safe output and publishes its head-bound status.
 * This runs inside the reviewer workflow, before workflow_run consumers are triggered.
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
  const outputPath = process.env.GH_AW_AGENT_OUTPUT;
  if (!outputPath) {
    throw new Error("GH_AW_AGENT_OUTPUT is unavailable");
  }

  const runAttemptText = process.env.GITHUB_RUN_ATTEMPT;
  if (!runAttemptText || !/^[1-9]\d*$/.test(runAttemptText)) {
    throw new Error(`Invalid workflow run attempt: '${runAttemptText ?? ""}'`);
  }

  const runAttempt = Number(runAttemptText);
  const { owner, repo } = context.repo;
  const { headSha, issueNumber } = await getWorkflowRunArtifactInputs({
    github,
    core,
    owner,
    repo,
    runId: context.runId,
  });
  if (!isFullGitSha(headSha) || !Number.isSafeInteger(issueNumber) || issueNumber <= 0) {
    core.info("The reviewer run has no trusted PR/SHA correlation; status is unchanged");
    return EMPTY_RESULT;
  }

  let status: EvaluatedSemanticReview;
  try {
    const agentOutput = JSON.parse(await readFile(outputPath, "utf8")) as unknown;
    const result = parseSemanticReviewResult(agentOutput, {
      headSha,
      issueNumber,
      runAttempt,
    });

    const { data: pullRequest } = await github.rest.pulls.get({
      owner,
      repo,
      pull_number: issueNumber,
    });
    if (pullRequest.state !== "open" || pullRequest.head.sha !== headSha) {
      core.info("Ignoring ARM API review result for a closed PR or stale head SHA");
      return { headSha, issueNumber, statusPublished: false };
    }

    const changedFiles = (await github.paginate(github.rest.pulls.listFiles, {
      owner,
      repo,
      pull_number: issueNumber,
      per_page: PER_PAGE_MAX,
    })) as ChangedFile[];
    const coverage = evaluateAutomatedReviewCoverage(pullRequest.changed_files, changedFiles);
    status = coverage.manualReviewRequired
      ? {
          state: CommitStatusState.ERROR,
          description: `${MANUAL_REVIEW_DESCRIPTION_PREFIX}${coverage.reason ?? "automated review coverage was limited"}`,
        }
      : evaluateSemanticReview(result);
  } catch (error) {
    // Any failure here, including a transient GitHub API error, is reported as incomplete rather
    // than as a manual-review hold, so a re-run can still produce a passing result.
    const fullReason = error instanceof Error ? error.message : "invalid semantic result";
    core.warning(fullReason);
    const prefix = REVIEW_INCOMPLETE_DESCRIPTION_PREFIX;
    const available = MAX_STATUS_DESCRIPTION - prefix.length;
    const truncatedReason =
      fullReason.length > available ? `${fullReason.slice(0, available - 1)}\u2026` : fullReason;
    status = {
      state: CommitStatusState.ERROR,
      description: `${prefix}${truncatedReason}`,
    };
  }

  // Checked last so the window between this read and the write is as small as possible. An
  // earlier check would leave the slow PR and file-list calls inside the window, where a newer
  // run's Pending could be overwritten by this older result.
  const latestStatus = await getLatestSemanticStatus(github, owner, repo, headSha);
  if (isSuperseded(latestStatus, context.runId, runAttempt)) {
    core.info("A newer ARM API review run superseded this result");
    return { headSha, issueNumber, statusPublished: false };
  }

  await publishStatus(
    { github, core },
    owner,
    repo,
    headSha,
    getRunStatusUrl(context, owner, repo, runAttempt),
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
 */
export async function finalizeUnpublishedArmSemanticReview({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<{ statusPublished: boolean }> {
  const runAttemptText = process.env.GITHUB_RUN_ATTEMPT ?? "";
  const { owner, repo } = context.repo;
  const { headSha } = await getWorkflowRunArtifactInputs({
    github,
    core,
    owner,
    repo,
    runId: context.runId,
  });
  if (!isFullGitSha(headSha) || !/^[1-9]\d*$/.test(runAttemptText)) {
    core.info("The reviewer run has no trusted head SHA or run attempt; status is unchanged");
    return { statusPublished: false };
  }

  const targetUrl = getRunStatusUrl(context, owner, repo, runAttemptText);
  const latestStatus = await getLatestSemanticStatus(github, owner, repo, headSha);
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
