/**
 * ARM lease validation label names.
 */
export const ArmLeaseValidationLabel = Object.freeze({
  ArmModelingReviewRequired: "ARMModelingReviewRequired",
  ArmModelingSignedOff: "ARMModelingSignedOff",
  ArmModelingAutoSignedOff: "ARMModelingAutoSignedOff",
});
export type ArmLeaseValidationLabel =
  (typeof ArmLeaseValidationLabel)[keyof typeof ArmLeaseValidationLabel];
