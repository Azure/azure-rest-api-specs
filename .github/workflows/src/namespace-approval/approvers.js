import { readFile } from "fs/promises";
import yaml from "js-yaml";

/**
 * @typedef {Object} ApproversConfig
 * @property {Record<string, string[]>} [data-plane]
 * @property {{ all?: string[] }} [management-plane]
 */

const PROTECTED_LABELS_PATH = ".github/protected-labels.yml";

/**
 * Derive namespace ApproversConfig from protected-labels.yml.
 *
 * Reads plane-aware namespace entries and builds the nested structure
 * that validate-approval.js expects:
 *   data-plane: { dotnet: [...], java: [...], global: [...] }
 *   management-plane: { all: [...] }
 *
 * @param {string} [path]
 * @returns {Promise<ApproversConfig>}
 */
export async function loadApproversConfig(path = PROTECTED_LABELS_PATH) {
  const content = await readFile(path, "utf8");
  const config = /** @type {Record<string, unknown>} */ (yaml.load(content));

  /** @type {Record<string, string[]>} */
  const dataPlane = {};
  /** @type {string[]} */
  let mgmtAll = [];

  // Include global-approvers in data-plane.global so getAllApprovers()
  // (used by handleUnlabeled) recognizes them as authorized.
  const globalApprovers = /** @type {string[]} */ (
    /** @type {unknown} */ (config["global-approvers"] ?? [])
  );

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
      const users = /** @type {string[]} */ (/** @type {unknown} */ (entry));
      if (lang === "all") {
        dataPlane.global = users;
      } else {
        dataPlane[lang] = users;
      }
      continue;
    }

    // Plane-aware entry
    if (entry && typeof entry === "object") {
      const planeEntry = /** @type {{ "management-plane"?: string[], "data-plane"?: string[] }} */ (
        entry
      );
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

  return {
    "data-plane": dataPlane,
    // Intentionally unions all mgmt approvers into one list - any mgmt approver
    // for any language can approve any other language on mgmt plane.
    "management-plane": { all: mgmtAll },
  };
}
