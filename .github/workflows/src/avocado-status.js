// @ts-check

import { extractInputs } from "./context.js";
import { PER_PAGE_MAX } from "./github.js";

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

  const target_url =
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
      context: "[TEST IGNORE] Swagger Avocado",
      description: "Succeeded due to label 'Approved-Avocado'",
      target_url,
    });
    return;
  }

  // TODO
  // - Get status of check avocado-code
  // - If success, set status to success
  // - If fail, get status of label Approved-Avocado
  // - If label, set status to neutral
  // - If no label, set status to failed

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

  await github.rest.repos.createCommitStatus({
    owner,
    repo,
    sha: head_sha,
    state: "pending",
    context: "[TEST IGNORE] Swagger Avocado",
    description: "Check is running...",
    target_url,
  });
}
