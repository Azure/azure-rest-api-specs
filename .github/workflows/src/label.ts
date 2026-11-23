export const LabelAction = Object.freeze({
  None: "none",
  Add: "add",
  Remove: "remove",
});
export type LabelAction = (typeof LabelAction)[keyof typeof LabelAction];

export const TYPESPEC_SUPPRESSIONS_REVIEW_REQUIRED_LABEL = "typespec-suppressions-review-required";
export const TYPESPEC_SUPPRESSIONS_APPROVED_LABEL = "typespec-suppressions-approved";
export const CLIENT_CUSTOMIZATION_REVIEW_REQUIRED_LABEL = "client-customization-review-required";
export const CLIENT_CUSTOMIZATION_APPROVED_LABEL = "client-customization-approved";
