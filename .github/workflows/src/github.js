import { inspect } from "util";
import { toPercent } from "../../shared/src/math.js";
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
    throw new Error(`Failed to write to the GitHub Actions summary: ${inspect(error)}`);
  }
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
    logger.info(
      `[github] ${request.method.toUpperCase()} ${request.url} ${request.body ? JSON.stringify(request.body) : ""}`,
    );
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
