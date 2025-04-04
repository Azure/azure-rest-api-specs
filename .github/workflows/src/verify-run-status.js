import { PER_PAGE_MAX } from "./github.js"
import { extractInputs } from "./context.js";

/**
 * 
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments 
 * @param {string} checkRunName 
 * @param {string} workflowName
 */
export default async function({github, context, core}, checkRunName, workflowName) {
  const inputs = await extractInputs(github, context, core);

  const checkRun = context.eventName == "check_run"
    ? context.payload.check_run
    : await getCheckRunStatus(github, context, core, checkRunName, inputs.head_sha);
  const workflow = context.eventName == "workflow_run" 
    ? context.payload.workflow_run 
    : await getWorkflowRun(github, context, core, workflowName, inputs.head_sha);

  core.debug(`Check run: ${JSON.stringify(checkRun)}`);
  core.debug(`Workflow run: ${JSON.stringify(workflow)}`);

  if (!checkRun || checkRun.status !== "completed") { 
    core.info(`No completed check run with name: ${checkRunName}`);
    return;
  }

  if (!checkRun || workflow.status !== "completed") { 
    core.info(`No completed workflow run with name: ${workflowName}`);
    return;
  }

  core.info(`Check run conclusion: ${checkRun.conclusion}`);
  core.info(`Workflow run conclusion: ${workflow.conclusion}`);

  if (checkRun.conclusion !== workflow.conclusion) {
    core.setFailed(`Check run conclusion (${checkRun.conclusion}) does not match workflow run conclusion (${workflow.conclusion})`);
    return false;
  }
}

/**
 * 
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {import('github-script').AsyncFunctionArguments['context']} context
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} checkRunName 
 * @param {string} head_sha 
 * @returns 
 */
export async function getCheckRunStatus(github, context, core, checkRunName, head_sha) {
  const checkRuns = await github.paginate(
    github.rest.checks.listForRef, 
    {
      ...context.repo,
      ref: head_sha,
      check_name: checkRunName,
      status: "completed",
      per_page: PER_PAGE_MAX,
    }
  );
  core.debug(`Check runs: ${JSON.stringify(checkRuns)}`);

  if (checkRuns.length === 0) {
    return null;
  }

  if (checkRuns.length > 1) {
    core.setFailed(`Multiple completed check runs with name: ${checkRunName}`);
    core.debug(`Check runs: ${JSON.stringify(checkRuns)}`);
    throw new Error(`Multiple completed check runs with name: ${checkRunName}`);
  }

  return checkRuns[0];
}

/**
 * @param {import('github-script').AsyncFunctionArguments['github']} github
 * @param {import('github-script').AsyncFunctionArguments['context']} context
 * @param {import('github-script').AsyncFunctionArguments['core']} core
 * @param {string} workflowName 
 * @param {string} head_sha 
 * @returns 
 */
export async function getWorkflowRun(github, context, core, workflowName, head_sha) {

  const workflowRuns = await github.paginate(
    github.rest.actions.listWorkflowRunsForRepo, 
    {
      ...context.repo,
      head_sha,
      status: "completed",
      per_page: PER_PAGE_MAX,
    });
  core.debug(`Workflow runs: ${JSON.stringify(workflowRuns)}`);

  if (workflowRuns.length === 0) { 
    core.info(`No completed workflow runs`);
    return null;
  }

  const matchingWorkflowRuns = workflowRuns.filter((run) => run.name === workflowName);

  if (matchingWorkflowRuns.length === 0) {
    return null;
  }

  if (matchingWorkflowRuns.length > 1) {
    core.setFailed(`Multiple completed workflow runs with name: ${workflowName}`);
    throw new Error(`Multiple completed workflow runs with name: ${workflowName}`);
  }

  return matchingWorkflowRuns[0];
}
