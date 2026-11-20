## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
modelerfour:
  lenient-model-deduplication: true
rename-model: AllowedMethods:CorsRuleAllowedMethodsItem,AccountType:ActiveDirectoryPropertiesAccountType
property-include-always: EncryptionIdentity.encryptionUserAssignedIdentity
enable-sync-stack: false
directive:
  - from: storageTaskAssignments.json
    where: $.definitions.StorageTaskAssignmentProperties.properties.provisioningState
    transform: >
      $['x-ms-enum']['modelAsString'] = false;
    reason: Handle breaking change.
  - from: storageTaskAssignments.json
    where: $.definitions.ExecutionTrigger.properties.type
    transform: >
      $['x-ms-enum']['modelAsString'] = false;
    reason: Handle breaking change.
  - from: storageTaskAssignments.json
    where: $.definitions.TriggerParameters.properties.intervalUnit
    transform: >
      $['x-ms-enum']['modelAsString'] = false;
    reason: Handle breaking change.
  - from: storageTaskAssignments.json
    where: $.definitions.StorageTaskAssignmentUpdateProperties.properties.provisioningState
    transform: >
      $['x-ms-enum']['modelAsString'] = false;
    reason: Handle breaking change.
  - from: storageTaskAssignments.json
    where: $.definitions.ExecutionTriggerUpdate.properties.type
    transform: >
      $['x-ms-enum']['modelAsString'] = false;
    reason: Handle breaking change.
  - from: storageTaskAssignments.json
    where: $.definitions.TriggerParametersUpdate.properties.intervalUnit
    transform: >
      $['x-ms-enum']['modelAsString'] = false;
    reason: Handle breaking change.
```
