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
    - DefinitionsPropertiesNamesCamelCase
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
```

## Code Generation

### C#

```yaml
csharp:
  namespace: Microsoft.Azure.Management.RecoveryServices.Backup
  output-folder: Generated/CSharp
```