import { loadPackageNamePolicy, UNPROTECTED_PLANE, type PackageNamePolicy } from "./policy.ts";

export type ApproversConfig = {
  "data-plane"?: Record<string, string[]>;
  "management-plane"?: {
    all?: string[];
  };
  tier1?: {
    "data-plane"?: string[];
    "management-plane"?: string[];
  };
  // Languages whose plane was explicitly set to the "unprotected" keyword. Such a
  // plane has no approver list (anyone may approve), so it is tracked separately
  // instead of leaving the language absent (which would look "not configured").
  unprotected?: {
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
export function createApproversConfig(config: PackageNamePolicy): ApproversConfig {
  const dataPlane: Record<string, string[]> = {};

  let mgmtAll: string[] = [];

  // Languages whose data-plane / management-plane was set to the "unprotected"
  // keyword. These have no approver list; post-results renders them as "anyone".
  const unprotectedDataPlane: string[] = [];
  const unprotectedMgmt: string[] = [];

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
      const mgmt = planeEntry["management-plane"];
      // A plane set to the "unprotected" literal has no approver list.
      if (Array.isArray(mgmt)) {
        // Collect unique mgmt approvers across all namespace labels
        mgmtAll = [...new Set([...mgmtAll, ...mgmt])];
      } else if (mgmt === UNPROTECTED_PLANE) {
        unprotectedMgmt.push(lang);
      }
      const dp = planeEntry["data-plane"];
      if (Array.isArray(dp)) {
        if (lang === "all") {
          dataPlane.global = dp;
        } else {
          dataPlane[lang] = dp;
        }
      } else if (dp === UNPROTECTED_PLANE) {
        unprotectedDataPlane.push(lang);
      }
    }
  }

  // Merge global-approvers into data-plane.global
  if (globalApprovers.length > 0) {
    dataPlane.global = [...new Set([...(dataPlane.global ?? []), ...globalApprovers])];
  }

  // Parse tier1 configuration. Plane values are language lists; ignore any
  // "unprotected" literal so the union type does not leak into string[] fields.
  return {
    "data-plane": dataPlane,
    // Intentionally unions all mgmt approvers into one list - any mgmt approver
    // for any language can approve any other language on mgmt plane.
    "management-plane": { all: mgmtAll },
    tier1: config.tier1,
    unprotected: {
      "data-plane": unprotectedDataPlane,
      "management-plane": unprotectedMgmt,
    },
  };
}

export async function loadApproversConfig(
  path: string = PROTECTED_LABELS_PATH,
): Promise<ApproversConfig> {
  return createApproversConfig(await loadPackageNamePolicy(path));
}
