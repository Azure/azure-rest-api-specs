# Data Plane API Specification Update Pull Request

> [!TIP]
> Overwhelmed by all this guidance? See the `Getting help` section at the bottom of this PR description.


<!-- 🚨🚨🚨 Replace this line with a summary and reason for these changes to your data plane API 🚨🚨🚨 -->

## PR review workflow diagram

Please understand this diagram before proceeding. It explains how to get your PR approved & merged.

![spec_pr_review_workflow_diagram](https://github.com/Azure/azure-rest-api-specs/assets/4429827/5bb5e7ce-8aff-4dbb-a3f8-0d9b68fef5b1)

## API Info: The Basics

Most of the information about your service should be captured in the issue that serves as your [*API Spec engagement record*](https://aka.ms/azsdk/onboarding/restapischedule).

* Link to API Spec engagement record issue:

Is this review for (select one):

- [ ] a private preview
- [ ] a public preview
- [ ] GA release

### Change Scope

<sup>This section will help us focus on the specific parts of your API that are new or have been modified. <br/>Please share a link to the design document for the new APIs, a link to the previous API Spec document (if applicable), and the root paths that have been updated. </sup>
* Design Document:
* Previous API Spec Doc:
* Updated paths:

### Viewing API changes

For convenient view of the API changes made by this PR, refer to the URLs provided in the table 
in the `Generated ApiView` comment added to this PR. You can use ApiView to show API versions diff. 

### Suppressing failures

If one or multiple validation error/warning suppression(s) is detected in your PR, please follow the 
[Swagger-Suppression-Process](https://aka.ms/pr-suppressions) 
to get approval.

### Release planner

A [release plan](https://aka.ms/azsdkdocs/release-plans) should have been created. If not, please create one as it will help guide you through the REST API and SDK creation process. 

## ❔Got questions? Need additional info?? We are here to help!

<details>
  <summary> Contact us!</summary>

The [Azure API Review Board](https://aka.ms/azsdk/onboarding/restapischedule) is dedicated to helping you create amazing APIs. You can read about our mission and learn more about our process on our [wiki](https://aka.ms/azsdk/onboarding/restapischedule).
* 💬 [Teams Channel](https://teams.microsoft.com/l/channel/19%3a3ebb18fded0e47938f998e196a52952f%40thread.tacv2/General?groupId=1a10b50c-e870-4fe0-8483-bf5542a8d2d8&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47)
* 💌 [email](mailto://azureapirbcore@microsoft.com)

</details>

<details>
  <summary>Click here for links to tools, specs, guidelines & other good stuff</summary>

### Tooling

 * [Open API validation tools](https://aka.ms/swaggertools) were run on this PR. Go here to see [how to fix errors](https://aka.ms/ci-fix)
 * [Spectral Linting](https://github.com/Azure/azure-api-style-guide/blob/main/README.md)

### Guidelines & Specifications

 * [Azure REST API Guidelines](https://aka.ms/azapi/guidelines)
 * [OpenAPI Style Guidelines](https://aka.ms/azapi/style)
 * [Azure Breaking Change Policy](https://aka.ms/AzBreakingChangesPolicy)

### Helpful Links

 * [Schedule a data plane REST API spec review](https://aka.ms/azsdk/onboarding/restapischedule)

</details>

## Getting help

- First, please carefully read through this PR description, from top to bottom.
- If you don't have permissions to remove or add labels to the PR, request `write access` per [aka.ms/azsdk/access#request-access-to-rest-api-or-sdk-repositories](https://aka.ms/azsdk/access#request-access-to-rest-api-or-sdk-repositories) 
- To understand what you must do next to merge this PR, see the `Next Steps to Merge` comment. It will appear within few minutes of submitting this PR and will continue to be up-to-date with current PR state.
- For guidance on fixing this PR CI check failures, see the hyperlinks provided in given failure 
  and https://aka.ms/ci-fix.
- If the PR CI checks appear to be stuck in `queued` state, please add a comment with contents `/azp run`.
  This should result in a new comment denoting a `PR validation pipeline` has started and the checks should be updated after few minutes.
- If the help provided by the previous points is not enough, post to https://aka.ms/azsdk/support/specreview-channel and link to this PR.
