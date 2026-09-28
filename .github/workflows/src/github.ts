import type { AsyncFunctionArguments } from "@actions/github-script";
import type { operations } from "@octokit/openapi-webhooks-types";
import { toPercent } from "../../shared/src/math.ts";
import { Duration, formatDuration, getDuration, subtract } from "../../shared/src/time.ts";

export type Core = AsyncFunctionArguments["core"];

type WebhookEventName = {
  [Name in keyof operations]: Name extends `${infer Event}/${string}` ? Event : Name;
}[keyof operations];

/** GitHub OpenAPI payloads for an event, optionally restricted to specific actions. */
export type WebhookEvent<
  Event extends WebhookEventName,
  Action extends string = string,
> = operations[Extract<
  keyof operations,
  Event | `${Event}/${Action}`
>]["requestBody"]["content"]["application/json"];

export type CommitStatuses =
  RestEndpointMethodTypes["repos"]["listCommitStatusesForRef"]["response"]["data"];

export type WorkflowRuns =
  RestEndpointMethodTypes["actions"]["listWorkflowRunsForRepo"]["response"]["data"]["workflow_runs"];

export type CheckRuns =
  RestEndpointMethodTypes["checks"]["listForRef"]["response"]["data"]["check_runs"];

export type RestEndpointMethodTypes =
  import("@octokit/plugin-rest-endpoint-methods").RestEndpointMethodTypes;

export function createLogHook(
  endpoint: typeof import("@octokit/endpoint").endpoint,
  logger: import("../../shared/src/logger.ts").ILogger,
): (options: import("@octokit/types").RequestParameters & { url: string; method: string }) => void {
  function logHook(
    options: import("@octokit/types").RequestParameters & { url: string; method: string },
  ) {
    const request = endpoint(options);
    logger.info(
      `[github] ${request.method.toUpperCase()} ${request.url} ${request.body ? JSON.stringify(request.body) : ""}`,
    );
  }

  return logHook;
}

export function createRateLimitHook(
  logger: import("../../shared/src/logger.ts").ILogger,
): (response: import("@octokit/types").OctokitResponse<unknown>) => void {
  function rateLimitHook(response: import("@octokit/types").OctokitResponse<unknown>) {
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
