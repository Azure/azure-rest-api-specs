import {
  loadProtectedLabelsConfig,
  type ProtectedLabelsConfig,
} from "../protected-labels/authorization.ts";

export type ApproversConfig = {
  "data-plane"?: Record<string, string[]>;
  "management-plane"?: {
    all?: string[];
  };
  tier1?: {
    "data-plane"?: string[];
    "management-plane"?: string[];
  };
};

const PROTECTED_LABELS_PATH = ".github/protected-labels.yml";

/**
 * Derive namespace ApproversConfig from protected-labels.yml.
 *
 * Reads plane-aware namespace entries and builds the nested structure
 * that validate-approval.js expects:
 *   data-plane: { dotnet: [...], java: [...], global: [...] }
 *   management-plane: { all: [...] }
 */
export function createApproversConfig(config: ProtectedLabelsConfig): ApproversConfig {
  const dataPlane: Record<string, string[]> = {};

  let mgmtAll: string[] = [];

  // Include global-approvers in data-plane.global so getAllApprovers()
  // (used by handleUnlabeled) recognizes them as authorized.
  const globalApprovers = config.globalApprovers;

  for (const [label, entry] of Object.entries(config.labels)) {
    // Match package-name-<lang>-approved or package-name-approved-all
    let lang;
    if (label === "package-name-approved-all") {
      lang = "all";
    } else {
      const match = label.match(/^package-name-(\w+)-approved$/);
      if (!match) continue;
      lang = match[1];
    }

    // Flat entry (backward compat) - treat all users as data-plane
    if (Array.isArray(entry)) {
      const users = entry;
      if (lang === "all") {
        dataPlane.global = users;
      } else {
        dataPlane[lang] = users;
      }
      continue;
    }

    // Plane-aware entry
    if (entry && typeof entry === "object") {
      const planeEntry = entry;
      if (planeEntry["management-plane"]) {
        // Collect unique mgmt approvers across all namespace labels
        mgmtAll = [...new Set([...mgmtAll, ...planeEntry["management-plane"]])];
      }
      if (planeEntry["data-plane"]) {
        if (lang === "all") {
          dataPlane.global = planeEntry["data-plane"];
        } else {
          dataPlane[lang] = planeEntry["data-plane"];
        }
      }
    }
  }

  // Merge global-approvers into data-plane.global
  if (globalApprovers.length > 0) {
    dataPlane.global = [...new Set([...(dataPlane.global ?? []), ...globalApprovers])];
  }

  // Parse tier1 configuration
  const tier1Entry = config.labels["tier1"];
  const tier1Config = Array.isArray(tier1Entry) ? {} : (tier1Entry ?? {});

  return {
    "data-plane": dataPlane,
    // Intentionally unions all mgmt approvers into one list - any mgmt approver
    // for any language can approve any other language on mgmt plane.
    "management-plane": { all: mgmtAll },
    tier1: tier1Config,
  };
}

export async function loadApproversConfig(
  path: string = PROTECTED_LABELS_PATH,
): Promise<ApproversConfig> {
  return createApproversConfig(await loadProtectedLabelsConfig(path));
}
