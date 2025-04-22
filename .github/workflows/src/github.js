// @ts-check

export const PER_PAGE_MAX = 100;

/**
 * https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/collaborating-on-repositories-with-code-quality-features/about-status-checks#check-statuses-and-conclusions
 */
export const CheckStatus = {
  /**
   * @type {"completed"}
   * @description The check run completed and has a conclusion.
   */
  COMPLETED: "completed",
  /**
   * @type {"expected"}
   * @description The check run is waiting for a status to be reported.
   */
  EXPECTED: "expected",
  /**
   * @type {"failure"}
   * @description The check run failed.
   */
  FAILURE: "failure",
  /**
   * @type {"in_progress"}
   * @description The check run is in progress.
   */
  IN_PROGRESS: "in_progress",
  /**
   * @type {"pending"}
   * @description The check run is at the front of the queue but the group-based concurrency limit has been reached.
   */
  PENDING: "pending",
  /**
   * @type {"queued"}
   * @description The check run has been queued.
   */
  QUEUED: "queued",
  /**
   * @type {"requested"}
   * @description The check run has been created but has not been queued.
   */
  REQUESTED: "requested",
  /**
   * @type {"startup_failure"}
   * @description The check suite failed during startup. This status is not applicable to check runs.
   */
  STARTUP_FAILURE: "startup_failure",
  /**
   * @type {"waiting"}
   * @description The check run is waiting for a deployment protection rule to be satisfied.
   */
  WAITING: "waiting",
};

/**
 * https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/collaborating-on-repositories-with-code-quality-features/about-status-checks#check-statuses-and-conclusions
 */
export const CheckConclusion = {
  /**
   * @type {"action_required"}
   * @description The check run provided required actions upon its completion. For more information, see Using the REST API to interact with checks.
   */
  ACTION_REQUIRED: "action_required",
  /**
   * @type {"cancelled"}
   * @description The check run was cancelled before it completed.
   */
  CANCELLED: "cancelled",
  /**
   * @type {"failure"}
   * @description The check run failed.
   */
  FAILURE: "failure",
  /**
   * @type {"neutral"}
   * @description The check run completed with a neutral result. This is treated as a success for dependent checks in GitHub Actions.
   */
  NEUTRAL: "neutral",
  /**
   * @type {"skipped"}
   * @description The check run was skipped. This is treated as a success for dependent checks in GitHub Actions.
   */
  SKIPPED: "skipped",
  /**
   * @type {"stale"}
   * @description The check run was marked stale by GitHub because it took too long.
   */
  STALE: "stale",
  /**
   * @type {"success"}
   * @description The check run completed successfully.
   */
  SUCCESS: "success",
  /**
   * @type {"timed_out"}
   * @description The check run timed out.
   */
  TIMED_OUT: "timed_out",
};

/**
 * https://docs.github.com/en/rest/commits/statuses?apiVersion=2022-11-28#create-a-commit-status--parameters
 */
export const CommitStatusState = {
  /**
   * @type {"error"}
   */
  ERROR: "error",
  /**
   * @type {"failure"}
   */
  FAILURE: "failure",
  /**
   * @type {"pending"}
   */
  PENDING: "pending",
  /**
   * @type {"success"}
   */
  SUCCESS: "success",
};
