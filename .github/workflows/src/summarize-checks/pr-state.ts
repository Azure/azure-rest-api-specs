import { ARM_INITIAL_REVIEW_REQUESTED_LABEL } from "../arm-auto-signoff/arm-auto-signoff-labels.ts";
import { evaluateArmSignoff } from "../arm-auto-signoff/arm-signoff-policy.ts";
import type { CommitStatus } from "../arm-auto-signoff/arm-semantic-review.ts";
import { processImpactAssessment, type ImpactAssessment, type LabelContext } from "./labelling.ts";

export interface PrStatePlan {
  labels: string[];
  labelsToAdd: string[];
  labelsToRemove: string[];
  requestInitialArmReview: boolean;
}

export function projectImpactLabels(
  existingLabels: string[],
  impactAssessment: ImpactAssessment | undefined,
): LabelContext {
  const labels: LabelContext = {
    present: new Set(existingLabels),
    toAdd: new Set(),
    toRemove: new Set(),
  };
  if (impactAssessment) processImpactAssessment(labels, impactAssessment);
  return labels;
}

function projectedLabels(labels: LabelContext): string[] {
  return [...new Set([...labels.present, ...labels.toAdd])].filter(
    (label) => !labels.toRemove.has(label),
  );
}

/** Compute intake, approval, and queue labels before publishing any part of the PR state. */
export function evaluatePrState(
  existingLabels: string[],
  impactAssessment: ImpactAssessment | undefined,
  statuses: CommitStatus[],
): PrStatePlan {
  const classified = projectedLabels(projectImpactLabels(existingLabels, impactAssessment));
  const signedOff = evaluateArmSignoff(classified, statuses);
  // Queue labels depend on the approval just calculated, not on the old live labels.
  const labels = projectedLabels(projectImpactLabels(signedOff, impactAssessment));
  return {
    labels,
    labelsToAdd: labels.filter((label) => !existingLabels.includes(label)),
    labelsToRemove: existingLabels.filter((label) => !labels.includes(label)),
    requestInitialArmReview:
      impactAssessment !== undefined &&
      !impactAssessment.isDraft &&
      labels.includes("ARMReview") &&
      labels.includes("WaitForARMFeedback") &&
      ![
        ARM_INITIAL_REVIEW_REQUESTED_LABEL,
        "NotReadyForARMReview",
        "ARMChangesRequested",
        "ARMManualSignoffRequired",
        "ARMSignedOff",
        "skip-arm-review",
      ].some((label) => labels.includes(label)),
  };
}
