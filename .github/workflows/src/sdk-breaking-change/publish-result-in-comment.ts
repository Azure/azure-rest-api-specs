import { commentOrUpdate } from "../comment.ts";
import { isFullGitSha } from "../../../shared/src/git.ts";
import type { GitHubScriptArgs } from "../github.ts";

export async function publishResultInComment(
  { github, context, core }: GitHubScriptArgs,
  pullNumber: number,
  command: string,
  content: string,
  headSha?: string,
): Promise<void> {
  if (!Number.isSafeInteger(pullNumber) || pullNumber <= 0) {
    throw new Error(`Invalid pull request number: ${pullNumber}`);
  }
  if (headSha !== undefined && !isFullGitSha(headSha)) {
    throw new Error(`Invalid SDK breaking-change head SHA: ${headSha}`);
  }

  const body = `${command}\n\n${content}${
    headSha ? `\n<!-- sdk-breaking-change-head-sha: ${headSha} -->` : ""
  }`;
  await commentOrUpdate(
    github,
    core,
    context.repo.owner,
    context.repo.repo,
    pullNumber,
    body,
    command,
  );
}
