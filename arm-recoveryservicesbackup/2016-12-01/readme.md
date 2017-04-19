# Scenario: RecoveryServices.Backup swagger configuration

> see https://aka.ms/autorest

## Information
```yaml
override-info:
  title: Recovery Services Backup Client
  description: Open API 2.0 Specs for Azure RecoveryServices Backup service
```

## Inputs

``` yaml 
input-file:
  - ./backupManagement.json
azure-arm: true
```

## Suppression

``` yaml
directive:
  - suppress: 
    - BooleanPropertyNotRecommended
    - TrackedResourceListByImmediateParent

  - suppress: ProvidersPathValidation
    from: backupManagement.json
    where: 
      - $.paths["/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupconfig/vaultconfig"]
      - $["/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupJobs/operationResults/{operationId}"].paths
      - $.paths["/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig"]
    reason: These paths have been validated from ARM team and any change will require changes across services

  - suppress: XmsExamplesProvidedValidation
    reason: This is a temporary suppression due to time constraint. x-ms-examples will be added in update

  - suppress: AvoidNestedProperties
    reason: x-ms-client-flatten doesn't work with polymophic classes. So adding x-ms-client-flatten will require one to one checking of contracts and can't be done for now due to time constraint.

  - suppress: ServiceDefinitionParameters
    from: backupManagement.json
    where:
      - $.parameters
    reason: Seems like a false positive
  
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Autorest invalidates two letter acronyms as well and changes in data contracts require service wide changes and require more time
```

## Code Generation

### C#

```yaml
csharp:
  namespace: Microsoft.Azure.Management.RecoveryServices.Backup
  output-folder: Generated/CSharp
```