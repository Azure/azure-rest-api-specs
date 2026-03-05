/**
 * Detect new ARM resource types in PRs using Azure OpenAPI Validator's ArmHelper.
 *
 * Compares resource types between the base branch and HEAD for existing RPs
 * to identify newly introduced resource types that require ARM lease validation.
 */

import { resolve } from "path";
import { simpleGit } from "simple-git";
import { ArmHelper } from "@microsoft.azure/openapi-validator-rulesets/dist/native/utilities/arm-helper.js";
import { SwaggerInventory } from "@microsoft.azure/openapi-validator-core";

// Match: specification/<orgName>/resource-manager/<Namespace>/(stable|preview)/<version>/
const VERSION_PATTERN =
  /^specification\/([^/]+)\/resource-manager\/([^/]+)\/(stable|preview)\/([^/]+)\//;

// Match pattern: specification/<orgName>/resource-manager/<RPNamespace>/...
const RESOURCE_MANAGER_PATTERN = /^specification\/[^\/]+\/resource-manager\/([^\/]+)\//;

const RESOURCE_TYPE_REGEX = /\/providers\/([^?]+)/;

/** Extract resource type from API path (e.g. Microsoft.Compute/virtualMachines/extensions) */
function getResourceType(apiPath) {
  const match = apiPath.match(RESOURCE_TYPE_REGEX);
  if (!match) return null;

  // Split and filter out parameter segments like {vmName} to get the static resource type
  return match[1]
    .split("/")
    .filter((segment) => !segment.startsWith("{"))
    .join("/");
}

/**
 * Get all ARM resource types from a swagger document using openapi-validator's ArmHelper.
 *
 * @param {Object} swaggerDoc - Parsed swagger JSON document
 * @param {string} specPath - Absolute path to the swagger file
 * @returns {Map<string, {resourceType: string, provider: string, modelName: string, operations: Array<{method: string, apiPath: string}>}>}
 */
function getResourceTypesFromSwagger(swaggerDoc, specPath) {
  const armHelper = new ArmHelper(
    swaggerDoc,
    resolve(specPath),
    new SwaggerInventory(),
  );
  const resourceTypes = new Map();

  for (const resource of armHelper.getAllResources()) {
    const firstOp = resource.operations[0];
    const resourceType = getResourceType(firstOp.apiPath);

    if (resourceType && !resourceTypes.has(resourceType)) {
      resourceTypes.set(resourceType, {
        resourceType,
        provider: resourceType.split("/")[0],
        modelName: resource.modelName,
        operations: resource.operations.map((op) => ({
          method: op.httpMethod,
          apiPath: op.apiPath,
        })),
      });
    }
  }

  return resourceTypes;
}

/**
 * Get resource types from swagger files at a specific git ref.
 *
 * @param {import("simple-git").SimpleGit} git
 * @param {string} commitish - Git ref
 * @param {string} namespacePath - e.g. `specification/compute/resource-manager/Microsoft.Compute`
 * @param {string} repoRoot - Repository root directory
 * @returns {Promise<Map<string, Object>>} Map of resource type to info
 */
async function getResourceTypesAtRef(git, commitish, namespacePath, repoRoot) {
  const allTypes = new Map();

  let output;
  try {
    output = await git.raw([
      "ls-tree",
      "-r",
      "--name-only",
      commitish,
      namespacePath,
    ]);
  } catch {
    return allTypes; // path doesn't exist at this ref
  }

  const swaggerFiles = output
    .split("\n")
    .filter((f) => f.endsWith(".json") && !f.includes("/examples/"));

  for (const file of swaggerFiles) {
    /** @type {string} */
    let content;
    try {
      content = await git.show([`${commitish}:${file}`]);
    } catch (e) {
      console.warn(`Failed to read ${file} at ${commitish}, skipping: ${e.message}`);
      continue;
    }

    try {
      const swaggerDoc = JSON.parse(content);
      const types = getResourceTypesFromSwagger(
        swaggerDoc,
        resolve(repoRoot, file),
      );
      for (const [type, info] of types) {
        if (!allTypes.has(type)) {
          allTypes.set(type, info);
        }
      }
    } catch {
      // skip un-parseable files
    }
  }

  return allTypes;
}

/**
 * Detect new resource types introduced in a PR for existing RPs.
 *
 * For each namespace that already exists in the base branch, compares the set
 * of ARM resource types between base and HEAD using ArmHelper. Any resource type
 * present in HEAD but absent from base is new.
 *
 * @param {Object} params
 * @param {string} params.repoRoot - Repository root directory
 * @param {string} params.mergeBase - Git ref for the base commit
 * @param {string[]} params.rmFiles - Resource-manager file paths changed in the PR
 * @param {import("@actions/core")} params.core - GitHub Actions core for logging
 * @returns {Promise<Array<{namespace: string, orgName: string, newResourceTypes: Array<{resourceType: string, provider: string, modelName: string, operations: string[]}>}>>}
 */
export async function detectNewResourceTypes({
  repoRoot,
  mergeBase,
  rmFiles,
  core,
}) {
  const git = simpleGit(repoRoot);

  // Group changed RM swagger files by namespace
  /** @type {Map<string, {orgName: string, namespacePath: string}>} */
  const namespaceMap = new Map();

  for (const file of rmFiles) {
    // Determine orgName and namespace from the file path
    // Format: specification/<orgName>/resource-manager/<namespace>/...
    const parts = file.split("/");
    if (parts[0] !== "specification" || parts[2] !== "resource-manager") continue;

    const orgName = parts[1];
    const namespace = parts[3];
    const namespacePath = `specification/${orgName}/resource-manager/${namespace}`;

    if (!namespaceMap.has(namespace)) {
      namespaceMap.set(namespace, { orgName, namespacePath });
    }
  }

  const results = [];

  for (const [namespace, { orgName, namespacePath }] of namespaceMap) {
    core.info(`Checking for new resource types in ${namespace}...`);

    const baseTypes = await getResourceTypesAtRef(
      git,
      mergeBase,
      namespacePath,
      repoRoot,
    );

    // If the namespace didn't exist in base, skip — that's a new RP, handled elsewhere
    if (baseTypes.size === 0) {
      core.info(` ${namespace}: no resources in base (new RP, skipping)`);
      continue;
    }

    const headTypes = await getResourceTypesAtRef(
      git,
      "HEAD",
      namespacePath,
      repoRoot,
    );

    const newTypes = [];
    for (const [type, info] of headTypes) {
      if (!baseTypes.has(type)) {
        newTypes.push({
          resourceType: type,
          provider: info.provider,
          modelName: info.modelName,
          operations: info.operations.map((op) => op.method),
        });
      }
    }

    if (newTypes.length > 0) {
      core.info(
        ` ${namespace}: ${newTypes.length} new resource type(s) detected`,
      );
      for (const t of newTypes) {
        core.info(`  - ${t.resourceType} (${t.operations.join(", ")})`);
      }
      results.push({ namespace, orgName, newResourceTypes: newTypes });
    } else {
      core.info(` ${namespace}: no new resource types`);
    }
  }

  return results;
}
