import { extractInputs } from "./context.js";
import { getCheckRuns, getCommitStatuses, getWorkflowRuns } from "./github.js";

/**
 * @typedef {import('@octokit/plugin-rest-endpoint-methods').RestEndpointMethodTypes} RestEndpointMethodTypes
 * @typedef {RestEndpointMethodTypes["repos"]["listCommitStatusesForRef"]["response"]["data"]} CommitStatuses
 */

const SUPPORTED_EVENTS = ["workflow_run", "check_run", "check_suite"];

/* v8 ignore start */
/**
 * Given the name of a completed check run name and a completed workflow, verify
 * that both have the same conclusion. If conclusions are different, fail the
 * action.
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
 */
export async function verifyRunStatus({ github, context, core }) {
  const checkRunName = process.env.CHECK_RUN_NAME;
  if (!checkRunName) {
    throw new Error("CHECK_RUN_NAME is not set");
  }

  const commitStatusName = process.env.COMMIT_STATUS_NAME;
  const workflowName = process.env.WORKFLOW_NAME;
  if (!commitStatusName && !workflowName) {
    throw new Error("Neither COMMIT_STATUS nor WORKFLOW_NAME is not set");
  }

  if (!SUPPORTED_EVENTS.some((e) => e === context.eventName)) {
    throw new Error(
      `Unsupported event: ${context.eventName}. Supported events: ${SUPPORTED_EVENTS.join(", ")}`,
    );
  }

  if (context.eventName === "check_suite" && context.payload.check_suite.status !== "completed") {
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
    commitStatusName,
    workflowName,
  });
}
/* v8 ignore stop */

/**
 * @param {Object} params
 * @param {import('@actions/github-script').AsyncFunctionArguments["github"]} params.github
 * @param {import('@actions/github-script').AsyncFunctionArguments["context"]} params.context
 * @param {import('@actions/github-script').AsyncFunctionArguments["core"]} params.core
 * @param {string} params.checkRunName
 * @param {string} [params.commitStatusName]
 * @param {string} [params.workflowName]
 */
export async function verifyRunStatusImpl({
  github,
  context,
  core,
  checkRunName,
  commitStatusName,
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
    const checkRuns = await getCheckRuns(github, context, checkRunName, head_sha);
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

  if (commitStatusName) {
    core.info(`commitStatusName: ${commitStatusName}`);

    // Get the commit status
    let commitStatusContext, commitStatusState, commitStatusTargetUrl;

    // Fetch the commit status from the API
    try {
      const commitStatuses = await getCommitStatuses(github, context, commitStatusName, head_sha);
      if (commitStatuses && commitStatuses.length > 0) {
        commitStatusContext = commitStatuses[0].context;
        commitStatusState = commitStatuses[0].state;
        commitStatusTargetUrl = commitStatuses[0].target_url;
      } else {
        // Count the commit status as pending if not found and return with no-op
        core.notice(
          `Commit status is in pending state. Skipping comparison with check run conclusion.`,
        );
        return;
      }
    } catch (error) {
      core.setFailed(
        `Failed to fetch commit status: ${error instanceof Error ? error.message : String(error)}`,
      );
      return;
    }

    core.info(
      `Commit status context: ${commitStatusContext}, state: ${commitStatusState}, URL: ${commitStatusTargetUrl}`,
    );

    if (commitStatusState === "pending") {
      core.notice(
        `Commit status is in pending state. Skipping comparison with check run conclusion.`,
      );
      return;
    }

    // Normalize check run conclusion: treat 'neutral' as 'success'
    const normalizedCheckRunConclusion =
      checkRun.conclusion === "neutral" ? "success" : checkRun.conclusion;

    if (normalizedCheckRunConclusion !== commitStatusState) {
      core.setFailed(
        `Check run conclusion (${checkRun.conclusion}) does not match commit status state (${commitStatusState})`,
      );
      return;
    }

    core.notice(
      `Conclusions match for check run ${checkRunName} and commit status ${commitStatusName}`,
    );
  }

  if (workflowName) {
    let workflowRun;
    if (context.eventName == "workflow_run") {
      workflowRun = context.payload.workflow_run;
    } else {
      const workflowRuns = await getWorkflowRuns(github, context, workflowName, head_sha);
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

    // Normalize check run conclusion: treat 'neutral' as 'success'
    const normalizedCheckRunConclusion =
      checkRun.conclusion === "neutral" ? "success" : checkRun.conclusion;

    if (normalizedCheckRunConclusion !== workflowRun.conclusion) {
      core.setFailed(
        `Check run conclusion (${checkRun.conclusion}) does not match workflow run conclusion (${workflowRun.conclusion})`,
      );
      return;
    }

    core.notice(`Conclusions match for check run ${checkRunName} and workflow run ${workflowName}`);
  }
}
