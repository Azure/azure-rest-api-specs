import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import type { GitHubScriptArgs, WebhookEvent } from "./github.ts";

export async function resolveOwnershipPullRequest({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<number | null> {
  if (context.eventName === "issue_comment") {
    const { issue, comment, sender } = context.payload as WebhookEvent<"issue-comment", "created">;
    if (
      !issue.pull_request ||
      comment.body.trim() !== "/azsdk check-ownership" ||
      sender.type === "Bot"
    ) {
      core.info("Ignoring unrelated ownership refresh.");
      return null;
    }
    // Refreshing reads current authorization; it cannot grant approval.
    return issue.number;
  }
  if (context.eventName !== "workflow_run") {
    throw new Error(`Unsupported ownership approval trigger: ${context.eventName}`);
  }
  const payload = context.payload as WebhookEvent<"workflow-run", "completed">;
  const { data: run } = await github.rest.actions.getWorkflowRun({
    ...context.repo,
    run_id: payload.workflow_run.id,
  });
  if (
    run.repository.id !== payload.repository.id ||
    run.path !== ".github/workflows/ownership-approval-notify.yaml" ||
    !["pull_request", "pull_request_review"].includes(run.event)
  ) {
    throw new Error("Unexpected ownership notification workflow");
  }
  let numbers = (run.pull_requests ?? [])
    .filter((pr) => pr.base.repo.id === payload.repository.id)
    .map((pr) => pr.number);
  if (numbers.length === 0) {
    const { data } = await github.rest.search.issuesAndPullRequests({
      q: `repo:${context.repo.owner}/${context.repo.repo} is:pr is:open ${run.head_sha}`,
      per_page: PER_PAGE_MAX,
      advanced_search: "true",
    });
    if (data.incomplete_results || data.total_count !== data.items.length) {
      throw new Error("Incomplete ownership PR lookup; use /azsdk check-ownership");
    }
    numbers = data.items.map((pr) => pr.number);
  }
  const candidates: number[] = [];
  for (const number of new Set(numbers)) {
    const { data: pr } = await github.rest.pulls.get({ ...context.repo, pull_number: number });
    if (pr.state === "open" && pr.base.repo.id === payload.repository.id) candidates.push(number);
  }
  if (candidates.length > 1) {
    throw new Error("Ambiguous ownership PR lookup; use /azsdk check-ownership");
  }
  if (!candidates.length) core.info("No open PR found for ownership notification.");
  return candidates[0] ?? null;
}
