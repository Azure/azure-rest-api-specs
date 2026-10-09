import { commentOrUpdate } from "../comment.ts";
import type { GitHubScriptArgs } from "../github.ts";

export async function publishResultInComment(
  { github, context, core }: GitHubScriptArgs,
  pullNumber: number,
  command: string,
  content: string,
): Promise<void> {
  if (!Number.isSafeInteger(pullNumber) || pullNumber <= 0) {
    throw new Error(`Invalid pull request number: ${pullNumber}`);
  }

  const body = `${command}\n\n${content}`;
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
