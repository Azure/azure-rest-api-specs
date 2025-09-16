## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

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
- Microsoft.Authorization/stable/2020-09-01/dataPolicyManifests.json
- Microsoft.Authorization/stable/2021-06-01/policyDefinitions.json
- Microsoft.Authorization/stable/2021-06-01/policySetDefinitions.json
- Microsoft.Authorization/stable/2022-06-01/policyAssignments.json
- Microsoft.Authorization/preview/2022-07-01-preview/policyExemptions.json
```

``` yaml $(tag) == 'package-policy-2023-04-java'
input-file:
- Microsoft.Authorization/stable/2020-09-01/dataPolicyManifests.json
- Microsoft.Authorization/stable/2023-04-01/policyDefinitions.json
- Microsoft.Authorization/stable/2023-04-01/policyDefinitionVersions.json
- Microsoft.Authorization/stable/2023-04-01/policySetDefinitions.json
- Microsoft.Authorization/stable/2023-04-01/policySetDefinitionVersions.json
- Microsoft.Authorization/stable/2023-04-01/policyAssignments.json
- Microsoft.Authorization/preview/2022-07-01-preview/policyExemptions.json
```
