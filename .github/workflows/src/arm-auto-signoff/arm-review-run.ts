import { PER_PAGE_MAX } from "../../../shared/src/github.ts";
import { getWorkflowRunArtifactInputs } from "../context.ts";
import type { Core, GitHub } from "../github.ts";

export const ARM_REVIEW_WORKFLOW = "arm-api-review.lock.yml";

export function parseArmReviewRunUrl(
  url: string | null | undefined,
  owner: string,
  repo: string,
): { runId: number; runAttempt: number } | undefined {
  const prefix = `https://github.com/${owner}/${repo}/actions/runs/`;
  if (!url?.startsWith(prefix)) return undefined;
  const match = /^([1-9]\d*)\/attempts\/([1-9]\d*)$/.exec(url.slice(prefix.length));
  if (!match) return undefined;
  const runId = Number(match[1]);
  const runAttempt = Number(match[2]);
  return Number.isSafeInteger(runId) && Number.isSafeInteger(runAttempt)
    ? { runId, runAttempt }
    : undefined;
}

/**
 * Dispatch/comment runs use the default-branch SHA, not the PR SHA. Use the existing PR run
 * title to reject newer queued runs even before their correlation artifact is available.
 */
export async function isLatestArmReviewRun({
  github,
  core,
  owner,
  repo,
  issueNumber,
  runId,
  runAttempt,
  headSha,
  completed = true,
}: {
  github: GitHub;
  core: Core;
  owner: string;
  repo: string;
  issueNumber: number;
  runId: number;
  runAttempt: number;
  headSha: string;
  completed?: boolean;
}): Promise<boolean> {
  const { data: run } = await github.rest.actions.getWorkflowRun({
    owner,
    repo,
    run_id: runId,
  });
  if (
    run.path !== `.github/workflows/${ARM_REVIEW_WORKFLOW}` ||
    !["workflow_dispatch", "issue_comment", "pull_request_target"].includes(run.event) ||
    run.run_attempt !== runAttempt ||
    (completed && (run.status !== "completed" || run.conclusion !== "success"))
  ) {
    core.info("ARM semantic result is not from a successful current reviewer attempt");
    return false;
  }

  for (let page = 1; ; page++) {
    const { data } = await github.rest.actions.listWorkflowRuns({
      owner,
      repo,
      workflow_id: ARM_REVIEW_WORKFLOW,
      per_page: PER_PAGE_MAX,
      page,
    });
    let reachedRun = false;
    for (const candidate of data.workflow_runs) {
      if (
        candidate.run_number > run.run_number &&
        candidate.conclusion !== "skipped" &&
        candidate.display_title.startsWith(`ARM API Review #${issueNumber} (`)
      ) {
        core.info("A newer ARM reviewer run for this PR supersedes this result");
        return false;
      }
      if (candidate.run_number <= run.run_number) {
        reachedRun = true;
        break;
      }
    }
    if (reachedRun || data.workflow_runs.length < PER_PAGE_MAX) break;
  }
  if (!completed) return true;

  const correlation = await getWorkflowRunArtifactInputs({
    github,
    core,
    owner,
    repo,
    runId,
  });
  return correlation.headSha === headSha && correlation.issueNumber === issueNumber;
}
