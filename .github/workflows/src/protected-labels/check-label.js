// Protected Labels Enforcement
// Entry point for .github/workflows/protected-labels.yaml
//
// Ensures only authorized users (from .github/protected-labels.yml) can apply
// protected labels. Unauthorized applications are removed with a warning comment.
//
// Supports two entry formats:
//   Flat:  LabelName: [user1, user2]
//   Plane: LabelName: { management-plane: [user1], data-plane: [user2] }

import { readFile } from "fs/promises";
import yaml from "js-yaml";
import { join } from "path";
import { extractInputs } from "../context.js";

// Bots that are trusted to apply labels as part of automated workflows.
// github-actions[bot] applies labels from workflows running on the base branch.
// azure-sdk applies labels from the Azure SDK automation pipeline.
// These cannot be influenced by PR authors since they run trusted base-branch code.
const ALLOWED_BOT_LOGINS = ["github-actions[bot]", "azure-sdk"];

// Labels that indicate PR plane context
const MGMT_LABELS = ["Mgmt", "resource-manager"];
const DP_LABELS = ["data-plane"];

/**
 * @typedef {string[] | { "management-plane"?: string[], "data-plane"?: string[] }} LabelEntry
 */

/**
 * Load and validate the protected-labels.yml config.
 * @returns {Promise<{ globalApprovers: string[], labels: Record<string, LabelEntry> }>}
 */
async function loadConfig() {
  const configPath = join(process.cwd(), ".github", "protected-labels.yml");
  const content = await readFile(configPath, "utf8");
  const raw = /** @type {Record<string, unknown>} */ (yaml.load(content));

  if (!raw || typeof raw !== "object") {
    throw new Error("Invalid protected-labels.yml: expected a YAML object");
  }

  const globalApprovers = /** @type {string[]} */ (raw["global-approvers"]) ?? [];
  if (
    !Array.isArray(globalApprovers) ||
    !globalApprovers.every((u) => typeof u === "string" && u.length > 0)
  ) {
    throw new Error(
      `Invalid protected-labels.yml: "global-approvers" must map to an array of non-empty strings`,
    );
  }

  /** @type {Record<string, LabelEntry>} */
  const labels = {};
  for (const [label, value] of Object.entries(raw)) {
    if (label === "global-approvers") continue;
    if (Array.isArray(value)) {
      // Flat format: LabelName: [user1, user2]
      if (!value.every((u) => typeof u === "string" && u.length > 0)) {
        throw new Error(
          `Invalid protected-labels.yml: "${label}" must map to an array of non-empty strings`,
        );
      }
      labels[label] = value;
    } else if (value && typeof value === "object") {
      // Plane-aware format: at least one of management-plane or data-plane required
      const obj = /** @type {Record<string, unknown>} */ (value);
      const mgmt = obj["management-plane"];
      const dp = obj["data-plane"];
      if ((!mgmt && !dp) || (mgmt && !Array.isArray(mgmt)) || (dp && !Array.isArray(dp))) {
        throw new Error(
          `Invalid protected-labels.yml: "${label}" plane-aware entry must have "management-plane" and/or "data-plane" as arrays`,
        );
      }
      /** @type {Record<string, string[]>} */
      const planeEntry = {};
      if (mgmt) planeEntry["management-plane"] = /** @type {string[]} */ (mgmt);
      if (dp) planeEntry["data-plane"] = /** @type {string[]} */ (dp);
      labels[label] = planeEntry;
    } else {
      throw new Error(
        `Invalid protected-labels.yml: "${label}" must map to an array or a plane-aware object`,
      );
    }
  }
  return { globalApprovers, labels };
}

/**
 * Resolve the authorized user list for a label entry, accounting for plane context.
 *
 * @param {LabelEntry} entry
 * @param {"mgmt" | "data-plane" | "unknown"} plane
 * @returns {string[] | null} null means "skip enforcement" (plane-aware label but no plane context)
 */
function resolveAuthorizedUsers(entry, plane) {
  if (Array.isArray(entry)) {
    return entry;
  }
  // Plane-aware entry: enforce only if we can determine the plane
  if (plane === "mgmt") return entry["management-plane"] ?? [];
  if (plane === "data-plane") return entry["data-plane"] ?? [];
  // Unknown plane: skip enforcement for plane-aware labels
  return null;
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

  const { globalApprovers, labels } = await loadConfig();
  const entry = labels[labelName];

  if (!entry) {
    core.info(`"${labelName}" is not a protected label, skipping`);
    return;
  }

  // Determine plane from PR labels (explicit: mgmt, data-plane, or unknown)
  /** @type {string[]} */
  const prLabels = payload.pull_request.labels.map((/** @type {{ name: string }} */ l) => l.name);
  const isMgmt = prLabels.some((l) => MGMT_LABELS.includes(l));
  const isDP = prLabels.some((l) => DP_LABELS.includes(l));
  /** @type {"mgmt" | "data-plane" | "unknown"} */
  const plane = isMgmt ? "mgmt" : isDP ? "data-plane" : "unknown";

  const perLabelUsers = resolveAuthorizedUsers(entry, plane);
  if (perLabelUsers === null) {
    // Plane-aware label on a PR with no plane context - skip enforcement
    core.info(
      `"${labelName}" is plane-aware but PR has no plane label (Mgmt/resource-manager/data-plane), skipping`,
    );
    return;
  }
  const authorizedUsers = [...new Set([...perLabelUsers, ...globalApprovers])];

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
