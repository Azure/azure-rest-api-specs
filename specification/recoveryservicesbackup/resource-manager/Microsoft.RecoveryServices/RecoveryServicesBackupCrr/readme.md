# RecoveryServicesBackupCrr

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Recovery Services Backup Cross Region Restore service.

---

## Getting Started

To build the SDK, install [AutoRest](https://aka.ms/autorest/install) and run:

> `autorest`

---

## Configuration

```yaml
title: Recovery Services Backup Passive Client
description: OpenAPI 2.0 specifications for the Azure Recovery Services Backup Cross Region Restore service
openapi-type: arm
tag: package-passivestamp-2023-01-15
license-header: MICROSOFT_MIT
```

### Validations

```yaml $(validate)
azure-validator: true
model-validator: true
semantic-validator: true
message-format: json
```

### Tag: package-passivestamp-2023-01-15

```yaml $(tag) == 'package-passivestamp-2023-01-15'
input-file:
  - stable/2023-01-15/bms.json
```

## Suppression

```yaml $(directive)
directive:
  - suppress: OperationsAPIImplementation
    from: bms.json
    where: $
    reason: The provider-wide Microsoft.RecoveryServices operations endpoint is implemented by the RecoveryServicesBackup active-stamp specification. This passive-stamp CRR specification represents the existing 2023-01-15 API surface and must not duplicate ownership of that endpoint.
  - suppress: AvoidAdditionalProperties
    from: bms.json
    where:
      - $.definitions.AzureFileshareProtectedItem.properties.kpisHealths
      - $.definitions.AzureIaaSVMJobExtendedInfo.properties.propertyBag
      - $.definitions.AzureIaaSVMJobExtendedInfo.properties.internalPropertyBag
      - $.definitions.AzureIaaSVMProtectedItem.properties.kpisHealths
      - $.definitions.AzureStorageJobExtendedInfo.properties.propertyBag
      - $.definitions.AzureVmWorkloadProtectedItem.properties.kpisHealths
      - $.definitions.AzureWorkloadJobExtendedInfo.properties.propertyBag
      - $.definitions.AzureWorkloadRecoveryPoint.properties.recoveryPointMoveReadinessInfo
      - $.definitions.AzureWorkloadRestoreRequest.properties.propertyBag
      - $.definitions.CrrAccessToken.properties.rpTierInformation
      - $.definitions.DPMProtectedItemExtendedInfo.properties.protectableObjectLoadPath
      - $.definitions.DpmJobExtendedInfo.properties.propertyBag
      - $.definitions.GenericProtectedItem.properties.sourceAssociations
      - $.definitions.IaasVMRecoveryPoint.properties.recoveryPointMoveReadinessInfo
      - $.definitions.MabJobExtendedInfo.properties.propertyBag
      - $.definitions.OperationStatusJobsExtendedInfo.properties.failedJobsError
      - $.definitions.RecoveryPointTierInformation.properties.extendedInfo
    reason: These open-ended dictionaries are part of the existing stable 2023-01-15 passive-stamp API contract. Replacing them with closed models would reject existing keys and change generated SDK dictionary properties, breaking wire and client compatibility.
  - suppress: AllTrackedResourcesMustHaveDelete
    from: bms.json
    where:
      - $.definitions.AADPropertiesResource
      - $.definitions.BackupResourceConfigResource
      - $.definitions.RecoveryPointResource
    reason: These legacy 2023-01-15 envelopes include location and tags, so the Swagger validator classifies them as tracked resources. AADPropertiesResource is an action response, BackupResourceConfigResource is a singleton with GET/PUT/PATCH, and RecoveryPointResource is read-only; adding DELETE operations would change the shipped lifecycle contract.
  - suppress: TrackedResourcePatchOperation
    from: bms.json
    where:
      - $.definitions.AADPropertiesResource
      - $.definitions.RecoveryPointResource
    reason: AADPropertiesResource is an action response and RecoveryPointResource is read-only. Their frozen envelopes include location and tags, which causes tracked-resource classification, but adding PATCH operations would change the shipped stable contract.
  - suppress: TrackedResourcesMustHavePut
    from: bms.json
    where:
      - $.definitions.AADPropertiesResource
      - $.definitions.RecoveryPointResource
    reason: AADPropertiesResource is an action response and RecoveryPointResource is read-only. Their frozen envelopes include location and tags, which causes tracked-resource classification, but adding PUT operations would change the shipped stable contract.
  - suppress: TrackedResourceBeyondsThirdLevel
    from: bms.json
    where: $.definitions.RecoveryPointResource
    reason: The deeply nested recovery point route is part of the shipped stable 2023-01-15 contract. RecoveryPointResource is read-only, but its required legacy location and tags fields cause the Swagger validator to classify it as tracked; changing the route or envelope would be breaking.
  - suppress: PathForTrackedResourceTypes
    from: bms.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupAadProperties"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig"]
    reason: These shipped routes return legacy envelopes containing location and tags, which causes tracked-resource classification. The first is a subscription/location provider action and the second is a vault singleton; moving either route would break the stable 2023-01-15 wire contract.
  - suppress: PathForNestedResource
    from: bms.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig"]
    reason: This non-standard vault singleton route is part of the shipped stable 2023-01-15 contract. Rewriting its literal backupstorageconfig/vaultstorageconfig segments to a modern nested-resource path would be breaking.
  - suppress: EvenSegmentedPathForPutOperation
    from: bms.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig"]
    reason: The PUT operation uses the shipped stable singleton route. Changing the literal backupstorageconfig/vaultstorageconfig path to a modern resource-type/resource-name pattern would break existing clients.
  - suppress: ParametersOrder
    from: bms.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/"].get
    reason: The operation preserves the parameter order of the shipped stable 2023-01-15 Swagger and its generated SDK method. Reordering these parameters solely to follow path-segment order would change the existing SDK signature.
  - suppress: RequiredPropertiesMissingInResourceModel
    from: bms.json
    where:
      - $.definitions.OperationStatus
      - $.definitions.BackupManagementUsageList
    reason: These are legacy operation-status and collection response models, not ARM resource envelopes. Adding required id, name, and type properties would change the frozen response contract.
  - suppress: BodyTopLevelProperties
    from: bms.json
    where: $.definitions.OperationStatus
    reason: OperationStatus is a legacy operation-status payload rather than an ARM resource envelope. Moving status, startTime, endTime, or error under a properties bag would change the shipped response shape.
  - suppress: GetCollectionOnlyHasValueAndNextLink
    from: bms.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupAadProperties"].get.responses["200"].schema.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupUsageSummaries"].get.responses["200"].schema.properties
    reason: The first operation returns a single legacy AAD-properties action response and is not a resource collection. The second preserves the frozen BackupManagementUsageList response; changing either response envelope would break the stable contract.
  - suppress: XmsPageableForListCalls
    from: bms.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupAadProperties"].get
    reason: This GET is a legacy provider action returning one AADPropertiesResource, not a pageable list. Adding x-ms-pageable would incorrectly change generated SDK behavior.
  - suppress: PostResponseCodes
    from: bms.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupCrossRegionRestore"].post
    reason: The frozen long-running POST explicitly returns body-less 200 and 202 responses. Removing the existing 200 or adding a response schema would change the shipped HTTP contract.
  - suppress: LroErrorContent
    from: bms.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupCrossRegionRestore"].post.responses.default.schema["$ref"]
    reason: This stable operation uses the service's legacy NewErrorResponse contract. Replacing it with a newer common-types error schema would change the generated SDK error model.
  - suppress: ParametersInPost
    from: bms.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupCrrJobs"].post.parameters
    reason: The $filter and $skipToken query parameters are part of the shipped BackupCrrJobs_List POST contract. Removing or relocating them would break existing callers.
  - suppress: ResourceNameRestriction
    from: bms.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}/accessToken"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectedItems/"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupUsageSummaries"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig"]
    reason: These resource-name parameters shipped without regex constraints in stable 2023-01-15. Adding patterns would narrow previously accepted names and could reject existing client inputs.
  - suppress: PutGetPatchResponseSchema
    from: bms.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig"]
    reason: The frozen singleton returns BackupResourceConfigResource from GET and PUT but a body-less 204 from PATCH. Making all three response schemas identical would change the established PATCH behavior.
  - suppress: PutResponseCodes
    from: bms.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig"].put
    reason: The synchronous PUT shipped with 200 and default responses only. Adding 201 or changing response codes would alter the stable HTTP contract.
  - suppress: PatchResponseCodes
    from: bms.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig"].patch
    reason: The synchronous PATCH intentionally returns body-less 204 and default responses. Replacing 204 with 200 and a response body would alter the stable HTTP contract.
```
