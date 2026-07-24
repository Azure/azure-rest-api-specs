export type ImpactAssessment = {
  resourceManagerRequired: boolean;
  dataPlaneRequired: boolean;
  suppressionReviewRequired: boolean;
  typeSpecSuppressionReviewRequired: boolean;
  isNewApiVersion: boolean;
  rpaasRpNotInPrivateRepo: boolean;
  rpaasChange: boolean;
  newRP: boolean;
  rpaasRPMissing: boolean;
  typeSpecChanged: boolean;
  isDraft: boolean;
  targetBranch: string;
};
