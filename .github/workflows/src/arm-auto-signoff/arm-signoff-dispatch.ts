import { isFullGitSha } from "../../../shared/src/git.ts";
import { getWorkflowRunArtifactInputs } from "../context.ts";
import type { GitHubScriptArgs } from "../github.ts";

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
  const defaultBranch: unknown = context.payload.repository?.default_branch;
  if (typeof defaultBranch !== "string" || !defaultBranch) {
    throw new Error("Universal dispatch requires the repository default branch");
  }
  await github.rest.actions.createWorkflowDispatch({
    owner,
    repo,
    workflow_id: "arm-universal-auto-signoff.yaml",
    ref: defaultBranch,
    inputs: { pr_number: String(issueNumber), head_sha: headSha },
  });
  core.info(`Dispatched Universal signoff for PR #${issueNumber} at ${headSha}`);
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
