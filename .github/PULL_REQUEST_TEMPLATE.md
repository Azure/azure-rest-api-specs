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
  4. If updating an existing version, please select the specific language SDKs and CLIs that must be refreshed after the swagger is published.
      - [ ] SDK of .NET (need service team to ensure code readiness)
      - [ ] SDK of Python
      - [ ] SDK of Java
      - [ ] SDK of Js
      - [ ] SDK of Go
      - [ ] PowerShell
      - [ ] CLI
      - [ ] Terraform
      - [ ] No refresh required for updates in this PR

### Contribution checklist:
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
- [ ] Check this box if any of the following apply to the PR so that label "WaitForARMFeedback" will be added automatically to begin ARM API Review. Failure to comply may result in delays to the manifest.
  - Adding a new service
  - Adding new API(s)
  - Adding a new API version
    -[ ] To review changes efficiently, ensure you are using OpenAPIHub to initialize the PR for adding a new version. More details, refer to the [wiki](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/208/OpenAPI-Hub-Adding-new-API-version).

- [ ] Ensure you've reviewed following [guidelines](https://aka.ms/rpguidelines) including [ARM resource provider contract](https://github.com/Azure/azure-resource-manager-rpc) and [REST guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md). Estimated time (4 hours). This is required before you can request review from ARM API Review board.

- [ ] If you are blocked on ARM review and want to get the PR merged with urgency, please get the ARM oncall for reviews (*RP Manifest Approvers* team under <ins>Azure Resource Manager service</ins>) from IcM and reach out to them. 

### Breaking Change Review Checklist 
If any of the following scenarios apply to the PR, request approval from the Breaking Change Review Board as defined in the [Breaking Change Policy](http://aka.ms/bcforapi). 
- [ ] Removing API(s) in a stable version
- [ ] Removing properties in a stable version
- [ ] Removing API version(s) in a stable version
- [ ] Updating API in a stable or public preview version with Breaking Change Validation errors
- [ ] Updating API(s) in public preview over 1 year (refer to [Retirement of Previews](https://dev.azure.com/msazure/AzureWiki/_wiki/wikis/AzureWiki.wiki/37683/Retirement-of-Previews))

**Action**: to initiate an evaluation of the breaking change, create a new intake using the [template for breaking changes](https://aka.ms/Breakingchangetemplate). Addition details on the process and office hours are on the [Breaking change Wiki](https://dev.azure.com/msazure/AzureWiki/_wiki/wikis/AzureWiki.wiki/37684/Breaking-Changes).

Please follow the link to find more details on [PR review process](https://aka.ms/SwaggerPRReview).
