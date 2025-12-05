/**
 * Represents the types of changes present in a pull request.
 * 
 * All properties are boolean flags that indicate presence of a change type.
 * An empty PR would have all properties set to false.
 * 
 * @typedef {Object} PullRequestChanges
 * @property {boolean} documentation - True if PR contains documentation (.md) file changes
 * @property {boolean} examples - True if PR contains example file changes (/examples/*.json)
 * @property {boolean} functional - True if PR contains functional spec changes (API-impacting)
 * @property {boolean} nonFunctional - True if PR contains non-functional spec changes (metadata only)
 * @property {boolean} other - True if PR contains other file types (config, scripts, etc.)
 */

/**
 * Creates a PullRequestChanges object with all flags set to false
 * @returns {PullRequestChanges}
 */
export function createEmptyPullRequestChanges() {
  return {
    documentation: false,
    examples: false,
    functional: false,
    nonFunctional: false,
    other: false,
  };
}

/**
 * Checks if a PR qualifies as trivial based on its changes
 * A PR is trivial if it contains only:
 * - Documentation changes
 * - Example changes
 * - Non-functional spec changes
 * And does NOT contain:
 * - Functional spec changes
 * - Other file types
 * 
 * @param {PullRequestChanges} changes - The PR changes object
 * @returns {boolean} - True if PR is trivial
 */
export function isTrivialPullRequest(changes) {
  // Trivial if no functional changes and no other files
  // Must have at least one of: documentation, examples, or nonFunctional
  const hasNoBlockingChanges = !changes.functional && !changes.other;
  const hasTrivialChanges = changes.documentation || changes.examples || changes.nonFunctional;
  
  return hasNoBlockingChanges && hasTrivialChanges;
}

/**
 * Checks if a PR contains only documentation changes
 * @param {PullRequestChanges} changes - The PR changes object
 * @returns {boolean} - True if only documentation changed
 */
export function isDocumentationOnly(changes) {
  return changes.documentation && 
    !changes.examples && 
    !changes.functional && 
    !changes.nonFunctional && 
    !changes.other;
}

/**
 * Checks if a PR contains only example changes
 * @param {PullRequestChanges} changes - The PR changes object
 * @returns {boolean} - True if only examples changed
 */
export function isExamplesOnly(changes) {
  return !changes.documentation && 
    changes.examples && 
    !changes.functional && 
    !changes.nonFunctional && 
    !changes.other;
}

/**
 * Checks if a PR contains only non-functional spec changes (with optional docs/examples)
 * @param {PullRequestChanges} changes - The PR changes object
 * @returns {boolean} - True if only non-functional changes (+ optional docs/examples)
 */
export function isNonFunctionalOnly(changes) {
  return changes.nonFunctional && 
    !changes.functional && 
    !changes.other;
}
