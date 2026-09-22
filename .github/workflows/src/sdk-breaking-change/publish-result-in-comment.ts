import type { AsyncFunctionArguments } from "@actions/github-script";

export async function publishResultInComment(
  { github, context, core }: Pick<AsyncFunctionArguments, "github" | "context" | "core">,
  pullNumber: number,
  command: string,
  content: string,
): Promise<void> {
  if (!Number.isSafeInteger(pullNumber) || pullNumber <= 0) {
    throw new Error(`Invalid pull request number: ${pullNumber}`);
  }

  const body = `${command}\n\n${content}`;
  const comments = await github.paginate(github.rest.issues.listComments, {
    ...context.repo,
    issue_number: pullNumber,
    per_page: 100,
  });
  const existingComment = comments
    .filter(({ body }) => body?.trimStart().toLowerCase().startsWith(command.toLowerCase()))
    .sort((left, right) => right.id - left.id)[0];

  if (existingComment) {
    try {
      await github.rest.issues.updateComment({
        ...context.repo,
        comment_id: existingComment.id,
        body,
      });
      return;
    } catch (error) {
      if (!(error instanceof Error && "status" in error && error.status === 403)) {
        throw error;
      }
      core.warning(
        "The workflow token cannot edit the existing analysis comment; creating a new comment instead.",
      );
    }
  }

  await github.rest.issues.createComment({
    ...context.repo,
    issue_number: pullNumber,
    body,
  });
}
