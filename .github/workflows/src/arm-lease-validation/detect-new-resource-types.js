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

// Match pattern: specification/<orgName>/resource-manager/<RPNamespace>/...
const RESOURCE_MANAGER_PATTERN = /^specification\/[^\/]+\/resource-manager\/([^\/]+)\//;

const RESOURCE_TYPE_REGEX = /\/providers\/([^/?#]+)(\/[^?#]*)?/;

/**
 * Extract resource type from API path (e.g. Microsoft.Compute/virtualMachines/extensions)
 * @param {string} apiPath
 * @returns {string | null}
 */
function getResourceType(apiPath) {
  const match = apiPath.match(RESOURCE_TYPE_REGEX);
  if (!match) return null;

  // Split and filter out parameter segments like {vmName} to get the static resource type
  const provider = /** @type {string} */ (match[1]);
  const typeHierarchy = /** @type {string | undefined} */ (match[2]);
  if (!typeHierarchy) return provider;

  // typeHierarchy starts with "/" (e.g. "/superDisks/{diskName}").
  // Filter out empty segments and path parameters, then re-join with "/" preserving the leading slash.
  const staticSegments = typeHierarchy
    .split("/")
    .filter((segment) => segment && !segment.startsWith("{"));

  if (staticSegments.length === 0) return provider;

  return provider + "/" + staticSegments.join("/");
}

/**
 * Get all ARM resource types from a swagger document using openapi-validator's ArmHelper.
 *
 * Primary: ArmHelper detects resources based on definitions with x-ms-azure-resource or
 * ARM base types. Fallback: path-based detection for specs using inline schemas.
 *
 * @param {Object} swaggerDoc - Parsed swagger JSON document
 * @param {string} specPath - Absolute path to the swagger file
 * @returns {Map<string, {resourceType: string, provider: string, modelName: string|null, operations: Array<{method: string, apiPath: string}>}>}
 */
function getResourceTypesFromSwagger(swaggerDoc, specPath) {
  const resourceTypes = new Map();

  // ArmHelper requires a populated SwaggerInventory to resolve cross-file $refs.
  // When used with a fresh empty inventory (as here), it throws "Node does not exist"
  // during getAllResources(). Wrap in try/catch so we always fall through to the
  // path-based fallback when ArmHelper cannot run.
  try {
    const armHelper = new ArmHelper(
      swaggerDoc,
      resolve(specPath),
      new SwaggerInventory(),
    );

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
  } catch {
    // ArmHelper failed (e.g. empty SwaggerInventory throws "Node does not exist").
    // Fall through to the path-based fallback below.
  }

  // Fallback: when ArmHelper finds no resources (e.g. spec uses inline response schemas
  // instead of $ref to named definitions, or ArmHelper threw), scan paths directly for
  // ARM resource patterns.
  if (resourceTypes.size === 0 && swaggerDoc.paths) {
    /** @type {Record<string, Record<string, unknown>>} */
    const paths = /** @type {any} */ (swaggerDoc.paths);
    for (const [apiPath, pathItem] of Object.entries(paths)) {
      const resourceType = getResourceType(apiPath);
      if (!resourceType || !resourceType.includes("/")) continue;

      const parts = resourceType.split("/");
      // Skip operations-only paths (e.g. Microsoft.Compute/operations)
      if (parts[parts.length - 1].toLowerCase() === "operations") continue;

      /** @type {Array<{method: string, apiPath: string}>} */
      const ops = Object.entries(/** @type {Record<string, unknown>} */ (pathItem))
        .filter(([method]) =>
          ["get", "put", "post", "patch", "delete"].includes(method.toLowerCase()),
        )
        .map(([method]) => ({ method: method.toUpperCase(), apiPath }));

      if (ops.length === 0) continue;

      if (!resourceTypes.has(resourceType)) {
        resourceTypes.set(resourceType, {
          resourceType,
          provider: parts[0],
          modelName: null,
          operations: ops,
        });
      } else {
        const existing = /** @type {{operations: Array<{method: string, apiPath: string}>}} */ (
          resourceTypes.get(resourceType)
        );
        for (const op of ops) {
          if (!existing.operations.some((e) => e.method === op.method && e.apiPath === op.apiPath)) {
            existing.operations.push(op);
          }
        }
      }
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
 * @returns {Promise<Map<string, Object> | null>} Map of resource type to info, or null if path doesn't exist at this ref
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
    return null; // path doesn't exist at this ref
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

  // Group changed RM swagger files by service subdirectory (namespace + service group)
  /** @type {Map<string, {orgName: string, namespacePath: string, namespace: string}>} */
  const namespaceMap = new Map();

  for (const file of rmFiles) {
    // Use RESOURCE_MANAGER_PATTERN to ensure the file is inside a namespace directory
    // (the trailing "/" in the pattern requires at least one path component after the namespace)
    const rmMatch = file.match(RESOURCE_MANAGER_PATTERN);
    if (!rmMatch) continue;

    const parts = file.split("/");
    const orgName = parts[1];
    const namespace = parts[3];
    // Scope to the service subdirectory (e.g. DiskRP) to avoid scanning the entire namespace
    const serviceGroup = parts[4];
    const namespacePath = `specification/${orgName}/resource-manager/${namespace}/${serviceGroup}`;
    const serviceKey = `${namespace}/${serviceGroup}`;

    if (!namespaceMap.has(serviceKey)) {
      namespaceMap.set(serviceKey, { orgName, namespacePath, namespace });
    }
  }

  const results = [];

  for (const [serviceKey, { orgName, namespacePath, namespace }] of namespaceMap) {
    core.info(`Checking for new resource types in ${serviceKey}...`);

    const baseTypes = await getResourceTypesAtRef(
      git,
      mergeBase,
      namespacePath,
      repoRoot,
    );

    // Skip namespace if it doesn't exist in base (brand new RP — handled by RP-level detection)
    if (baseTypes === null) {
      core.info(` ${namespace}: no resources in base (new namespace), skipping RT detection`);
      continue;
    }

    const headTypes = await getResourceTypesAtRef(
      git,
      "HEAD",
      namespacePath,
      repoRoot,
    );

    const newTypes = [];
    for (const [type, info] of (headTypes ?? new Map())) {
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
