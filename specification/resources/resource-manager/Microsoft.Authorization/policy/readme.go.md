## Go

These settings apply only when `--go` is specified on the command line.

### Fix up regular expressions to support Unicode.

``` yaml 
directive:
  from: swagger-document # do it globally
  where: $.paths..parameters[?(@.name == "resourceGroupName" || @.name == "sourceResourceGroupName")].pattern
  set: ^[-\p{L}\._\(\)\w]+$ 
  reason: Necessary to match Unicode characters in the Go regexp engine.
```

``` yaml $(go) && $(track2) && $(package-policy)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/resources/armpolicy
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

``` yaml $(tag) == 'package-policy-2025-03-go'
input-file:
- stable/2020-09-01/dataPolicyManifests.json
- https://github.com/Azure/azure-rest-api-specs/tree/2b3c430bff9474d80080498090d71caf3fafcb75/specification/resources/resource-manager/Microsoft.Authorization/policy/stable/2025-03-01/policyAssignments.json
- https://github.com/Azure/azure-rest-api-specs/tree/2b3c430bff9474d80080498090d71caf3fafcb75/specification/resources/resource-manager/Microsoft.Authorization/policy/stable/2025-03-01/policyDefinitions.json
- https://github.com/Azure/azure-rest-api-specs/tree/2b3c430bff9474d80080498090d71caf3fafcb75/specification/resources/resource-manager/Microsoft.Authorization/policy/stable/2025-03-01/policyDefinitionVersions.json
- https://github.com/Azure/azure-rest-api-specs/tree/2b3c430bff9474d80080498090d71caf3fafcb75/specification/resources/resource-manager/Microsoft.Authorization/policy/stable/2025-03-01/policySetDefinitions.json
- https://github.com/Azure/azure-rest-api-specs/tree/2b3c430bff9474d80080498090d71caf3fafcb75/specification/resources/resource-manager/Microsoft.Authorization/policy/stable/2025-03-01/policySetDefinitionVersions.json
- https://github.com/Azure/azure-rest-api-specs/tree/2b3c430bff9474d80080498090d71caf3fafcb75/specification/resources/resource-manager/Microsoft.Authorization/policy/stable/2025-03-01/policyTokens.json
- https://github.com/Azure/azure-rest-api-specs/tree/2b3c430bff9474d80080498090d71caf3fafcb75/specification/resources/resource-manager/Microsoft.Authorization/policy/preview/2022-07-01-preview/policyExemptions.json
```
