import { extractInputs } from "./context.js";
import { PER_PAGE_MAX } from "./github.js";

const SUPPORTED_EVENTS = ["workflow_run", "check_run", "check_suite"];

/**
 * @typedef {import('@octokit/plugin-rest-endpoint-methods').RestEndpointMethodTypes} RestEndpointMethodTypes
 * @typedef {RestEndpointMethodTypes["checks"]["listForRef"]["response"]["data"]["check_runs"]} CheckRuns
 * @typedef {RestEndpointMethodTypes["actions"]["listWorkflowRunsForRepo"]["response"]["data"]["workflow_runs"]} WorkflowRuns
 */

/* v8 ignore start */
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

  if (!SUPPORTED_EVENTS.some((e) => e === context.eventName)) {
    throw new Error(
      `Unsupported event: ${context.eventName}. Supported events: ${SUPPORTED_EVENTS.join(", ")}`,
    );
  }

  if (
    context.eventName === "check_suite" &&
    context.payload.check_suite.status !== "completed"
  ) {
    core.setFailed(
      `Check suite ${context.payload.check_suite.app.name} is not completed. Cannot evaluate incomplete check suite.`,
    );
    return;
  }

  return await verifyRunStatusImpl({
    github,
    context,
    core,
    checkRunName,
    workflowName,
  });
}
/* v8 ignore stop */

/**
 * @param {Object} params
 * @param {import('github-script').AsyncFunctionArguments["github"]} params.github
 * @param {import('github-script').AsyncFunctionArguments["context"]} params.context
 * @param {import('github-script').AsyncFunctionArguments["core"]} params.core
 * @param {string} params.checkRunName
 * @param {string} params.workflowName
 */
export async function verifyRunStatusImpl({
  github,
  context,
  core,
  checkRunName,
  workflowName,
}) {
  if (context.eventName == "check_run") {
    const contextRunName = context.payload.check_run.name;
    if (contextRunName !== checkRunName) {
      core.setFailed(
        `Check run name (${contextRunName}) does not match input: ${checkRunName}. Ensure job is filtering by github.event.check_run.name.`,
      );
      return;
    }
  }

  const { head_sha } = await extractInputs(github, context, core);

  let checkRun;
  if (context.eventName == "check_run") {
    checkRun = context.payload.check_run;
  } else {
    const checkRuns = await getCheckRuns(
      github,
      context,
      checkRunName,
      head_sha,
    );
    if (checkRuns.length === 0) {
      if (context.eventName === "check_suite") {
        const message = `Could not locate check run ${checkRunName} in check suite ${context.payload.check_suite.app.name}. Ensure job is filtering by github.event.check_suite.app.name.`;
        core.setFailed(message);
        return;
      }

      core.notice(
        `No completed check run with name: ${checkRunName}. Not enough information to judge success or failure. Ending with success status.`,
      );
      return;
    }

    // Use the most recent check run
    checkRun = checkRuns[0];
  }

  core.info(
    `Check run name: ${checkRun.name}, conclusion: ${checkRun.conclusion}, URL: ${checkRun.html_url}`,
  );
  core.debug(`Check run: ${JSON.stringify(checkRun)}`);

  let workflowRun;
  if (context.eventName == "workflow_run") {
    workflowRun = context.payload.workflow_run;
  } else {
    const workflowRuns = await getWorkflowRuns(
      github,
      context,
      workflowName,
      head_sha,
    );
    if (workflowRuns.length === 0) {
      core.notice(
        `No completed workflow run with name: ${workflowName}. Not enough information to judge success or failure. Ending with success status.`,
      );
      return;
    }

    // Use the most recent workflow run
    workflowRun = workflowRuns[0];
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

  core.notice(
    `Conclusions match for check run ${checkRunName} and workflow run ${workflowName}`,
  );
}

/**
 * Returns the check with the given checkRunName for the given ref.
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {import('github-script').AsyncFunctionArguments['context']} context
 * @param {string} checkRunName
 * @param {string} ref
 * @returns {Promise<CheckRuns>}
 */
export async function getCheckRuns(github, context, checkRunName, ref) {
  const result = await github.paginate(github.rest.checks.listForRef, {
    ...context.repo,
    ref: ref,
    check_name: checkRunName,
    status: "completed",
    per_page: PER_PAGE_MAX,
  });

  // a and b will never be null because status is "completed"
  /* v8 ignore next */
  return result.sort((a, b) =>
    compareDatesDescending(a.completed_at || "", b.completed_at || ""),
  );
}

/**
 * Returns the workflow run with the given workflowName for the given ref.
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {import('github-script').AsyncFunctionArguments['context']} context
 * @param {string} workflowName
 * @param {string} ref
 * @returns {Promise<WorkflowRuns>}
 */
export async function getWorkflowRuns(github, context, workflowName, ref) {
  const result = await github.paginate(
    github.rest.actions.listWorkflowRunsForRepo,
    {
      ...context.repo,
      head_sha: ref,
      status: "completed",
      per_page: PER_PAGE_MAX,
    },
  );

  return result
    .filter((run) => run.name === workflowName)
    .sort((a, b) => compareDatesDescending(a.updated_at, b.updated_at));
}

/**
 * Compares two date strings in descending order.
 * @param {string} a date string of the form "YYYY-MM-DDTHH:mm:ssZ"
 * @param {string} b date string of the form "YYYY-MM-DDTHH:mm:ssZ"
 * @returns
 */
export function compareDatesDescending(a, b) {
  return new Date(b).getTime() - new Date(a).getTime();
}
