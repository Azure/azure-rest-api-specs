// @ts-check

import { extractInputs } from "./context.js";

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<void>}
 */
export default async function getStatus({ github, context, core }) {
  core.info("avocado-status.js:getStatus()");

  const { owner, repo, head_sha } = await extractInputs(github, context, core);

  // TODO
  // - Get status of check avocado-code
  // - If success, set status to success
  // - If fail, get status of label Approved-Avocado
  // - If label, set status to neutral
  // - If no label, set status to failed

  const target_url =
    `https://github.com/${context.repo.owner}/${context.repo.repo}` +
    `/actions/runs/${context.runId}`;

  github.rest.repos.createCommitStatus({
    owner,
    repo,
    sha: head_sha,
    state: "pending",
    context: "[TEST IGNORE] Swagger Avocado",
    description: "Check is running...",
    target_url,
  });
}
