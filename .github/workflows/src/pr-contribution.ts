import type { GitHubScriptArgs, WebhookEvent } from "./github.ts";

export async function labelExternalContributor({ github, context }: GitHubScriptArgs) {
  const { pull_request: pr } = context.payload as WebhookEvent<"pull-request", "opened">;
  if (
    pr.user.type !== "User" ||
    ["MEMBER", "COLLABORATOR", "OWNER"].includes(pr.author_association) ||
    pr.labels.some((label) => label.name === "customer-reported")
  ) {
    return;
  }

  const { data } = await github.rest.repos.getCollaboratorPermissionLevel({
    ...context.repo,
    username: pr.user.login,
  });
  if (data.permission === "write" || data.permission === "admin") return;

  await github.rest.issues.addLabels({
    ...context.repo,
    issue_number: pr.number,
    labels: ["customer-reported"],
  });
}
