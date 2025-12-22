/**
 * Represents the types of changes present in a pull request.
 *
 * All properties are boolean flags that indicate presence of a change type.
 * An empty PR would have all properties set to false.
 *
 * @typedef {Object} PullRequestChanges
 * @property {boolean} rmDocumentation - True if PR contains resource-manager scoped documentation (.md) changes
 * @property {boolean} rmExamples - True if PR contains resource-manager scoped example changes (/examples/*.json)
 * @property {boolean} rmFunctional - True if PR contains resource-manager scoped functional spec changes (API-impacting)
 * @property {boolean} rmOther - True if PR contains other resource-manager scoped changes (non-trivial)
 * @property {boolean} other - True if PR contains changes outside resource-manager (blocks ARM auto-signoff)
 */

/**
 * Creates a PullRequestChanges object with all flags set to false
 * @returns {PullRequestChanges}
 */
export function createEmptyPullRequestChanges() {
  return {
    rmDocumentation: false,
    rmExamples: false,
    rmFunctional: false,
    rmOther: false,
    other: false,
  };
}

/**
 * Checks if a PR qualifies as trivial based on its changes
 * A PR is trivial if it contains only:
 * - Documentation changes
 * - Example changes
 * And does NOT contain:
 * - Functional spec changes
 * - Other file types
 *
 * @param {PullRequestChanges} changes - The PR changes object
 * @returns {boolean} - True if PR is trivial
 */
export function isTrivialPullRequest(changes) {
  // Trivial if no functional changes and no other files
  // Must have at least one of: documentation, examples
  const hasNoBlockingChanges =
    !changes.rmFunctional && !changes.rmOther && !changes.other;
  const hasTrivialChanges = changes.rmDocumentation || changes.rmExamples;

  return hasNoBlockingChanges && hasTrivialChanges;
}

/**
 * Checks if a PR contains only documentation changes
 * @param {PullRequestChanges} changes - The PR changes object
 * @returns {boolean} - True if only documentation changed
 */
export function isDocumentationOnly(changes) {
  return (
    changes.rmDocumentation &&
    !changes.rmExamples &&
    !changes.rmFunctional &&
    !changes.rmOther &&
    !changes.other
  );
}

/**
 * Checks if a PR contains only example changes
 * @param {PullRequestChanges} changes - The PR changes object
 * @returns {boolean} - True if only examples changed
 */
export function isExamplesOnly(changes) {
  return (
    !changes.rmDocumentation &&
    changes.rmExamples &&
    !changes.rmFunctional &&
    !changes.rmOther &&
    !changes.other
  );
}
