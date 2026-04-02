# ARM Modelling Review Process

## Overview

The ARM Modelling Review process ensures that Azure Resource Manager (ARM) API designs are reviewed by Product Managers (PMs) for consistency, best practices, and alignment with Azure platform standards. This review is required for certain types of API changes that may have significant design implications.

## When ARM Modelling Review is Required

The `ARMModellingReviewRequired` label is added to a pull request when the proposed API changes require design review by the ARM team. This typically includes:

- New resource types or resource providers
- Significant changes to resource modeling patterns
- Complex nested resource hierarchies
- Novel API design patterns that deviate from standard ARM conventions
- Changes that may impact cross-service consistency

## Process Overview

### 1. Label Added

When the automation or an ARM reviewer determines that modelling review is needed, the `ARMModellingReviewRequired` label will be added to your PR.

### 2. PR Blocked

Once the label is added:
- The PR will transition to `NotReadyForARMReview` state
- The "Next Steps to Merge" comment will indicate that ARM Modelling Review is required
- The PR cannot proceed to ARM sign-off until the review is complete

### 3. Attend Office Hours

To complete the ARM Modelling Review:

1. **Schedule a session**: Visit the [ARM Modelling Office Hours page](https://aka.ms/azsdk/arm-modelling-office-hours) to schedule or join the next available session. You can also contact the ARM review team through the support channel.
2. **Prepare your design**: Have your API design documentation ready, including:
   - Resource modeling diagrams
   - Sample API requests and responses
   - Rationale for design decisions
   - Any areas where you need specific guidance

3. **Attend the meeting**: Present your API design to the Product Managers at the scheduled office hours
4. **Discuss feedback**: Address any questions or concerns raised during the review

### 4. Approval

After the office hours review is complete:
- A PM will add the `ARMModelling-Approved-OfficeHours` label to your PR
- The `NotReadyForARMReview` label will be automatically removed
- Your PR will transition to `WaitForARMFeedback` state and continue through the normal ARM review process

## Approval Labels

The following approval labels may be added after modelling review:

- `ARMModelling-Approved-OfficeHours`: The standard approval label indicating the design was reviewed and approved during office hours

## Troubleshooting

### My PR has ARMModellingReviewRequired but I believe review is not needed

If you believe the label was added in error:
1. Add a comment to your PR explaining why modelling review should not be required
2. Tag an ARM reviewer to evaluate your justification
3. If agreed, the reviewer can remove the label

### I need urgent review

If your PR is time-sensitive:
1. Mention the urgency in your PR comments
2. Reach out to the ARM review team directly
3. Provide business justification for expedited review

### The label was removed but then added back

This can happen if:
- New commits introduce additional modeling concerns
- The design discussion revealed issues that need further review
- Automation re-evaluated the PR after updates

## Contact Information

For questions about the ARM Modelling Review process:
- **ARM Modelling Office Hours**: https://aka.ms/azsdk/arm-modelling-office-hours
- **Teams Channel**: See aka.ms/azsdk/support/specreview-channel
- **ARM Review Documentation**: https://aka.ms/azsdk/pr-arm-review

## Related Documentation

- [PR Workflow Diagram](https://aka.ms/azsdk/pr-diagram)
- [ARM Review Process](https://aka.ms/azsdk/pr-arm-review)
- [Breaking Change Policy](https://aka.ms/AzBreakingChangesPolicy)
- [Azure REST API Guidelines](https://github.com/microsoft/api-guidelines)

## Workflow Integration

The `ARMModellingReviewRequired` label integrates with the PR review workflow as follows:

```
PR Created
    ↓
ARMModellingReviewRequired added (if needed)
    ↓
NotReadyForARMReview state
    ↓
Attend Office Hours & Get Approval
    ↓
ARMModelling-Approved-OfficeHours added
    ↓
WaitForARMFeedback (normal ARM review continues)
    ↓
ARMSignedOff
    ↓
PR Ready to Merge
```

This process runs in parallel with other review requirements (e.g., VersioningReviewRequired, BreakingChangeReviewRequired) and all must be satisfied before the PR can proceed.
