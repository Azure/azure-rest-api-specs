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

import { readFile } from "fs/promises";
import yaml from "js-yaml";
import { join } from "path";
import { extractInputs } from "../context.ts";

// Bots that are trusted to apply labels as part of automated workflows.
// github-actions[bot] applies labels from workflows running on the base branch.
// azure-sdk applies labels from the Azure SDK automation pipeline.
// These cannot be influenced by PR authors since they run trusted base-branch code.
export const ALLOWED_BOT_LOGINS = ["github-actions[bot]", "azure-sdk"];

// Labels that indicate PR plane context
const MGMT_LABELS = ["Mgmt", "resource-manager"];
const DP_LABELS = ["data-plane"];

export type LabelEntry =
  | string[]
  | {
      "management-plane"?: string[];
      "data-plane"?: string[];
    };

/**
 * Load and validate the protected-labels.yml config.
 */
async function loadConfig(): Promise<{
  globalApprovers: string[];
  labels: Record<string, LabelEntry>;
}> {
  const configPath = join(process.cwd(), ".github", "protected-labels.yml");
  const content = await readFile(configPath, "utf8");
  const raw = yaml.load(content) as Record<string, unknown>;

  if (!raw || typeof raw !== "object") {
    throw new Error("Invalid protected-labels.yml: expected a YAML object");
  }

  const globalApprovers = (raw["global-approvers"] as string[]) ?? [];
  if (
    !Array.isArray(globalApprovers) ||
    !globalApprovers.every((u) => typeof u === "string" && u.length > 0)
  ) {
    throw new Error(
      `Invalid protected-labels.yml: "global-approvers" must map to an array of non-empty strings`,
    );
  }

  const labels: Record<string, LabelEntry> = {};
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
      const obj = value as Record<string, unknown>;
      const mgmt = obj["management-plane"];
      const dp = obj["data-plane"];
      if ((!mgmt && !dp) || (mgmt && !Array.isArray(mgmt)) || (dp && !Array.isArray(dp))) {
        throw new Error(
          `Invalid protected-labels.yml: "${label}" plane-aware entry must have "management-plane" and/or "data-plane" as arrays`,
        );
      }

      const planeEntry: Record<string, string[]> = {};
      if (mgmt) planeEntry["management-plane"] = mgmt as string[];
      if (dp) planeEntry["data-plane"] = dp as string[];
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
 * @returns null means "skip enforcement" (plane-aware label but no plane context)
 */
function resolveAuthorizedUsers(
  entry: LabelEntry,
  plane: "mgmt" | "data-plane" | "unknown",
): string[] | null {
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

  const prLabels: string[] = payload.pull_request.labels.map((l: { name: string }) => l.name);
  const isMgmt = prLabels.some((l) => MGMT_LABELS.includes(l));
  const isDP = prLabels.some((l) => DP_LABELS.includes(l));

  const plane: "mgmt" | "data-plane" | "unknown" = isMgmt
    ? "mgmt"
    : isDP
      ? "data-plane"
      : "unknown";

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
