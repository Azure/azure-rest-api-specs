import { isFullGitSha } from "../../../shared/src/git.ts";
import { getWorkflowRunArtifactInputs } from "../context.ts";
import type { GitHubScriptArgs } from "../github.ts";
import { summarizeChecksImpl } from "../summarize-checks/summarize-checks.ts";

/** Publish labels, next steps, and the merge gate in the trusted reviewer's conclusion. */
export async function reconcileReviewedPr({ github, context, core }: GitHubScriptArgs) {
  const { owner, repo } = context.repo;
  const { headSha, issueNumber } = await getWorkflowRunArtifactInputs({
    github,
    core,
    owner,
    repo,
    runId: context.runId,
  });
  if (!headSha && !issueNumber) {
    core.info("No trusted reviewer correlation; PR reconciliation skipped");
    return;
  }
  if (!isFullGitSha(headSha) || !Number.isSafeInteger(issueNumber) || issueNumber <= 0) {
    throw new Error("PR reconciliation requires trusted PR/head correlation");
  }
  await summarizeChecksImpl(
    github,
    core,
    owner,
    repo,
    issueNumber,
    headSha,
    context.eventName,
    undefined,
    `${context.serverUrl}/${owner}/${repo}/actions/runs/${context.runId}`,
  );
}
