# ARM Modelling Review Workflow Diagram

This diagram illustrates how the ARMModellingReviewRequired label integrates into the PR review workflow.

```mermaid
flowchart TD
    Start[PR Created] --> CheckType{PR Type?}
    
    CheckType -->|ARM Resource Manager| ArmReview[ARMReview Label Added]
    CheckType -->|Data Plane| DataPlane[Continue Data Plane Review]
    
    ArmReview --> CheckModelling{Requires<br/>Modelling<br/>Review?}
    
    CheckModelling -->|No| CheckOther{Other Reviews<br/>Required?}
    CheckModelling -->|Yes| AddModelling[ARMModellingReviewRequired<br/>Label Added]
    
    AddModelling --> NotReady[NotReadyForARMReview<br/>State]
    
    NotReady --> Blocked[PR Blocked:<br/>Next Steps to Merge shows<br/>Office Hours requirement]
    
    Blocked --> OfficeHours[Team Attends<br/>ARM Modelling Office Hours]
    
    OfficeHours --> PMReview{PM Approval?}
    
    PMReview -->|Approved| PMLabel[PM Adds:<br/>ARMModelling-Approved-OfficeHours]
    PMReview -->|Changes Requested| Revise[Revise Design]
    
    Revise --> OfficeHours
    
    PMLabel --> RemoveBlock[NotReadyForARMReview<br/>Removed Automatically]
    
    RemoveBlock --> CheckOther
    
    CheckOther -->|Versioning| VersionReview[VersioningReviewRequired]
    CheckOther -->|Breaking Change| BreakingReview[BreakingChangeReviewRequired]
    CheckOther -->|RPaaS| RPaaSReview[RPaaS Reviews]
    CheckOther -->|None| WaitFeedback[WaitForARMFeedback<br/>State]
    
    VersionReview --> GetApproval1[Get Versioning Approval]
    BreakingReview --> GetApproval2[Get Breaking Change Approval]
    RPaaSReview --> GetApproval3[Get RPaaS Exception]
    
    GetApproval1 --> WaitFeedback
    GetApproval2 --> WaitFeedback
    GetApproval3 --> WaitFeedback
    
    WaitFeedback --> ArmReviewProcess[ARM Team Reviews]
    
    ArmReviewProcess --> ArmDecision{ARM Review<br/>Decision?}
    
    ArmDecision -->|Signed Off| ArmSignedOff[ARMSignedOff Label]
    ArmDecision -->|Changes Requested| ArmChanges[ARMChangesRequested Label]
    
    ArmChanges --> AuthorRevisions[Author Makes Revisions]
    AuthorRevisions --> WaitFeedback
    
    ArmSignedOff --> FinalChecks[Final CI Checks]
    FinalChecks --> Merge[Ready to Merge]
    
    style Start fill:#e1f5ff
    style Merge fill:#c8e6c9
    style NotReady fill:#ffebee
    style Blocked fill:#ffebee
    style PMLabel fill:#c8e6c9
    style ArmSignedOff fill:#c8e6c9
```

## Key States

### Before Modelling Review
- **ARMReview**: PR is in scope for ARM review
- **ARMModellingReviewRequired**: Modelling review is needed
- **NotReadyForARMReview**: PR is blocked until modelling review completes

### After Modelling Review
- **ARMModelling-Approved-OfficeHours**: Modelling review completed successfully
- **WaitForARMFeedback**: Awaiting ARM team review
- **ARMSignedOff**: Final approval to merge

## Parallel Review Requirements

The ARMModellingReviewRequired check runs in parallel with other review requirements:
- VersioningReviewRequired + Versioning-Approved-* labels
- BreakingChangeReviewRequired + BreakingChange-Approved-* labels
- CI-NewRPNamespaceWithoutRPaaS + RPaaSException

All blocking requirements must be resolved before the PR can proceed to WaitForARMFeedback state.

## Label Transitions

The automation handles the following transitions:

1. When `ARMModellingReviewRequired` is present:
   - `NotReadyForARMReview` is automatically added
   - PR cannot proceed until approval

2. When `ARMModelling-Approved-OfficeHours` is added:
   - Modelling review requirement is satisfied
   - If no other blocking issues, `NotReadyForARMReview` is removed
   - PR transitions to `WaitForARMFeedback`

3. If approval is removed or new modelling concerns arise:
   - `NotReadyForARMReview` is re-added
   - Process repeats from office hours step
