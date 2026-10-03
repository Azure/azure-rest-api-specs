import { readFile } from "node:fs/promises";
import { isFullGitSha } from "../../../shared/src/git.ts";
import { CommitStatusState, PER_PAGE_MAX } from "../../../shared/src/github.ts";
import { ARM_API_REVIEW_WORKFLOW_NAME, extractInputs } from "../context.ts";
import type { Core, GitHub, GitHubScriptArgs, WebhookEvent } from "../github.ts";
import {
  ARM_SEMANTIC_REVIEW_STATUS,
  encodeSemanticReviewReceipt,
  evaluateAutomatedReviewCoverage,
  evaluateSemanticReview,
  getLatestSemanticReviewStatus,
  getSemanticReviewOutcome,
  manualReviewRequiredStatus,
  parseSemanticReviewReceipt,
  parseSemanticReviewResult,
  reviewIncompleteStatus,
  SemanticReviewOutcome,
  type CommitStatus,
  type EvaluatedSemanticReview,
  type SemanticReviewResult,
} from "./arm-semantic-review.ts";

type ChangedFile = {
  filename: string;
  additions: number;
  deletions: number;
};

async function createSemanticReviewStatus({
  owner,
  repo,
  headSha,
  targetUrl,
  status,
  github,
  core,
}: {
  owner: string;
  repo: string;
  headSha: string;
  targetUrl: string;
  status: Pick<EvaluatedSemanticReview, "state" | "description">;
  github: GitHub;
  core: Core;
}): Promise<void> {
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

export async function validateSemanticReviewResult({
  owner,
  repo,
  result,
  github,
}: {
  owner: string;
  repo: string;
  result: SemanticReviewResult;
  github: GitHub;
}): Promise<void> {
  const { data: pullRequest } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: result.issueNumber,
  });
  if (pullRequest.state !== "open" || pullRequest.head.sha !== result.headSha) {
    throw new Error("The reviewed pull request head is no longer current");
  }
}

function parseWorkflowRunIdentity(
  targetUrl: string | null,
): { runId: number; runAttempt: number } | undefined {
  const match = /\/actions\/runs\/([1-9]\d*)\/attempts\/([1-9]\d*)(?:\/|$)/.exec(targetUrl ?? "");
  if (!match) {
    return undefined;
  }
  const runId = Number(match[1]);
  const runAttempt = Number(match[2]);
  if (!Number.isSafeInteger(runId) || !Number.isSafeInteger(runAttempt)) {
    return undefined;
  }
  return { runId, runAttempt };
}

