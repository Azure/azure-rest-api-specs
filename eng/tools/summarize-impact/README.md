# `Summarize Impact`

This tool models the PR and produces an artifact that is consumed by the `summarize-checks` check.

The source directory must be checked out at the PR head and the target directory at its merge base
with the target branch. The merge-base commit must also be available in the source repository.
The workflow fetches full history to compute this baseline, excluding unrelated target-branch changes.

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
