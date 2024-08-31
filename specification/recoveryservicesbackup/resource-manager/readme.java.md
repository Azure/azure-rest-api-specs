## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
directive:
  - from: bms.json
    where: "$.definitions.AzureVmWorkloadSAPHanaHSRProtectableItem"
    transform: >
      $["x-ms-client-name"] = "AzureVmWorkloadSapHanaHsr"
  - from: bms.json
    where: "$.definitions.ProtectedItem.properties.softDeleteRetentionPeriodInDays"
    transform: >
      $["x-ms-client-name"] = "softDeleteRetentionPeriod"
  - from: bms.json
    where: "$.definitions.PrivateLinkServiceConnectionState.properties.actionsRequired"
    transform: >
      $["x-ms-client-name"] = "actionRequired"
  - from: bms.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupconfig/vaultconfig"].patch.parameters
    transform: >
      $.splice(5, 1);
      return $;
    reason: hide x-ms-authorization-auxiliary header
  - from: bms.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupconfig/vaultconfig"].put.parameters
    transform: >
      $.splice(5, 1);
      return $;
    reason: hide x-ms-authorization-auxiliary header
  - from: bms.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}"].put.parameters
    transform: >
      $.splice(8, 1);
      return $;
    reason: hide x-ms-authorization-auxiliary header
  - from: bms.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}/restore"].post.parameters
    transform: >
      $.splice(9, 1);
      return $;
    reason: hide x-ms-authorization-auxiliary header
  - from: bms.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupPolicies/{policyName}"].put.parameters
    transform: >
      $.splice(6, 1);
      return $;
    reason: hide x-ms-authorization-auxiliary header
  - from: bms.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupSecurityPIN"].post.parameters
    transform: >
      $.splice(5, 1);
      return $;
    reason: hide x-ms-authorization-auxiliary header
```
