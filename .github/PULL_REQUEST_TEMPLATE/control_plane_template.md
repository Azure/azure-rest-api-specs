# ARM (Control Plane) API Specification Update Pull Request 

> Tip: overwhelmed by all this guidance? See the `Getting help` section at the bottom of this PR description.

## PR review workflow diagram

Please understand this diagram before proceeding. It explains how to get your PR approved & merged.

![diagram](https://github.com/Azure/azure-rest-api-specs/assets/20296335/35140fb9-639e-4e44-ac4b-38b1a20dddf9)

<details>
<summary> Click here to see the details of Step 1 </summary>

### Breaking changes review (Diagram Step 1)

If the automation determines you have breaking changes, i.e. Step 1 from the diagram applies to you,
  you must follow the [breaking changes process].  
  **IMPORTANT** This applies even if:
- The tool fails while it shouldn't, e.g. due to runtime exception, or incorrect detection of breaking changes.
- You believe there is no need for you to request breaking change approval, for any reason. 
    Such claims must be reviewed, and the process is the same.

</details>

<details> 
<summary> Click here to see the details of Step 2 </summary>

### ARM API changes review (Diagram Step 2)

- If this PR is in purview of ARM review then automation will add the `ARMReview` label.
- If you want to force ARM review, add the label yourself.
- Proceed according to the diagram at the top of this comment.

</details>

<details>
<summary> Click here to see the diagram footnotes</summary>

### Diagram footnotes

[1] [ARM review queue] (for **merge** queues, see [2])  
The PRs are processed by time opened, ascending. Your PR may show up on 2nd or later page. 
If you addressed Step 1 from the diagram and your PR is not showing up in the queue, ensure the label `ARMChangesRequested` 
is removed from your PR. This should cause the label `WaitForARMFeedback` to be added.
[2] [public repo merge queue], [private repo merge queue] (for **ARM review** queue, [1])

If you need further help with anything, see `Getting help` section below.

</details>

## Purpose of this PR

What's the purpose of this PR? Check all that apply. This is **mandatory**!

  - [ ] New API version. (If API spec is not defined in TypeSpec, the PR should have been generated using [OpenAPI Hub](https://aka.ms/openapihub)).
  - [ ] Update existing version for a new feature. (This is applicable only when you are revising a private preview API version.)
  - [ ] Update existing version to fix swagger quality issues in S360.
  - [ ] Other, please clarify:
    - _edit this with your clarification_

## Due diligence checklist

To merge this PR, you **must** go through the following checklist and confirm you understood 
and followed the instructions by checking all the boxes:

- [ ] I confirm this PR is modifying Azure Resource Manager (ARM) related specifications, and not data plane related specifications.
- [ ] I have reviewed following [Resource Provider guidelines](https://aka.ms/rpguidelines), including
  [ARM resource provider contract](https://github.com/Azure/azure-resource-manager-rpc) and
  [REST guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md) (estimated time: 4 hours).  
  I understand this is required before I can proceed to the Diagram Step 2, "ARM API changes Review", for this PR.

## Additional information

<details>
<summary> Viewing API changes</summary>

For convenient view of the API changes made by this PR, refer to the URLs provided in the table 
in the `Generated ApiView` comment added to this PR. You can use ApiView to show API versions diff. 

</details>
<details>
<summary>Suppressing failures</summary>

If one or multiple validation error/warning suppression(s) is detected in your PR, please follow the 
[Swagger-Suppression-Process](https://aka.ms/azsdk/pr-suppressions) 
to get approval.

</details>

## Getting help

- First, please carefully read through this PR description, from top to bottom. Please fill out the `Purpose of this PR` and `Due diligence checklist`.
- To understand what you must do next to merge this PR, see the `Next Steps to Merge` comment. It will appear within few minutes of submitting this PR and will continue to be up-to-date with current PR state.
- For guidance on fixing this PR CI check failures, see the hyperlinks provided in given failure 
  and https://aka.ms/ci-fix.
- If the PR CI checks appear to be stuck in `queued` state, please add a comment with contents `/azp run`.
  This should result in a new comment denoting a `PR validation pipeline` has started and the checks should be updated after few minutes.
- If the help provided by the previous points is not enough, post to https://aka.ms/azsdk/support/specreview-channel and link to this PR.

[ARM review queue]: https://github.com/search?q=org%3AAzure+is%3Apr+is%3Aopen+label%3AWaitForARMFeedback+-label%3AIDCDevDiv++draft%3Afalse+sort%3Acreated-asc+&type=pullrequests
[public repo merge queue]: https://github.com/Azure/azure-rest-api-specs/pulls?q=is%3Aopen+is%3Apr+label%3AMergeRequested+draft%3Afalse+sort%3Acreated-asc
[private repo merge queue]: https://github.com/Azure/azure-rest-api-specs-pr/pulls?q=is%3Aopen+is%3Apr+label%3AMergeRequested+-label%3AApproved-OkToMerge+draft%3Afalse+sort%3Acreated-asc
[breaking changes process]: https://eng.ms/docs/cloud-ai-platform/azure-core/azure-core-pm-and-design/trusted-platform-pm-karimb/service-lifecycle-and-actions-team/service-lifecycle-actions-team/apex/media/launchingproductbreakingchanges#breaking-change-process-1
