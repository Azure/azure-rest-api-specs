// @ts-check

export const PER_PAGE_MAX = 100;

/**
 * https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/collaborating-on-repositories-with-code-quality-features/about-status-checks#check-statuses-and-conclusions
 */
export const CheckStatus = {
  /** @description The check run completed and has a conclusion. */
  COMPLETED: "completed",
  /** @description The check run is waiting for a status to be reported. */
  EXPECTED: "expected",
  /** @description The check run failed. */
  FAILURE: "failure",
  /** @description The check run is in progress. */
  IN_PROGRESS: "in_progress",
  /** @description The check run is at the front of the queue but the group-based concurrency limit has been reached. */
  PENDING: "pending",
  /** @description The check run has been queued. */
  QUEUED: "queued",
  /** @description The check run has been created but has not been queued. */
  REQUESTED: "requested",
  /** @description The check suite failed during startup. This status is not applicable to check runs. */
  STARTUP_FAILURE: "startup_failure",
  /** @description The check run is waiting for a deployment protection rule to be satisfied. */
  WAITING: "waiting",
};
