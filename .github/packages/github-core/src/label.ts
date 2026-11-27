export const LabelAction = Object.freeze({
  None: "none",
  Add: "add",
  Remove: "remove",
});
export type LabelAction = (typeof LabelAction)[keyof typeof LabelAction];
