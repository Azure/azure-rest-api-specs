// @ts-check

import { PER_PAGE_MAX } from "../../shared/src/github.js";
import { toPercent } from "../../shared/src/math.js";
import { byDate, invert } from "../../shared/src/sort.js";
import { Duration, formatDuration, getDuration, subtract } from "../../shared/src/time.js";

/**
 * @typedef {import('@octokit/plugin-rest-endpoint-methods').RestEndpointMethodTypes} RestEndpointMethodTypes
 * @typedef {RestEndpointMethodTypes["checks"]["listForRef"]["response"]["data"]["check_runs"]} CheckRuns
 * @typedef {RestEndpointMethodTypes["actions"]["listWorkflowRunsForRepo"]["response"]["data"]["workflow_runs"]} WorkflowRuns
 * @typedef {RestEndpointMethodTypes["repos"]["listCommitStatusesForRef"]["response"]["data"]} CommitStatuses
 */

/**
 * Writes content to the GitHub Actions summary
 * @param {string} content - Markdown content to add to the summary
 * @param {typeof import("@actions/core")} core - GitHub Actions core library
 */
export async function writeToActionsSummary(content, core) {
  try {
    await core.summary.addRaw(content).write();
    core.info("Successfully wrote to the GitHub Actions summary");
  } catch (error) {
    throw new Error(`Failed to write to the GitHub Actions summary: ${error}`);
  }
}

/**
 * Returns the check with the given checkRunName for the given ref.
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {import('@actions/github-script').AsyncFunctionArguments['context']} context
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

  /* v8 ignore next */
  return result.sort(
    invert(
      byDate((run) => {
        if (run.completed_at === null) {
          // completed_at should never be null because status is "completed"
          throw new Error(`Unexpected value of run.completed_at: '${run.completed_at}'`);
        } else {
          return run.completed_at;
        }
      }),
    ),
  );
}

/**
 * Returns the check with the given checkRunName for the given ref.
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {import('@actions/github-script').AsyncFunctionArguments['context']} context
 * @param {string} commitStatusName
 * @param {string} ref
 * @returns {Promise<CommitStatuses>}
 */
export async function getCommitStatuses(github, context, commitStatusName, ref) {
  const result = await github.paginate(github.rest.repos.listCommitStatusesForRef, {
    ...context.repo,
    ref: ref,
    per_page: PER_PAGE_MAX,
  });

  return result
    .filter(
      (status) =>
        // Property "context" is case-insensitive
        status.context.toLowerCase() === commitStatusName.toLowerCase(),
    )
    .sort(invert(byDate((status) => status.updated_at)));
}

/**
 * Returns the workflow run with the given workflowName for the given ref.
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} github
 * @param {import('@actions/github-script').AsyncFunctionArguments['context']} context
 * @param {string} workflowName
 * @param {string} ref
 * @returns {Promise<WorkflowRuns>}
 */
export async function getWorkflowRuns(github, context, workflowName, ref) {
  const result = await github.paginate(github.rest.actions.listWorkflowRunsForRepo, {
    ...context.repo,
    head_sha: ref,
    status: "completed",
    per_page: PER_PAGE_MAX,
  });

  return result
    .filter((run) => run.name === workflowName)
    .sort(invert(byDate((run) => run.updated_at)));
}

/**
 * @param {import("@octokit/endpoint").endpoint} endpoint
 * @param {import('../../shared/src/logger.js').ILogger} logger
 * @returns {(options: import("@octokit/types").RequestParameters & {url: string, method: string}) => void}
 */
export function createLogHook(endpoint, logger) {
  /**
   * @param {import("@octokit/types").RequestParameters & {url: string, method: string}} options
   */
  function logHook(options) {
    const request = endpoint(options);
    const { method, url, body } = request;
    logger.info(`[github] ${method.toUpperCase()} ${url} ${body ? JSON.stringify(body) : ""}`);
  }

  return logHook;
}

/**
 * @param {import('../../shared/src/logger.js').ILogger} logger
 * @returns {(response: import("@octokit/types").OctokitResponse<any>) => void}
 */
export function createRateLimitHook(logger) {
  /**
   * @param {import("@octokit/types").OctokitResponse<any>} response
   */
  function rateLimitHook(response) {
    const {
      "x-ratelimit-limit": limitHeader,
      "x-ratelimit-remaining": remainingHeader,
      "x-ratelimit-reset": resetHeader,
    } = response.headers;

    if (!limitHeader || !remainingHeader || !resetHeader) {
      logger.debug(`[github] missing ratelimit header(s) in response`);
      return;
    }

    const limit = parseInt(limitHeader);
    const remaining = parseInt(remainingHeader);
    const used = limit - remaining;

    const reset = new Date(parseInt(resetHeader) * Duration.Second);
    const start = subtract(reset, Duration.Hour);
    const elapsedMs = new Date().getTime() - start.getTime();
    const elapsedFraction = elapsedMs / Duration.Hour;

    // Example: If limit is 1000, and 6 minutes have elapsed (10% of 1 hour),
    // availableLimit will be 100 (10% of total).
    const availableLimit = limit * elapsedFraction;

    // If load is > 100%, we are "running hot" and predicted to hit limit before reset
    // Keep load < 50% for a safety margin.  If regularly > 50%, optimize.
    const load = used / availableLimit;

    // const resource = headers["x-ratelimit-resource"];

    logger.info(
      `[github] load: ${toPercent(load)}, used: ${used}, remaining: ${remaining}` +
        `, reset: ${formatDuration(getDuration(new Date(), reset))}`,
    );
  }

  return rateLimitHook;
}
