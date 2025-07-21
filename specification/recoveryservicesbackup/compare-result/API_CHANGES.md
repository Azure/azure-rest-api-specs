## Swagger Changes

### Changes for `x-ms-code-generation-settings`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-ms-code-generation-settings__deleted']` | deleted | `{"internalConstructors":false}` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `info.description__added` | added | `Open API 2.0 Specs for Azure RecoveryServices Backup service` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/Microsoft.RecoveryServices/operations'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../common-types/resource-management/v3/types.j...` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupPreValidateProtection'].post.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../common-types/resource-management/v3/types.j...` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupStatus'].post.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../common-types/resource-management/v3/types.j...` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupValidateFeatures'].post.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../common-types/resource-management/v3/types.j...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/backupProtectionIntent/{intentObjectName}'].delete.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../common-types/resource-management/v3/types.j...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/backupProtectionIntent/{intentObjectName}'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../common-types/resource-management/v3/types.j...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/backupProtectionIntent/{intentObjectName}'].put.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../common-types/resource-management/v3/types.j...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectionIntents'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../common-types/resource-management/v3/types.j...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupUsageSummaries'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../../../common-types/resource-management/v3/types.j...` |

### Changes for `x-ms-odata`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupDeletedProtectionContainers'].get['x-ms-odata__deleted']` | deleted | `#/definitions/BMSContainerQueryObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupEngines'].get['x-ms-odata__deleted']` | deleted | `#/definitions/BMSBackupEnginesQueryObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupEngines/{backupEngineName}'].get['x-ms-odata__deleted']` | deleted | `#/definitions/BMSBackupEngineQueryObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectableContainers'].get['x-ms-odata__deleted']` | deleted | `#/definitions/BMSContainerQueryObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/inquire'].post['x-ms-odata__deleted']` | deleted | `#/definitions/BMSContainersInquiryQueryObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/items'].get['x-ms-odata__deleted']` | deleted | `#/definitions/BMSWorkloadItemQueryObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}'].get['x-ms-odata__deleted']` | deleted | `#/definitions/GetProtectedItemQueryObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints'].get['x-ms-odata__deleted']` | deleted | `#/definitions/BMSRPQueryObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/refreshContainers'].post['x-ms-odata__deleted']` | deleted | `#/definitions/BMSRefreshContainersQueryObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupJobs'].get['x-ms-odata__deleted']` | deleted | `#/definitions/JobQueryObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupJobsExport'].post['x-ms-odata__deleted']` | deleted | `#/definitions/JobQueryObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupPolicies'].get['x-ms-odata__deleted']` | deleted | `#/definitions/ProtectionPolicyQueryObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectableItems'].get['x-ms-odata__deleted']` | deleted | `#/definitions/BMSPOQueryObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectedItems'].get['x-ms-odata__deleted']` | deleted | `#/definitions/ProtectedItemQueryObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectionContainers'].get['x-ms-odata__deleted']` | deleted | `#/definitions/BMSContainerQueryObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectionIntents'].get['x-ms-odata__deleted']` | deleted | `#/definitions/ProtectionIntentQueryObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupUsageSummaries'].get['x-ms-odata__deleted']` | deleted | `#/definitions/BMSBackupSummariesQueryObject` |

### Changes for `202`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupPolicies/{policyName}'].delete.responses.202__added` | added | `{"description":"ignore"}` |

### Changes for `BMSPOQueryObject`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BMSPOQueryObject__deleted` | deleted | `{"type":"object","properties":{"backupManagementType":{"type":"string","enum":["Invalid","AzureIaasV...` |

### Changes for `BMSRPQueryObject`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BMSRPQueryObject__deleted` | deleted | `{"type":"object","properties":{"startDate":{"type":"string","format":"date-time"},"endDate":{"type":...` |

### Changes for `ClientDiscoveryResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClientDiscoveryResponse__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `IaasVMILRRegistrationRequest`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMILRRegistrationRequest__deleted` | deleted | `{"type":"object","properties":{"recoveryPointId":{"type":"string"},"virtualMachineId":{"type":"strin...` |

### Changes for `BackupFabricResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackupFabricResource__added` | added | `{"type":"object","properties":{"name":{"type":"string","readOnly":true}},"required":["name"]}` |

### Changes for `BmspoQueryObject`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BmspoQueryObject__added` | added | `{"type":"object","properties":{"backupManagementType":{"type":"string","enum":["Invalid","AzureIaasV...` |

### Changes for `BmsrpQueryObject`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BmsrpQueryObject__added` | added | `{"type":"object","properties":{"startDate":{"type":"string","format":"date-time"},"endDate":{"type":...` |

### Changes for `IaasVmilrRegistrationRequest`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVmilrRegistrationRequest__added` | added | `{"type":"object","properties":{"recoveryPointId":{"type":"string"},"virtualMachineId":{"type":"strin...` |

### Changes for `NewErrorResponseError`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NewErrorResponseError__added` | added | `{"type":"object","properties":{"code":{"type":"string","readOnly":true},"message":{"type":"string","...` |

### Changes for `TypeSpec.Http.OkResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['TypeSpec.Http.OkResponse__added']` | added | `{"type":"object"}` |

