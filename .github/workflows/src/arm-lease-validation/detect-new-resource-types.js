/**
 * Detect new ARM resource types in PRs by parsing swagger paths.
 *
 * Compares resource types between the base branch and HEAD for existing RPs
 * to identify newly introduced resource types that require ARM lease validation.
 */

import { simpleGit } from "simple-git";

// Match pattern: specification/<orgName>/resource-manager/<RPNamespace>/...
const RESOURCE_MANAGER_PATTERN = new RegExp(
  String.raw`^specification/[^/]+/resource-manager/([^/]+)/`,
);

const RESOURCE_TYPE_REGEX = new RegExp(String.raw`/providers/([^/?#]+)(/[^?#]*)?`);

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
 * Get all ARM resource types from a swagger document by parsing paths.
 *
 * Scans paths for ARM resource patterns like /providers/Microsoft.X/resourceTypes.
 *
 * @param {{paths?: Record<string, Record<string, unknown>>}} swaggerDoc - Parsed swagger JSON document
 * @returns {Map<string, {resourceType: string, provider: string, modelName: string|null, operations: Array<{method: string, apiPath: string}>}>}
 */
function getResourceTypesFromSwagger(swaggerDoc) {
  /** @type {Map<string, {resourceType: string, provider: string, modelName: string|null, operations: {method: string, apiPath: string}[]}>} */
  const resourceTypes = new Map();

  if (!swaggerDoc.paths) {
    return resourceTypes;
  }

  const paths = swaggerDoc.paths;
  for (const [apiPath, pathItem] of Object.entries(paths)) {
    const resourceType = getResourceType(apiPath);
    if (!resourceType || !resourceType.includes("/")) continue;

    const parts = resourceType.split("/");
    // Skip operations-only paths (e.g. Microsoft.Compute/operations)
    if (parts[parts.length - 1].toLowerCase() === "operations") continue;

    /** @type {Array<{method: string, apiPath: string}>} */
    const ops = Object.entries(pathItem)
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

  return resourceTypes;
}

/**
 * Get resource types from swagger files at a specific git ref.
 *
 * @param {import("simple-git").SimpleGit} git
 * @param {string} gitRef - Git ref (e.g. "HEAD" or "HEAD^")
 * @param {string} namespacePath - e.g. `specification/compute/resource-manager/Microsoft.Compute`
 * @param {string} branchName - Branch name for logging (e.g. "base" or "head")
 * @returns {Promise<Map<string, Object> | null>} Map of resource type to info, or null if path doesn't exist at this ref
 */
async function getResourceTypesAtRef(git, gitRef, namespacePath, branchName) {
  /** @type {Map<string, {resourceType: string, provider: string, modelName: string|null, operations: {method: string, apiPath: string}[]}>} */
  const allTypes = new Map();

  let output;
  try {
    output = await git.raw(["ls-tree", "-r", "--name-only", gitRef, namespacePath]);
  } catch {
    return null; // path doesn't exist at this ref
  }

  const swaggerFiles = output
    .split("\n")
    .filter((f) => f.trim() && f.endsWith(".json") && !f.includes("/examples/"))
    .filter((f, index, self) => self.indexOf(f) === index); // deduplicate

  const total = swaggerFiles.length;
  if (total > 0) {
    console.log(
      `Analyzing ${total} swagger files in ${branchName} branch (${gitRef}) for comparison...`,
    );
  }

  // Iterate over files, but only log summary if it's too much
  for (let i = 0; i < swaggerFiles.length; i++) {
    const file = swaggerFiles[i];
    if (total > 10 && i % 20 === 0 && i > 0) {
      console.log(`Progress: ${i}/${total} files processed...`);
    }

    let content;
    try {
      content = await git.show([`${gitRef}:${file.trim()}`]);
    } catch {
      // Intentionally quiet to avoid log spam during comparison
      continue;
    }

    try {
      const parsed = /** @type {unknown} */ (JSON.parse(content));
      const swaggerDoc = /** @type {{paths?: Record<string, Record<string, unknown>>}} */ (parsed);
      // Skip files that aren't ARM resource-manager specs (minimal check)
      if (!swaggerDoc.paths) continue;
      const types = getResourceTypesFromSwagger(swaggerDoc);
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
 * @param {string[]} params.rmFiles - Resource-manager file paths changed in the PR
 * @param {import("@actions/core")} params.core - GitHub Actions core for logging
 * @returns {Promise<Array<{rpNamespace: string, orgName: string, newResourceTypes: Array<{resourceType: string, provider: string, modelName: string|null, operations: string[]}>}>>}
 */
export async function detectNewResourceTypes({ repoRoot, rmFiles, core }) {
  const git = simpleGit(repoRoot);

  // Group changed RM swagger files by service subdirectory (rpNamespace + serviceName)
  /** @type {Map<string, {orgName: string, namespacePath: string, rpNamespace: string}>} */
  const namespaceMap = new Map();

  for (const file of rmFiles) {
    // Use RESOURCE_MANAGER_PATTERN to ensure the file is inside a rpNamespace directory
    // (the trailing "/" in the pattern requires at least one path component after the rpNamespace)
    const rmMatch = file.match(RESOURCE_MANAGER_PATTERN);
    if (!rmMatch) continue;

    const parts = file.split("/");
    const orgName = parts[1];
    const rpNamespace = parts[3];
    // Check if parts[4] is an actual service name (e.g. DiskRP) vs lifecycle folder (stable/preview)
    // If it's stable/preview, compare at rpNamespace root to avoid false negatives when
    // introducing the first preview/stable folder under an existing rpNamespace
    const serviceName = parts[4];
    const isLifecycleFolder = serviceName === "stable" || serviceName === "preview";
    const namespacePath = isLifecycleFolder
      ? `specification/${orgName}/resource-manager/${rpNamespace}`
      : `specification/${orgName}/resource-manager/${rpNamespace}/${serviceName}`;
    const serviceKey = isLifecycleFolder ? rpNamespace : `${rpNamespace}/${serviceName}`;

    if (!namespaceMap.has(serviceKey)) {
      namespaceMap.set(serviceKey, { orgName, namespacePath, rpNamespace });
    }
  }

  const results = [];

  for (const [serviceKey, { orgName, namespacePath, rpNamespace }] of namespaceMap) {
    core.info(`Checking for new resource types in ${serviceKey}...`);

    const baseTypes = await getResourceTypesAtRef(git, "HEAD^", namespacePath, "base");

    // Skip rpNamespace if it doesn't exist in base (brand new RP — handled by RP-level detection)
    if (baseTypes === null) {
      core.info(` ${rpNamespace}: no resources in base (new rpNamespace), skipping RT detection`);
      continue;
    }

    const headTypes = await getResourceTypesAtRef(git, "HEAD", namespacePath, "head");

    const newTypes = [];
    /** @type {Map<string, {resourceType: string, provider: string, modelName: string|null, operations: {method: string, apiPath: string}[]}>} */
    const typedHeadTypes = headTypes ?? new Map();
    for (const [type, info] of typedHeadTypes) {
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
      core.info(` ${rpNamespace}: ${newTypes.length} new resource type(s) detected`);
      for (const t of newTypes) {
        core.info(`  - ${t.resourceType} (${t.operations.join(", ")})`);
      }
      results.push({ rpNamespace, orgName, newResourceTypes: newTypes });
    } else {
      core.info(` ${rpNamespace}: no new resource types`);
    }
  }

  return results;
}
