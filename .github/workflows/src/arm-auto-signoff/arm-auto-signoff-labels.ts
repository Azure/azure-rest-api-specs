/**
 * ARM auto-signoff label names.
 */
export const ArmAutoSignoffLabel = Object.freeze({
  ArmSignedOff: "ARMSignedOff",
  ArmManualSignoffRequired: "ARMManualSignoffRequired",
  ArmAutoSignedOff: "ARMAutoSignedOff",
  ArmAutoSignedOffTest: "ARMAutoSignedOff-Test",
  ArmAutoSignedOffIncrementalTSP: "ARMAutoSignedOff-IncrementalTSP",
  ArmAutoSignedOffTrivial: "ARMAutoSignedOff-Trivial",
});
export type ArmAutoSignoffLabel = (typeof ArmAutoSignoffLabel)[keyof typeof ArmAutoSignoffLabel];
