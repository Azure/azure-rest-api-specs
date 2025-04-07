import { extractInputs } from "./context.js";
import { PER_PAGE_MAX } from "./github.js";

/**
 * @typedef {import('@octokit/plugin-rest-endpoint-methods').RestEndpointMethodTypes} RestEndpointMethodTypes
 * @typedef {RestEndpointMethodTypes["checks"]["listForRef"]["response"]["data"]["check_runs"][number]} CheckRun
 * @typedef {RestEndpointMethodTypes["actions"]["listWorkflowRunsForRepo"]["response"]["data"]["workflow_runs"][number]} WorkflowRun
 */

/**
 * Given the name of a completed check run name and a completed workflow, verify 
 * that both have the same conclusion. If conclusions are different, fail the 
 * action.
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 */
export async function verifyRunStatus({ github, context, core }) {
  const checkRunName = process.env.CHECK_RUN_NAME;
  if (!checkRunName) {
    throw new Error("CHECK_RUN_NAME is not set");
  }

  const workflowName = process.env.WORKFLOW_NAME;
  if (!workflowName) {
    throw new Error("WORKFLOW_NAME is not set");
  }

  // Exit early when context is a check_run event and the check run does not
  // match the checkRunName.
  if (context.eventName == "check_run") {
    const contextRunName = context.payload.check_run.name;
    if (contextRunName !== checkRunName) {
      core.notice(`Check run name (${contextRunName}) does not match input: ${checkRunName}`);
      return;
    }
  }

  const { head_sha } = await extractInputs(github, context, core);

  const checkRun =
    context.eventName == "check_run"
      ? context.payload.check_run
      : await getCheckRun(github, context, core, checkRunName, head_sha);

  if (!checkRun) {
    core.notice(`No completed check run with name: ${checkRunName}`);
    return;
  }

  core.info(
    `Check run name: ${checkRun.name}, conclusion: ${checkRun.conclusion}, URL: ${checkRun.html_url}`,
  );
  core.debug(`Check run: ${JSON.stringify(checkRun)}`);

  const workflowRun =
    context.eventName == "workflow_run"
      ? context.payload.workflow_run
      : await getWorkflowRun(github, context, core, workflowName, head_sha);

  if (!workflowRun) {
    core.notice(`No completed workflow run with name: ${workflowName}`);
    return;
  }

  core.info(
    `Workflow run name: ${workflowRun.name}, conclusion: ${workflowRun.conclusion}, URL: ${workflowRun.html_url}`,
  );
  core.debug(`Workflow run: ${JSON.stringify(workflowRun)}`);

  if (checkRun.conclusion !== workflowRun.conclusion) {
    core.setFailed(
      `Check run conclusion (${checkRun.conclusion}) does not match workflow run conclusion (${workflowRun.conclusion})`,
    );
    return;
  }

  core.notice(`Conclusions match for check run ${checkRunName} and workflow run ${workflowName}`);
}

/**
 * Returns the check with the given checkRunName for the given ref.
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {import('github-script').AsyncFunctionArguments['context']} context
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} checkRunName
 * @param {string} ref
 * @returns {Promise<CheckRun | null>}
 */
export async function getCheckRun(
  github,
  context,
  core,
  checkRunName,
  ref,
) {
  const checkRuns = await github.paginate(github.rest.checks.listForRef, {
    ...context.repo,
    ref: ref,
    check_name: checkRunName,
    status: "completed",
    per_page: PER_PAGE_MAX,
  });

  if (checkRuns.length === 0) {
    return null;
  }

  if (checkRuns.length > 1) {
    core.info(`Multiple check runs:`);
    checkRuns.forEach((cr) => {
      core.info(`- ${cr.name}: ${cr.conclusion}`);
    });

    const message = `Multiple completed check runs with name: ${checkRunName}`;
    core.setFailed(message);
    throw new Error(message);
  }

  return checkRuns[0];
}

/**
 * Returns the workflow run with the given workflowName for the given ref.
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {import('github-script').AsyncFunctionArguments['context']} context
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} workflowName
 * @param {string} ref
 * @returns {Promise<WorkflowRun | null>}
 */
export async function getWorkflowRun(
  github,
  context,
  core,
  workflowName,
  ref,
) {
  const workflowRuns = await github.paginate(
    github.rest.actions.listWorkflowRunsForRepo,
    {
      ...context.repo,
      head_sha: ref,
      status: "completed",
      per_page: PER_PAGE_MAX,
    },
  );

  if (workflowRuns.length === 0) {
    core.info(`No completed workflow runs`);
    return null;
  }

  const matches = workflowRuns.filter((run) => run.name === workflowName);

  if (matches.length === 0) {
    return null;
  }

  if (matches.length > 1) {
    core.warning(
      `Multiple matching workflow runs, selecting the most recent run`,
    );
    matches.forEach((wf) =>
      core.info(`- ${wf.name}: ${wf.conclusion} ${wf.html_url}`),
    );

    // Sort by "updated_at" descending, so most recent run is at index 0
    matches.sort(
      (a, b) =>
        new Date(b.updated_at).getTime() - new Date(a.updated_at).getTime(),
    );
  }

  return matches[0];
}
