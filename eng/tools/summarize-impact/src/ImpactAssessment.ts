export type ImpactAssessment = {
  resourceManagerRequired: boolean;
  dataPlaneRequired: boolean;
  suppressionReviewRequired: boolean;
  isNewApiVersion: boolean;
  rpaasExceptionRequired: boolean;
  rpaasRpNotInPrivateRepo: boolean;
  rpaasChange: boolean;
  newRP: boolean;
  rpaasRPMissing: boolean;
  typeSpecChanged: boolean;
  isDraft: boolean;
  targetBranch: string;
};
