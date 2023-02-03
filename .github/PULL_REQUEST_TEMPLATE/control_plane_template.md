## ARM API Information (Control Plane)

<i>MSFT employees can try out our new experience at <b>[OpenAPI Hub](https://aka.ms/openapiportal) </b> - one location for using our validation tools and finding your workflow.
</i>
Azure 1st Party Service can try out the [Shift Left](https://aka.ms/ShiftLeft) experience to initiate API design review from ADO code repo.  If you are interested, may request engineering support by filling in with the form https://aka.ms/ShiftLeftSupportForm.

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
  4. By default, Azure SDKs of all languages (.NET/Python/Java/JavaScript for both management-plane SDK and data-plane SDK, Go for management-plane SDK only ) MUST be refreshed with/after swagger of new version is published. If you prefer NOT to refresh any specific SDK language upon swagger updates in the current PR, please leave details with justification here.

### Contribution checklist (MS Employees Only):
- [ ] I commit to follow the [Breaking Change Policy](https://aka.ms/AzBreakingChangesPolicy) of "no breaking changes"
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
    -[ ] To review changes efficiently, ensure you copy the existing version into the new directory structure for first commit and then push new changes, including version updates, in separate commits. You can use OpenAPIHub to initialize the PR for adding a new version. For more details refer to the [wiki](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/208/OpenAPI-Hub-Adding-new-API-version).

- [ ] Ensure you've reviewed following [guidelines](https://aka.ms/rpguidelines) including [ARM resource provider contract](https://github.com/Azure/azure-resource-manager-rpc) and [REST guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md). Estimated time (4 hours). This is required before you can request review from ARM API Review board.

- [ ] If you are blocked on ARM review and want to get the PR merged with urgency, please get the ARM oncall for reviews (*RP Manifest Approvers* team under <ins>Azure Resource Manager service</ins>) from IcM and reach out to them.

### Breaking Change Review Checklist
If you have any breaking changes as defined in the [Breaking Change Policy](https://aka.ms/AzBreakingChangesPolicy/), request approval from the Breaking Change Review Board.

**Action**: to initiate an evaluation of the breaking change, create a new intake using the [template for breaking changes](https://aka.ms/Breakingchangetemplate). Additional details on the process and office hours are on the [Breaking Change Wiki](https://dev.azure.com/msazure/AzureWiki/_wiki/wikis/AzureWiki.wiki/37684/Breaking-Changes).

NOTE: To update API(s) in public preview for over 1 year (refer to [Retirement of Previews](https://dev.azure.com/msazure/AzureWiki/_wiki/wikis/AzureWiki.wiki/37683/Retirement-of-Previews))

Please follow the link to find more details on [PR review process](https://aka.ms/SwaggerPRReview).
