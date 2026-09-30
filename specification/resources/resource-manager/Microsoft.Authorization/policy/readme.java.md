## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
enable-sync-stack: false

directive:
  - rename-operation:
      from: Tags_DeleteValue
      to: TagOperations_DeleteValue
  - rename-operation:
      from: Tags_CreateOrUpdateValue
      to: TagOperations_CreateOrUpdateValue
  - rename-operation:
      from: Tags_CreateOrUpdate
      to: TagOperations_CreateOrUpdate
  - rename-operation:
      from: Tags_Delete
      to: TagOperations_Delete
  - rename-operation:
      from: Tags_DeleteValue
      to: TagOperations_DeleteValue
  - rename-operation:
      from: Tags_List
      to: TagOperations_List
  - rename-operation:
      from: Tags_CreateOrUpdateAtScope
      to: TagOperations_CreateOrUpdateAtScope
  - rename-operation:
      from: Tags_UpdateAtScope
      to: TagOperations_UpdateAtScope
  - rename-operation:
      from: Tags_GetAtScope
      to: TagOperations_GetAtScope
  - rename-operation:
      from: Tags_DeleteAtScope
      to: TagOperations_DeleteAtScope
```

``` yaml $(tag) == 'package-policy-2022-06-java'
input-file:
- stable/2020-09-01/dataPolicyManifests.json
- stable/2021-06-01/policyDefinitions.json
- stable/2021-06-01/policySetDefinitions.json
- stable/2022-06-01/policyAssignments.json
- preview/2022-07-01-preview/policyExemptions.json
```

``` yaml $(tag) == 'package-policy-2023-04-java'
input-file:
- stable/2020-09-01/dataPolicyManifests.json
- stable/2023-04-01/policyDefinitions.json
- stable/2023-04-01/policyDefinitionVersions.json
- stable/2023-04-01/policySetDefinitions.json
- stable/2023-04-01/policySetDefinitionVersions.json
- stable/2023-04-01/policyAssignments.json
- preview/2022-07-01-preview/policyExemptions.json
```

``` yaml $(tag) == 'package-policy-2025-03-java'
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
