import { logMessage, logWarning } from "../log.js";

/**
 * Represents a GitHub label.
 * Currently used in the context of processing
 * labels related to the review workflow of PRs submitted to
 * Azure/azure-rest-api-specs and Azure/azure-rest-api-specs-pr repositories.
 * This processing happens in the prSummary.ts / summary() function.
 *
 * See also: https://aka.ms/SpecPRReviewARMInvariants
 */
export interface Label {
  readonly name: string;

  /** Is the label currently present on the pull request?
   *
   * This is determined at the time of construction of this object.
   */
  readonly present?: boolean;

  /** Should this label be present on the pull request?
   *
   * Must be defined before applyStateChange is called.
   *
   * Not set at the construction time to facilitate determining desired presence
   * of multiple labels in single code block, without intermixing it with
   * label construction logic.
   */
  readonly shouldBePresent?: boolean;
}

/**
 * Creates a new Label object
 */
export function createLabel(name: string, presentLabels?: Set<string>): Label {
  return {
    name,
    present: presentLabels?.has(name),
    shouldBePresent: undefined,
  };
}

/**
 * Updates a label with the desired presence state
 */
export function setLabelShouldBePresent(label: Label, shouldBePresent: boolean): Label {
  return {
    ...label,
    shouldBePresent,
  };
}

/**
 * If the label should be added, add its name to labelsToAdd.
 * If the label should be removed, add its name to labelsToRemove.
 * Otherwise, do nothing.
 *
 * Precondition: label.shouldBePresent has been defined.
 */
export function applyLabelStateChange(
  label: Label,
  labelsToAdd: Set<string>,
  labelsToRemove: Set<string>,
): void {
  if (label.shouldBePresent === undefined) {
    logWarning(
      "ASSERTION VIOLATION! " +
        `Cannot applyStateChange for label '${label.name}' ` +
        "as its desired presence hasn't been defined. Returning early.",
    );
    return;
  }

  if (!label.present && label.shouldBePresent) {
    if (!labelsToAdd.has(label.name)) {
      logMessage(
        `Label.applyStateChange: '${label.name}' was not present and should be present. Scheduling addition.`,
      );
      labelsToAdd.add(label.name);
    } else {
      logMessage(
        `Label.applyStateChange: '${label.name}' was not present and should be present. It is already scheduled for addition.`,
      );
    }
  } else if (label.present && !label.shouldBePresent) {
    if (!labelsToRemove.has(label.name)) {
      logMessage(
        `Label.applyStateChange: '${label.name}' was present and should not be present. Scheduling removal.`,
      );
      labelsToRemove.add(label.name);
    } else {
      logMessage(
        `Label.applyStateChange: '${label.name}' was present and should not be present. It is already scheduled for removal.`,
      );
    }
  } else if (label.present === label.shouldBePresent) {
    logMessage(
      `Label.applyStateChange: '${label.name}' is ${label.present ? "present" : "not present"}. This is the desired state.`,
    );
  } else {
    logWarning(
      "ASSERTION VIOLATION! " +
        `Label.applyStateChange: '${label.name}' is ${label.present ? "present" : "not present"} while it should be ${label.shouldBePresent ? "present" : "not present"}. ` +
        `At this point of execution this should not happen.`,
    );
  }
}

/**
 * Checks if the label name is equal to or a prefix of the given label string
 */
export function isLabelEqualToOrPrefixOf(label: Label, labelString: string): boolean {
  return label.name.endsWith("*")
    ? labelString.startsWith(label.name.slice(0, -1))
    : label.name === labelString;
}

/**
 * Returns a log string representation of the label
 */
export function getLabelLogString(label: Label): string {
  return (
    `Label: name: ${label.name}, ` +
    `present: ${label.present}, ` +
    `shouldBePresent: ${label.shouldBePresent}. `
  );
}

export function anyLabelMatches(labelsToMatchAgainst: string[], inputLabels: string[]): boolean {
  return getMatchingLabelIfAny(labelsToMatchAgainst, inputLabels) !== undefined;
}

export function getMatchingLabelIfAny(
  labelsToMatchAgainst: string[],
  inputLabels: string[],
): string | undefined {
  const matchingLabel: string | undefined = labelsToMatchAgainst.find((labelToMatchAgainstStr) => {
    const labelToMatchAgainst = createLabel(labelToMatchAgainstStr);
    return inputLabels.some((inputLabel) =>
      isLabelEqualToOrPrefixOf(labelToMatchAgainst, inputLabel),
    );
  });

  return matchingLabel;
}
