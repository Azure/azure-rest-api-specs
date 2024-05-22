# ARM (Control Plane) API Specification Update Pull Request 

> [!TIP]
> Overwhelmed by all this guidance? See the `Getting help` section at the bottom of this PR description.

## PR review workflow diagram

Please understand this diagram before proceeding. It explains how to get your PR approved & merged.

![spec_pr_review_workflow_diagram](https://github.com/Azure/azure-rest-api-specs/assets/4429827/5bb5e7ce-8aff-4dbb-a3f8-0d9b68fef5b1)

## Purpose of this PR

What's the purpose of this PR? Check the specific option that applies. This is **mandatory**!

  - [ ] New resource provider.
  - [ ] New API version for an existing resource provider. (If API spec is not defined in TypeSpec, the PR should have been created in adherence to [OpenAPI specs PR creation guidance](https://aka.ms/azsdkdocs/createopenapispec)).
  - [ ] Update existing version for a new feature. (This is applicable only when you are revising a private preview API version.)
  - [ ] Update existing version to fix OpenAPI spec quality issues in S360.
  - [ ] Other, please clarify:
    - _edit this with your clarification_

## Due diligence checklist

To merge this PR, you **must** go through the following checklist and confirm you understood 
and followed the instructions by checking all the boxes:

- [ ] I confirm this PR is modifying Azure Resource Manager (ARM) related specifications, and not data plane related specifications.
- [ ] I have reviewed following [Resource Provider guidelines](https://aka.ms/rpguidelines), including
  [ARM resource provider contract](https://aka.ms/azurerpc) and
  [REST guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md) (estimated time: 4 hours).  
  I understand this is required before I can proceed to the diagram Step 2, "ARM API changes review", for this PR.

## Additional information

<details>
<summary> Viewing API changes</summary>

For convenient view of the API changes made by this PR, refer to the URLs provided in the table 
in the `Generated ApiView` comment added to this PR. You can use ApiView to show API versions diff. 

</details>
<details>
<summary>Suppressing failures</summary>

If one or multiple validation error/warning suppression(s) is detected in your PR, please follow the 
[suppressions guide](https://aka.ms/azsdk/pr-suppressions) to get approval.

</details>

## Getting help

- First, please carefully read through this PR description, from top to bottom. Please fill out the `Purpose of this PR` and `Due diligence checklist`.
- To understand what you must do next to merge this PR, see the `Next Steps to Merge` comment. It will appear within few minutes of submitting this PR and will continue to be up-to-date with current PR state.
- For guidance on fixing this PR CI check failures, see the hyperlinks provided in given failure 
  and https://aka.ms/ci-fix.
- For help with ARM review (PR workflow diagram Step 2), see https://aka.ms/azsdk/pr-arm-review.
- If the PR CI checks appear to be stuck in `queued` state, please add a comment with contents `/azp run`.
  This should result in a new comment denoting a `PR validation pipeline` has started and the checks should be updated after few minutes.
- If the help provided by the previous points is not enough, post to https://aka.ms/azsdk/support/specreview-channel and link to this PR.