export async function finalizeSemanticReviewWorkflow({
  owner,
  repo,
  issueNumber,
  headSha,
  runId,
  runAttempt,
  workflowConclusion,
  reviewerExecuted = true,
  targetUrl,
  artifactNames,
  github,
  core,
}: {
  owner: string;
  repo: string;
  issueNumber: number;
  headSha: string;
  runId: number;
  runAttempt: number;
  workflowConclusion: string | null;
  reviewerExecuted?: boolean;
  targetUrl: string;
  artifactNames: string[];
  github: GitHub;
  core: Core;
}): Promise<boolean> {
  if (!reviewerExecuted) {
    core.info("The ARM API Reviewer did not execute; semantic status is unchanged");
    return false;
  }
  if (!Number.isSafeInteger(issueNumber) || issueNumber <= 0 || !isFullGitSha(headSha)) {
    core.info("ARM API review completion is missing a valid PR number or head SHA");
    return false;
  }

  const { data: pullRequest } = await github.rest.pulls.get({
    owner,
    repo,
    pull_number: issueNumber,
  });
  if (pullRequest.state !== "open" || pullRequest.head.sha !== headSha) {
    core.info("Ignoring ARM API review completion for a closed PR or stale head SHA");
    return false;
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
  const latestStatus = getLatestSemanticReviewStatus(statuses);
  if (latestStatus && latestStatus.target_url !== targetUrl) {
    const latestIdentity = parseWorkflowRunIdentity(latestStatus.target_url);
    if (
      latestIdentity &&
      (latestIdentity.runId > runId ||
        (latestIdentity.runId === runId && latestIdentity.runAttempt > runAttempt))
    ) {
      core.info("A newer ARM API review run superseded this completion");
      return false;
    }
  }

  if (workflowConclusion === "cancelled") {
    if (latestStatus && latestStatus.state !== CommitStatusState.PENDING) {
      await createSemanticReviewStatus({
        owner,
        repo,
        headSha,
        targetUrl,
        status: {
          state: CommitStatusState.PENDING,
          description: "Review canceled; rerun required",
        },
        github,
        core,
      });
      return true;
    }
    core.info("Canceled ARM API review did not publish a semantic result");
    return false;
  }

  const changedFiles: ChangedFile[] = await github.paginate(github.rest.pulls.listFiles, {
    owner,
    repo,
    pull_number: issueNumber,
    per_page: PER_PAGE_MAX,
  });
  const coverage = evaluateAutomatedReviewCoverage(pullRequest.changed_files, changedFiles);

  if (workflowConclusion === "success" && latestStatus?.state !== CommitStatusState.PENDING) {
    const existingOutcome = getSemanticReviewOutcome(latestStatus);
    if (
      !coverage.manualReviewRequired ||
      existingOutcome === SemanticReviewOutcome.ManualReviewRequired
    ) {
      core.info("ARM semantic review result is already finalized");
      return false;
    }
  }

  let receipt: SemanticReviewResult | undefined;
  let receiptError: string | undefined;
  try {
    receipt = parseSemanticReviewReceipt(artifactNames, runAttempt);
  } catch (error) {
    receiptError = error instanceof Error ? error.message : "Invalid ARM semantic review receipt";
    core.warning(receiptError);
  }

  if (
    receipt &&
    (receipt.issueNumber !== issueNumber || receipt.headSha.toLowerCase() !== headSha.toLowerCase())
  ) {
    receiptError = "ARM semantic review receipt does not match its workflow run";
    core.warning(receiptError);
    receipt = undefined;
  }

  const evaluatedReceipt = receipt ? evaluateSemanticReview(receipt) : undefined;
  let status: EvaluatedSemanticReview;
  if (coverage.manualReviewRequired) {
    status = manualReviewRequiredStatus(coverage.reason ?? "automated review coverage was limited");
  } else if (workflowConclusion === "success" && evaluatedReceipt) {
    status = evaluatedReceipt;
  } else if (
    workflowConclusion !== "success" &&
    evaluatedReceipt?.outcome === SemanticReviewOutcome.ManualReviewRequired
  ) {
    status = evaluatedReceipt;
  } else {
    const reason = receiptError
      ? "semantic result was invalid"
      : workflowConclusion === "success"
        ? "semantic result was missing"
        : `workflow concluded with ${workflowConclusion ?? "an unknown result"}`;
    status = reviewIncompleteStatus(reason);
  }

  await createSemanticReviewStatus({
    owner,
    repo,
    headSha,
    targetUrl,
    status,
    github,
    core,
  });
  return true;
}

/* v8 ignore start */
export default async function validateArmSemanticReview({
  github,
  context,
}: GitHubScriptArgs): Promise<{
  artifactValue: string;
}> {
  const outputPath = process.env.GH_AW_AGENT_OUTPUT;
  const issueNumberText = process.env.TARGET_PR_NUMBER;
  if (!outputPath) {
    throw new Error("GH_AW_AGENT_OUTPUT is unavailable");
  }
  if (!issueNumberText || !/^[1-9]\d*$/.test(issueNumberText)) {
    throw new Error(`Invalid target PR number: '${issueNumberText ?? ""}'`);
  }

  const runAttemptText = process.env.GITHUB_RUN_ATTEMPT;
  if (!runAttemptText || !/^[1-9]\d*$/.test(runAttemptText)) {
    throw new Error(`Invalid workflow run attempt: '${runAttemptText ?? ""}'`);
  }

  const agentOutput = JSON.parse(await readFile(outputPath, "utf8")) as unknown;
  const result = parseSemanticReviewResult(agentOutput, Number(issueNumberText));
  await validateSemanticReviewResult({
    ...context.repo,
    result,
    github,
  });
  return {
    artifactValue: encodeSemanticReviewReceipt(result, Number(runAttemptText)),
  };
}

export async function finalizeArmSemanticReview({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<void> {
  const payload = context.payload as WebhookEvent<"workflow-run", "completed">;
  const workflowRun = payload.workflow_run;
  if (workflowRun.name !== ARM_API_REVIEW_WORKFLOW_NAME) {
    return;
  }

  const repositoryOwner = workflowRun.repository.owner?.login;
  if (!repositoryOwner) {
    throw new Error("ARM API review workflow run is missing its repository owner");
  }
  const artifacts = await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
    owner: repositoryOwner,
    repo: workflowRun.repository.name,
    run_id: workflowRun.id,
    per_page: PER_PAGE_MAX,
  });
  const artifactNames = artifacts.map((artifact) => artifact.name);
  const reviewerExecuted =
    workflowRun.conclusion !== "success" ||
    (artifactNames.some((name) => name.startsWith("head-sha=")) &&
      artifactNames.some((name) => name.startsWith("issue-number=")));
  if (!reviewerExecuted) {
    core.info("The ARM API Reviewer did not execute; semantic status is unchanged");
    return;
  }

  const { owner, repo, head_sha, issue_number } = await extractInputs(github, context, core);
  await finalizeSemanticReviewWorkflow({
    owner,
    repo,
    issueNumber: issue_number,
    headSha: head_sha,
    runId: workflowRun.id,
    runAttempt: workflowRun.run_attempt,
    workflowConclusion: workflowRun.conclusion,
    reviewerExecuted,
    targetUrl: `${workflowRun.html_url}/attempts/${workflowRun.run_attempt}`,
    artifactNames,
    github,
    core,
  });
}
/* v8 ignore stop */
