/**
 * Name of the unprivileged `pull_request` intake workflow (pull-request-event.yaml).
 *
 * Trusted handlers subscribe to its completion with `workflow_run`. The intake file is read from
 * the PR merge commit, so a PR can change its name, run-name, and steps. Handlers must only trust
 * GitHub-provided `workflow_run` fields and re-read PR state through the API.
 */
export const PULL_REQUEST_EVENT_WORKFLOW = "Pull Request Event";
