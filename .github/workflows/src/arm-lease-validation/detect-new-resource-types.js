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

const RESOURCE_TYPE_REGEX = /\/providers\/([^/?#]+)(\/[^?#]*)?/;

/** Extract resource type from API path (e.g. Microsoft.Compute/virtualMachines/extensions) */
function getResourceType(apiPath) {
  const match = apiPath.match(RESOURCE_TYPE_REGEX);
  if (!match) return null;

  // Split and filter out parameter segments like {vmName} to get the static resource type
  const provider = match[1];
  const typeHierarchy = match[2];
  if (!typeHierarchy) return provider;

  return (
    provider +
    typeHierarchy
      .split("/")
      .filter((segment) => segment && !segment.startsWith("{"))
      .join("/")
  );
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
    .filter((f) => f.trim() && f.endsWith(".json") && !f.includes("/examples/"))
    .filter((f, index, self) => self.indexOf(f) === index); // deduplicate

  const total = swaggerFiles.length;
  if (total > 0) {
    console.log(`Analyzing ${total} swagger files in base branch for comparison...`);
  }

  // Iterate over files, but only log summary if it's too much
  for (let i = 0; i < swaggerFiles.length; i++) {
    const file = swaggerFiles[i];
    if (total > 10 && i % 20 === 0 && i > 0) {
      console.log(`Progress: ${i}/${total} files processed...`);
    }

    let content;
    try {
      content = await git.show([`${commitish}:${file.trim()}`]);
    } catch (e) {
      // Intentionally quiet to avoid log spam during comparison
      continue;
    }

    try {
      const swaggerDoc = JSON.parse(content);
      // Skip files that aren't ARM resource-manager specs (minimal check)
      if (!swaggerDoc.paths) continue;
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
