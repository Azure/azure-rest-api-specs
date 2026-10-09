import type { Core, GitHub, GitHubScriptArgs, WebhookEvent } from "./github.ts";

/** Re-read PR state because a queued workflow's event payload can be stale. */
export async function getOpenPullRequest(
  github: Pick<GitHub, "rest">,
  core: Core,
  { owner, repo, issue_number }: { owner: string; repo: string; issue_number: number },
) {
  if (!Number.isInteger(issue_number) || issue_number <= 0) {
    core.info("No PR number resolved; skipping PR updates.");
    return;
  }

  const { data: pr } = await github.rest.pulls.get({ owner, repo, pull_number: issue_number });
  if (pr.state !== "open") {
    core.info(`PR ${owner}/${repo}#${issue_number} is closed; skipping PR updates.`);
    return;
  }
  return pr;
}

export function getCheckRunPullRequestNumber(payload: WebhookEvent<"check-run">): number {
  const prs = payload.check_run.pull_requests?.filter(
    (pr) =>
      pr.base.repo?.id === payload.repository.id && pr.head.sha === payload.check_run.head_sha,
  );
  return prs?.length === 1 ? prs[0].number : NaN;
}

/** Dependency-free preflight, before SDK authentication and dependency installation. */
export async function shouldRunSdkWorkflow({ github, context, core }: GitHubScriptArgs) {
  const payload = context.payload;
  const issue_number =
    context.eventName === "check_run"
      ? getCheckRunPullRequestNumber(payload as WebhookEvent<"check-run">)
      : (payload as WebhookEvent<"pull-request">).pull_request.number;
  if (!Number.isInteger(issue_number) || issue_number <= 0) {
    core.info("No unambiguous PR in the event; deferring to commit/artifact resolution.");
    return true;
  }

  const pr = await getOpenPullRequest(github, core, { ...context.repo, issue_number });
  if (!pr) return false;
  if (
    context.eventName === "check_run" &&
    pr.head.sha !== (payload as WebhookEvent<"check-run">).check_run.head_sha
  ) {
    core.info("The checked commit is no longer the PR head; skipping SDK workflow.");
    return false;
  }
  return true;
}
