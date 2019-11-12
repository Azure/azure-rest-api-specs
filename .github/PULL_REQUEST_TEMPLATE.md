### Latest improvements:
<i>MSFT employees can try out our new experience at <b>[OpenAPI Hub](https://aka.ms/openapiportal) </b> - one location for using our validation tools and finding your workflow. 
</i><br>
### Contribution checklist:
- [ ] I have reviewed the [documentation](https://github.com/Azure/adx-documentation-pr/wiki/Overall-basic-flow) for the workflow.
- [ ] [Validation tools](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-checklist.md#validation-tools-for-swagger-checklist) were run on swagger spec(s) and have all been fixed in this PR.
- [ ] The [OpenAPI Hub](https://aka.ms/openapiportal) was used for checking validation status and next steps.
### ARM API Review Checklist
- [ ] Service team MUST add the "WaitForARMFeedback" label if the management plane API changes fall into one of the below categories. 
- adding/removing APIs.
- adding/removing properties.
- adding/removing API-version. 
- adding a new service in Azure.

Failure to comply may result in delays for manifest application. Note this does not apply to data plane APIs.
- [ ] If you are blocked on ARM review and want to get the PR merged urgently, please get the ARM oncall for reviews (RP Manifest Approvers team under Azure Resource Manager service) from IcM and reach out to them. 
Please follow the link to find more details on [API review process](https://armwiki.azurewebsites.net/rp_onboarding/ResourceProviderOnboardingAPIRevieworkflow.html).
