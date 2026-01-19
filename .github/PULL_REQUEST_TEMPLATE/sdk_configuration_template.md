# SDK configuration pull request

## Purpose of this PR

- [ ] Make changes to the SDK configuration only when there are no modifications to the API specification, eliminating the need for an ARM or Stewardship Board API review.

## Due diligence checklist

To merge this PR, you **must** go through the following checklist and confirm you understood
and followed the instructions by checking all the boxes:

- [ ] I confirm this PR is modifying only SDK configurations, and not API related specifications.
- [ ] I have reviewed and used the respective `tspconfig.yaml` templates:
  - [ARM tspconfig template](https://aka.ms/azsdk/tspconfig-sample-mpg)
  - [Data plane tspconfig template](https://aka.ms/azsdk/tspconfig-sample-dpg)

## Getting help

- First, carefully read through this PR description, from top to bottom. Fill out the `Purpose of this PR` and `Due diligence checklist`.
- If you don't have permissions to remove or add labels to the PR, request `write access` per [aka.ms/azsdk/access#request-access-to-rest-api-or-sdk-repositories](https://aka.ms/azsdk/access#request-access-to-rest-api-or-sdk-repositories)
- To understand what you must do next to merge this PR, see the `Next Steps to Merge` comment. It will appear within few minutes of submitting this PR and will continue to be up-to-date with current PR state.
- For guidance on fixing this PR CI check failures, see the hyperlinks provided in given failure and https://aka.ms/ci-fix.
- If the PR CI checks appear to be stuck in `queued` state, please add a comment with contents `/azp run`.
  This should result in a new comment denoting a `PR validation pipeline` has started and the checks should be updated after few minutes.
- If the help provided by the previous points is not enough, post to https://aka.ms/azsdk/support/specreview-channel and link to this PR.
