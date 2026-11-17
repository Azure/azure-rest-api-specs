import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import { escapeMarkdown } from "../../shared/src/markdown.ts";
import type { GitHubScriptArgs } from "./github.ts";

const ISSUE_MARKER = "<!-- sync-repo-labels-failure -->";
const ISSUE_TITLE = "Repository label synchronization is failing";

export async function reportLabelSyncFailure({ github, context, core }: GitHubScriptArgs) {
  const runUrl = `${context.serverUrl}/${context.repo.owner}/${context.repo.repo}/actions/runs/${context.runId}/attempts/${context.runAttempt}`;
  const jobs = await github.paginate(github.rest.actions.listJobsForWorkflowRunAttempt, {
    ...context.repo,
    run_id: context.runId,
    attempt_number: context.runAttempt,
    per_page: PER_PAGE_MAX,
  });
  const failures = jobs
    .filter((job) => job.conclusion === "failure" || job.conclusion === "timed_out")
    .map((job) => {
      const steps = (job.steps ?? [])
        .filter((step) => step.conclusion === "failure")
        .map((step) => escapeMarkdown(step.name));
      return (
        `- [${escapeMarkdown(job.name)}](${job.html_url}): ${job.conclusion}` +
        (steps.length > 0 ? `; failed steps: ${steps.join(", ")}` : "")
      );
    });
  const body =
    `${ISSUE_MARKER}\n\nRepository label synchronization failed.\n\n` +
    `[Failed run ${context.runNumber}, attempt ${context.runAttempt}](${runUrl}) ` +
    `(trigger: ${escapeMarkdown(context.eventName)}).\n\n` +
    failures.join("\n") +
    "\n\nInspect the failed job logs and any `label-audit-before` / `label-audit-outcome` " +
    "artifacts on that run. Resolve the failure and rerun synchronization; label cleanup " +
    "may be incomplete until it succeeds.\n\n" +
    "This issue is updated for subsequent failures while it remains open. " +
    "Close it once the failure is resolved.";
  const issues = await github.paginate(
    github.rest.issues.listForRepo,
    {
      ...context.repo,
      state: "open",
      creator: "github-actions[bot]",
      per_page: PER_PAGE_MAX,
    },
    (response, done) => {
      const issue = response.data.find(
        (item) => !item.pull_request && item.body?.includes(ISSUE_MARKER),
      );
      if (!issue) return [];
      done();
      return [issue];
    },
  );
  let issue = issues[0];
  if (!issue) {
    ({ data: issue } = await github.rest.issues.create({
      ...context.repo,
      title: ISSUE_TITLE,
      body,
    }));
  } else if (issue.body !== body) {
    await github.rest.issues.update({
      ...context.repo,
      issue_number: issue.number,
      body,
    });
  }
  core.info(`Label synchronization failure issue: ${issue.html_url}`);
  await core.summary.addRaw(`[Failure tracking issue](${issue.html_url})\n`).write();
  return issue.html_url;
}
