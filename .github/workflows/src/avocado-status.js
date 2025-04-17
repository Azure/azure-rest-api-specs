// @ts-check

import { extractInputs } from "./context.js";
import {
  CheckConclusion,
  CheckStatus,
  CommitStatusState,
  PER_PAGE_MAX,
} from "./github.js";
import { Label } from "./label.js";

// TODO: Add tests
/* v8 ignore start */
/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<void>}
 */
export default async function setStatus({ github, context, core }) {
  const { owner, repo, head_sha, issue_number } = await extractInputs(
    github,
    context,
    core,
  );

  // Default target is this run itself
  let target_url =
    `https://github.com/${context.repo.owner}/${context.repo.repo}` +
    `/actions/runs/${context.runId}`;

  return await setStatusImpl({
    owner,
    repo,
    head_sha,
    issue_number,
    target_url,
    github,
    core,
  });
}
/* v8 ignore stop */

/**
 * @param {Object} params
 * @param {string} params.owner
 * @param {string} params.repo
 * @param {string} params.head_sha
 * @param {number} params.issue_number
 * @param {string} params.target_url
 * @param {(import("@octokit/core").Octokit & import("@octokit/plugin-rest-endpoint-methods/dist-types/types.js").Api & { paginate: import("@octokit/plugin-paginate-rest").PaginateInterface; })} params.github
 * @param {typeof import("@actions/core")} params.core
 * @returns {Promise<void>}
 */
export async function setStatusImpl({
  owner,
  repo,
  head_sha,
  issue_number,
  target_url,
  github,
  core,
}) {
  const statusName = "[TEST IGNORE] Swagger Avocado";

  // TODO: Try to extract labels from context (when available) to avoid unnecessary API call
  const labels = await github.paginate(github.rest.issues.listLabelsOnIssue, {
    owner: owner,
    repo: repo,
    issue_number: issue_number,
    per_page: PER_PAGE_MAX,
  });
  const labelNames = labels.map((label) => label.name);

  core.info(`Labels: ${labelNames}`);

  if (labelNames.includes(Label.APPROVED_AVOCADO)) {
    const description = `Found label '${Label.APPROVED_AVOCADO}'`;
    core.info(description);

    const state = CheckConclusion.SUCCESS;
    core.info(`Setting status to '${state}'`);

    await github.rest.repos.createCommitStatus({
      owner,
      repo,
      sha: head_sha,
      state,
      context: statusName,
      description,
      target_url,
    });

    return;
  }

  const workflowRuns = await github.paginate(
    github.rest.actions.listWorkflowRunsForRepo,
    {
      owner,
      repo,
      event: "pull_request",
      head_sha,
      per_page: PER_PAGE_MAX,
    },
  );

  core.info("Workflow Runs:");
  workflowRuns.forEach((wf) => {
    core.info(`- ${wf.name}: ${wf.conclusion || wf.status}`);
  });

  const wfName = "[TEST-IGNORE] Swagger Avocado - Analyze Code";
  const avocadoCodeRuns = workflowRuns
    .filter((wf) => wf.name == wfName)
    // Sort by "updated_at" descending
    .sort(
      (a, b) =>
        new Date(b.updated_at).getTime() - new Date(a.updated_at).getTime(),
    );

  // Sorted by "updated_at" descending, so most recent run is at index 0.
  // If "avocadoCodeRuns.length === 0", run will be "undefined", which the following
  // code must handle.
  const run = avocadoCodeRuns[0];

  if (run) {
    /**
     * Update target to the "Analyze Code" run, which contains the meaningful output.
     *
     * @example https://github.com/mikeharder/azure-rest-api-specs/actions/runs/14509047569
     */
    target_url = run.html_url;

    if (run.conclusion === CheckConclusion.FAILURE) {
      /**
       * Update target to point directly to the first failed job
       *
       * @example https://github.com/mikeharder/azure-rest-api-specs/actions/runs/14509047569/job/40703679014?pr=18
       */

      const jobs = await github.paginate(
        github.rest.actions.listJobsForWorkflowRun,
        {
          owner,
          repo,
          run_id: run.id,
          per_page: PER_PAGE_MAX,
        },
      );
      const failedJobs = jobs.filter(
        (job) => job.conclusion === CheckConclusion.FAILURE,
      );
      const failedJob = failedJobs[0];
      if (failedJob?.html_url) {
        target_url = `${failedJob.html_url}?pr=${issue_number}`;
      }
    }
  }

  if (run?.status === CheckStatus.COMPLETED) {
    const state =
      run.conclusion === CheckConclusion.SUCCESS
        ? CheckConclusion.SUCCESS
        : CheckConclusion.FAILURE;

    await github.rest.repos.createCommitStatus({
      owner,
      repo,
      sha: head_sha,
      state,
      context: statusName,
      target_url,
    });
  } else {
    // Run was not found (not started), or not completed
    await github.rest.repos.createCommitStatus({
      owner,
      repo,
      sha: head_sha,
      state: CommitStatusState.PENDING,
      context: statusName,
      target_url,
    });
  }
}
