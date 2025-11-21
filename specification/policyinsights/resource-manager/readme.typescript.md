## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-policyinsights"
  output-folder: "$(typescript-sdks-folder)/sdk/policyinsights/arm-policyinsights"
  generate-metadata: true

directive:
  - from: policyStates.json
    where-operation: PolicyStates_ListQueryResultsForManagementGroup
    transform: delete $["x-ms-pageable"]
  - from: policyStates.json
    where-operation: PolicyStates_ListQueryResultsForSubscription
    transform: delete $["x-ms-pageable"]
  - from: policyStates.json
    where-operation: PolicyStates_ListQueryResultsForResourceGroup
    transform: delete $["x-ms-pageable"]
  - from: policyStates.json
    where-operation: PolicyStates_ListQueryResultsForResource
    transform: delete $["x-ms-pageable"]
  - from: policyStates.json
    where-operation: PolicyStates_ListQueryResultsForPolicySetDefinition
    transform: delete $["x-ms-pageable"]
  - from: policyStates.json
    where-operation: PolicyStates_ListQueryResultsForPolicyDefinition
    transform: delete $["x-ms-pageable"]
  - from: policyStates.json
    where-operation: PolicyStates_ListQueryResultsForSubscriptionLevelPolicyAssignment
    transform: delete $["x-ms-pageable"]
  - from: policyStates.json
    where-operation: PolicyStates_ListQueryResultsForResourceGroupLevelPolicyAssignment
    transform: delete $["x-ms-pageable"]
  - from: PaloAltoNetworks.Cloudngfw.json
    where-operation: LocalRulestacks_listPredefinedUrlCategories
    transform: delete $["x-ms-pageable"]
```
