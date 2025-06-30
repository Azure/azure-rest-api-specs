// @ts-check

import { extractInputs } from "./context.js";
import { setStatusImpl } from "./set-status.js";

// TODO: Add tests
/* v8 ignore start */
/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<void>}
 */
export default async function summary({ github, context, core }) {
  const { owner, repo, head_sha, issue_number } = await extractInputs(github, context, core);

  // Default target is this run itself
  let target_url =
    `https://github.com/${context.repo.owner}/${context.repo.repo}` +
    `/actions/runs/${context.runId}`;

  const data = [
    [
      "[TEST-IGNORE] Swagger Avocado - Analyze Code",
      "[TEST-IGNORE] Swagger Avocado",
      "Approved-Avocado",
    ],
    [
      "[TEST-IGNORE] Swagger ModelValidation",
      "[TEST-IGNORE] Swagger ModelValidation",
      "Approved-ModelValidation",
    ],
    [
      "[TEST-IGNORE] Swagger SemanticValidation",
      "[TEST-IGNORE] Swagger SemanticValidation",
      "Approved-SemanticValidation",
    ],
  ];

  for (const row of data) {
    await setStatusImpl({
      owner,
      repo,
      head_sha,
      issue_number,
      target_url,
      github,
      core,
      monitoredWorkflowName: row[0],
      requiredStatusName: row[1],
      overridingLabel: row[2],
    });
  }
}
/* v8 ignore stop */
