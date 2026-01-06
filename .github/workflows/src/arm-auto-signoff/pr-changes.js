/**
 * JSON representation of the change flags.
 *
 * All properties are boolean flags that indicate presence of a change type.
 * An empty PR would have all properties set to false.
 *
 * @typedef {Object} PullRequestChangesJSON
 * @property {boolean} rmDocumentation - True if PR contains resource-manager scoped documentation (.md) changes
 * @property {boolean} rmExamples - True if PR contains resource-manager scoped example changes (/examples/*.json)
 * @property {boolean} rmFunctional - True if PR contains resource-manager scoped functional spec changes (API-impacting)
 * @property {boolean} rmOther - True if PR contains other resource-manager scoped changes (non-trivial)
 * @property {boolean} other - True if PR contains changes outside resource-manager (blocks ARM auto-signoff)
 */

/**
 * Represents the types of changes present in a pull request.
 */
export class PullRequestChanges {
  /** @type {boolean} */
  rmDocumentation = false;

  /** @type {boolean} */
  rmExamples = false;

  /** @type {boolean} */
  rmFunctional = false;

  /** @type {boolean} */
  rmOther = false;

  /** @type {boolean} */
  other = false;

  /**
   * A PR is trivial if it contains only:
   * - Documentation changes
   * - Example changes
   * and does NOT contain:
   * - Functional spec changes
   * - Other file types
   *
   * @returns {boolean}
   */
  isTrivial() {
    const hasNoBlockingChanges = !this.rmFunctional && !this.rmOther && !this.other;
    const hasTrivialChanges = this.rmDocumentation || this.rmExamples;
    return hasNoBlockingChanges && hasTrivialChanges;
  }

  /**
   * @returns {boolean}
   */
  isDocumentationOnly() {
    return (
      this.rmDocumentation &&
      !this.rmExamples &&
      !this.rmFunctional &&
      !this.rmOther &&
      !this.other
    );
  }

  /**
   * @returns {boolean}
   */
  isExamplesOnly() {
    return (
      !this.rmDocumentation &&
      this.rmExamples &&
      !this.rmFunctional &&
      !this.rmOther &&
      !this.other
    );
  }

  /**
   * Ensure stable JSON output even though this is a class.
   * @returns {PullRequestChangesJSON}
   */
  toJSON() {
    return {
      rmDocumentation: this.rmDocumentation,
      rmExamples: this.rmExamples,
      rmFunctional: this.rmFunctional,
      rmOther: this.rmOther,
      other: this.other,
    };
  }
}
