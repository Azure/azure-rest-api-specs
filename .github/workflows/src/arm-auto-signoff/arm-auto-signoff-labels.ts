/**
 * ARM auto-signoff label names.
 */
export const ArmAutoSignoffLabel = Object.freeze({
  ArmSignedOff: "ARMSignedOff",
  ArmManualSignoffRequired: "ARMManualSignoffRequired",
  ArmAutoSignedOff: "ARMAutoSignedOff",
  ArmAutoSignedOffIncrementalTSP: "ARMAutoSignedOff-IncrementalTSP",
  ArmAutoSignedOffTrivial: "ARMAutoSignedOff-Trivial",
});
export type ArmAutoSignoffLabel = (typeof ArmAutoSignoffLabel)[keyof typeof ArmAutoSignoffLabel];

/** Legacy markers from the retired auto-signoff workflow; replaced by `ARMAutoSignedOff`. */
export const legacyAutoSignoffMarkers: readonly ArmAutoSignoffLabel[] = Object.freeze([
  ArmAutoSignoffLabel.ArmAutoSignedOffIncrementalTSP,
  ArmAutoSignoffLabel.ArmAutoSignedOffTrivial,
]);

/**
 * Markers that make `ARMSignedOff` automation-owned. `ARMSignedOff` without any marker is a human
 * approval.
 */
export const autoSignoffMarkers: readonly ArmAutoSignoffLabel[] = Object.freeze([
  ArmAutoSignoffLabel.ArmAutoSignedOff,
  ...legacyAutoSignoffMarkers,
]);
