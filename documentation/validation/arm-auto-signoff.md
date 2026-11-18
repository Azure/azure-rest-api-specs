## Remaining Work
- [ARM Auto SignOff] Update for GA: https://github.com/Azure/azure-rest-api-specs/pull/33440

## Test PRs
- RM TSP: https://github.com/Azure/azure-rest-api-specs/pull/32545
- DP TSP: https://github.com/Azure/azure-rest-api-specs/pull/32694

## Issue Queries
```
base:main AND
is:pr AND
is:open AND
(label:ARMAutoSignedOff OR
 (label:TypeSpec AND
  label:ARMReview AND
  -label:NotReadyForARMReview AND
  (-label:SuppressionReviewRequired OR
   label:Approved-Suppression)))
```
https://github.com/Azure/azure-rest-api-specs/issues?q=base%3Amain%20AND%20is%3Apr%20AND%20is%3Aopen%20AND%20(label%3AARMAutoSignedOff%20OR%20(label%3ATypeSpec%20AND%20label%3AARMReview%20AND%20-label%3ANotReadyForARMReview%20AND%20(-label%3ASuppressionReviewRequired%20OR%20label%3AApproved-Suppression)))

https://github.com/Azure/azure-rest-api-specs-pr/issues?q=base%3Amain%20AND%20is%3Apr%20AND%20is%3Aopen%20AND%20(label%3AARMAutoSignedOff%20OR%20(label%3ATypeSpec%20AND%20label%3AARMReview%20AND%20-label%3ANotReadyForARMReview%20AND%20(-label%3ASuppressionReviewRequired%20OR%20label%3AApproved-Suppression)))

## Source Code
* ARM Incremental TypeSpec
  * Determines if PR contains only incremental changes to an existing TypeSpec RP
  * https://github.com/Azure/azure-rest-api-specs/blob/main/.github/workflows/arm-incremental-typespec.yaml
* ARM Auto SignOff
  * Combines results of "ARM Incremental TypeSpec", labels, and checks to determine if PR is eligible for auto sign-off
  * https://github.com/Azure/azure-rest-api-specs/blob/main/.github/workflows/arm-auto-signoff.yaml
