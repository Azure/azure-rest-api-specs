# Data Plane API - Pull Request
<!-- 🚨🚨🚨 Replace this line with a summary and reason for these changes to your data plane API 🚨🚨🚨 -->

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
 * [Open API Hub](https://aka.ms/openapiportal)

### Guidelines & Specifications

 * [Azure REST API Guidelines](https://aka.ms/azapi/guidelines)
 * [OpenAPI Style Guidelines](https://aka.ms/azapi/style)
 * [Azure Breaking Change Policy](https://aka.ms/AzBreakingChangesPolicy)

### Helpful Links

 * [Schedule a data plane REST API spec review](https://aka.ms/azsdk/onboarding/restapischedule)

</details>

<details>
  <summary>Checks stuck in `queued` state?</summary>
If the PR CI checks appear to be stuck in `queued` state, please add a comment with contents `/azp run`.
This should result in a new comment denoting a `PR validation pipeline` has started and the checks should be updated after few minutes.  
</details>
