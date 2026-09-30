import { isFullGitSha } from "../../../shared/src/git.ts";
import { extractInputs } from "../context.ts";
import type { GitHubScriptArgs } from "../github.ts";

export type SummaryInputs = Pick<
  Awaited<ReturnType<typeof extractInputs>>,
  "owner" | "repo" | "issue_number" | "head_sha"
>;

/** Resolves only immutable identity before acquiring the per-PR summary concurrency group. */
export async function resolveSummaryInputs({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<SummaryInputs | null> {
  const { owner, repo, issue_number, head_sha } = await extractInputs(github, context, core);
  if (!Number.isSafeInteger(issue_number) || issue_number <= 0) {
    core.warning("No issue number found for this event. Skipping the check summary.");
    return null;
  }
  if (!isFullGitSha(head_sha)) {
    throw new Error(`Invalid head SHA for ${owner}/${repo}#${issue_number}: '${head_sha}'`);
  }
  core.setOutput("issue_number", issue_number);
  return { owner, repo, issue_number, head_sha };
}
