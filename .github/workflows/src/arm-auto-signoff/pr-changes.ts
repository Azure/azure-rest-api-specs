/**
 * Represents the types of changes present in a pull request.
 */
export class PullRequestChanges {
  rmDocumentation: boolean = false;

  rmExamples: boolean = false;

  rmTypeSpec: boolean = false;

  rmFunctional: boolean = false;

  rmOther: boolean = false;

  other: boolean = false;

  /**
   * A PR is trivial if it contains only:
   * - Documentation changes
   * - Example changes
   * - TypeSpec file changes (.tsp, tspconfig.yaml)
   * and does NOT contain:
   * - Functional spec changes
   * - Other file types
   */
  isTrivial(): boolean {
    const hasNoBlockingChanges = !this.rmFunctional && !this.rmOther && !this.other;
    const hasTrivialChanges = this.rmDocumentation || this.rmExamples || this.rmTypeSpec;
    return hasNoBlockingChanges && hasTrivialChanges;
  }

  isDocumentationOnly(): boolean {
    return (
      this.rmDocumentation &&
      !this.rmExamples &&
      !this.rmTypeSpec &&
      !this.rmFunctional &&
      !this.rmOther &&
      !this.other
    );
  }

  isExamplesOnly(): boolean {
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
