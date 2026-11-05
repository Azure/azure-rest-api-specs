import { isFullGitSha } from "../../../shared/src/git.ts";
import { getWorkflowRunArtifactInputs } from "../context.ts";
import type { Context, GitHub, GitHubScriptArgs } from "../github.ts";

/** Dispatches a workflow on the default branch so only trusted base-branch code runs. */
async function dispatchOnDefaultBranch(
  github: GitHub,
  context: Context,
  workflowId: string,
  inputs: Record<string, string>,
) {
  const defaultBranch: unknown = context.payload.repository?.default_branch;
  if (typeof defaultBranch !== "string" || !defaultBranch) {
    throw new Error(`Dispatching ${workflowId} requires the repository default branch`);
  }
  await github.rest.actions.createWorkflowDispatch({
    ...context.repo,
    workflow_id: workflowId,
    ref: defaultBranch,
    inputs,
  });
}

/** Reconcile every terminal reviewer outcome without depending on workflow_run delivery. */
export async function dispatchUniversalSignoff({ github, context, core }: GitHubScriptArgs) {
  const { owner, repo } = context.repo;
  const { headSha, issueNumber } = await getWorkflowRunArtifactInputs({
    github,
    core,
    owner,
    repo,
    runId: context.runId,
  });
  if (!headSha || !Number.isSafeInteger(issueNumber) || issueNumber <= 0) {
    core.info("No trusted reviewer correlation; Universal dispatch skipped");
    return;
  }
  await dispatchOnDefaultBranch(github, context, "arm-universal-auto-signoff.yaml", {
    pr_number: String(issueNumber),
    head_sha: headSha,
  });
  core.info(`Dispatched Universal signoff for PR #${issueNumber} at ${headSha}`);
}

/** Hands this Universal run's label artifacts to Update Labels. */
export async function dispatchUpdateLabels({ github, context, core }: GitHubScriptArgs) {
  await dispatchOnDefaultBranch(github, context, "update-labels.yaml", {
    source_run_id: String(context.runId),
  });
  core.info(`Dispatched Update Labels for source run ${context.runId}`);
}

/** Refreshes Summarize Checks after Update Labels applied labels from a dispatched run. */
export async function dispatchSummarizeChecks(
  { github, context, core }: GitHubScriptArgs,
  { prNumber, headSha }: { prNumber: string; headSha: string },
) {
  await dispatchOnDefaultBranch(github, context, "summarize-checks.yaml", {
    pr_number: prNumber,
    head_sha: headSha,
  });
  core.info(`Dispatched Summarize Checks for PR #${prNumber} at ${headSha}`);
}

export function parseSignoffDispatchInputs(inputs: Record<string, unknown> | null | undefined) {
  const issueNumber = Number(inputs?.pr_number);
  const headSha = inputs?.head_sha;
  if (
    !Number.isSafeInteger(issueNumber) ||
    issueNumber <= 0 ||
    typeof inputs?.pr_number !== "string" ||
    !/^[1-9]\d*$/.test(inputs.pr_number) ||
    typeof headSha !== "string" ||
    !isFullGitSha(headSha)
  ) {
    throw new Error("Signoff dispatch requires a positive PR number and full head SHA");
  }
  return { issue_number: issueNumber, head_sha: headSha };
}
