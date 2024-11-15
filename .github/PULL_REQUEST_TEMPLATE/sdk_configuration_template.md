# SDK configuration update pull request

## Purpose of this PR

What's the purpose of this PR?. This is **mandatory**!

- [ ] Add or update only SDK configuration where there are no changes to the API spec.

## Due diligence checklist

To merge this PR, you **must** go through the following checklist and confirm you understood
and followed the instructions by checking all the boxes:

- [ ] I confirm this PR is modifying only SDK configurations, and not API related specifications.
- [ ] I have reviewed following [Resource Provider guidelines](https://aka.ms/rpguidelines), including
  [ARM resource provider contract](https://aka.ms/azurerpc) and
  [REST guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md) (estimated time: 4 hours).  
  I understand this is required before I can proceed to the diagram Step 2, "ARM API changes review", for this PR.



## Getting help

- First, please carefully read through this PR description, from top to bottom. Please fill out the `Purpose of this PR` and `Due diligence checklist`.
- If you don't have permissions to remove or add labels to the PR, request `write access` per [aka.ms/azsdk/access#request-access-to-rest-api-or-sdk-repositories](https://aka.ms/azsdk/access#request-access-to-rest-api-or-sdk-repositories)
- To understand what you must do next to merge this PR, see the `Next Steps to Merge` comment. It will appear within few minutes of submitting this PR and will continue to be up-to-date with current PR state.
- For guidance on fixing this PR CI check failures, see the hyperlinks provided in given failure 
  and https://aka.ms/ci-fix.
- For help with ARM review (PR workflow diagram Step 2), see https://aka.ms/azsdk/pr-arm-review.
- If the PR CI checks appear to be stuck in `queued` state, please add a comment with contents `/azp run`.
  This should result in a new comment denoting a `PR validation pipeline` has started and the checks should be updated after few minutes.
- If the help provided by the previous points is not enough, post to https://aka.ms/azsdk/support/specreview-channel and link to this PR.