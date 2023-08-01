# ARM (Control Plane) API Specification Update Pull Request 

## PR review workflow diagram

Please understand this diagram before proceeding. It explains how to get your PR approved & merged.

![diagram](https://github.com/Azure/azure-rest-api-specs/assets/4429827/8cb0b0e5-55ba-44a4-9848-2faead57fcc0)

[1]  
[ARM PR review queue for azure-rest-api-specs repo](https://github.com/Azure/azure-rest-api-specs/pulls?q=is%3Aopen+is%3Apr+label%3AWaitForARMFeedback+-label%3AIDCDevDiv+draft%3Afalse+)  
  [ARM PR review queue for azure-rest-api-specs-pr repo](https://github.com/Azure/azure-rest-api-specs-pr/pulls?q=is%3Aopen+is%3Apr+label%3AWaitForARMFeedback+-label%3AIDCDevDiv+draft%3Afalse+sort%3Acreated-asc)  
The PRs are processed last (bottom) to first. Your PR may be on 2nd or later page.  
If your PR is not on the queue, remove the `ARMChangesRequested` label. Most of the time automation should do it, but you can do it manually if necessary.  
[2] https://aka.ms/azsdk/support/specreview-channel  
[3] [List of SDK breaking changes approvers](https://teams.microsoft.com/l/message/19:0351f5f9404446e4b4fd4eaf2c27448d@thread.skype/1689115217750?tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47&groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&parentMessageId=1689115217750&teamName=Azure%20SDK&channelName=API%20Spec%20Review&createdTime=1689115217750) in pinned Teams announcement  
[4]  
[ARM PR merge queue for azure-rest-api-specs repo](https://github.com/Azure/azure-rest-api-specs/pulls?q=is%3Aopen+is%3Apr+label%3AMergeRequested+-label%3AIDCDevDiv+draft%3Afalse)  
  [ARM PR merge queue for azure-rest-api-specs-pr repo](https://github.com/Azure/azure-rest-api-specs-pr/pulls?q=is%3Aopen+is%3Apr+label%3AMergeRequested+-label%3AIDCDevDiv+draft%3Afalse+sort%3Acreated-asc)  

## Purpose of this PR

What's the purpose of this PR? Check all that apply. This is **mandatory**!

  - [ ] New API version. (Such PR should have been generated with [OpenAPI Hub](https://aka.ms/openapihub), per [this wiki doc](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/208/OpenAPI-Hub-Adding-new-API-version).)
  - [ ] Update existing version for a new feature. (This is applicable only when you are revising a private preview API version.)
  - [ ] Update existing version to fix swagger quality issues in S360.
  - [ ] Other, please clarify:
    - _edit this with your clarification_

## Due diligence checklist

To merge this PR, you **must** go through the following checklist and confirm you understood 
and followed the instructions by checking all the boxes:

- [ ] I have reviewed the general guidance on the spec PR review process: https://aka.ms/specprreview.
- [ ] I confirm this PR is modifying Azure Resource Manager (ARM) related specifications, and not data-plane related specifications.
- [ ] I commit to follow the [Breaking Change Policy](https://aka.ms/AzBreakingChangesPolicy).
- [ ] I have reviewed following [Resource Provider guidelines](https://aka.ms/rpguidelines), including
  [ARM resource provider contract](https://github.com/Azure/azure-resource-manager-rpc) and
  [REST guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md) (estimated time: 4 hours).  
  I understand this is required before I can request review from an ARM API Review board.

### ARM API changes review

- If you want for the ARM team to review this PR, you must add the `ARMReview` label. 
- The automation may automatically add the `ARMReview` label, if appropriate.  
  If this happens, proceed according to guidance given in GitHub comments also added by the automation.

### Breaking change review

If you have any breaking changes as defined in the [Breaking Change Policy](https://aka.ms/AzBreakingChangesPolicy/), 
follow the process outlined in the [High-level Breaking Change Process doc](https://aka.ms/breakingchangesprocess#high-level-breaking-change-process).
      
## Getting help

- For guidance on fixing this PR CI check failures, see the hyperlinks provided in given failure 
  and https://aka.ms/ci-fix.
- For additional help, see https://aka.ms/azsdk/support/spectools.
