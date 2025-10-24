# `Summarize Impact`

This tool models the PR and produces an artifact that is consumed by the `summarize-checks` check.

The schema of the artifact looks like:

```typescript
export type ImpactAssessment = {
  prType: string[];
  resourceManagerRequired: boolean;
  suppressionReviewRequired: boolean;
  versioningReviewRequired: boolean;
  breakingChangeReviewRequired: boolean;
  isNewApiVersion: boolean;
  rpaasExceptionRequired: boolean;
  rpaasRpNotInPrivateRepo: boolean;
  rpaasChange: boolean;
  newRP: boolean;
  rpaasRPMissing: boolean;
  typeSpecChanged: boolean;
  isDraft: boolean;
  labelContext: LabelContext;
};
```
