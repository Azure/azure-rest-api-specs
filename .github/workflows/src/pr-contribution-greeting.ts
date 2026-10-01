import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import type { GitHubScriptArgs, WebhookEvent } from "./github.ts";

const MARKER = "<!-- PRContributionGreeting -->";

export async function greetContributor({ github, context }: GitHubScriptArgs): Promise<void> {
  const { pull_request: pr } = context.payload as WebhookEvent<"pull-request", "opened">;
  const author = pr.user;
  if (
    !author ||
    author.type === "Bot" ||
    ["MEMBER", "COLLABORATOR", "OWNER"].includes(pr.author_association)
  ) {
    return;
  }

  try {
    const { data: permission } = await github.rest.repos.getCollaboratorPermissionLevel({
      ...context.repo,
      username: author.login,
    });
    if (["write", "maintain", "admin"].includes(permission.permission)) return;
  } catch (error) {
    // Non-collaborators may return 404 instead of a "none" permission.
    if (!(error instanceof Error && "status" in error && error.status === 404)) throw error;
  }

  const comments = await github.paginate(github.rest.issues.listComments, {
    ...context.repo,
    issue_number: pr.number,
    per_page: PER_PAGE_MAX,
  });
  if (comments.some((comment) => comment.body?.includes(MARKER))) return;

  await github.rest.issues.createComment({
    ...context.repo,
    issue_number: pr.number,
    body: `Thank you for your contribution @${author.login}! We will review the pull request and get back to you soon.\n${MARKER}`,
  });
}
