/**
 * Represents the types of changes present in a pull request.
 */
export class PullRequestChanges {
  /** @type {boolean} */
  rmDocumentation = false;

  /** @type {boolean} */
  rmExamples = false;

  /** @type {boolean} */
  rmTypeSpec = false;

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
   * - TypeSpec file changes (.tsp, tspconfig.yaml)
   * and does NOT contain:
   * - Functional spec changes
   * - Other file types
   *
   * @returns {boolean}
   */
  isTrivial() {
    const hasNoBlockingChanges = !this.rmFunctional && !this.rmOther && !this.other;
    const hasTrivialChanges = this.rmDocumentation || this.rmExamples || this.rmTypeSpec;
    return hasNoBlockingChanges && hasTrivialChanges;
  }

  /**
   * @returns {boolean}
   */
  isDocumentationOnly() {
    return (
      this.rmDocumentation &&
      !this.rmExamples &&
      !this.rmTypeSpec &&
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
      !this.rmTypeSpec &&
      !this.rmFunctional &&
      !this.rmOther &&
      !this.other
    );
  }
}
