// @ts-check

import { extractInputs } from "./context.js";
import { PER_PAGE_MAX } from "./github.js";

const statusName = "[TEST IGNORE] Swagger Avocado";

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<void>}
 */
export default async function getStatus({ github, context, core }) {
  core.info("avocado-status.js:getStatus()");

  const { owner, repo, head_sha, issue_number } = await extractInputs(
    github,
    context,
    core,
  );

  // Default target is this run itself
  let target_url =
    `https://github.com/${context.repo.owner}/${context.repo.repo}` +
    `/actions/runs/${context.runId}`;

  // TODO: Try to extract labels from context (when available) to avoid unnecessary API call
  const labels = await github.paginate(github.rest.issues.listLabelsOnIssue, {
    owner: owner,
    repo: repo,
    issue_number: issue_number,
    per_page: PER_PAGE_MAX,
  });
  const labelNames = labels.map((label) => label.name);

  if (labelNames.includes("Approved-Avocado")) {
    await github.rest.repos.createCommitStatus({
      owner,
      repo,
      sha: head_sha,
      state: "success",
      context: statusName,
      description: "Found label 'Approved-Avocado'",
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

    if (run.conclusion === "failure") {
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
      const failedJobs = jobs.filter((job) => job.conclusion === "failure");
      const failedJob = failedJobs[0];
      if (failedJob?.html_url) {
        target_url = failedJob.html_url;
      }
    }
  }

  if (run?.status === "completed") {
    const state = run.conclusion === "success" ? "success" : "failure";

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
      state: "pending",
      context: statusName,
      target_url,
    });
  }
}
