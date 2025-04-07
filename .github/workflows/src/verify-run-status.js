import { PER_PAGE_MAX } from "./github.js";
import { extractInputs } from "./context.js";

/**
 *
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 */
export async function verifyRunStatus(
  { github, context, core }
) {
  const checkRunName = process.env.CHECK_RUN_NAME || "";
  if (!checkRunName) { 
    throw new Error("CHECK_RUN_NAME is not set");
  }
  
  const workflowName = process.env.WORKFLOW_NAME || "";
  if (!workflowName) {
    throw new Error("WORKFLOW_NAME is not set");
  }

  // Exit early when context is a check_run event and the check run does not
  // match the checkRunName.
  if (context.eventName == "check_run") {
    const contextRunName = context.payload.check_run.name;
    if (contextRunName !== checkRunName) {
      core.info(
        `Check run name (${contextRunName}) does not match input: ${checkRunName}`,
      );
      return;
    }
  }

  const { head_sha } = await extractInputs(github, context, core);

  const checkRun =
    context.eventName == "check_run"
      ? context.payload.check_run
      : await getCheckRunStatus(github, context, core, checkRunName, head_sha);

  if (!checkRun) {
    core.info(`No completed check run with name: ${checkRunName}`);
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
    core.info(`No completed workflow run with name: ${workflowName}`);
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

  core.info("Checks match");
}

/**
 *
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {import('github-script').AsyncFunctionArguments['context']} context
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} checkRunName
 * @param {string} head_sha
 */
export async function getCheckRunStatus(
  github,
  context,
  core,
  checkRunName,
  head_sha,
) {
  const checkRuns = await github.paginate(github.rest.checks.listForRef, {
    ...context.repo,
    ref: head_sha,
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
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {import('github-script').AsyncFunctionArguments['context']} context
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} workflowName
 * @param {string} head_sha
 */
export async function getWorkflowRun(
  github,
  context,
  core,
  workflowName,
  head_sha,
) {
  const workflowRuns = await github.paginate(
    github.rest.actions.listWorkflowRunsForRepo,
    {
      ...context.repo,
      head_sha,
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
