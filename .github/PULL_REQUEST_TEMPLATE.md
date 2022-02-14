

## ARM API Information (Control Plane)
<details>
  <summary>Expand this section for managment plane</summary>
  
<i>MSFT employees can try out our new experience at <b>[OpenAPI Hub](https://aka.ms/openapiportal) </b> - one location for using our validation tools and finding your workflow. 
</i>

### Changelog
Add a changelog entry for this PR by answering the following questions:
  1. What's the purpose of the update?
      - [ ] new service onboarding
      - [ ] new API version
      - [ ] update existing version for new feature
      - [ ] update existing version to fix swagger quality issue in s360
      - [ ] Other, please clarify
  2. When are you targeting to deploy the new service/feature to public regions? Please provide the date or, if the date is not yet available, the month.
  3. When do you expect to publish the swagger? Please provide date or, the the date is not yet available, the month.
  4. If updating an existing version, please select the specific langauge SDKs and CLIs that must be refreshed after the swagger is published.
      - [ ] SDK of .NET (need service team to ensure code readiness)
      - [ ] SDK of Python
      - [ ] SDK of Java
      - [ ] SDK of Js
      - [ ] SDK of Go
      - [ ] PowerShell
      - [ ] CLI
      - [ ] Terraform
      - [ ] No refresh required for updates in this PR

### Contribution checklist (MS Employees Only):
- [ ] I commit to follow the [Breaking Change Policy](http://aka.ms/bcforapi) of "no breaking changes"
- [ ] I have reviewed the [documentation](https://aka.ms/ameonboard) for the workflow.
- [ ] [Validation tools](https://aka.ms/swaggertools) were run on swagger spec(s) and errors have all been fixed in this PR. [How to fix?](https://aka.ms/ci-fix)

If any further question about AME onboarding or validation tools, please view the [FAQ](https://aka.ms/faqinprreview).

### ARM API Review Checklist 

> **Applicability**: :warning: 
>
> If your changes encompass only the following scenarios, you should SKIP this section, as these scenarios do not require ARM review.
> - Change to data plane APIs 
> - Adding new properties 
> - All removals

Otherwise your PR may be subject to ARM review requirements. Complete the following:
- [ ] Check this box if any of the following apply to the PR so that label “WaitForARMFeedback” will be added automatically to begin ARM API Review. Failure to comply may result in delays to the manifest.
  - Adding a new service
  - Adding new API(s)
  - Adding a new API version
    -[ ] To review changes efficiently, ensure you copy the existing version into the new directory structure for first commit and then push new changes, including version updates, in separate commits.

- [ ] Ensure you've reviewed following [guidelines](https://aka.ms/rpguidelines) including [ARM resource provider contract](https://github.com/Azure/azure-resource-manager-rpc) and [REST guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md). Estimated time (4 hours). This is required before you can request review from ARM API Review board.

- [ ] If you are blocked on ARM review and want to get the PR merged with urgency, please get the ARM oncall for reviews (*RP Manifest Approvers* team under <ins>Azure Resource Manager service</ins>) from IcM and reach out to them. 

### Breaking Change Review Checklist 
If you have any breaking changes as defined in the [Breaking Change Policy](http://aka.ms/AzBreakingChangesPolicy/), request approval from the Breaking Change Review Board.
  
**Action**: to initiate an evaluation of the breaking change, create a new intake using the [template for breaking changes](https://aka.ms/Breakingchangetemplate). Additional details on the process and office hours are on the [Breaking Change Wiki](https://dev.azure.com/msazure/AzureWiki/_wiki/wikis/AzureWiki.wiki/37684/Breaking-Changes).
  
NOTE: To update API(s) in public preview for over 1 year (refer to [Retirement of Previews](https://dev.azure.com/msazure/AzureWiki/_wiki/wikis/AzureWiki.wiki/37683/Retirement-of-Previews))

Please follow the link to find more details on [PR review process](https://aka.ms/SwaggerPRReview).
  
</details>

## Data Plane API

<details>
  <summary>Expand this section for dataplane</summary>

This PR template is for Data Plane APIs only.

### API Info: The Basics
Most of the information about your service should be captured in the issue that serves as your [*engagement record*](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/271/Azure-REST-API-Stewardship?anchor=rest-api-stewardship-process).

* Link to engagement record issue: 

Is this review for (select one):

- [ ] a public preview
- [ ] GA release 

### What are you changing?
<sup>This section will help us focus on the specific parts of your API that are new or have been modified. <br/>Please share a link to the design document for the new APIs, a link to the previous Open API document (swagger) if applicable, and the root paths that have been updated. </sup>

#### Description
< Your text here >
  
#### References & Links  
* Design Document: 
* Previous Open API Doc: 
* Updated paths:
  
### :grey_question: Got questions? Need additional info?? We are here to help!

<details>
  <summary> Contact us!</summary>

The [Azure API Review Board](https://aka.ms/azapi) is dedicated to helping you create amazing APIs. You can read about our mission and learn more about our process on our [wiki](https://aka.ms/azapi).
* :speech_balloon: [Teams Channel](https://teams.microsoft.com/l/channel/19%3a3ebb18fded0e47938f998e196a52952f%40thread.tacv2/General?groupId=1a10b50c-e870-4fe0-8483-bf5542a8d2d8&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47)
* :love_letter: [email](mailto://azureapirbcore@microsoft.com)

</details>

<details>
  <summary>Click here for links to tools, specs, guidelines & other good stuff</summary>
  
### Tooling
 * [Open API validation tools](https://aka.ms/swaggertools) were run on this PR. Go here to see [how to fix errors](https://aka.ms/ci-fix)
 * [Spectral Linting](https://aka.ms/azapi/style)
 * [Open API Hub](https://aka.ms/openapiportal)

### Guidelines & Specifications
 * [Azure REST API Guidelines](https://aka.ms/azapi/guidelines)
 * [OpenAPI Style Guidelines](https://aka.ms/azapi/style)
 * [Azure Breaking Change Policy](http://aka.ms/AzBreakingChangesPolicy/)

### Helpful Links
 * [Azure DevTools Wiki](https://aka.ms/azapi)
  
</details>
  
</details>
