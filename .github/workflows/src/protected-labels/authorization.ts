import { readFile } from "fs/promises";
import yaml from "js-yaml";
import { join } from "path";

export const ALLOWED_BOT_LOGINS = ["github-actions[bot]", "azure-sdk"];

const MGMT_LABELS = ["Mgmt", "resource-manager"];
const DP_LABELS = ["data-plane"];

export type LabelEntry =
  | string[]
  | {
      "management-plane"?: string[];
      "data-plane"?: string[];
    };

export type ProtectedLabelsConfig = {
  globalApprovers: string[];
  labels: Record<string, LabelEntry>;
};

export type LabelAuthorization = {
  status: "authorized" | "trusted-bot" | "unauthorized" | "unprotected" | "unknown-plane";
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
    if (
      (!managementPlane && !dataPlane) ||
      (managementPlane && !Array.isArray(managementPlane)) ||
      (dataPlane && !Array.isArray(dataPlane))
    ) {
      throw new Error(
        `Invalid protected-labels.yml: "${label}" plane-aware entry must have "management-plane" and/or "data-plane" as arrays`,
      );
    }

    labels[label] = {
      ...(managementPlane ? { "management-plane": managementPlane as string[] } : {}),
      ...(dataPlane ? { "data-plane": dataPlane as string[] } : {}),
    };
  }

  return { globalApprovers, labels };
}

function resolveAuthorizedUsers(
  entry: LabelEntry,
  prLabels: string[],
  plane?: LabelPlane,
): string[] | null {
  if (Array.isArray(entry)) {
    return entry;
  }

  if (plane) {
    return entry[plane] ?? [];
  }
  if (prLabels.some((label) => MGMT_LABELS.includes(label))) {
    return entry["management-plane"] ?? [];
  }
  if (prLabels.some((label) => DP_LABELS.includes(label))) {
    return entry["data-plane"] ?? [];
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

  const authorizedUsers = [...new Set([...perLabelUsers, ...config.globalApprovers])];
  const actorLower = actor.toLowerCase();
  const authorized = authorizedUsers.some((user) => user.toLowerCase() === actorLower);
  return {
    status: authorized ? "authorized" : "unauthorized",
    authorizedUsers,
  };
}
