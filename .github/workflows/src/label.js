/**
 * @readonly
 * @enum {"none" | "add" | "remove"}
 */
export const LabelAction = Object.freeze({
  None: "none",
  Add: "add",
  Remove: "remove",
});

/**
 * ARM auto-signoff label names.
 * @readonly
 * @enum {string}
 */
export const ArmAutoSignoffLabel = Object.freeze({
  ArmSignedOff: "ARMSignedOff",
  ArmAutoSignedOff: "ARMAutoSignedOff",
  ArmAutoSignedOffIncrementalTSP: "ARMAutoSignedOff-IncrementalTSP",
  ArmAutoSignedOffTrivialTest: "ARMAutoSignedOff-Trivial-Test",
});