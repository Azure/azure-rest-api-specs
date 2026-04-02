# PR Workflow Step 2: ARM API Changes Review

## Overview

Step 2 of the PR review workflow focuses on ARM (Azure Resource Manager) API changes review. This is a critical step where the ARM review team evaluates your API design for compliance with Azure standards, best practices, and platform consistency.

## When Step 2 Applies

Step 2 applies to PRs that:
- Modify or add ARM (control plane) API specifications
- Introduce new resource types or resource providers
- Make changes to existing ARM APIs that could impact service architecture
- Require ARM team sign-off before merging

## Step 2 Sub-Processes

### 2.1 Prerequisites Review

Before proceeding to ARM review, ensure you have:
- ✅ Reviewed [Resource Provider guidelines](https://aka.ms/rpguidelines)
- ✅ Understood the [ARM resource provider contract](https://aka.ms/azurerpc)
- ✅ Reviewed [REST API guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)
- ✅ Created a [release plan](https://aka.ms/azsdkdocs/release-plans)
- ✅ Passed initial CI checks

### 2.2 ARM Modelling Review (When Required)

For PRs requiring design review, the ARM Modelling Review process must be completed first.

#### When ARM Modelling Review is Required

The `ARMModellingReviewRequired` label is added when your PR includes:
- **New resource types or resource providers** - First-time introduction of resources
- **Significant changes to resource modeling patterns** - Major architectural changes
- **Complex nested resource hierarchies** - Multi-level resource relationships
- **Novel API design patterns** - Patterns that deviate from standard ARM conventions
- **Cross-service consistency concerns** - Changes that may impact other services

#### ARM Modelling Review Process

1. **Label Added**: `ARMModellingReviewRequired` label is applied to your PR
   - PR transitions to `NotReadyForARMReview` state
   - "Next Steps to Merge" comment shows office hours requirement

2. **Schedule Office Hours**: 
   - Visit [ARM Modelling Office Hours](https://aka.ms/azsdk/arm-modelling-office-hours)
   - Schedule a session with the ARM team PMs
   - Prepare your API design documentation

3. **Prepare Your Presentation**:
   - Create resource modeling diagrams
   - Prepare sample API requests and responses
   - Document rationale for design decisions
   - List areas needing specific guidance

4. **Attend Office Hours**:
   - Present your API design to Product Managers
   - Discuss feedback and address concerns
   - Clarify design choices and requirements

5. **Receive Approval**:
   - PM adds `ARMModelling-Approved-OfficeHours` label
   - `NotReadyForARMReview` label is automatically removed
   - PR transitions to `WaitForARMFeedback` state

**Documentation**: See [ARM Modelling Review Process](./arm-modelling-review-process.md) for complete details.

### 2.3 Parallel Review Requirements

While in Step 2, your PR may also require:

#### Versioning Review
- **Label**: `VersioningReviewRequired`
- **Approval**: `Versioning-Approved-*` labels
- **Trigger**: Changes to existing API versions (same version modifications)
- **Resolution**: Follow [Azure's Versioning Policy](https://aka.ms/AzBreakingChangesPolicy)

#### Breaking Change Review
- **Label**: `BreakingChangeReviewRequired`  
- **Approval**: `BreakingChange-Approved-*` labels
- **Trigger**: Changes across API versions detected as breaking
- **Resolution**: Get approval per [Breaking Change Policy](https://aka.ms/AzBreakingChangesPolicy)

#### RPaaS Requirements
- **Label**: `CI-NewRPNamespaceWithoutRPaaS` or `CI-RpaaSRPNotInPrivateRepo`
- **Approval**: `RPaaSException` label
- **Trigger**: New RP namespace without RPaaS onboarding
- **Resolution**: Complete [RPaaS onboarding](https://armwiki.azurewebsites.net/rpaas/overview.html) or request exception

**Important**: All blocking labels must be resolved before proceeding. The PR remains in `NotReadyForARMReview` state until all requirements are satisfied.

### 2.4 ARM Team Review

Once all blocking requirements are resolved:

1. **Transition to WaitForARMFeedback**:
   - PR enters the ARM review queue
   - ARM reviewers are automatically notified
   - Wait for reviewer assignment and feedback

2. **Review Cycle**:
   - ARM reviewers examine your API design
   - Feedback provided via PR comments
   - May request changes or clarifications

3. **Possible Outcomes**:
   - **ARMSignedOff**: Review approved, proceed to next steps
   - **ARMChangesRequested**: Revisions needed, address feedback and request re-review
   - **Additional labels**: May receive other review requirements

4. **Making Revisions**:
   - Address all ARM reviewer feedback
   - Update PR with changes
   - Add comment when ready for re-review
   - PR returns to `WaitForARMFeedback` state

## Step 2 Workflow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                    STEP 2: ARM API CHANGES REVIEW                │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
                    ┌──────────────────┐
                    │  PR Enters Step 2 │
                    └──────────────────┘
                              │
                              ▼
                    ┌──────────────────────────┐
                    │  Check Review Requirements│
                    └──────────────────────────┘
                              │
                ┌─────────────┼─────────────┐
                ▼             ▼             ▼
    ┌──────────────┐  ┌─────────────┐  ┌──────────┐
    │ARM Modelling │  │ Versioning  │  │ Breaking │
    │   Review     │  │   Review    │  │  Change  │
    │  Required?   │  │  Required?  │  │ Required?│
    └──────────────┘  └─────────────┘  └──────────┘
            │                 │              │
            ▼                 ▼              ▼
    [Office Hours]    [Get Approval]  [Get Approval]
            │                 │              │
            └─────────────────┴──────────────┘
                              │
                              ▼
                    ┌──────────────────┐
                    │ All Requirements │
                    │    Resolved?     │
                    └──────────────────┘
                              │
                              ▼
                    ┌──────────────────────┐
                    │ WaitForARMFeedback   │
                    │   (ARM Review Queue) │
                    └──────────────────────┘
                              │
                ┌─────────────┼─────────────┐
                ▼                           ▼
    ┌──────────────────┐        ┌──────────────────┐
    │  ARMSignedOff    │        │ARMChangesRequested│
    │  (Approved)      │        │ (Needs Revision) │
    └──────────────────┘        └──────────────────┘
            │                           │
            ▼                           ▼
    ┌──────────────────┐        ┌──────────────────┐
    │  Proceed to      │        │  Author Revises  │
    │  Next Steps      │        │  Returns to      │
    │                  │        │  ARM Review      │
    └──────────────────┘        └──────────────────┘
```

## Key Labels in Step 2

| Label | Meaning | Action Required |
|-------|---------|-----------------|
| `ARMReview` | PR is in ARM review scope | Proceed through Step 2 |
| `NotReadyForARMReview` | Blocking requirements exist | Resolve all blocking issues |
| `ARMModellingReviewRequired` | Design review needed | Attend office hours meeting |
| `ARMModelling-Approved-OfficeHours` | Design review completed | Automatic - no action |
| `VersioningReviewRequired` | Version changes detected | Get appropriate approval |
| `BreakingChangeReviewRequired` | Breaking changes detected | Get appropriate approval |
| `WaitForARMFeedback` | In ARM review queue | Wait for ARM reviewer feedback |
| `ARMChangesRequested` | Revisions needed | Address feedback, request re-review |
| `ARMSignedOff` | ARM review approved | Proceed to final steps |

## Timeframes

- **ARM Modelling Office Hours**: Schedule within 1-2 weeks (depends on availability)
- **ARM Review**: Typically 2-5 business days after entering `WaitForARMFeedback`
- **Re-review**: 1-3 business days after addressing feedback

## Getting Help

### For ARM Modelling Review
- **Schedule Office Hours**: https://aka.ms/azsdk/arm-modelling-office-hours
- **Teams Channel**: aka.ms/azsdk/support/specreview-channel
- **Documentation**: [ARM Modelling Review Process](./arm-modelling-review-process.md)

### For General ARM Review
- **ARM Review Documentation**: https://aka.ms/azsdk/pr-arm-review
- **Resource Provider Guidelines**: https://aka.ms/rpguidelines
- **ARM RPC Contract**: https://aka.ms/azurerpc

### For Breaking Changes
- **Breaking Change Policy**: https://aka.ms/AzBreakingChangesPolicy
- **CI Fix Guide**: https://aka.ms/ci-fix

### For RPaaS
- **RPaaS Overview**: https://armwiki.azurewebsites.net/rpaas/overview.html
- **RPaaS Exception**: https://aka.ms/RPaaSException

## Tips for Success

1. **Start Early**: Review guidelines before creating your PR
2. **Be Prepared**: Have design documentation ready for office hours
3. **Be Responsive**: Address feedback promptly to avoid delays
4. **Ask Questions**: Use Teams channel if unclear about requirements
5. **Follow Standards**: Adherence to ARM guidelines speeds up review
6. **Check Status**: Monitor "Next Steps to Merge" comment for current state
7. **Document Decisions**: Keep track of design discussions and rationale

## Common Issues

### Stuck in NotReadyForARMReview
- **Cause**: Blocking labels present (Modelling, Versioning, Breaking Change, RPaaS)
- **Solution**: Address each blocking requirement as indicated in "Next Steps to Merge"

### ARMChangesRequested but no comments
- **Cause**: Comments may be in review threads or on specific files
- **Solution**: Check all PR conversations and file changes tabs

### Office hours not scheduled
- **Cause**: High demand or availability constraints
- **Solution**: Contact ARM team via Teams channel for urgent needs

### Multiple review cycles
- **Cause**: Complex changes or unclear design rationale
- **Solution**: Provide comprehensive design documentation upfront

## Related Documentation

- [PR Workflow Overview](https://aka.ms/azsdk/pr-diagram)
- [ARM Modelling Review Process](./arm-modelling-review-process.md)
- [ARM Modelling Review Workflow Diagram](./arm-modelling-review-workflow-diagram.md)
- [Breaking Change Guidelines](./Breaking%20changes%20guidelines.md)
- [CI Fix Guide](./ci-fix.md)
