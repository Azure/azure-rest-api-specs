/**
 * Utilities for identifying and extracting ARM resource types from OpenAPI/swagger paths.
 *
 * This module is intentionally dependency-free so that it can be used by any workflow
 * (arm-modeling-review, arm-auto-signoff, etc.) without pulling in heavy tooling.
 */

/**
 * Regex that isolates the provider namespace and optional path hierarchy from an API path.
 *
 * Examples:
 *   /subscriptions/{id}/providers/Microsoft.Compute/virtualMachines/{name}
 *     → provider = "Microsoft.Compute", typeHierarchy = "/virtualMachines/{name}"
 *   /providers/Microsoft.Compute/operations
 *     → provider = "Microsoft.Compute", typeHierarchy = "/operations"
 */
const RESOURCE_TYPE_REGEX = /\/providers\/([^/?#]+)(\/[^?#]*)?/;

/**
 * ARM path patterns that scope a resource to a subscription / resource group.
 */
const SUBSCRIPTION_SCOPE_REGEX = /^\/subscriptions\//i;
const RESOURCE_GROUP_SCOPE_REGEX = /^\/subscriptions\/[^/]+\/resourceGroups\//i;

/**
 * Extract the ARM resource type from an OpenAPI API path.
 *
 * Strips path parameters (segments wrapped in `{}`) and returns the static resource
 * type hierarchy, e.g.:
 *
 *   /subscriptions/{id}/resourceGroups/{rg}/providers/Microsoft.Compute/virtualMachines/{name}
 *     → "Microsoft.Compute/virtualMachines"
 *
 *   /subscriptions/{id}/providers/Microsoft.Compute/virtualMachines/{name}/extensions/{ext}
 *     → "Microsoft.Compute/virtualMachines/extensions"
 *
 *   /providers/Microsoft.Compute/operations
 *     → "Microsoft.Compute/operations"
 *
 * Returns `null` when no `/providers/` segment is found.
 *
 * @param {string} apiPath - OpenAPI path string (e.g. from the `paths` object)
 * @returns {string | null} Resource type in the form "Namespace/resourceType[/childType…]",
 *   or `null` if the path contains no provider segment.
 */
export function getResourceType(apiPath) {
  const match = apiPath.match(RESOURCE_TYPE_REGEX);
  if (!match) return null;

  const provider = /** @type {string} */ (match[1]);
  const typeHierarchy = /** @type {string | undefined} */ (match[2]);
  if (!typeHierarchy) return provider;

  // typeHierarchy starts with "/" (e.g. "/virtualMachines/{vmName}/extensions/{extName}").
  // Keep only static (non-parameter) segments.
  const staticSegments = typeHierarchy
    .split("/")
    .filter((segment) => segment.length > 0 && !segment.startsWith("{"));

  if (staticSegments.length === 0) return provider;

  return provider + "/" + staticSegments.join("/");
}

/**
 * Return `true` when the API path represents an ARM *operations list* endpoint —
 * i.e. the last static path segment is exactly `"operations"`.
 *
 * These endpoints are not resource types and should be excluded from detection.
 *
 * @param {string} resourceType - Value returned by {@link getResourceType}
 * @returns {boolean}
 */
export function isOperationsPath(resourceType) {
  const parts = resourceType.split("/");
  return parts[parts.length - 1].toLowerCase() === "operations";
}

/**
 * Return `true` when the API path is scoped to a resource group.
 *
 * @param {string} apiPath
 * @returns {boolean}
 */
export function isResourceGroupScoped(apiPath) {
  return RESOURCE_GROUP_SCOPE_REGEX.test(apiPath);
}

/**
 * Return `true` when the API path is scoped to a subscription (but not a resource group).
 *
 * @param {string} apiPath
 * @returns {boolean}
 */
export function isSubscriptionScoped(apiPath) {
  return SUBSCRIPTION_SCOPE_REGEX.test(apiPath) && !RESOURCE_GROUP_SCOPE_REGEX.test(apiPath);
}
