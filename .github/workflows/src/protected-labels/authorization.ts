import { readFile } from "node:fs/promises";
import yaml from "js-yaml";
import { join } from "node:path";

export const ALLOWED_BOT_LOGINS = ["github-actions[bot]", "azure-sdk"];

// Reserved plane value that opts a plane out of enforcement (anyone may apply).
// Must not collide with a GitHub login. An OMITTED plane stays fail-closed (global-only);
// only this explicit keyword opens a plane. See #46728.
export const UNPROTECTED_PLANE = "__unprotected__";

// Plane is derived from resource-manager/data-plane, which summarize-checks reconciles
// (adds and removes). "Mgmt" is intentionally excluded: it is written add-only by
// package-name post-results and goes stale, which misclassified data-plane PRs (#46785).
const MGMT_LABELS = ["resource-manager"];
const DP_LABELS = ["data-plane"];

// A plane maps either to an approver list or to the literal "__unprotected__".
export type PlaneApprovers = string[] | typeof UNPROTECTED_PLANE;

export type LabelEntry =
  | string[]
  | {
      "management-plane"?: PlaneApprovers;
      "data-plane"?: PlaneApprovers;
    };

export type ProtectedLabelsConfig = {
  globalApprovers: string[];
  labels: Record<string, LabelEntry>;
};

export type LabelAuthorization = {
  status:
    | "authorized"
    | "trusted-bot"
    | "unauthorized"
    | "unprotected"
    | "plane-unprotected"
    | "unknown-plane";
  authorizedUsers: string[];
};

export type LabelPlane = "data-plane" | "management-plane";

export async function loadProtectedLabelsConfig(
  path: string = join(process.cwd(), ".github", "protected-labels.yml"),
): Promise<ProtectedLabelsConfig> {
  const content = await readFile(path, "utf8");
  const raw = yaml.load(content) as Record<string, unknown>;

  if (!raw || typeof raw !== "object") {
    throw new Error("Invalid protected-labels.yml: expected a YAML object");
  }

  const globalApprovers = (raw["global-approvers"] as string[]) ?? [];
  if (
    !Array.isArray(globalApprovers) ||
    !globalApprovers.every((user) => typeof user === "string" && user.length > 0)
  ) {
    throw new Error(
      `Invalid protected-labels.yml: "global-approvers" must map to an array of non-empty strings`,
    );
  }

  const labels: Record<string, LabelEntry> = {};
  for (const [label, value] of Object.entries(raw)) {
    if (label === "global-approvers") continue;

    if (Array.isArray(value)) {
      if (!value.every((user) => typeof user === "string" && user.length > 0)) {
        throw new Error(
          `Invalid protected-labels.yml: "${label}" must map to an array of non-empty strings`,
        );
      }
      labels[label] = value;
      continue;
    }

    if (!value || typeof value !== "object") {
      throw new Error(
        `Invalid protected-labels.yml: "${label}" must map to an array or a plane-aware object`,
      );
    }

    const planeEntry = value as Record<string, unknown>;
    const managementPlane = planeEntry["management-plane"];
    const dataPlane = planeEntry["data-plane"];
    const isValidPlaneValue = (v: unknown): boolean =>
      v === undefined ||
      v === UNPROTECTED_PLANE ||
      (Array.isArray(v) && v.every((user) => typeof user === "string" && user.length > 0));
    if (
      (!managementPlane && !dataPlane) ||
      !isValidPlaneValue(managementPlane) ||
      !isValidPlaneValue(dataPlane)
    ) {
      throw new Error(
        `Invalid protected-labels.yml: "${label}" plane-aware entry must have "management-plane" and/or "data-plane", each an array of logins or the literal "${UNPROTECTED_PLANE}"`,
      );
    }

    labels[label] = {
      ...(managementPlane !== undefined
        ? { "management-plane": managementPlane as PlaneApprovers }
        : {}),
      ...(dataPlane !== undefined ? { "data-plane": dataPlane as PlaneApprovers } : {}),
    };
  }

  return { globalApprovers, labels };
}

function resolveAuthorizedUsers(
  entry: LabelEntry,
  prLabels: string[],
  plane?: LabelPlane,
): string[] | typeof UNPROTECTED_PLANE | null {
  if (Array.isArray(entry)) {
    return entry;
  }

  const resolvePlane = (p: LabelPlane): string[] | typeof UNPROTECTED_PLANE => {
    const value = entry[p];
    if (value === UNPROTECTED_PLANE) {
      return UNPROTECTED_PLANE;
    }
    return value ?? [];
  };

  if (plane) {
    return resolvePlane(plane);
  }
  if (prLabels.some((label) => MGMT_LABELS.includes(label))) {
    return resolvePlane("management-plane");
  }
  if (prLabels.some((label) => DP_LABELS.includes(label))) {
    return resolvePlane("data-plane");
  }
  return null;
}

export function evaluateLabelAuthorization({
  config,
  labelName,
  actor,
  prLabels,
  plane,
}: {
  config: ProtectedLabelsConfig;
  labelName: string;
  actor: string;
  prLabels: string[];
  plane?: LabelPlane;
}): LabelAuthorization {
  if (ALLOWED_BOT_LOGINS.includes(actor)) {
    return { status: "trusted-bot", authorizedUsers: [] };
  }

  const entry = config.labels[labelName];
  if (!entry) {
    return { status: "unprotected", authorizedUsers: [] };
  }

  const perLabelUsers = resolveAuthorizedUsers(entry, prLabels, plane);
  if (perLabelUsers === null) {
    return { status: "unknown-plane", authorizedUsers: [] };
  }
  if (perLabelUsers === UNPROTECTED_PLANE) {
    // Distinct from "unprotected" (label absent from config): here the label IS
    // protected but this plane explicitly opted out. Consumers that fail-closed on
    // not configured labels (e.g. package-name approval) must still honor this. See #46728.
    return { status: "plane-unprotected", authorizedUsers: [] };
  }

  const authorizedUsers = [...new Set([...perLabelUsers, ...config.globalApprovers])];
  const actorLower = actor.toLowerCase();
  const authorized = authorizedUsers.some((user) => user.toLowerCase() === actorLower);
  return {
    status: authorized ? "authorized" : "unauthorized",
    authorizedUsers,
  };
}
