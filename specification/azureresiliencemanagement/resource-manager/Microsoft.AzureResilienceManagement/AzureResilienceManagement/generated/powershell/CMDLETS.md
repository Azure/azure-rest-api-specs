# Az.AzureResilienceManagement - Cmdlet Index

Generated from `package-2026-08-31-preview` using `@autorest/powershell@4.0.758`.

- **Total cmdlets:** 417
- **Distinct nouns (resource types):** 34

Every cmdlet ends in an underscore + variant suffix (e.g. `_Get`, `_List`, `_GetViaIdentity`, `_UpdateExpanded`, `_ViaJsonString`). See [AutoRest cmdlet variants](https://github.com/Azure/autorest.powershell/blob/main/docs/design/cmdlet-variants.md) for what each suffix means.

Parameter tables below hide PowerShell common parameters and HTTP-pipeline plumbing (Verbose/Debug/ErrorAction/DefaultProfile/HttpPipeline*/Proxy*/PassThru/AsJob/NoWait/WhatIf/Confirm). Only domain-relevant parameters are shown.

## Verb summary

| Verb | Count |
|------|------:|
| Get | 73 |
| Update | 71 |
| Test | 68 |
| Invoke | 56 |
| New | 50 |
| Set | 24 |
| Add | 18 |
| Stop | 18 |
| Remove | 17 |
| Resume | 14 |
| Start | 8 |

## Cmdlets grouped by noun

### AzureResilienceManagementCommitRecoveryPlanActionFailover _(count: 3)_

<details><summary><code>Invoke-AzureResilienceManagementCommitRecoveryPlanActionFailover_Commit</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementCommitRecoveryPlanActionFailover_CommitViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementCommitRecoveryPlanActionFailover_CommitViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>


### AzureResilienceManagementDrill _(count: 47)_

<details><summary><code>Get-AzureResilienceManagementDrill_Get</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | DrillName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementDrill_GetViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementDrill_GetViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | DrillName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementDrill_List</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `ServiceGroupName` | `String` | yes |  |
| `SkipToken` | `String` |  |  |
| `Top` | `Int32` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementDrill_Create</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | DrillName |
| `Resource` | `IDrill` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementDrill_CreateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | DrillName |
| `ServiceGroupName` | `String` | yes |  |
| `ChaosResourceIdentityForFaultType` | `String` |  |  |
| `ChaosResourceIdentityForFaultUserAssignedIdentity` | `String` |  |  |
| `ChaosResourcePropertiesIdentityType` | `String` |  |  |
| `ChaosResourcePropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `DrillAssetPropertyRegion` | `String` |  |  |
| `DrillAssetPropertyResourceGroup` | `String` |  |  |
| `DrillAssetPropertySubscription` | `String` |  |  |
| `DrillType` | `String` |  |  |
| `HealthModelMonitoringPropertiesIdentityType` | `String` |  |  |
| `HealthModelMonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `HealthModelMonitoringPropertyDiscoveryRuleId` | `String` |  |  |
| `IdentityType` | `String` |  |  |
| `MonitoringPropertiesIdentityType` | `String` |  |  |
| `MonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `RbacSetupMode` | `String` |  |  |
| `RecoveryPlanPropertiesIdentityType` | `String` |  |  |
| `RecoveryPlanPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `SliMonitoringPropertiesIdentityType` | `String` |  |  |
| `SliMonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `SliMonitoringPropertySli` | `ISliSelection[]` |  |  |
| `UserAssignedIdentity` | `String[]` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementDrill_CreateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Resource` | `IDrill` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementDrill_CreateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ChaosResourceIdentityForFaultType` | `String` |  |  |
| `ChaosResourceIdentityForFaultUserAssignedIdentity` | `String` |  |  |
| `ChaosResourcePropertiesIdentityType` | `String` |  |  |
| `ChaosResourcePropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `DrillAssetPropertyRegion` | `String` |  |  |
| `DrillAssetPropertyResourceGroup` | `String` |  |  |
| `DrillAssetPropertySubscription` | `String` |  |  |
| `DrillType` | `String` |  |  |
| `HealthModelMonitoringPropertiesIdentityType` | `String` |  |  |
| `HealthModelMonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `HealthModelMonitoringPropertyDiscoveryRuleId` | `String` |  |  |
| `IdentityType` | `String` |  |  |
| `MonitoringPropertiesIdentityType` | `String` |  |  |
| `MonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `RbacSetupMode` | `String` |  |  |
| `RecoveryPlanPropertiesIdentityType` | `String` |  |  |
| `RecoveryPlanPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `SliMonitoringPropertiesIdentityType` | `String` |  |  |
| `SliMonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `SliMonitoringPropertySli` | `ISliSelection[]` |  |  |
| `UserAssignedIdentity` | `String[]` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementDrill_CreateViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | DrillName |
| `Resource` | `IDrill` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementDrill_CreateViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | DrillName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ChaosResourceIdentityForFaultType` | `String` |  |  |
| `ChaosResourceIdentityForFaultUserAssignedIdentity` | `String` |  |  |
| `ChaosResourcePropertiesIdentityType` | `String` |  |  |
| `ChaosResourcePropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `DrillAssetPropertyRegion` | `String` |  |  |
| `DrillAssetPropertyResourceGroup` | `String` |  |  |
| `DrillAssetPropertySubscription` | `String` |  |  |
| `DrillType` | `String` |  |  |
| `HealthModelMonitoringPropertiesIdentityType` | `String` |  |  |
| `HealthModelMonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `HealthModelMonitoringPropertyDiscoveryRuleId` | `String` |  |  |
| `IdentityType` | `String` |  |  |
| `MonitoringPropertiesIdentityType` | `String` |  |  |
| `MonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `RbacSetupMode` | `String` |  |  |
| `RecoveryPlanPropertiesIdentityType` | `String` |  |  |
| `RecoveryPlanPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `SliMonitoringPropertiesIdentityType` | `String` |  |  |
| `SliMonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `SliMonitoringPropertySli` | `ISliSelection[]` |  |  |
| `UserAssignedIdentity` | `String[]` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementDrill_CreateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | DrillName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementDrill_CreateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | DrillName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementDrill_Delete</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | DrillName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementDrill_DeleteViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementDrill_DeleteViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | DrillName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Start-AzureResilienceManagementDrill_Start</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillStartRequest` | yes |  |
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Start-AzureResilienceManagementDrill_StartExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Start-AzureResilienceManagementDrill_StartViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillStartRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Start-AzureResilienceManagementDrill_StartViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Start-AzureResilienceManagementDrill_StartViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillStartRequest` | yes |  |
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Start-AzureResilienceManagementDrill_StartViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Start-AzureResilienceManagementDrill_StartViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Start-AzureResilienceManagementDrill_StartViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementDrill_End</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillEndRequest` | yes |  |
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementDrill_EndExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Attestation` | `String` | yes |  |
| `AttestationNote` | `String` | yes |  |
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementDrill_EndViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillEndRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementDrill_EndViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Attestation` | `String` | yes |  |
| `AttestationNote` | `String` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementDrill_EndViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillEndRequest` | yes |  |
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementDrill_EndViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Attestation` | `String` | yes |  |
| `AttestationNote` | `String` | yes |  |
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementDrill_EndViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementDrill_EndViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementDrill_Validate</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IValidateForExecutionRequest` | yes |  |
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementDrill_ValidateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `ValidateForExecutionPropertyOperationName` | `String` |  |  |
| `ValidateForExecutionPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementDrill_ValidateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IValidateForExecutionRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementDrill_ValidateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |
| `ValidateForExecutionPropertyOperationName` | `String` |  |  |
| `ValidateForExecutionPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementDrill_ValidateViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IValidateForExecutionRequest` | yes |  |
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementDrill_ValidateViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ValidateForExecutionPropertyOperationName` | `String` |  |  |
| `ValidateForExecutionPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementDrill_ValidateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementDrill_ValidateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | DrillName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementDrill_Update</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | DrillName |
| `Property` | `IDrillUpdate` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementDrill_UpdateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | DrillName |
| `ServiceGroupName` | `String` | yes |  |
| `ChaosResourceIdentityForFaultType` | `String` |  |  |
| `ChaosResourceIdentityForFaultUserAssignedIdentity` | `String` |  |  |
| `ChaosResourcePropertiesIdentityType` | `String` |  |  |
| `ChaosResourcePropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `DrillAssetPropertyRegion` | `String` |  |  |
| `DrillAssetPropertySubscription` | `String` |  |  |
| `HealthModelMonitoringPropertiesIdentityType` | `String` |  |  |
| `HealthModelMonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `HealthModelMonitoringPropertyDiscoveryRuleId` | `String` |  |  |
| `IdentityType` | `String` |  |  |
| `MonitoringPropertiesIdentityType` | `String` |  |  |
| `MonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `RbacSetupMode` | `String` |  |  |
| `RecoveryPlanPropertiesIdentityType` | `String` |  |  |
| `RecoveryPlanPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `SliMonitoringPropertiesIdentityType` | `String` |  |  |
| `SliMonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `SliMonitoringPropertySli` | `ISliSelection[]` |  |  |
| `UserAssignedIdentity` | `String[]` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementDrill_UpdateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Property` | `IDrillUpdate` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementDrill_UpdateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ChaosResourceIdentityForFaultType` | `String` |  |  |
| `ChaosResourceIdentityForFaultUserAssignedIdentity` | `String` |  |  |
| `ChaosResourcePropertiesIdentityType` | `String` |  |  |
| `ChaosResourcePropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `DrillAssetPropertyRegion` | `String` |  |  |
| `DrillAssetPropertySubscription` | `String` |  |  |
| `HealthModelMonitoringPropertiesIdentityType` | `String` |  |  |
| `HealthModelMonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `HealthModelMonitoringPropertyDiscoveryRuleId` | `String` |  |  |
| `IdentityType` | `String` |  |  |
| `MonitoringPropertiesIdentityType` | `String` |  |  |
| `MonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `RbacSetupMode` | `String` |  |  |
| `RecoveryPlanPropertiesIdentityType` | `String` |  |  |
| `RecoveryPlanPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `SliMonitoringPropertiesIdentityType` | `String` |  |  |
| `SliMonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `SliMonitoringPropertySli` | `ISliSelection[]` |  |  |
| `UserAssignedIdentity` | `String[]` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementDrill_UpdateViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | DrillName |
| `Property` | `IDrillUpdate` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementDrill_UpdateViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | DrillName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ChaosResourceIdentityForFaultType` | `String` |  |  |
| `ChaosResourceIdentityForFaultUserAssignedIdentity` | `String` |  |  |
| `ChaosResourcePropertiesIdentityType` | `String` |  |  |
| `ChaosResourcePropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `DrillAssetPropertyRegion` | `String` |  |  |
| `DrillAssetPropertySubscription` | `String` |  |  |
| `HealthModelMonitoringPropertiesIdentityType` | `String` |  |  |
| `HealthModelMonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `HealthModelMonitoringPropertyDiscoveryRuleId` | `String` |  |  |
| `IdentityType` | `String` |  |  |
| `MonitoringPropertiesIdentityType` | `String` |  |  |
| `MonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `RbacSetupMode` | `String` |  |  |
| `RecoveryPlanPropertiesIdentityType` | `String` |  |  |
| `RecoveryPlanPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `SliMonitoringPropertiesIdentityType` | `String` |  |  |
| `SliMonitoringPropertiesIdentityUserAssignedIdentity` | `String` |  |  |
| `SliMonitoringPropertySli` | `ISliSelection[]` |  |  |
| `UserAssignedIdentity` | `String[]` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementDrill_UpdateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | DrillName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementDrill_UpdateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | DrillName |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementDrillResource _(count: 21)_

<details><summary><code>Add-AzureResilienceManagementDrillResource_Add</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IAddOrUpdateResourcesRequest` | yes |  |
| `DrillName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Add-AzureResilienceManagementDrillResource_AddExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `FaultDurationInMin` | `Int32` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `ForceInclusionAndUpdate` | `String` |  |  |
| `ResourceListExcludeResource` | `String[]` |  |  |
| `ResourceListIncludeResource` | `IIncludeOrUpdateResource[]` |  |  |
| `ResourceListUpdateResource` | `IIncludeOrUpdateResource[]` |  |  |

</details>

<details><summary><code>Add-AzureResilienceManagementDrillResource_AddViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IAddOrUpdateResourcesRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Add-AzureResilienceManagementDrillResource_AddViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `FaultDurationInMin` | `Int32` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |
| `ForceInclusionAndUpdate` | `String` |  |  |
| `ResourceListExcludeResource` | `String[]` |  |  |
| `ResourceListIncludeResource` | `IIncludeOrUpdateResource[]` |  |  |
| `ResourceListUpdateResource` | `IIncludeOrUpdateResource[]` |  |  |

</details>

<details><summary><code>Add-AzureResilienceManagementDrillResource_AddViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IAddOrUpdateResourcesRequest` | yes |  |
| `DrillName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Add-AzureResilienceManagementDrillResource_AddViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `FaultDurationInMin` | `Int32` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ForceInclusionAndUpdate` | `String` |  |  |
| `ResourceListExcludeResource` | `String[]` |  |  |
| `ResourceListIncludeResource` | `IIncludeOrUpdateResource[]` |  |  |
| `ResourceListUpdateResource` | `IIncludeOrUpdateResource[]` |  |  |

</details>

<details><summary><code>Add-AzureResilienceManagementDrillResource_AddViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `JsonFilePath` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Add-AzureResilienceManagementDrillResource_AddViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `JsonString` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillResource_Get</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `Name` | `String` | yes | DrillResourceName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillResource_GetViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillResource_GetViaIdentityDrill</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Name` | `String` | yes | DrillResourceName |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillResource_GetViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `Name` | `String` | yes | DrillResourceName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillResource_List</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `SkipToken` | `String` |  |  |
| `Top` | `Int32` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementDrillResource_Update</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IAddOrUpdateResourcesRequest` | yes |  |
| `DrillName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementDrillResource_UpdateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `FaultDurationInMin` | `Int32` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `ForceInclusionAndUpdate` | `String` |  |  |
| `ResourceListExcludeResource` | `String[]` |  |  |
| `ResourceListIncludeResource` | `IIncludeOrUpdateResource[]` |  |  |
| `ResourceListUpdateResource` | `IIncludeOrUpdateResource[]` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementDrillResource_UpdateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IAddOrUpdateResourcesRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementDrillResource_UpdateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `FaultDurationInMin` | `Int32` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |
| `ForceInclusionAndUpdate` | `String` |  |  |
| `ResourceListExcludeResource` | `String[]` |  |  |
| `ResourceListIncludeResource` | `IIncludeOrUpdateResource[]` |  |  |
| `ResourceListUpdateResource` | `IIncludeOrUpdateResource[]` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementDrillResource_UpdateViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IAddOrUpdateResourcesRequest` | yes |  |
| `DrillName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementDrillResource_UpdateViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `FaultDurationInMin` | `Int32` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ForceInclusionAndUpdate` | `String` |  |  |
| `ResourceListExcludeResource` | `String[]` |  |  |
| `ResourceListIncludeResource` | `IIncludeOrUpdateResource[]` |  |  |
| `ResourceListUpdateResource` | `IIncludeOrUpdateResource[]` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementDrillResource_UpdateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `JsonFilePath` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementDrillResource_UpdateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `JsonString` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementDrillResyncReadiness _(count: 3)_

<details><summary><code>Test-AzureResilienceManagementDrillResyncReadiness_Check</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementDrillResyncReadiness_CheckViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementDrillResyncReadiness_CheckViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>


### AzureResilienceManagementDrillRun _(count: 9)_

<details><summary><code>Get-AzureResilienceManagementDrillRun_Get</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `Name` | `String` | yes | DrillRunName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillRun_GetViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillRun_GetViaIdentityDrill</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Name` | `String` | yes | DrillRunName |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillRun_GetViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `Name` | `String` | yes | DrillRunName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillRun_List</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Resume-AzureResilienceManagementDrillRun_Resume</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `Name` | `String` | yes | DrillRunName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Resume-AzureResilienceManagementDrillRun_ResumeViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Resume-AzureResilienceManagementDrillRun_ResumeViaIdentityDrill</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Name` | `String` | yes | DrillRunName |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Resume-AzureResilienceManagementDrillRun_ResumeViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `Name` | `String` | yes | DrillRunName |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>


### AzureResilienceManagementDrillRunNote _(count: 10)_

<details><summary><code>Add-AzureResilienceManagementDrillRunNote_Add</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillRunAddNotesRequest` | yes |  |
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Add-AzureResilienceManagementDrillRunNote_AddExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `Note` | `String` |  |  |

</details>

<details><summary><code>Add-AzureResilienceManagementDrillRunNote_AddViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillRunAddNotesRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Add-AzureResilienceManagementDrillRunNote_AddViaIdentityDrill</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillRunAddNotesRequest` | yes |  |
| `DrillInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Add-AzureResilienceManagementDrillRunNote_AddViaIdentityDrillExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `Note` | `String` |  |  |

</details>

<details><summary><code>Add-AzureResilienceManagementDrillRunNote_AddViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |
| `Note` | `String` |  |  |

</details>

<details><summary><code>Add-AzureResilienceManagementDrillRunNote_AddViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillRunAddNotesRequest` | yes |  |
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Add-AzureResilienceManagementDrillRunNote_AddViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Note` | `String` |  |  |

</details>

<details><summary><code>Add-AzureResilienceManagementDrillRunNote_AddViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `JsonFilePath` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Add-AzureResilienceManagementDrillRunNote_AddViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `JsonString` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementDrillRunReport _(count: 4)_

<details><summary><code>New-AzureResilienceManagementDrillRunReport_Generate</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementDrillRunReport_GenerateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementDrillRunReport_GenerateViaIdentityDrill</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementDrillRunReport_GenerateViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>


### AzureResilienceManagementDrillRunReportDownloadUrl _(count: 4)_

<details><summary><code>Get-AzureResilienceManagementDrillRunReportDownloadUrl_List</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IListReportDownloadUrlRequest` | yes |  |
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillRunReportDownloadUrl_ListExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `Format` | `String` |  |  |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillRunReportDownloadUrl_ListViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `JsonFilePath` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillRunReportDownloadUrl_ListViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `JsonString` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementDrillRunResource _(count: 6)_

<details><summary><code>Get-AzureResilienceManagementDrillRunResource_Get</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `Name` | `String` | yes | DrillRunResourceName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillRunResource_GetViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillRunResource_GetViaIdentityDrill</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `Name` | `String` | yes | DrillRunResourceName |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillRunResource_GetViaIdentityDrillRun</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillRunInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Name` | `String` | yes | DrillRunResourceName |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillRunResource_GetViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `Name` | `String` | yes | DrillRunResourceName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementDrillRunResource_List</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementEnrollment _(count: 25)_

<details><summary><code>Get-AzureResilienceManagementEnrollment_Get</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | EnrollmentName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String[]` | yes |  |
| `UsagePlanName` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementEnrollment_GetViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementEnrollment_GetViaIdentityUsagePlan</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | EnrollmentName |
| `UsagePlanInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementEnrollment_List</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String[]` | yes |  |
| `UsagePlanName` | `String` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementEnrollment_Create</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | EnrollmentName |
| `Resource` | `IEnrollment` | yes |  |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |
| `UsagePlanName` | `String` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementEnrollment_CreateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | EnrollmentName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |
| `UsagePlanName` | `String` | yes |  |
| `ServiceGroupId` | `String` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementEnrollment_CreateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Resource` | `IEnrollment` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementEnrollment_CreateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ServiceGroupId` | `String` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementEnrollment_CreateViaIdentityUsagePlan</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | EnrollmentName |
| `Resource` | `IEnrollment` | yes |  |
| `UsagePlanInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementEnrollment_CreateViaIdentityUsagePlanExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | EnrollmentName |
| `UsagePlanInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ServiceGroupId` | `String` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementEnrollment_CreateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | EnrollmentName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |
| `UsagePlanName` | `String` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementEnrollment_CreateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | EnrollmentName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |
| `UsagePlanName` | `String` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementEnrollment_Delete</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | EnrollmentName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |
| `UsagePlanName` | `String` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementEnrollment_DeleteViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementEnrollment_DeleteViaIdentityUsagePlan</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | EnrollmentName |
| `UsagePlanInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementEnrollment_Update</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | EnrollmentName |
| `Resource` | `IEnrollment` | yes |  |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |
| `UsagePlanName` | `String` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementEnrollment_UpdateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | EnrollmentName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |
| `UsagePlanName` | `String` | yes |  |
| `ServiceGroupId` | `String` |  |  |

</details>

<details><summary><code>Set-AzureResilienceManagementEnrollment_UpdateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | EnrollmentName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |
| `UsagePlanName` | `String` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementEnrollment_UpdateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | EnrollmentName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |
| `UsagePlanName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementEnrollment_Update</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | EnrollmentName |
| `Resource` | `IEnrollment` | yes |  |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |
| `UsagePlanName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementEnrollment_UpdateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | EnrollmentName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |
| `UsagePlanName` | `String` | yes |  |
| `ServiceGroupId` | `String` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementEnrollment_UpdateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Resource` | `IEnrollment` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementEnrollment_UpdateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ServiceGroupId` | `String` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementEnrollment_UpdateViaIdentityUsagePlan</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | EnrollmentName |
| `Resource` | `IEnrollment` | yes |  |
| `UsagePlanInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementEnrollment_UpdateViaIdentityUsagePlanExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | EnrollmentName |
| `UsagePlanInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ServiceGroupId` | `String` |  |  |

</details>


### AzureResilienceManagementFailDrillRunOver _(count: 10)_

<details><summary><code>Invoke-AzureResilienceManagementFailDrillRunOver_Fail</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillRunFailoverRequest` | yes |  |
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementFailDrillRunOver_FailExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `AutoFailover` | `String` |  |  |
| `ExecutionConfigurationUserConsent` | `String` |  |  |
| `FailoverRequestPropertySelectedResourceId` | `String[]` |  |  |
| `FailoverRequestPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementFailDrillRunOver_FailViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillRunFailoverRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementFailDrillRunOver_FailViaIdentityDrill</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillRunFailoverRequest` | yes |  |
| `DrillInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementFailDrillRunOver_FailViaIdentityDrillExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `AutoFailover` | `String` |  |  |
| `ExecutionConfigurationUserConsent` | `String` |  |  |
| `FailoverRequestPropertySelectedResourceId` | `String[]` |  |  |
| `FailoverRequestPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementFailDrillRunOver_FailViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |
| `AutoFailover` | `String` |  |  |
| `ExecutionConfigurationUserConsent` | `String` |  |  |
| `FailoverRequestPropertySelectedResourceId` | `String[]` |  |  |
| `FailoverRequestPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementFailDrillRunOver_FailViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillRunFailoverRequest` | yes |  |
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementFailDrillRunOver_FailViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `AutoFailover` | `String` |  |  |
| `ExecutionConfigurationUserConsent` | `String` |  |  |
| `FailoverRequestPropertySelectedResourceId` | `String[]` |  |  |
| `FailoverRequestPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementFailDrillRunOver_FailViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `JsonFilePath` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementFailDrillRunOver_FailViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `JsonString` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementFinalizeRecoveryPlanAction _(count: 3)_

<details><summary><code>Invoke-AzureResilienceManagementFinalizeRecoveryPlanAction_Finalize</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementFinalizeRecoveryPlanAction_FinalizeViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementFinalizeRecoveryPlanAction_FinalizeViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>


### AzureResilienceManagementGoalAssignment _(count: 27)_

<details><summary><code>Get-AzureResilienceManagementGoalAssignment_Get</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalAssignmentName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementGoalAssignment_GetViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementGoalAssignment_GetViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalAssignmentName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementGoalAssignment_List</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `ServiceGroupName` | `String` | yes |  |
| `SkipToken` | `String` |  |  |
| `Top` | `Int32` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementGoalAssignment_Create</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalAssignmentName |
| `Resource` | `IGoalAssignment` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementGoalAssignment_CreateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalAssignmentName |
| `ServiceGroupName` | `String` | yes |  |
| `GoalAssignmentType` | `String` |  |  |
| `GoalTemplateId` | `String` |  |  |
| `RequireZonalResiliency` | `SwitchParameter` |  |  |
| `ServiceLevelResource` | `IServiceLevelResource[]` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementGoalAssignment_CreateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Resource` | `IGoalAssignment` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementGoalAssignment_CreateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `GoalAssignmentType` | `String` |  |  |
| `GoalTemplateId` | `String` |  |  |
| `RequireZonalResiliency` | `SwitchParameter` |  |  |
| `ServiceLevelResource` | `IServiceLevelResource[]` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementGoalAssignment_CreateViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalAssignmentName |
| `Resource` | `IGoalAssignment` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementGoalAssignment_CreateViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalAssignmentName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `GoalAssignmentType` | `String` |  |  |
| `GoalTemplateId` | `String` |  |  |
| `RequireZonalResiliency` | `SwitchParameter` |  |  |
| `ServiceLevelResource` | `IServiceLevelResource[]` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementGoalAssignment_CreateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | GoalAssignmentName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementGoalAssignment_CreateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | GoalAssignmentName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementGoalAssignment_Delete</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalAssignmentName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementGoalAssignment_DeleteViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementGoalAssignment_DeleteViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalAssignmentName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementGoalAssignment_Update</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalAssignmentName |
| `Resource` | `IGoalAssignment` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementGoalAssignment_UpdateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalAssignmentName |
| `ServiceGroupName` | `String` | yes |  |
| `GoalAssignmentType` | `String` |  |  |
| `GoalTemplateId` | `String` |  |  |
| `RequireZonalResiliency` | `SwitchParameter` |  |  |
| `ServiceLevelResource` | `IServiceLevelResource[]` |  |  |

</details>

<details><summary><code>Set-AzureResilienceManagementGoalAssignment_UpdateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | GoalAssignmentName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementGoalAssignment_UpdateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | GoalAssignmentName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignment_Update</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalAssignmentName |
| `Property` | `IGoalAssignmentUpdate` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignment_UpdateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalAssignmentName |
| `ServiceGroupName` | `String` | yes |  |
| `GoalAssignmentType` | `String` |  |  |
| `GoalTemplateId` | `String` |  |  |
| `RequireZonalResiliency` | `SwitchParameter` |  |  |
| `ServiceLevelResource` | `IServiceLevelResource[]` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignment_UpdateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Property` | `IGoalAssignmentUpdate` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignment_UpdateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `GoalAssignmentType` | `String` |  |  |
| `GoalTemplateId` | `String` |  |  |
| `RequireZonalResiliency` | `SwitchParameter` |  |  |
| `ServiceLevelResource` | `IServiceLevelResource[]` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignment_UpdateViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalAssignmentName |
| `Property` | `IGoalAssignmentUpdate` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignment_UpdateViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalAssignmentName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `GoalAssignmentType` | `String` |  |  |
| `GoalTemplateId` | `String` |  |  |
| `RequireZonalResiliency` | `SwitchParameter` |  |  |
| `ServiceLevelResource` | `IServiceLevelResource[]` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignment_UpdateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | GoalAssignmentName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignment_UpdateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | GoalAssignmentName |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementGoalAssignmentGoalResource _(count: 11)_

<details><summary><code>Update-AzureResilienceManagementGoalAssignmentGoalResource_Refresh</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `GoalAssignmentName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignmentGoalResource_RefreshViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignmentGoalResource_RefreshViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `GoalAssignmentName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignmentGoalResource_Update</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IUpdateGoalResourceRequest` | yes |  |
| `GoalAssignmentName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignmentGoalResource_UpdateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `GoalAssignmentName` | `String` | yes |  |
| `Resource` | `IGoalResource[]` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignmentGoalResource_UpdateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IUpdateGoalResourceRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignmentGoalResource_UpdateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Resource` | `IGoalResource[]` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignmentGoalResource_UpdateViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IUpdateGoalResourceRequest` | yes |  |
| `GoalAssignmentName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignmentGoalResource_UpdateViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `GoalAssignmentName` | `String` | yes |  |
| `Resource` | `IGoalResource[]` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignmentGoalResource_UpdateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `GoalAssignmentName` | `String` | yes |  |
| `JsonFilePath` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalAssignmentGoalResource_UpdateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `GoalAssignmentName` | `String` | yes |  |
| `JsonString` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementGoalResource _(count: 5)_

<details><summary><code>Get-AzureResilienceManagementGoalResource_Get</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `GoalAssignmentName` | `String` | yes |  |
| `Name` | `String` | yes | GoalResourceName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementGoalResource_GetViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementGoalResource_GetViaIdentityGoalAssignment</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `GoalAssignmentInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Name` | `String` | yes | GoalResourceName |

</details>

<details><summary><code>Get-AzureResilienceManagementGoalResource_GetViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `GoalAssignmentName` | `String` | yes |  |
| `Name` | `String` | yes | GoalResourceName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementGoalResource_List</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `GoalAssignmentName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `SkipToken` | `String` |  |  |
| `Top` | `Int32` |  |  |

</details>


### AzureResilienceManagementGoalTemplate _(count: 27)_

<details><summary><code>Get-AzureResilienceManagementGoalTemplate_Get</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalTemplateName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementGoalTemplate_GetViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementGoalTemplate_GetViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalTemplateName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementGoalTemplate_List</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `ServiceGroupName` | `String` | yes |  |
| `SkipToken` | `String` |  |  |
| `Top` | `Int32` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementGoalTemplate_Create</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalTemplateName |
| `Resource` | `IGoalTemplate` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementGoalTemplate_CreateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalTemplateName |
| `ServiceGroupName` | `String` | yes |  |
| `RegionalRecoveryPointObjective` | `String` |  |  |
| `RegionalRecoveryTimeObjective` | `String` |  |  |
| `RequireDisasterRecovery` | `String` |  |  |
| `RequireHighAvailability` | `String` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementGoalTemplate_CreateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Resource` | `IGoalTemplate` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementGoalTemplate_CreateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `RegionalRecoveryPointObjective` | `String` |  |  |
| `RegionalRecoveryTimeObjective` | `String` |  |  |
| `RequireDisasterRecovery` | `String` |  |  |
| `RequireHighAvailability` | `String` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementGoalTemplate_CreateViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalTemplateName |
| `Resource` | `IGoalTemplate` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementGoalTemplate_CreateViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalTemplateName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `RegionalRecoveryPointObjective` | `String` |  |  |
| `RegionalRecoveryTimeObjective` | `String` |  |  |
| `RequireDisasterRecovery` | `String` |  |  |
| `RequireHighAvailability` | `String` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementGoalTemplate_CreateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | GoalTemplateName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementGoalTemplate_CreateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | GoalTemplateName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementGoalTemplate_Delete</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalTemplateName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementGoalTemplate_DeleteViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementGoalTemplate_DeleteViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalTemplateName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementGoalTemplate_Update</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalTemplateName |
| `Resource` | `IGoalTemplate` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementGoalTemplate_UpdateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalTemplateName |
| `ServiceGroupName` | `String` | yes |  |
| `RegionalRecoveryPointObjective` | `String` |  |  |
| `RegionalRecoveryTimeObjective` | `String` |  |  |
| `RequireDisasterRecovery` | `String` |  |  |
| `RequireHighAvailability` | `String` |  |  |

</details>

<details><summary><code>Set-AzureResilienceManagementGoalTemplate_UpdateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | GoalTemplateName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementGoalTemplate_UpdateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | GoalTemplateName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalTemplate_Update</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalTemplateName |
| `Property` | `IGoalTemplateUpdate` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalTemplate_UpdateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalTemplateName |
| `ServiceGroupName` | `String` | yes |  |
| `GoalType` | `String` |  |  |
| `RegionalRecoveryPointObjective` | `String` |  |  |
| `RegionalRecoveryTimeObjective` | `String` |  |  |
| `RequireDisasterRecovery` | `String` |  |  |
| `RequireHighAvailability` | `String` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalTemplate_UpdateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Property` | `IGoalTemplateUpdate` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalTemplate_UpdateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `GoalType` | `String` |  |  |
| `RegionalRecoveryPointObjective` | `String` |  |  |
| `RegionalRecoveryTimeObjective` | `String` |  |  |
| `RequireDisasterRecovery` | `String` |  |  |
| `RequireHighAvailability` | `String` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalTemplate_UpdateViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalTemplateName |
| `Property` | `IGoalTemplateUpdate` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalTemplate_UpdateViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | GoalTemplateName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `GoalType` | `String` |  |  |
| `RegionalRecoveryPointObjective` | `String` |  |  |
| `RegionalRecoveryTimeObjective` | `String` |  |  |
| `RequireDisasterRecovery` | `String` |  |  |
| `RequireHighAvailability` | `String` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalTemplate_UpdateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | GoalTemplateName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementGoalTemplate_UpdateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | GoalTemplateName |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementMarkDrillRunAsComplete _(count: 10)_

<details><summary><code>Invoke-AzureResilienceManagementMarkDrillRunAsComplete_Mark</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IMarkAsCompleteRequest` | yes |  |
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementMarkDrillRunAsComplete_MarkExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `DrillRunStage` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementMarkDrillRunAsComplete_MarkViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IMarkAsCompleteRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementMarkDrillRunAsComplete_MarkViaIdentityDrill</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IMarkAsCompleteRequest` | yes |  |
| `DrillInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementMarkDrillRunAsComplete_MarkViaIdentityDrillExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `DrillRunStage` | `String` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementMarkDrillRunAsComplete_MarkViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillRunStage` | `String` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementMarkDrillRunAsComplete_MarkViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IMarkAsCompleteRequest` | yes |  |
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementMarkDrillRunAsComplete_MarkViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `DrillRunStage` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementMarkDrillRunAsComplete_MarkViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `JsonFilePath` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementMarkDrillRunAsComplete_MarkViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `JsonString` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementOperation _(count: 1)_

<details><summary><code>Get-AzureResilienceManagementOperation_List</code></summary>

_(no domain parameters)_

</details>


### AzureResilienceManagementOperationStatus _(count: 3)_

<details><summary><code>Get-AzureResilienceManagementOperationStatus_Get</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Location` | `String` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementOperationStatus_GetViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementOperationStatus_GetViaIdentityLocation</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `LocationInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>


### AzureResilienceManagementRecommendGoalAssignmentCapacity _(count: 8)_

<details><summary><code>Invoke-AzureResilienceManagementRecommendGoalAssignmentCapacity_Recommend</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IRecommendCapacityRequest` | yes |  |
| `GoalAssignmentName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementRecommendGoalAssignmentCapacity_RecommendExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `GoalAssignmentName` | `String` | yes |  |
| `ResourceId` | `String[]` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementRecommendGoalAssignmentCapacity_RecommendViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IRecommendCapacityRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementRecommendGoalAssignmentCapacity_RecommendViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ResourceId` | `String[]` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementRecommendGoalAssignmentCapacity_RecommendViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IRecommendCapacityRequest` | yes |  |
| `GoalAssignmentName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementRecommendGoalAssignmentCapacity_RecommendViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `GoalAssignmentName` | `String` | yes |  |
| `ResourceId` | `String[]` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementRecommendGoalAssignmentCapacity_RecommendViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `GoalAssignmentName` | `String` | yes |  |
| `JsonFilePath` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementRecommendGoalAssignmentCapacity_RecommendViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `GoalAssignmentName` | `String` | yes |  |
| `JsonString` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementRecoveryJob _(count: 25)_

<details><summary><code>Get-AzureResilienceManagementRecoveryJob_Get</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryJobName |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementRecoveryJob_GetViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementRecoveryJob_GetViaIdentityRecoveryPlan</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryJobName |
| `RecoveryPlanInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementRecoveryJob_GetViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryJobName |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementRecoveryJob_List</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Resume-AzureResilienceManagementRecoveryJob_Resume</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IRecoveryActionRequest` | yes |  |
| `Name` | `String` | yes | RecoveryJobName |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Resume-AzureResilienceManagementRecoveryJob_ResumeExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryJobName |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `Description` | `String` |  |  |

</details>

<details><summary><code>Resume-AzureResilienceManagementRecoveryJob_ResumeViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IRecoveryActionRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Resume-AzureResilienceManagementRecoveryJob_ResumeViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |
| `Description` | `String` |  |  |

</details>

<details><summary><code>Resume-AzureResilienceManagementRecoveryJob_ResumeViaIdentityRecoveryPlan</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IRecoveryActionRequest` | yes |  |
| `Name` | `String` | yes | RecoveryJobName |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Resume-AzureResilienceManagementRecoveryJob_ResumeViaIdentityRecoveryPlanExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryJobName |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Description` | `String` |  |  |

</details>

<details><summary><code>Resume-AzureResilienceManagementRecoveryJob_ResumeViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IRecoveryActionRequest` | yes |  |
| `Name` | `String` | yes | RecoveryJobName |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Resume-AzureResilienceManagementRecoveryJob_ResumeViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryJobName |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Description` | `String` |  |  |

</details>

<details><summary><code>Resume-AzureResilienceManagementRecoveryJob_ResumeViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | RecoveryJobName |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Resume-AzureResilienceManagementRecoveryJob_ResumeViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | RecoveryJobName |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementRecoveryJob_Cancel</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IRecoveryActionRequest` | yes |  |
| `Name` | `String` | yes | RecoveryJobName |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementRecoveryJob_CancelExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryJobName |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `Description` | `String` |  |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementRecoveryJob_CancelViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IRecoveryActionRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementRecoveryJob_CancelViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |
| `Description` | `String` |  |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementRecoveryJob_CancelViaIdentityRecoveryPlan</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IRecoveryActionRequest` | yes |  |
| `Name` | `String` | yes | RecoveryJobName |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementRecoveryJob_CancelViaIdentityRecoveryPlanExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryJobName |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Description` | `String` |  |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementRecoveryJob_CancelViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IRecoveryActionRequest` | yes |  |
| `Name` | `String` | yes | RecoveryJobName |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementRecoveryJob_CancelViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryJobName |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Description` | `String` |  |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementRecoveryJob_CancelViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | RecoveryJobName |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Stop-AzureResilienceManagementRecoveryJob_CancelViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | RecoveryJobName |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementRecoveryJobResource _(count: 6)_

<details><summary><code>Get-AzureResilienceManagementRecoveryJobResource_Get</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryJobResourceName |
| `RecoveryJobName` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementRecoveryJobResource_GetViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementRecoveryJobResource_GetViaIdentityRecoveryJob</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryJobResourceName |
| `RecoveryJobInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementRecoveryJobResource_GetViaIdentityRecoveryPlan</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryJobResourceName |
| `RecoveryJobName` | `String` | yes |  |
| `RecoveryPlanInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementRecoveryJobResource_GetViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryJobResourceName |
| `RecoveryJobName` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementRecoveryJobResource_List</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `RecoveryJobName` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementRecoveryPlan _(count: 27)_

<details><summary><code>Get-AzureResilienceManagementRecoveryPlan_Get</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryPlanName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementRecoveryPlan_GetViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementRecoveryPlan_GetViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryPlanName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementRecoveryPlan_List</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `ServiceGroupName` | `String` | yes |  |
| `SkipToken` | `String` |  |  |
| `Top` | `Int32` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementRecoveryPlan_Create</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryPlanName |
| `Resource` | `IRecoveryPlan` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementRecoveryPlan_CreateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryPlanName |
| `ServiceGroupName` | `String` | yes |  |
| `Description` | `String` |  |  |
| `GroupUniqueId` | `String` |  |  |
| `IdentityType` | `String` |  |  |
| `OrderId` | `Int32` |  |  |
| `PlanDescription` | `String` |  |  |
| `PlanType` | `String` |  |  |
| `PostAction` | `IRecoveryGroupBaseAction[]` |  |  |
| `PreAction` | `IRecoveryGroupBaseAction[]` |  |  |
| `RecoveryGroupSettingAdditionalGroup` | `IRecoveryGroup[]` |  |  |
| `UserAssignedIdentity` | `String[]` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementRecoveryPlan_CreateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Resource` | `IRecoveryPlan` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementRecoveryPlan_CreateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Description` | `String` |  |  |
| `GroupUniqueId` | `String` |  |  |
| `IdentityType` | `String` |  |  |
| `OrderId` | `Int32` |  |  |
| `PlanDescription` | `String` |  |  |
| `PlanType` | `String` |  |  |
| `PostAction` | `IRecoveryGroupBaseAction[]` |  |  |
| `PreAction` | `IRecoveryGroupBaseAction[]` |  |  |
| `RecoveryGroupSettingAdditionalGroup` | `IRecoveryGroup[]` |  |  |
| `UserAssignedIdentity` | `String[]` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementRecoveryPlan_CreateViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryPlanName |
| `Resource` | `IRecoveryPlan` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementRecoveryPlan_CreateViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryPlanName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Description` | `String` |  |  |
| `GroupUniqueId` | `String` |  |  |
| `IdentityType` | `String` |  |  |
| `OrderId` | `Int32` |  |  |
| `PlanDescription` | `String` |  |  |
| `PlanType` | `String` |  |  |
| `PostAction` | `IRecoveryGroupBaseAction[]` |  |  |
| `PreAction` | `IRecoveryGroupBaseAction[]` |  |  |
| `RecoveryGroupSettingAdditionalGroup` | `IRecoveryGroup[]` |  |  |
| `UserAssignedIdentity` | `String[]` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementRecoveryPlan_CreateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | RecoveryPlanName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementRecoveryPlan_CreateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | RecoveryPlanName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementRecoveryPlan_Delete</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryPlanName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementRecoveryPlan_DeleteViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementRecoveryPlan_DeleteViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryPlanName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementRecoveryPlan_Update</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryPlanName |
| `Resource` | `IRecoveryPlan` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementRecoveryPlan_UpdateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryPlanName |
| `ServiceGroupName` | `String` | yes |  |
| `Description` | `String` |  |  |
| `GroupUniqueId` | `String` |  |  |
| `IdentityType` | `String` |  |  |
| `OrderId` | `Int32` |  |  |
| `PlanDescription` | `String` |  |  |
| `PlanType` | `String` |  |  |
| `PostAction` | `IRecoveryGroupBaseAction[]` |  |  |
| `PreAction` | `IRecoveryGroupBaseAction[]` |  |  |
| `RecoveryGroupSettingAdditionalGroup` | `IRecoveryGroup[]` |  |  |
| `UserAssignedIdentity` | `String[]` |  |  |

</details>

<details><summary><code>Set-AzureResilienceManagementRecoveryPlan_UpdateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | RecoveryPlanName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementRecoveryPlan_UpdateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | RecoveryPlanName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementRecoveryPlan_Update</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryPlanName |
| `Property` | `IRecoveryPlanUpdate` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementRecoveryPlan_UpdateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryPlanName |
| `ServiceGroupName` | `String` | yes |  |
| `Description` | `String` |  |  |
| `GroupUniqueId` | `String` |  |  |
| `IdentityType` | `String` |  |  |
| `OrderId` | `Int32` |  |  |
| `PlanDescription` | `String` |  |  |
| `PostAction` | `IRecoveryGroupBaseAction[]` |  |  |
| `PreAction` | `IRecoveryGroupBaseAction[]` |  |  |
| `RecoveryGroupSettingAdditionalGroup` | `IRecoveryGroup[]` |  |  |
| `UserAssignedIdentity` | `String[]` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementRecoveryPlan_UpdateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Property` | `IRecoveryPlanUpdate` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementRecoveryPlan_UpdateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Description` | `String` |  |  |
| `GroupUniqueId` | `String` |  |  |
| `IdentityType` | `String` |  |  |
| `OrderId` | `Int32` |  |  |
| `PlanDescription` | `String` |  |  |
| `PostAction` | `IRecoveryGroupBaseAction[]` |  |  |
| `PreAction` | `IRecoveryGroupBaseAction[]` |  |  |
| `RecoveryGroupSettingAdditionalGroup` | `IRecoveryGroup[]` |  |  |
| `UserAssignedIdentity` | `String[]` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementRecoveryPlan_UpdateViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryPlanName |
| `Property` | `IRecoveryPlanUpdate` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementRecoveryPlan_UpdateViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryPlanName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Description` | `String` |  |  |
| `GroupUniqueId` | `String` |  |  |
| `IdentityType` | `String` |  |  |
| `OrderId` | `Int32` |  |  |
| `PlanDescription` | `String` |  |  |
| `PostAction` | `IRecoveryGroupBaseAction[]` |  |  |
| `PreAction` | `IRecoveryGroupBaseAction[]` |  |  |
| `RecoveryGroupSettingAdditionalGroup` | `IRecoveryGroup[]` |  |  |
| `UserAssignedIdentity` | `String[]` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementRecoveryPlan_UpdateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | RecoveryPlanName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementRecoveryPlan_UpdateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | RecoveryPlanName |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementRecoveryPlanAction _(count: 42)_

<details><summary><code>Set-AzureResilienceManagementRecoveryPlanAction_Failover</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IFailoverRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementRecoveryPlanAction_FailoverExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `ExecutionConfigurationUserConsent` | `String` |  |  |
| `FailoverRequestPropertySelectedResourceId` | `String[]` |  |  |
| `FailoverRequestPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Set-AzureResilienceManagementRecoveryPlanAction_FailoverViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementRecoveryPlanAction_FailoverViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_Validate</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IFailoverRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_Validate1</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_Validate2</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IValidateForOperationRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_Validate3</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IReprotectRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_Validate4</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IFailoverRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_Validate5</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `ExecutionConfigurationUserConsent` | `String` |  |  |
| `FailoverRequestPropertySelectedResourceId` | `String[]` |  |  |
| `FailoverRequestPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateExpanded1</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `OperationName` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateExpanded2</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `ReprotectRequestPropertySelectedResourceId` | `String[]` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateExpanded3</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `ExecutionConfigurationUserConsent` | `String` |  |  |
| `FailoverRequestPropertySelectedResourceId` | `String[]` |  |  |
| `FailoverRequestPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IFailoverRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentity1</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentity2</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IValidateForOperationRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentity3</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IReprotectRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentity4</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IFailoverRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentity5</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |
| `ExecutionConfigurationUserConsent` | `String` |  |  |
| `FailoverRequestPropertySelectedResourceId` | `String[]` |  |  |
| `FailoverRequestPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentityExpanded1</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |
| `OperationName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentityExpanded2</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |
| `ReprotectRequestPropertySelectedResourceId` | `String[]` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentityExpanded3</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |
| `ExecutionConfigurationUserConsent` | `String` |  |  |
| `FailoverRequestPropertySelectedResourceId` | `String[]` |  |  |
| `FailoverRequestPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IFailoverRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentityServiceGroup1</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroup1InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentityServiceGroup2</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IValidateForOperationRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroup2InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentityServiceGroup3</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IReprotectRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroup3InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentityServiceGroup4</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IFailoverRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroup4InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentityServiceGroup5</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroup5InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ExecutionConfigurationUserConsent` | `String` |  |  |
| `FailoverRequestPropertySelectedResourceId` | `String[]` |  |  |
| `FailoverRequestPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentityServiceGroupExpanded1</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `OperationName` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentityServiceGroupExpanded2</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ReprotectRequestPropertySelectedResourceId` | `String[]` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaIdentityServiceGroupExpanded3</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ExecutionConfigurationUserConsent` | `String` |  |  |
| `FailoverRequestPropertySelectedResourceId` | `String[]` |  |  |
| `FailoverRequestPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaJsonFilePath1</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaJsonFilePath2</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaJsonFilePath3</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaJsonString1</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaJsonString2</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanAction_ValidateViaJsonString3</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementRecoveryPlanActionFailover _(count: 8)_

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionFailover_Test</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IFailoverRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionFailover_TestExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `ExecutionConfigurationUserConsent` | `String` |  |  |
| `FailoverRequestPropertySelectedResourceId` | `String[]` |  |  |
| `FailoverRequestPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionFailover_TestViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IFailoverRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionFailover_TestViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |
| `ExecutionConfigurationUserConsent` | `String` |  |  |
| `FailoverRequestPropertySelectedResourceId` | `String[]` |  |  |
| `FailoverRequestPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionFailover_TestViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IFailoverRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionFailover_TestViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ExecutionConfigurationUserConsent` | `String` |  |  |
| `FailoverRequestPropertySelectedResourceId` | `String[]` |  |  |
| `FailoverRequestPropertySourceLocation` | `String[]` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionFailover_TestViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionFailover_TestViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementRecoveryPlanActionFailoverCleanup _(count: 8)_

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionFailoverCleanup_Test</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `ITestFailoverCleanupRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionFailoverCleanup_TestExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `Comment` | `String` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionFailoverCleanup_TestViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `ITestFailoverCleanupRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionFailoverCleanup_TestViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |
| `Comment` | `String` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionFailoverCleanup_TestViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `ITestFailoverCleanupRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionFailoverCleanup_TestViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Comment` | `String` |  |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionFailoverCleanup_TestViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionFailoverCleanup_TestViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementRecoveryPlanActionReadiness _(count: 3)_

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionReadiness_Check</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionReadiness_CheckViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Test-AzureResilienceManagementRecoveryPlanActionReadiness_CheckViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>


### AzureResilienceManagementRecoveryPlanActionResource _(count: 8)_

<details><summary><code>Update-AzureResilienceManagementRecoveryPlanActionResource_Update</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IUpdateRecoveryResourcesRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementRecoveryPlanActionResource_UpdateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `ResourcesToRemove` | `String[]` |  |  |
| `ResourcesToUpdate` | `IRecoveryResource[]` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementRecoveryPlanActionResource_UpdateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IUpdateRecoveryResourcesRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementRecoveryPlanActionResource_UpdateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |
| `ResourcesToRemove` | `String[]` |  |  |
| `ResourcesToUpdate` | `IRecoveryResource[]` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementRecoveryPlanActionResource_UpdateViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IUpdateRecoveryResourcesRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementRecoveryPlanActionResource_UpdateViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ResourcesToRemove` | `String[]` |  |  |
| `ResourcesToUpdate` | `IRecoveryResource[]` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementRecoveryPlanActionResource_UpdateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementRecoveryPlanActionResource_UpdateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementRecoveryResource _(count: 5)_

<details><summary><code>Get-AzureResilienceManagementRecoveryResource_Get</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryResourceName |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementRecoveryResource_GetViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementRecoveryResource_GetViaIdentityRecoveryPlan</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryResourceName |
| `RecoveryPlanInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementRecoveryResource_GetViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | RecoveryResourceName |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementRecoveryResource_List</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementReprotectDrillRun _(count: 10)_

<details><summary><code>Invoke-AzureResilienceManagementReprotectDrillRun_Reprotect</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillRunReprotectRequest` | yes |  |
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementReprotectDrillRun_ReprotectExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `ReprotectRequestPropertySelectedResourceId` | `String[]` |  |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementReprotectDrillRun_ReprotectViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillRunReprotectRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementReprotectDrillRun_ReprotectViaIdentityDrill</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillRunReprotectRequest` | yes |  |
| `DrillInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementReprotectDrillRun_ReprotectViaIdentityDrillExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ReprotectRequestPropertySelectedResourceId` | `String[]` |  |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementReprotectDrillRun_ReprotectViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |
| `ReprotectRequestPropertySelectedResourceId` | `String[]` |  |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementReprotectDrillRun_ReprotectViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IDrillRunReprotectRequest` | yes |  |
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementReprotectDrillRun_ReprotectViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ReprotectRequestPropertySelectedResourceId` | `String[]` |  |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementReprotectDrillRun_ReprotectViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `JsonFilePath` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementReprotectDrillRun_ReprotectViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `DrillName` | `String` | yes |  |
| `DrillRunName` | `String` | yes |  |
| `JsonString` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementReprotectRecoveryPlanAction _(count: 8)_

<details><summary><code>Invoke-AzureResilienceManagementReprotectRecoveryPlanAction_Reprotect</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IReprotectRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementReprotectRecoveryPlanAction_ReprotectExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |
| `ReprotectRequestPropertySelectedResourceId` | `String[]` |  |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementReprotectRecoveryPlanAction_ReprotectViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IReprotectRequest` | yes |  |
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementReprotectRecoveryPlanAction_ReprotectViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |
| `ReprotectRequestPropertySelectedResourceId` | `String[]` |  |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementReprotectRecoveryPlanAction_ReprotectViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Body` | `IReprotectRequest` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementReprotectRecoveryPlanAction_ReprotectViaIdentityServiceGroupExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `ReprotectRequestPropertySelectedResourceId` | `String[]` |  |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementReprotectRecoveryPlanAction_ReprotectViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementReprotectRecoveryPlanAction_ReprotectViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `OperationId` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>


### AzureResilienceManagementRetryRecoveryJob _(count: 4)_

<details><summary><code>Invoke-AzureResilienceManagementRetryRecoveryJob_Retry</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryJobName` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementRetryRecoveryJob_RetryViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `OperationId` | `String` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementRetryRecoveryJob_RetryViaIdentityRecoveryPlan</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryJobName` | `String` | yes |  |
| `RecoveryPlanInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Invoke-AzureResilienceManagementRetryRecoveryJob_RetryViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `OperationId` | `String` | yes |  |
| `RecoveryJobName` | `String` | yes |  |
| `RecoveryPlanName` | `String` | yes |  |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>


### AzureResilienceManagementUnifiedResilienceItem _(count: 4)_

<details><summary><code>Get-AzureResilienceManagementUnifiedResilienceItem_Get</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | UnifiedResilienceItemName |
| `ServiceGroupName` | `String` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementUnifiedResilienceItem_GetViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementUnifiedResilienceItem_GetViaIdentityServiceGroup</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | UnifiedResilienceItemName |
| `ServiceGroupInputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementUnifiedResilienceItem_List</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `ServiceGroupName` | `String` | yes |  |
| `SkipToken` | `String` |  |  |
| `Top` | `Int32` |  |  |

</details>


### AzureResilienceManagementUsagePlan _(count: 22)_

<details><summary><code>Get-AzureResilienceManagementUsagePlan_Get</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | UsagePlanName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String[]` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementUsagePlan_GetViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementUsagePlan_List</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `SubscriptionId` | `String[]` | yes |  |

</details>

<details><summary><code>Get-AzureResilienceManagementUsagePlan_List1</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String[]` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementUsagePlan_Create</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | UsagePlanName |
| `Resource` | `IUsagePlan` | yes |  |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementUsagePlan_CreateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Location` | `String` | yes |  |
| `Name` | `String` | yes | UsagePlanName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |
| `PlanType` | `String` |  |  |
| `Tag` | `ITrackedResourceTags` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementUsagePlan_CreateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Resource` | `IUsagePlan` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementUsagePlan_CreateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Location` | `String` | yes |  |
| `PlanType` | `String` |  |  |
| `Tag` | `ITrackedResourceTags` |  |  |

</details>

<details><summary><code>New-AzureResilienceManagementUsagePlan_CreateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | UsagePlanName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |

</details>

<details><summary><code>New-AzureResilienceManagementUsagePlan_CreateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | UsagePlanName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementUsagePlan_Delete</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | UsagePlanName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |

</details>

<details><summary><code>Remove-AzureResilienceManagementUsagePlan_DeleteViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementUsagePlan_Update</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | UsagePlanName |
| `Resource` | `IUsagePlan` | yes |  |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementUsagePlan_UpdateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Location` | `String` | yes |  |
| `Name` | `String` | yes | UsagePlanName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |
| `PlanType` | `String` |  |  |
| `Tag` | `ITrackedResourceTags` |  |  |

</details>

<details><summary><code>Set-AzureResilienceManagementUsagePlan_UpdateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | UsagePlanName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |

</details>

<details><summary><code>Set-AzureResilienceManagementUsagePlan_UpdateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | UsagePlanName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementUsagePlan_Update</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | UsagePlanName |
| `Property` | `IUsagePlanTagsUpdate` | yes |  |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementUsagePlan_UpdateExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `Name` | `String` | yes | UsagePlanName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |
| `Tag` | `IUsagePlanTagsUpdateTags` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementUsagePlan_UpdateViaIdentity</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Property` | `IUsagePlanTagsUpdate` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementUsagePlan_UpdateViaIdentityExpanded</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `InputObject` | `IAzureResilienceManagementIdentity` | yes |  |
| `Tag` | `IUsagePlanTagsUpdateTags` |  |  |

</details>

<details><summary><code>Update-AzureResilienceManagementUsagePlan_UpdateViaJsonFilePath</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonFilePath` | `String` | yes |  |
| `Name` | `String` | yes | UsagePlanName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |

</details>

<details><summary><code>Update-AzureResilienceManagementUsagePlan_UpdateViaJsonString</code></summary>

| Name | Type | Required | Aliases |
|------|------|:--------:|---------|
| `JsonString` | `String` | yes |  |
| `Name` | `String` | yes | UsagePlanName |
| `ResourceGroupName` | `String` | yes |  |
| `SubscriptionId` | `String` | yes |  |

</details>



