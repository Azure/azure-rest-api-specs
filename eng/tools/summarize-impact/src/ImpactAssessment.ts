import { LabelContext } from "./labelling-types.js";

export type ImpactAssessment = {
  resourceManagerRequired: boolean;
  suppressionReviewRequired: boolean;
  isNewApiVersion: boolean;
  rpaasExceptionRequired: boolean;
  rpaasRpNotInPrivateRepo: boolean;
  rpaasChange: boolean;
  newRP: boolean;
  rpaasRPMissing: boolean;
  typeSpecChanged: boolean;
  isDraft: boolean;
  labelContext: LabelContext;
  targetBranch: string;
};
