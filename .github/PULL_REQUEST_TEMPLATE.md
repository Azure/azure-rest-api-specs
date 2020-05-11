<i>MSFT employees can try out our new experience at <b>[OpenAPI Hub](https://aka.ms/openapiportal) </b> - one location for using our validation tools and finding your workflow. 
</i>

### Contribution checklist:
- [ ] I have reviewed the [documentation](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/202/Overall-Process-of-AME-Onboarding) for the workflow.
- [ ] [Validation tools](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/84/Swagger-Validation-tools) were run on swagger spec(s) and have all been fixed in this PR. [How to fix?](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/ci-fix.md)

If any further question about AME onboarding or validation tools, please view the [FAQ](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/FAQ.md).

### ARM API Review Checklist
- [ ] Service team MUST add the "**WaitForARMFeedback**" label if the management plane API changes fall into one of the below categories. 
  - adding/removing APIs.
  - adding/removing properties.
  - adding/removing API-version. 
  - adding a new service in Azure.

<i>Failure to comply may result in delays for manifest application. Note this does not apply to data plane APIs.</i>

- [ ] If you are blocked on ARM review and want to get the PR merged urgently, please get the ARM oncall for reviews (RP Manifest Approvers team under Azure Resource Manager service) from IcM and reach out to them. 
Please follow the link to find more details on [API review process]( https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/212/Swagger-PR-Review).
