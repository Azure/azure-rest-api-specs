/**
 * Represents a GitHub label.
 * Currently used in the context of processing
 * labels related to the review workflow of PRs submitted to
 * Azure/azure-rest-api-specs and Azure/azure-rest-api-specs-pr repositories.
 * This processing happens in the prSummary.ts / summary() function.
 *
 * See also: https://aka.ms/SpecPRReviewARMInvariants
 */
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

  constructor(name: string, presentLabels?: Set<string>) {
    this.name = name;
    this.present = presentLabels?.has(this.name) ?? undefined;
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

export function anyLabelMatches(labelsToMatchAgainst: string[], inputLabels: string[]): boolean {
  return getMatchingLabelIfAny(labelsToMatchAgainst, inputLabels) !== undefined;
}

export function getMatchingLabelIfAny(
  labelsToMatchAgainst: string[],
  inputLabels: string[],
): string | undefined {
  const matchingLabel: string | undefined = labelsToMatchAgainst.find((labelToMatchAgainstStr) => {
    const labelToMatchAgainst = new Label(labelToMatchAgainstStr);
    return inputLabels.some((inputLabel) => labelToMatchAgainst.isEqualToOrPrefixOf(inputLabel));
  });

  return matchingLabel;
}