### Changes for `VaultResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VaultResource__added` | added | `{"type":"object","properties":{"name":{"type":"string","readOnly":true}},"required":["name"]}` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBackupServerContainer.properties__added` | added | `{"canReRegister":{"type":"boolean"},"containerId":{"type":"string"},"protectedItemCount":{"type":"in...` |
| `definitions.AzureIaaSClassicComputeVMContainer.properties__added` | added | `{"virtualMachineId":{"type":"string"},"virtualMachineVersion":{"type":"string"},"resourceGroup":{"ty...` |
| `definitions.AzureIaaSClassicComputeVMProtectableItem.properties__added` | added | `{"virtualMachineId":{"type":"string"},"virtualMachineVersion":{"type":"string"},"resourceGroup":{"ty...` |
| `definitions.AzureIaaSClassicComputeVMProtectedItem.properties__added` | added | `{"friendlyName":{"type":"string","readOnly":true},"virtualMachineId":{"type":"string","readOnly":tru...` |
| `definitions.AzureIaaSComputeVMContainer.properties__added` | added | `{"virtualMachineId":{"type":"string"},"virtualMachineVersion":{"type":"string"},"resourceGroup":{"ty...` |
| `definitions.AzureIaaSComputeVMProtectableItem.properties__added` | added | `{"virtualMachineId":{"type":"string"},"virtualMachineVersion":{"type":"string"},"resourceGroup":{"ty...` |
| `definitions.AzureIaaSComputeVMProtectedItem.properties__added` | added | `{"friendlyName":{"type":"string","readOnly":true},"virtualMachineId":{"type":"string","readOnly":tru...` |
| `definitions.AzureSQLAGWorkloadContainerProtectionContainer.properties__added` | added | `{"sourceResourceId":{"type":"string"},"lastUpdatedTime":{"type":"string","format":"date-time"},"exte...` |
| `definitions.AzureVMAppContainerProtectionContainer.properties__added` | added | `{"sourceResourceId":{"type":"string"},"lastUpdatedTime":{"type":"string","format":"date-time"},"exte...` |
| `definitions.AzureVmWorkloadSAPAseDatabaseProtectableItem.properties__added` | added | `{"parentName":{"type":"string"},"parentUniqueName":{"type":"string"},"serverName":{"type":"string"},...` |
| `definitions.AzureVmWorkloadSAPAseDatabaseProtectedItem.properties__added` | added | `{"recoveryPointTimeInUTC":{"type":"string","format":"date-time"},"type":{"type":"string","enum":["In...` |
| `definitions.AzureVmWorkloadSAPAseDatabaseWorkloadItem.properties__added` | added | `{"parentName":{"type":"string"},"serverName":{"type":"string"},"isAutoProtectable":{"type":"boolean"...` |
| `definitions.AzureVmWorkloadSAPAseSystemProtectableItem.properties__added` | added | `{"parentName":{"type":"string"},"parentUniqueName":{"type":"string"},"serverName":{"type":"string"},...` |
| `definitions.AzureVmWorkloadSAPAseSystemWorkloadItem.properties__added` | added | `{"parentName":{"type":"string"},"serverName":{"type":"string"},"isAutoProtectable":{"type":"boolean"...` |
| `definitions.AzureVmWorkloadSAPHanaDatabaseProtectableItem.properties__added` | added | `{"parentName":{"type":"string"},"parentUniqueName":{"type":"string"},"serverName":{"type":"string"},...` |
| `definitions.AzureVmWorkloadSAPHanaDatabaseProtectedItem.properties__added` | added | `{"recoveryPointTimeInUTC":{"type":"string","format":"date-time"},"type":{"type":"string","enum":["In...` |
| `definitions.AzureVmWorkloadSAPHanaDatabaseWorkloadItem.properties__added` | added | `{"parentName":{"type":"string"},"serverName":{"type":"string"},"isAutoProtectable":{"type":"boolean"...` |
| `definitions.AzureVmWorkloadSAPHanaDBInstance.properties__added` | added | `{"parentName":{"type":"string"},"parentUniqueName":{"type":"string"},"serverName":{"type":"string"},...` |
| `definitions.AzureVmWorkloadSAPHanaDBInstanceProtectedItem.properties__added` | added | `{"recoveryPointTimeInUTC":{"type":"string","format":"date-time"},"type":{"type":"string","enum":["In...` |
| `definitions.AzureVmWorkloadSAPHanaHSRProtectableItem.properties__added` | added | `{"parentName":{"type":"string"},"parentUniqueName":{"type":"string"},"serverName":{"type":"string"},...` |
| `definitions.AzureVmWorkloadSAPHanaSystemProtectableItem.properties__added` | added | `{"parentName":{"type":"string"},"parentUniqueName":{"type":"string"},"serverName":{"type":"string"},...` |
| `definitions.AzureVmWorkloadSAPHanaSystemWorkloadItem.properties__added` | added | `{"parentName":{"type":"string"},"serverName":{"type":"string"},"isAutoProtectable":{"type":"boolean"...` |
| `definitions.AzureVmWorkloadSQLDatabaseProtectableItem.properties__added` | added | `{"parentName":{"type":"string"},"parentUniqueName":{"type":"string"},"serverName":{"type":"string"},...` |
| `definitions.AzureVmWorkloadSQLDatabaseProtectedItem.properties__added` | added | `{"recoveryPointTimeInUTC":{"type":"string","format":"date-time"},"type":{"type":"string","enum":["In...` |
| `definitions.AzureVmWorkloadSQLDatabaseWorkloadItem.properties__added` | added | `{"parentName":{"type":"string"},"serverName":{"type":"string"},"isAutoProtectable":{"type":"boolean"...` |
| `definitions.AzureVmWorkloadSQLInstanceProtectableItem.properties__added` | added | `{"parentName":{"type":"string"},"parentUniqueName":{"type":"string"},"serverName":{"type":"string"},...` |
| `definitions.AzureWorkloadSAPAsePointInTimeRecoveryPoint.properties__added` | added | `{"timeRanges":{"type":"array","items":{"$ref":"#/definitions/PointInTimeRange"}}}` |
| `definitions.AzureWorkloadSAPAseRecoveryPoint.properties__added` | added | `{"recoveryPointTimeInUTC":{"type":"string","format":"date-time"},"type":{"type":"string","enum":["In...` |
| `definitions.AzureWorkloadSAPAseRestoreRequest.properties__added` | added | `{"recoveryType":{"type":"string","enum":["Invalid","OriginalLocation","AlternateLocation","RestoreDi...` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRecoveryPoint.properties__added` | added | `{"timeRanges":{"type":"array","items":{"$ref":"#/definitions/PointInTimeRange"}}}` |
| `definitions.AzureWorkloadSAPHanaRecoveryPoint.properties__added` | added | `{"recoveryPointTimeInUTC":{"type":"string","format":"date-time"},"type":{"type":"string","enum":["In...` |
| `definitions.AzureWorkloadSAPHanaRestoreRequest.properties__added` | added | `{"recoveryType":{"type":"string","enum":["Invalid","OriginalLocation","AlternateLocation","RestoreDi...` |
| `definitions.NewErrorResponse.properties.error.properties__deleted` | deleted | `{"code":{"type":"string","description":"The error code.","readOnly":true},"message":{"type":"string"...` |
| `definitions.ValidateIaasVMRestoreOperationRequest.properties__added` | added | `{"restoreRequest":{"$ref":"#/definitions/RestoreRequest"}}` |

### Changes for `parentName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureVmWorkloadSQLAvailabilityGroupProtectableItem.properties.parentName__added` | added | `{"type":"string"}` |
| `definitions.AzureVmWorkloadSQLInstanceWorkloadItem.properties.parentName__added` | added | `{"type":"string"}` |

### Changes for `parentUniqueName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureVmWorkloadSQLAvailabilityGroupProtectableItem.properties.parentUniqueName__added` | added | `{"type":"string"}` |

### Changes for `serverName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureVmWorkloadSQLAvailabilityGroupProtectableItem.properties.serverName__added` | added | `{"type":"string"}` |
| `definitions.AzureVmWorkloadSQLInstanceWorkloadItem.properties.serverName__added` | added | `{"type":"string"}` |

### Changes for `isAutoProtectable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureVmWorkloadSQLAvailabilityGroupProtectableItem.properties.isAutoProtectable__added` | added | `{"type":"boolean"}` |
| `definitions.AzureVmWorkloadSQLInstanceWorkloadItem.properties.isAutoProtectable__added` | added | `{"type":"boolean"}` |

### Changes for `isAutoProtected`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureVmWorkloadSQLAvailabilityGroupProtectableItem.properties.isAutoProtected__added` | added | `{"type":"boolean"}` |

### Changes for `subinquireditemcount`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureVmWorkloadSQLAvailabilityGroupProtectableItem.properties.subinquireditemcount__added` | added | `{"type":"integer","format":"int32"}` |
| `definitions.AzureVmWorkloadSQLInstanceWorkloadItem.properties.subinquireditemcount__added` | added | `{"type":"integer","format":"int32"}` |

### Changes for `subprotectableitemcount`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureVmWorkloadSQLAvailabilityGroupProtectableItem.properties.subprotectableitemcount__added` | added | `{"type":"integer","format":"int32"}` |

### Changes for `prebackupvalidation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureVmWorkloadSQLAvailabilityGroupProtectableItem.properties.prebackupvalidation__added` | added | `{"$ref":"#/definitions/PreBackupValidation"}` |

### Changes for `isProtectable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureVmWorkloadSQLAvailabilityGroupProtectableItem.properties.isProtectable__added` | added | `{"type":"boolean"}` |

### Changes for `subWorkloadItemCount`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureVmWorkloadSQLInstanceWorkloadItem.properties.subWorkloadItemCount__added` | added | `{"type":"integer","format":"int32"}` |

### Changes for `recoveryType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadPointInTimeRestoreRequest.properties.recoveryType__added` | added | `{"type":"string","enum":["Invalid","OriginalLocation","AlternateLocation","RestoreDisks","Offline"],...` |
| `definitions.AzureWorkloadSAPAsePointInTimeRestoreRequest.properties.recoveryType__added` | added | `{"type":"string","enum":["Invalid","OriginalLocation","AlternateLocation","RestoreDisks","Offline"],...` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreRequest.properties.recoveryType__added` | added | `{"type":"string","enum":["Invalid","OriginalLocation","AlternateLocation","RestoreDisks","Offline"],...` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest.properties.recoveryType__added` | added | `{"type":"string","enum":["Invalid","OriginalLocation","AlternateLocation","RestoreDisks","Offline"],...` |
| `definitions.AzureWorkloadSAPHanaRestoreWithRehydrateRequest.properties.recoveryType__added` | added | `{"type":"string","enum":["Invalid","OriginalLocation","AlternateLocation","RestoreDisks","Offline"],...` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreRequest.properties.recoveryType__added` | added | `{"type":"string","enum":["Invalid","OriginalLocation","AlternateLocation","RestoreDisks","Offline"],...` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest.properties.recoveryType__added` | added | `{"type":"string","enum":["Invalid","OriginalLocation","AlternateLocation","RestoreDisks","Offline"],...` |
| `definitions.AzureWorkloadSQLRestoreRequest.properties.recoveryType__added` | added | `{"type":"string","enum":["Invalid","OriginalLocation","AlternateLocation","RestoreDisks","Offline"],...` |
| `definitions.AzureWorkloadSQLRestoreWithRehydrateRequest.properties.recoveryType__added` | added | `{"type":"string","enum":["Invalid","OriginalLocation","AlternateLocation","RestoreDisks","Offline"],...` |
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.recoveryType__added` | added | `{"type":"string","enum":["Invalid","OriginalLocation","AlternateLocation","RestoreDisks","Offline"],...` |

### Changes for `sourceResourceId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadPointInTimeRestoreRequest.properties.sourceResourceId__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSAPAsePointInTimeRestoreRequest.properties.sourceResourceId__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreRequest.properties.sourceResourceId__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest.properties.sourceResourceId__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSAPHanaRestoreWithRehydrateRequest.properties.sourceResourceId__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreRequest.properties.sourceResourceId__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest.properties.sourceResourceId__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSQLRestoreRequest.properties.sourceResourceId__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSQLRestoreWithRehydrateRequest.properties.sourceResourceId__added` | added | `{"type":"string"}` |
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.sourceResourceId__added` | added | `{"type":"string"}` |

### Changes for `propertyBag`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadPointInTimeRestoreRequest.properties.propertyBag__added` | added | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.AzureWorkloadSAPAsePointInTimeRestoreRequest.properties.propertyBag__added` | added | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreRequest.properties.propertyBag__added` | added | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest.properties.propertyBag__added` | added | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.AzureWorkloadSAPHanaRestoreWithRehydrateRequest.properties.propertyBag__added` | added | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreRequest.properties.propertyBag__added` | added | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest.properties.propertyBag__added` | added | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.AzureWorkloadSQLRestoreRequest.properties.propertyBag__added` | added | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.AzureWorkloadSQLRestoreWithRehydrateRequest.properties.propertyBag__added` | added | `{"type":"object","additionalProperties":{"type":"string"}}` |

### Changes for `targetInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadPointInTimeRestoreRequest.properties.targetInfo__added` | added | `{"$ref":"#/definitions/TargetRestoreInfo"}` |
| `definitions.AzureWorkloadSAPAsePointInTimeRestoreRequest.properties.targetInfo__added` | added | `{"$ref":"#/definitions/TargetRestoreInfo"}` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreRequest.properties.targetInfo__added` | added | `{"$ref":"#/definitions/TargetRestoreInfo"}` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest.properties.targetInfo__added` | added | `{"$ref":"#/definitions/TargetRestoreInfo"}` |
| `definitions.AzureWorkloadSAPHanaRestoreWithRehydrateRequest.properties.targetInfo__added` | added | `{"$ref":"#/definitions/TargetRestoreInfo"}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreRequest.properties.targetInfo__added` | added | `{"$ref":"#/definitions/TargetRestoreInfo"}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest.properties.targetInfo__added` | added | `{"$ref":"#/definitions/TargetRestoreInfo"}` |
| `definitions.AzureWorkloadSQLRestoreRequest.properties.targetInfo__added` | added | `{"$ref":"#/definitions/TargetRestoreInfo"}` |
| `definitions.AzureWorkloadSQLRestoreWithRehydrateRequest.properties.targetInfo__added` | added | `{"$ref":"#/definitions/TargetRestoreInfo"}` |

### Changes for `recoveryMode`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadPointInTimeRestoreRequest.properties.recoveryMode__added` | added | `{"type":"string","enum":["Invalid","FileRecovery","WorkloadRecovery","SnapshotAttach","RecoveryUsing...` |
| `definitions.AzureWorkloadSAPAsePointInTimeRestoreRequest.properties.recoveryMode__added` | added | `{"type":"string","enum":["Invalid","FileRecovery","WorkloadRecovery","SnapshotAttach","RecoveryUsing...` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreRequest.properties.recoveryMode__added` | added | `{"type":"string","enum":["Invalid","FileRecovery","WorkloadRecovery","SnapshotAttach","RecoveryUsing...` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest.properties.recoveryMode__added` | added | `{"type":"string","enum":["Invalid","FileRecovery","WorkloadRecovery","SnapshotAttach","RecoveryUsing...` |
| `definitions.AzureWorkloadSAPHanaRestoreWithRehydrateRequest.properties.recoveryMode__added` | added | `{"type":"string","enum":["Invalid","FileRecovery","WorkloadRecovery","SnapshotAttach","RecoveryUsing...` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreRequest.properties.recoveryMode__added` | added | `{"type":"string","enum":["Invalid","FileRecovery","WorkloadRecovery","SnapshotAttach","RecoveryUsing...` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest.properties.recoveryMode__added` | added | `{"type":"string","enum":["Invalid","FileRecovery","WorkloadRecovery","SnapshotAttach","RecoveryUsing...` |
| `definitions.AzureWorkloadSQLRestoreRequest.properties.recoveryMode__added` | added | `{"type":"string","enum":["Invalid","FileRecovery","WorkloadRecovery","SnapshotAttach","RecoveryUsing...` |
| `definitions.AzureWorkloadSQLRestoreWithRehydrateRequest.properties.recoveryMode__added` | added | `{"type":"string","enum":["Invalid","FileRecovery","WorkloadRecovery","SnapshotAttach","RecoveryUsing...` |

### Changes for `targetResourceGroupName`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadPointInTimeRestoreRequest.properties.targetResourceGroupName__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSAPAsePointInTimeRestoreRequest.properties.targetResourceGroupName__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreRequest.properties.targetResourceGroupName__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest.properties.targetResourceGroupName__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSAPHanaRestoreWithRehydrateRequest.properties.targetResourceGroupName__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreRequest.properties.targetResourceGroupName__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest.properties.targetResourceGroupName__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSQLRestoreRequest.properties.targetResourceGroupName__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSQLRestoreWithRehydrateRequest.properties.targetResourceGroupName__added` | added | `{"type":"string"}` |

### Changes for `userAssignedManagedIdentityDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadPointInTimeRestoreRequest.properties.userAssignedManagedIdentityDetails__added` | added | `{"$ref":"#/definitions/UserAssignedManagedIdentityDetails"}` |
| `definitions.AzureWorkloadSAPAsePointInTimeRestoreRequest.properties.userAssignedManagedIdentityDetails__added` | added | `{"$ref":"#/definitions/UserAssignedManagedIdentityDetails"}` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreRequest.properties.userAssignedManagedIdentityDetails__added` | added | `{"$ref":"#/definitions/UserAssignedManagedIdentityDetails"}` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest.properties.userAssignedManagedIdentityDetails__added` | added | `{"$ref":"#/definitions/UserAssignedManagedIdentityDetails"}` |
| `definitions.AzureWorkloadSAPHanaRestoreWithRehydrateRequest.properties.userAssignedManagedIdentityDetails__added` | added | `{"$ref":"#/definitions/UserAssignedManagedIdentityDetails"}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreRequest.properties.userAssignedManagedIdentityDetails__added` | added | `{"$ref":"#/definitions/UserAssignedManagedIdentityDetails"}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest.properties.userAssignedManagedIdentityDetails__added` | added | `{"$ref":"#/definitions/UserAssignedManagedIdentityDetails"}` |
| `definitions.AzureWorkloadSQLRestoreRequest.properties.userAssignedManagedIdentityDetails__added` | added | `{"$ref":"#/definitions/UserAssignedManagedIdentityDetails"}` |
| `definitions.AzureWorkloadSQLRestoreWithRehydrateRequest.properties.userAssignedManagedIdentityDetails__added` | added | `{"$ref":"#/definitions/UserAssignedManagedIdentityDetails"}` |

### Changes for `snapshotRestoreParameters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadPointInTimeRestoreRequest.properties.snapshotRestoreParameters__added` | added | `{"$ref":"#/definitions/SnapshotRestoreParameters"}` |
| `definitions.AzureWorkloadSAPAsePointInTimeRestoreRequest.properties.snapshotRestoreParameters__added` | added | `{"$ref":"#/definitions/SnapshotRestoreParameters"}` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreRequest.properties.snapshotRestoreParameters__added` | added | `{"$ref":"#/definitions/SnapshotRestoreParameters"}` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest.properties.snapshotRestoreParameters__added` | added | `{"$ref":"#/definitions/SnapshotRestoreParameters"}` |
| `definitions.AzureWorkloadSAPHanaRestoreWithRehydrateRequest.properties.snapshotRestoreParameters__added` | added | `{"$ref":"#/definitions/SnapshotRestoreParameters"}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreRequest.properties.snapshotRestoreParameters__added` | added | `{"$ref":"#/definitions/SnapshotRestoreParameters"}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest.properties.snapshotRestoreParameters__added` | added | `{"$ref":"#/definitions/SnapshotRestoreParameters"}` |
| `definitions.AzureWorkloadSQLRestoreRequest.properties.snapshotRestoreParameters__added` | added | `{"$ref":"#/definitions/SnapshotRestoreParameters"}` |
| `definitions.AzureWorkloadSQLRestoreWithRehydrateRequest.properties.snapshotRestoreParameters__added` | added | `{"$ref":"#/definitions/SnapshotRestoreParameters"}` |

### Changes for `targetVirtualMachineId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadPointInTimeRestoreRequest.properties.targetVirtualMachineId__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSAPAsePointInTimeRestoreRequest.properties.targetVirtualMachineId__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreRequest.properties.targetVirtualMachineId__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest.properties.targetVirtualMachineId__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSAPHanaRestoreWithRehydrateRequest.properties.targetVirtualMachineId__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreRequest.properties.targetVirtualMachineId__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest.properties.targetVirtualMachineId__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSQLRestoreRequest.properties.targetVirtualMachineId__added` | added | `{"type":"string"}` |
| `definitions.AzureWorkloadSQLRestoreWithRehydrateRequest.properties.targetVirtualMachineId__added` | added | `{"type":"string"}` |
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.targetVirtualMachineId__added` | added | `{"type":"string"}` |

### Changes for `pointInTime`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest.properties.pointInTime__added` | added | `{"type":"string","format":"date-time"}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest.properties.pointInTime__added` | added | `{"type":"string","format":"date-time"}` |

### Changes for `extendedInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadSQLPointInTimeRecoveryPoint.properties.extendedInfo__added` | added | `{"$ref":"#/definitions/AzureWorkloadSQLRecoveryPointExtendedInfo"}` |

### Changes for `recoveryPointTimeInUTC`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadSQLPointInTimeRecoveryPoint.properties.recoveryPointTimeInUTC__added` | added | `{"type":"string","format":"date-time"}` |
| `definitions.AzureWorkloadSQLRecoveryPoint.properties.recoveryPointTimeInUTC__added` | added | `{"type":"string","format":"date-time"}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadSQLPointInTimeRecoveryPoint.properties.type__added` | added | `{"type":"string","enum":["Invalid","Full","Log","Differential","Incremental","SnapshotFull","Snapsho...` |
| `definitions.AzureWorkloadSQLRecoveryPoint.properties.type__added` | added | `{"type":"string","enum":["Invalid","Full","Log","Differential","Incremental","SnapshotFull","Snapsho...` |
| `definitions.CloudError.properties.error.type__deleted` | deleted | `object` |
| `definitions.InquiryValidation.properties.protectableItemCount.type__deleted` | deleted | `object` |
| `definitions.NewErrorResponse.properties.error.type__deleted` | deleted | `object` |

### Changes for `recoveryPointTierDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadSQLPointInTimeRecoveryPoint.properties.recoveryPointTierDetails__added` | added | `{"type":"array","items":{"$ref":"#/definitions/RecoveryPointTierInformationV2"}}` |
| `definitions.AzureWorkloadSQLRecoveryPoint.properties.recoveryPointTierDetails__added` | added | `{"type":"array","items":{"$ref":"#/definitions/RecoveryPointTierInformationV2"}}` |

### Changes for `recoveryPointMoveReadinessInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadSQLPointInTimeRecoveryPoint.properties.recoveryPointMoveReadinessInfo__added` | added | `{"type":"object","additionalProperties":{"$ref":"#/definitions/RecoveryPointMoveReadinessInfo"}}` |
| `definitions.AzureWorkloadSQLRecoveryPoint.properties.recoveryPointMoveReadinessInfo__added` | added | `{"type":"object","additionalProperties":{"$ref":"#/definitions/RecoveryPointMoveReadinessInfo"}}` |

### Changes for `recoveryPointProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadSQLPointInTimeRecoveryPoint.properties.recoveryPointProperties__added` | added | `{"$ref":"#/definitions/RecoveryPointProperties"}` |
| `definitions.AzureWorkloadSQLRecoveryPoint.properties.recoveryPointProperties__added` | added | `{"$ref":"#/definitions/RecoveryPointProperties"}` |

### Changes for `shouldUseAlternateTargetLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadSQLPointInTimeRestoreRequest.properties.shouldUseAlternateTargetLocation__added` | added | `{"type":"boolean"}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest.properties.shouldUseAlternateTargetLocation__added` | added | `{"type":"boolean"}` |
| `definitions.AzureWorkloadSQLRestoreWithRehydrateRequest.properties.shouldUseAlternateTargetLocation__added` | added | `{"type":"boolean"}` |

### Changes for `isNonRecoverable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadSQLPointInTimeRestoreRequest.properties.isNonRecoverable__added` | added | `{"type":"boolean"}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest.properties.isNonRecoverable__added` | added | `{"type":"boolean"}` |
| `definitions.AzureWorkloadSQLRestoreWithRehydrateRequest.properties.isNonRecoverable__added` | added | `{"type":"boolean"}` |

### Changes for `alternateDirectoryPaths`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureWorkloadSQLPointInTimeRestoreRequest.properties.alternateDirectoryPaths__added` | added | `{"type":"array","items":{"$ref":"#/definitions/SQLDataDirectoryMapping"}}` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest.properties.alternateDirectoryPaths__added` | added | `{"type":"array","items":{"$ref":"#/definitions/SQLDataDirectoryMapping"}}` |
| `definitions.AzureWorkloadSQLRestoreWithRehydrateRequest.properties.alternateDirectoryPaths__added` | added | `{"type":"array","items":{"$ref":"#/definitions/SQLDataDirectoryMapping"}}` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackupManagementUsageList.allOf__added` | added | `[{"$ref":"#/definitions/ResourceList"}]` |

### Changes for `x-ms-external`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudError['x-ms-external__deleted']` | deleted | `true` |
| `definitions.CloudErrorBody['x-ms-external__deleted']` | deleted | `true` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FetchTieringCostSavingsInfoForVaultRequest.required__deleted` | deleted | `["objectType","sourceTierType","targetTierType"]` |

### Changes for `recoveryPointId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.recoveryPointId__added` | added | `{"type":"string"}` |

### Changes for `targetResourceGroupId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.targetResourceGroupId__added` | added | `{"type":"string"}` |

### Changes for `storageAccountId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.storageAccountId__added` | added | `{"type":"string"}` |

### Changes for `virtualNetworkId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.virtualNetworkId__added` | added | `{"type":"string"}` |

### Changes for `subnetId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.subnetId__added` | added | `{"type":"string"}` |

### Changes for `targetDomainNameId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.targetDomainNameId__added` | added | `{"type":"string"}` |

### Changes for `region`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.region__added` | added | `{"type":"string"}` |

### Changes for `affinityGroup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.affinityGroup__added` | added | `{"type":"string"}` |

### Changes for `createNewCloudService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.createNewCloudService__added` | added | `{"type":"boolean"}` |

### Changes for `originalStorageAccountOption`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.originalStorageAccountOption__added` | added | `{"type":"boolean"}` |

### Changes for `encryptionDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.encryptionDetails__added` | added | `{"$ref":"#/definitions/EncryptionDetails"}` |

### Changes for `restoreDiskLunList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.restoreDiskLunList__added` | added | `{"type":"array","items":{"type":"integer","format":"int32"}}` |

### Changes for `restoreWithManagedDisks`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.restoreWithManagedDisks__added` | added | `{"type":"boolean"}` |

### Changes for `diskEncryptionSetId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.diskEncryptionSetId__added` | added | `{"type":"string"}` |

### Changes for `zones`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.zones__added` | added | `{"type":"array","items":{"type":"string"}}` |

### Changes for `identityInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.identityInfo__added` | added | `{"$ref":"#/definitions/IdentityInfo"}` |

### Changes for `identityBasedRestoreDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.identityBasedRestoreDetails__added` | added | `{"$ref":"#/definitions/IdentityBasedRestoreDetails"}` |

### Changes for `extendedLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.extendedLocation__added` | added | `{"$ref":"#/definitions/ExtendedLocation"}` |

### Changes for `securedVMDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.securedVMDetails__added` | added | `{"$ref":"#/definitions/SecuredVMDetails"}` |

### Changes for `targetDiskNetworkAccessSettings`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IaasVMRestoreWithRehydrationRequest.properties.targetDiskNetworkAccessSettings__added` | added | `{"$ref":"#/definitions/TargetDiskNetworkAccessSettings"}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NewErrorResponse.properties.error.$ref__added` | added | `#/definitions/NewErrorResponseError` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ProtectableContainer.properties.protectableContainerType.readOnly__deleted` | deleted | `false` |

### Changes for `modelAsString`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TargetDiskNetworkAccessSettings.properties.targetDiskNetworkAccessOption['x-ms-enum'].modelAsString__added` | added | `false` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AzureBackupServerContainer.allOf[0].$ref` | `#/definitions/DpmContainer` | `#/definitions/ProtectionContainer` |
| `definitions.AzureIaaSClassicComputeVMContainer.allOf[0].$ref` | `#/definitions/IaaSVMContainer` | `#/definitions/ProtectionContainer` |
| `definitions.AzureIaaSClassicComputeVMProtectableItem.allOf[0].$ref` | `#/definitions/IaaSVMProtectableItem` | `#/definitions/WorkloadProtectableItem` |
| `definitions.AzureIaaSClassicComputeVMProtectedItem.allOf[0].$ref` | `#/definitions/AzureIaaSVMProtectedItem` | `#/definitions/ProtectedItem` |
| `definitions.AzureIaaSComputeVMContainer.allOf[0].$ref` | `#/definitions/IaaSVMContainer` | `#/definitions/ProtectionContainer` |
| `definitions.AzureIaaSComputeVMProtectableItem.allOf[0].$ref` | `#/definitions/IaaSVMProtectableItem` | `#/definitions/WorkloadProtectableItem` |
| `definitions.AzureIaaSComputeVMProtectedItem.allOf[0].$ref` | `#/definitions/AzureIaaSVMProtectedItem` | `#/definitions/ProtectedItem` |
| `definitions.AzureSQLAGWorkloadContainerProtectionContainer.allOf[0].$ref` | `#/definitions/AzureWorkloadContainer` | `#/definitions/ProtectionContainer` |
| `definitions.AzureVMAppContainerProtectionContainer.allOf[0].$ref` | `#/definitions/AzureWorkloadContainer` | `#/definitions/ProtectionContainer` |
| `definitions.AzureVmWorkloadSAPAseDatabaseProtectableItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadProtectableItem` | `#/definitions/WorkloadProtectableItem` |
| `definitions.AzureVmWorkloadSAPAseDatabaseProtectedItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadProtectedItem` | `#/definitions/RecoveryPoint` |
| `definitions.AzureVmWorkloadSAPAseDatabaseWorkloadItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadItem` | `#/definitions/WorkloadItem` |
| `definitions.AzureVmWorkloadSAPAseSystemProtectableItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadProtectableItem` | `#/definitions/WorkloadProtectableItem` |
| `definitions.AzureVmWorkloadSAPAseSystemWorkloadItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadItem` | `#/definitions/WorkloadItem` |
| `definitions.AzureVmWorkloadSAPHanaDatabaseProtectableItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadProtectableItem` | `#/definitions/WorkloadProtectableItem` |
| `definitions.AzureVmWorkloadSAPHanaDatabaseProtectedItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadProtectedItem` | `#/definitions/RecoveryPoint` |
| `definitions.AzureVmWorkloadSAPHanaDatabaseWorkloadItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadItem` | `#/definitions/WorkloadItem` |
| `definitions.AzureVmWorkloadSAPHanaDBInstance.allOf[0].$ref` | `#/definitions/AzureVmWorkloadProtectableItem` | `#/definitions/WorkloadProtectableItem` |
| `definitions.AzureVmWorkloadSAPHanaDBInstanceProtectedItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadProtectedItem` | `#/definitions/RecoveryPoint` |
| `definitions.AzureVmWorkloadSAPHanaHSRProtectableItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadProtectableItem` | `#/definitions/WorkloadProtectableItem` |
| `definitions.AzureVmWorkloadSAPHanaSystemProtectableItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadProtectableItem` | `#/definitions/WorkloadProtectableItem` |
| `definitions.AzureVmWorkloadSAPHanaSystemWorkloadItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadItem` | `#/definitions/WorkloadItem` |
| `definitions.AzureVmWorkloadSQLAvailabilityGroupProtectableItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadProtectableItem` | `#/definitions/WorkloadProtectableItem` |
| `definitions.AzureVmWorkloadSQLDatabaseProtectableItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadProtectableItem` | `#/definitions/WorkloadProtectableItem` |
| `definitions.AzureVmWorkloadSQLDatabaseProtectedItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadProtectedItem` | `#/definitions/RecoveryPoint` |
| `definitions.AzureVmWorkloadSQLDatabaseWorkloadItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadItem` | `#/definitions/WorkloadItem` |
| `definitions.AzureVmWorkloadSQLInstanceProtectableItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadProtectableItem` | `#/definitions/WorkloadProtectableItem` |
| `definitions.AzureVmWorkloadSQLInstanceWorkloadItem.allOf[0].$ref` | `#/definitions/AzureVmWorkloadItem` | `#/definitions/WorkloadItem` |
| `definitions.AzureWorkloadAutoProtectionIntent.allOf[0].$ref` | `#/definitions/AzureRecoveryServiceVaultProtectionIntent` | `#/definitions/ProtectionIntent` |
| `definitions.AzureWorkloadPointInTimeRecoveryPoint.allOf[0].$ref` | `#/definitions/AzureWorkloadRecoveryPoint` | `#/definitions/RecoveryPoint` |
| `definitions.AzureWorkloadPointInTimeRestoreRequest.allOf[0].$ref` | `#/definitions/AzureWorkloadRestoreRequest` | `#/definitions/RestoreRequest` |
| `definitions.AzureWorkloadSAPAsePointInTimeRecoveryPoint.allOf[0].$ref` | `#/definitions/AzureWorkloadPointInTimeRecoveryPoint` | `#/definitions/RecoveryPoint` |
| `definitions.AzureWorkloadSAPAsePointInTimeRestoreRequest.allOf[0].$ref` | `#/definitions/AzureWorkloadSAPAseRestoreRequest` | `#/definitions/RestoreRequest` |
| `definitions.AzureWorkloadSAPAseRecoveryPoint.allOf[0].$ref` | `#/definitions/AzureWorkloadRecoveryPoint` | `#/definitions/RecoveryPoint` |
| `definitions.AzureWorkloadSAPAseRestoreRequest.allOf[0].$ref` | `#/definitions/AzureWorkloadRestoreRequest` | `#/definitions/RestoreRequest` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRecoveryPoint.allOf[0].$ref` | `#/definitions/AzureWorkloadPointInTimeRecoveryPoint` | `#/definitions/RecoveryPoint` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreRequest.allOf[0].$ref` | `#/definitions/AzureWorkloadSAPHanaRestoreRequest` | `#/definitions/RestoreRequest` |
| `definitions.AzureWorkloadSAPHanaPointInTimeRestoreWithRehydrateRequest.allOf[0].$ref` | `#/definitions/AzureWorkloadSAPHanaPointInTimeRestoreRequest` | `#/definitions/RestoreRequest` |
| `definitions.AzureWorkloadSAPHanaRecoveryPoint.allOf[0].$ref` | `#/definitions/AzureWorkloadRecoveryPoint` | `#/definitions/RecoveryPoint` |
| `definitions.AzureWorkloadSAPHanaRestoreRequest.allOf[0].$ref` | `#/definitions/AzureWorkloadRestoreRequest` | `#/definitions/RestoreRequest` |
| `definitions.AzureWorkloadSAPHanaRestoreWithRehydrateRequest.allOf[0].$ref` | `#/definitions/AzureWorkloadSAPHanaRestoreRequest` | `#/definitions/RestoreRequest` |
| `definitions.AzureWorkloadSQLAutoProtectionIntent.allOf[0].$ref` | `#/definitions/AzureWorkloadAutoProtectionIntent` | `#/definitions/ProtectionIntent` |
| `definitions.AzureWorkloadSQLPointInTimeRecoveryPoint.allOf[0].$ref` | `#/definitions/AzureWorkloadSQLRecoveryPoint` | `#/definitions/RecoveryPoint` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreRequest.allOf[0].$ref` | `#/definitions/AzureWorkloadSQLRestoreRequest` | `#/definitions/RestoreRequest` |
| `definitions.AzureWorkloadSQLPointInTimeRestoreWithRehydrateRequest.allOf[0].$ref` | `#/definitions/AzureWorkloadSQLPointInTimeRestoreRequest` | `#/definitions/RestoreRequest` |
| `definitions.AzureWorkloadSQLRecoveryPoint.allOf[0].$ref` | `#/definitions/AzureWorkloadRecoveryPoint` | `#/definitions/RecoveryPoint` |
| `definitions.AzureWorkloadSQLRestoreRequest.allOf[0].$ref` | `#/definitions/AzureWorkloadRestoreRequest` | `#/definitions/RestoreRequest` |
| `definitions.AzureWorkloadSQLRestoreWithRehydrateRequest.allOf[0].$ref` | `#/definitions/AzureWorkloadSQLRestoreRequest` | `#/definitions/RestoreRequest` |
| `definitions.CloudErrorBody.properties.additionalInfo.items.$ref` | `../../../../../common-types/resource-management/v1/types.json#/definitions/ErrorAdditionalInfo` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorAdditionalInfo` |
| `definitions.IaasVMRestoreWithRehydrationRequest.allOf[0].$ref` | `#/definitions/IaasVMRestoreRequest` | `#/definitions/RestoreRequest` |
| `definitions.ProtectionContainer.properties.containerType['x-ms-enum'].modelAsString` | `true` | `false` |
| `definitions.RecoveryPointTierInformation.properties.status['x-ms-enum'].modelAsString` | `false` | `true` |
| `definitions.RecoveryPointTierInformationV2.properties.type['x-ms-enum'].modelAsString` | `true` | `false` |
| `definitions.ValidateIaasVMRestoreOperationRequest.allOf[0].$ref` | `#/definitions/ValidateRestoreOperationRequest` | `#/definitions/ValidateOperationRequest` |
| `info.title` | `RecoveryServicesBackupClient` | `Recovery Services Backup Client` |
| `paths['/providers/Microsoft.RecoveryServices/operations'].get.responses.200.schema.$ref` | `#/definitions/ClientDiscoveryResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/OperationListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupconfig/vaultconfig'].get.responses.default.schema.$ref` | `#/definitions/NewErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupconfig/vaultconfig'].patch.responses.default.schema.$ref` | `#/definitions/NewErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupconfig/vaultconfig'].put.responses.default.schema.$ref` | `#/definitions/NewErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupDeletedProtectionContainers'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupEncryptionConfigs/backupResourceEncryptionConfig'].get.responses.default.schema.$ref` | `#/definitions/NewErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupEncryptionConfigs/backupResourceEncryptionConfig'].put.responses.default.schema.$ref` | `#/definitions/NewErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupEngines'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupEngines/{backupEngineName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/operationResults/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectableContainers'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/inquire'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/items'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/operationResults/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/backup'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/operationResults/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/operationsStatus/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}/move'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}/provisionInstantItemRecovery'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}/restore'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}/revokeInstantItemRecovery'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPointsRecommendedForMove'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/refreshContainers'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupJobs'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupJobs/{jobName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupJobs/{jobName}/cancel'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupJobs/{jobName}/operationResults/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupJobs/operationResults/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupJobsExport'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupOperationResults/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupOperations/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupPolicies'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupPolicies/{policyName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupPolicies/{policyName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupPolicies/{policyName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupPolicies/{policyName}/operationResults/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupPolicies/{policyName}/operations/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectableItems'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectedItems'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectionContainers'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupResourceGuardProxies'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupResourceGuardProxies/{resourceGuardProxyName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupResourceGuardProxies/{resourceGuardProxyName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupResourceGuardProxies/{resourceGuardProxyName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupResourceGuardProxies/{resourceGuardProxyName}/unlockDelete'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupSecurityPIN'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig'].get.responses.default.schema.$ref` | `#/definitions/NewErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig'].patch.responses.default.schema.$ref` | `#/definitions/NewErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig'].put.responses.default.schema.$ref` | `#/definitions/NewErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig/operationResults/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/NewErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig/operationStatus/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/NewErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig/prepareDataMove'].post.responses.default.schema.$ref` | `#/definitions/NewErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig/triggerDataMove'].post.responses.default.schema.$ref` | `#/definitions/NewErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupTieringCost/default/fetchTieringCost'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupTieringCost/default/operationResults/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupTieringCost/default/operationsStatus/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupTriggerValidateOperation'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupValidateOperation'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupValidateOperationResults/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupValidateOperationsStatuses/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.responses.default.schema.$ref` | `#/definitions/NewErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/privateEndpointConnections/{privateEndpointConnectionName}/operationsStatus/{operationId}'].get.responses.default.schema.$ref` | `#/definitions/NewErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

