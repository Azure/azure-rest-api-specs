import { readFile } from "fs/promises";
import yaml from "js-yaml";

/**
 * @typedef {Object} ApproversConfig
 * @property {Record<string, string[]>} [data-plane]
 * @property {{ all?: string[] }} [management-plane]
 */

const APPROVERS_PATH = ".github/namespace-approvers.yml";

/**
 * Load the approvers configuration from the YAML file.
 *
 * @param {string} [path]
 * @returns {Promise<ApproversConfig>}
 */
export async function loadApproversConfig(path = APPROVERS_PATH) {
  const content = await readFile(path, "utf8");
  return /** @type {ApproversConfig} */ (yaml.load(content));
}
