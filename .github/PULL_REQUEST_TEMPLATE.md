<i>MSFT employees can try out our new experience at <b>[OpenAPI Hub](https://aka.ms/openapiportal) </b> - one location for using our validation tools and finding your workflow. 
</i>

### Changelog
Please ensure to add changelog with this PR by answering the following questions.
  1. What's the purpose of the update?    
      - [ ] new service onboarding 
      - [ ] new API version 
      - [ ] update existing version for new feature 
      - [ ] update existing version to fix swagger quality issue in s360
      - [ ] Other, please clarify 
  2. When you are targeting to deploy new service/feature to public regions? Please provide date, or month to public if date is not available yet.
  3. When you expect to publish swagger? Please provide date, or month to public if date is not available yet.
  4. If it's an update to existing version,  please select SDKs of specific language and CLIs that require refresh after swagger is published.
      - [ ] SDK of .NET (need service team to ensure code readiness)
      - [ ] SDK of Python
      - [ ] SDK of Java
      - [ ] SDK of Js
      - [ ] SDK of Go
      - [ ] PowerShell
      - [ ] CLI
      - [ ] Terraform
      - [ ] No, no need to refresh for updates in this PR

### Contribution checklist:
- [ ] I commit to follow the [Breaking Change Policy](http://aka.ms/bcforapi) of “no breaking changes
- [ ] I have reviewed the [documentation](https://aka.ms/ameonboard) for the workflow.
- [ ] [Validation tools](https://aka.ms/swaggertools) were run on swagger spec(s) and errors have all been fixed in this PR. [How to fix?](https://aka.ms/ci-fix)

If any further question about AME onboarding or validation tools, please view the [FAQ](https://aka.ms/faqinprreview).

### ARM API Review Checklist
- [ ] Ensure to check this box if one of the following scenarios meet updates in the PR, so that label “WaitForARMFeedback” will be added automatically to involve ARM API Review. Failure to comply may result in delays for manifest application. Note this does not apply to data plane APIs, all “removals” and “adding a new property” no more require ARM API review.
  - Adding new API(s)
  - Adding a new API version
  - Adding a new service

- [ ] Please ensure you've reviewed following [guidelines](https://aka.ms/rpguidelines) including [ARM resource provider contract](https://github.com/Azure/azure-resource-manager-rpc) and [REST guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md). Estimated time (4 hours). This is required before you can request review from ARM API Review board.

- [ ] If you are blocked on ARM review and want to get the PR merged with urgency, please get the ARM oncall for reviews (*RP Manifest Approvers* team under <ins>Azure Resource Manager service</ins>) from IcM and reach out to them. 

### Breaking Change Review Checklist 
If there are following updates in the PR, ensure to request an approval from API Review Board as defined in the [Breaking Change Policy](http://aka.ms/bcforapi). 

- [ ] Removing API(s) in stable version
- [ ] Removing properties in stable version
- [ ] Removing API version(s) in stable version
- [ ] Updating API in stable version with Breaking Change Validation errors
- [ ] Updating API(s) in preview over 1 year

To initiate an evaluation of the breaking change, create a new intake using the [template for breaking changes](https://msazure.visualstudio.com/One/_workitems/create/Scenario?templateId=d1c215ec-5d6a-4cb3-a193-95ddd0a1ba96&ownerId=85bb92fb-21fe-41ca-9309-47f2c5f57515). Addition details on the process and office hours are on the [Breaking change Wiki](https://dev.azure.com/msazure/AzureWiki/_wiki/wikis/AzureWiki.wiki/37684/Breaking-Changes).

Please follow the link to find more details on [PR review process](https://aka.ms/SwaggerPRReview).