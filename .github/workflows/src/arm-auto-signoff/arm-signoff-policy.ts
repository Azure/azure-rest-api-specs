import {
  ArmAutoSignoffLabel,
  autoSignoffMarkers,
  legacyAutoSignoffMarkers,
} from "./arm-auto-signoff-labels.ts";
import {
  getLatestSemanticReviewStatus,
  getSemanticReviewOutcome,
  SemanticReviewOutcome,
  type CommitStatus,
} from "./arm-semantic-review.ts";

/** Project automation-owned approval from current-head evidence, preserving human approvals. */
export function evaluateArmSignoff(labels: string[], statuses: CommitStatus[]): string[] {
  const desired = new Set(labels);
  const has = (label: string) => desired.has(label);
  if (has(ArmAutoSignoffLabel.ArmSignedOff) && !autoSignoffMarkers.some(has)) {
    return labels;
  }

  const ready = has("ARMReview") && !has("NotReadyForARMReview");
  const outcome = getSemanticReviewOutcome(getLatestSemanticReviewStatus(statuses));
  if (ready && outcome === SemanticReviewOutcome.ManualReviewRequired) {
    desired.add(ArmAutoSignoffLabel.ArmManualSignoffRequired);
  }
  const eligible =
    ready &&
    outcome === SemanticReviewOutcome.Passed &&
    !has("ARMChangesRequested") &&
    !has(ArmAutoSignoffLabel.ArmManualSignoffRequired) &&
    (!has("SuppressionReviewRequired") || has("Approved-Suppression")) &&
    ["Swagger LintDiff", "Swagger Avocado"].every(
      (name) =>
        statuses.find((status) => status.context.toLowerCase() === name.toLowerCase())?.state ===
        "success",
    );

  for (const label of [ArmAutoSignoffLabel.ArmSignedOff, ArmAutoSignoffLabel.ArmAutoSignedOff]) {
    if (eligible) desired.add(label);
    else desired.delete(label);
  }
  for (const label of legacyAutoSignoffMarkers) desired.delete(label);
  return [...desired];
}
