import { readFile } from "node:fs/promises";
import { isFullGitSha } from "../../../shared/src/git.ts";
import { CommitStatusState, PER_PAGE_MAX } from "../../../shared/src/github.ts";
import { ARM_API_REVIEW_WORKFLOW_PATH, parseWorkflowRunArtifactInputs } from "../context.ts";
import type { GitHubScriptArgs, WebhookEvent } from "../github.ts";
import {
  ARM_SEMANTIC_REVIEW_STATUS,
  evaluateAutomatedReviewCoverage,
  evaluateSemanticReview,
  getLatestSemanticReviewStatus,
  parseSemanticReviewResult,
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
 * Converts the exact completed ARM API Reviewer run into one head-bound commit status.
 * Missing or malformed evidence publishes `error`; stale SHAs are harmless because
 * Universal Auto-Signoff reads statuses only for the PR's current SHA.
 */
export async function finalizeArmSemanticReview({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<{
  headSha: string;
  issueNumber: number;
  statusPublished: boolean;
}> {
  const workflowRun = (context.payload as WebhookEvent<"workflow-run", "completed">).workflow_run;
  if (workflowRun.path !== ARM_API_REVIEW_WORKFLOW_PATH) {
    throw new Error(
      `Unexpected triggering workflow path: expected '${ARM_API_REVIEW_WORKFLOW_PATH}', ` +
        `received '${workflowRun.path}'`,
    );
  }

  const owner = workflowRun.repository.owner?.login;
  if (!owner) {
    throw new Error("ARM API review workflow run is missing its repository owner");
  }
  const repo = workflowRun.repository.name;
  const artifactNames = (
    await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
      owner,
      repo,
      run_id: workflowRun.id,
      per_page: PER_PAGE_MAX,
    })
  ).map((artifact) => artifact.name);
  const { headSha, issueNumber } = parseWorkflowRunArtifactInputs(artifactNames, core);
  if (!isFullGitSha(headSha) || !Number.isSafeInteger(issueNumber) || issueNumber <= 0) {
    core.info("The reviewer run has no trusted PR/SHA correlation; status is unchanged");
    return EMPTY_RESULT;
  }

  if (workflowRun.conclusion === "cancelled") {
    core.info("Canceled reviewer run leaves its Pending status unchanged");
    return { headSha, issueNumber, statusPublished: false };
  }

  const statuses: CommitStatus[] = await github.paginate(
    github.rest.repos.listCommitStatusesForRef,
    {
      owner,
      repo,
      ref: headSha,
      per_page: PER_PAGE_MAX,
    },
  );
  if (
    isSuperseded(getLatestSemanticReviewStatus(statuses), workflowRun.id, workflowRun.run_attempt)
  ) {
    core.info("A newer ARM API review run superseded this completion");
    return { headSha, issueNumber, statusPublished: false };
  }

  let status: EvaluatedSemanticReview;
  try {
    if (workflowRun.conclusion !== "success") {
      throw new Error(`workflow concluded with ${workflowRun.conclusion ?? "an unknown result"}`);
    }
    const outputPath = process.env.GH_AW_AGENT_OUTPUT;
    if (!outputPath) {
      throw new Error("agent output is unavailable");
    }
    const agentOutput = JSON.parse(await readFile(outputPath, "utf8")) as unknown;
    const result = parseSemanticReviewResult(agentOutput, issueNumber, workflowRun.run_attempt);
    if (result.headSha.toLowerCase() !== headSha.toLowerCase()) {
      throw new Error("semantic result SHA does not match reviewer correlation");
    }

    // Independently verify that the PR is within automated-review coverage limits.
    // The trusted file list from pulls.listFiles takes precedence over the model-reported
    // scope/completeness so that an oversized or truncated PR cannot be auto-signed-off.
    const { data: pullRequest } = await github.rest.pulls.get({
      owner,
      repo,
      pull_number: issueNumber,
    });
    if (pullRequest.state !== "open" || pullRequest.head.sha !== headSha) {
      core.info("Ignoring ARM API review completion for a closed PR or stale head SHA");
      return { headSha, issueNumber, statusPublished: false };
    }
    const changedFiles = (await github.paginate(github.rest.pulls.listFiles, {
      owner,
      repo,
      pull_number: issueNumber,
      per_page: PER_PAGE_MAX,
    })) as ChangedFile[];
    const coverage = evaluateAutomatedReviewCoverage(pullRequest.changed_files, changedFiles);
    if (coverage.manualReviewRequired) {
      status = {
        state: CommitStatusState.ERROR,
        description: `Review incomplete: ${coverage.reason ?? "automated review coverage was limited"}`,
      };
    } else {
      status = evaluateSemanticReview(result);
    }
  } catch (error) {
    const fullReason = error instanceof Error ? error.message : "invalid semantic result";
    core.warning(fullReason);
    const prefix = "Review incomplete: ";
    const available = MAX_STATUS_DESCRIPTION - prefix.length;
    const truncatedReason =
      fullReason.length > available ? `${fullReason.slice(0, available - 1)}\u2026` : fullReason;
    status = {
      state: CommitStatusState.ERROR,
      description: `${prefix}${truncatedReason}`,
    };
  }

  await publishStatus(
    { github, core },
    owner,
    repo,
    headSha,
    `${workflowRun.html_url}/attempts/${workflowRun.run_attempt}`,
    status,
  );
  return { headSha, issueNumber, statusPublished: true };
}
