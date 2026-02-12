export enum PRType {
  DataPlane = "data-plane",
  ResourceManager = "resource-manager",
}

/**
 * The LabelContext is used by prSummary.ts / summary() and downstream invocations.
 *
 * The "present" set represents the set of labels that are currently present on the PR
 * processed by given invocation of summary(). It is obtained via GitHub Octokit API at the beginning
 * of summary().
 *
 * The "toAdd" set is the set of labels to be added to the PR at the end of invocation of summary().
 * This is to be done by calling GitHub Octokit API to add the labels.
 *
 * The "toRemove" set is analogous to "toAdd" set, but instead it is the set of labels to be removed.
 *
 * The general pattern used in the code to populate "toAdd" or "toRemove" sets to be ready for
 * Octokit invocation is as follows:
 *
 * - the summary() function passes the context through its invocation chain.
 * - given function responsible for given label, like e.g. for label "ARMReview",
 *   creates a new instance of Label: const armReviewLabel = new Label("ARMReview", labelContext.present)
 * - the function then processes the label to determine if armReviewLabel.shouldBePresent is to be set to true or false.
 * - the function at the end of its invocation calls armReviewLabel.applyStateChanges(labelContext.toAdd, labelContext.toRemove)
 *   to update the sets.
 * - the function may optionally return { armReviewLabel.shouldBePresent } to allow the caller to pass this value
 *   further to downstream business logic that depends on it.
 * - at the end of invocation summary() calls Octokit passing it as input labelContext.toAdd and labelContext.toRemove.
 *
 * todo: this type is duplicated in JSDoc over in summarize-checks.js
 */
export type LabelContext = {
  present: Set<string>;
  toAdd: Set<string>;
  toRemove: Set<string>;
};

export class Label {
  name: string;

  /** Is the label currently present on the pull request?
   *
   * This is determined at the time of construction of this object.
   */
  present?: boolean;

  /** Should this label be present on the pull request?
   *
   * Must be defined before applyStateChange is called.
   *
   * Not set at the construction time to facilitate determining desired presence
   * of multiple labels in single code block, without intermixing it with
   * label construction logic.
   */
  shouldBePresent: boolean | undefined = undefined;

  constructor(name: string) {
    this.name = name;
  }

  /**
   * If the label should be added, add its name to labelsToAdd.
   * If the label should be removed, add its name to labelsToRemove.
   * Otherwise, do nothing.
   *
   * Precondition: this.shouldBePresent has been defined.
   */
  applyStateChange(labelsToAdd: Set<string>, labelsToRemove: Set<string>): void {
    if (this.shouldBePresent === undefined) {
      console.warn(
        "ASSERTION VIOLATION! " +
          `Cannot applyStateChange for label '${this.name}' ` +
          "as its desired presence hasn't been defined. Returning early.",
      );
      return;
    }

    if (!this.present && this.shouldBePresent) {
      if (!labelsToAdd.has(this.name)) {
        console.log(
          `Label.applyStateChange: '${this.name}' was not present and should be present. Scheduling addition.`,
        );
        labelsToAdd.add(this.name);
      } else {
        console.log(
          `Label.applyStateChange: '${this.name}' was not present and should be present. It is already scheduled for addition.`,
        );
      }
    } else if (this.present && !this.shouldBePresent) {
      if (!labelsToRemove.has(this.name)) {
        console.log(
          `Label.applyStateChange: '${this.name}' was present and should not be present. Scheduling removal.`,
        );
        labelsToRemove.add(this.name);
      } else {
        console.log(
          `Label.applyStateChange: '${this.name}' was present and should not be present. It is already scheduled for removal.`,
        );
      }
    } else if (this.present === this.shouldBePresent) {
      console.log(
        `Label.applyStateChange: '${this.name}' is ${this.present ? "present" : "not present"}. This is the desired state.`,
      );
    } else {
      console.warn(
        "ASSERTION VIOLATION! " +
          `Label.applyStateChange: '${this.name}' is ${this.present ? "present" : "not present"} while it should be ${this.shouldBePresent ? "present" : "not present"}. ` +
          `At this point of execution this should not happen.`,
      );
    }
  }

  isEqualToOrPrefixOf(label: string): boolean {
    return this.name.endsWith("*") ? label.startsWith(this.name.slice(0, -1)) : this.name === label;
  }

  logString(): string {
    return (
      `Label: name: ${this.name}, ` +
      `present: ${this.present}, ` +
      `shouldBePresent: ${this.shouldBePresent}. `
    );
  }
}
