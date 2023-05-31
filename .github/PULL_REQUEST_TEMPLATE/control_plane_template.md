## ARM API Information (Control Plane)

## MANDATORY CHECKLIST

To merge this PR, you **must** go through the following checklist and confirm you understood 
and followed the instructions by checking all the boxes:

- [ ] I confirm this PR is modifying Azure Resource Manager (ARM) related specifications, and not data-plane related specifications.
- [ ] I commit to follow the [Breaking Change Policy](https://aka.ms/AzBreakingChangesPolicy).
- [ ] If I am adding a new service, API, or API version, I have ensured to copy the existing version into a new
  directory structure for first commit and then I pushed new changes, including version updates, in separate commits.  
  - I understand I can use [OpenAPI Hub](https://aka.ms/openapihub) to initialize the PR for adding a new version.  
  - I understand that this doesn't apply if this PR was previously a PR in the [private repository](https://github.com/Azure/azure-rest-api-specs-pr).
- [ ] I have reviewed following [guidelines](https://aka.ms/rpguidelines), including
  [ARM resource provider contract](https://github.com/Azure/azure-resource-manager-rpc) and
  [REST guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md) (estimated time: 4 hours).  
  I understand this is required before I can request review from an ARM API Review board.

### ARM API review

- If you want for the ARM team to review this PR, you must add the `ARMReview` label. 
- The automation may automatically add the `ARMReview` label, if appropriate.

### Breaking change review

If you have any breaking changes as defined in the [Breaking Change Policy](https://aka.ms/AzBreakingChangesPolicy/), 
follow the process outlined in the [High-level Breaking Change Process doc](https://eng.ms/docs/cloud-ai-platform/azure-core/azure-core-pm-and-design/trusted-platform-pm-karimb/service-lifecycle-and-actions-team/service-lifecycle-actions-team/apex/media/overview_breakingchanges#high-level-breaking-change-process).
      
## In case you need help

- For general guidance for the spec PR review workflow, see https://aka.ms/specprreview and [FAQ](https://aka.ms/faqinprreview).
- For guidance on fixing this PR CI check failures, see the hyperlinks provided in given failure 
  and https://aka.ms/ci-fix.
- For help adding new API version using OpenAPI Hub, see [this wiki doc](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/208/OpenAPI-Hub-Adding-new-API-version).
- For asking for further help, see https://aka.ms/azsdk/support/spectools.
