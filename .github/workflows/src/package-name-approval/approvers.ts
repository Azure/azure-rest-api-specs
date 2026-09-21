import { readFile } from "fs/promises";
import yaml from "js-yaml";

export type ApproversConfig = {
  "data-plane"?: Record<string, string[]>;
  "management-plane"?: {
    all?: string[];
  };
  authorization?: {
    global: string[];
    labels: Record<
      string,
      {
        "data-plane": string[];
        "management-plane": string[];
      }
    >;
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
export async function loadApproversConfig(
  path: string = PROTECTED_LABELS_PATH,
): Promise<ApproversConfig> {
  const content = await readFile(path, "utf8");
  const config = yaml.load(content) as Record<string, unknown>;

  const dataPlane: Record<string, string[]> = {};
  const labelApprovers: NonNullable<ApproversConfig["authorization"]>["labels"] = {};

  let mgmtAll: string[] = [];

  // Include global-approvers in data-plane.global so getAllApprovers()
  // (used by handleUnlabeled) recognizes them as authorized.
  const globalApprovers = (config["global-approvers"] ?? ([] as unknown)) as string[];

  for (const [label, entry] of Object.entries(config)) {
    if (label === "global-approvers") continue;

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
      const users = entry as unknown as string[];
      labelApprovers[label] = {
        "data-plane": users,
        "management-plane": users,
      };
      if (lang === "all") {
        dataPlane.global = users;
      } else {
        dataPlane[lang] = users;
      }
      continue;
    }

    // Plane-aware entry
    if (entry && typeof entry === "object") {
      const planeEntry = entry as {
        "management-plane"?: string[];
        "data-plane"?: string[];
      };
      labelApprovers[label] = {
        "data-plane": planeEntry["data-plane"] ?? [],
        "management-plane": planeEntry["management-plane"] ?? [],
      };
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
  const tier1Config = config["tier1"] ?? {};

  return {
    "data-plane": dataPlane,
    // Intentionally unions all mgmt approvers into one list - any mgmt approver
    // for any language can approve any other language on mgmt plane.
    "management-plane": { all: mgmtAll },
    authorization: {
      global: globalApprovers,
      labels: labelApprovers,
    },
    tier1: tier1Config,
  };
}
