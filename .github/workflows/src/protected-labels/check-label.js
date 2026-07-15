// Protected Labels Enforcement
// Entry point for .github/workflows/protected-labels.yaml
//
// Ensures only authorized users (from .github/protected-labels.yml) can apply
// protected labels. Unauthorized applications are removed with a warning comment.
// This is the broad "labels == people" gate. Namespace-approval adds a narrower
// contextual layer on top (mgmt vs data-plane specific approvers).

import { readFile } from "fs/promises";
import yaml from "js-yaml";
import { join } from "path";
import { extractInputs } from "../context.js";

// Bots that are trusted to apply labels as part of automated workflows.
// github-actions[bot] applies labels from workflows running on the base branch.
// azure-sdk applies labels from the Azure SDK automation pipeline.
// These cannot be influenced by PR authors since they run trusted base-branch code.
const ALLOWED_BOT_LOGINS = ["github-actions[bot]", "azure-sdk"];

/**
 * Load and validate the protected-labels.yml config.
 * @returns {Promise<Record<string, string[]>>}
 */
async function loadConfig() {
  const configPath = join(process.cwd(), ".github", "protected-labels.yml");
  const content = await readFile(configPath, "utf8");
  const config = /** @type {Record<string, string[]>} */ (yaml.load(content));

  if (!config || typeof config !== "object") {
    throw new Error("Invalid protected-labels.yml: expected a YAML object");
  }
  for (const [label, users] of Object.entries(config)) {
    if (!Array.isArray(users) || !users.every((u) => typeof u === "string" && u.length > 0)) {
      throw new Error(
        `Invalid protected-labels.yml: "${label}" must map to an array of non-empty strings`,
      );
    }
  }
  return config;
}

/**
 * Check if the actor is authorized to apply the label. If not, remove and warn.
 *
 * @param {object} params
 * @param {import("@actions/github-script").AsyncFunctionArguments["github"]} params.github
 * @param {import("@actions/core")} params.core
 * @param {string} params.owner
 * @param {string} params.repo
 * @param {number} params.issueNumber
 * @param {string} params.labelName
 * @param {string} params.actor
 * @param {string[]} params.authorizedUsers
 * @returns {Promise<boolean>} true if authorized, false if removed
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
}) {
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
    if (/** @type {any} */ (e).status === 404) {
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
 *
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 */
export default async function checkLabel({ github, context, core }) {
  const { owner, repo, issue_number } = await extractInputs(github, context, core);

  const payload = /** @type {import("@octokit/webhooks-types").PullRequestLabeledEvent} */ (
    context.payload
  );

  const labelName = payload.label.name;
  const actor = payload.sender.login;

  if (ALLOWED_BOT_LOGINS.includes(actor)) {
    core.info(`${actor} is a trusted bot, skipping`);
    return;
  }

  const config = await loadConfig();
  const authorizedUsers = config[labelName];

  if (!authorizedUsers) {
    core.info(`"${labelName}" is not a protected label, skipping`);
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
    authorizedUsers,
  });
}
