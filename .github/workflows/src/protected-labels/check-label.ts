import type { Core, WebhookEvent } from "../github.ts";
// Protected Labels Enforcement
// Entry point for .github/workflows/protected-labels.yaml
//
// Ensures only authorized users (from .github/protected-labels.yml) can apply
// protected labels. Unauthorized applications are removed with a warning comment.
//
// Supports two entry formats:
//   Flat:  LabelName: [user1, user2]
//   Plane: LabelName: { management-plane: [user1], data-plane: [user2] }

import { extractInputs } from "../context.ts";
import { evaluateLabelAuthorization, loadProtectedLabelsConfig } from "./authorization.ts";

/**
 * Check if the actor is authorized to apply the label. If not, remove and warn.
 * @returns true if authorized, false if removed
 */
async function enforceLabelAuthorization({
  github,
  core,
  owner,
  repo,
  issueNumber,
  labelName,
  actor,
  authorizedUsers,
}: {
  github: import("@actions/github-script").AsyncFunctionArguments["github"];
  core: Core;
  owner: string;
  repo: string;
  issueNumber: number;
  labelName: string;
  actor: string;
  authorizedUsers: string[];
}): Promise<boolean> {
  // Case-insensitive: GitHub usernames are case-insensitive
  const actorLower = actor.toLowerCase();
  if (authorizedUsers.some((u) => u.toLowerCase() === actorLower)) {
    core.info(`${actor} is authorized to apply "${labelName}"`);
    return true;
  }

  core.warning(`${actor} is not authorized to apply "${labelName}", removing`);

  try {
    await github.rest.issues.removeLabel({
      owner,
      repo,
      issue_number: issueNumber,
      name: labelName,
    });
  } catch (e) {
    // 404 means label was already removed (race condition with another workflow)
    if ((e as { status?: number }).status === 404) {
      core.info(`Label "${labelName}" already removed (race condition), continuing`);
    } else {
      throw e;
    }
  }

  const authorizedList = authorizedUsers.map((u) => `@${u}`).join(", ");
  await github.rest.issues.createComment({
    owner,
    repo,
    issue_number: issueNumber,
    body:
      `⚠️ @${actor} is not authorized to apply \`${labelName}\`. ` +
      `Only ${authorizedList} can apply this label.\n\nLabel removed.`,
  });

  return false;
}

/**
 * Main entry point - called from the workflow via github-script.
 */
export default async function checkLabel({
  github,
  context,
  core,
}: import("@actions/github-script").AsyncFunctionArguments) {
  const { owner, repo, issue_number } = await extractInputs(github, context, core);

  const payload = context.payload as WebhookEvent<"pull-request", "labeled">;

  const labelName = payload.label?.name;
  if (!labelName) {
    throw new Error("Pull request label event is missing a label name.");
  }
  const actor = payload.sender.login;

  const config = await loadProtectedLabelsConfig();
  const prLabels = payload.pull_request.labels.map((label: { name: string }) => label.name);
  const authorization = evaluateLabelAuthorization({
    config,
    labelName,
    actor,
    prLabels,
  });

  if (authorization.status === "trusted-bot") {
    core.info(`${actor} is a trusted bot, skipping`);
    return;
  }
  if (authorization.status === "unprotected") {
    core.info(`"${labelName}" is not a protected label, skipping`);
    return;
  }
  if (authorization.status === "unknown-plane") {
    core.info(
      `"${labelName}" is plane-aware but PR has no plane label (Mgmt/resource-manager/data-plane), skipping`,
    );
    return;
  }
  if (authorization.status === "authorized") {
    core.info(`${actor} is authorized to apply "${labelName}"`);
    return;
  }

  await enforceLabelAuthorization({
    github,
    core,
    owner,
    repo,
    issueNumber: issue_number,
    labelName,
    actor,
    authorizedUsers: authorization.authorizedUsers,
  });
}
