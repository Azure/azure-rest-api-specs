## Swagger Changes

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AllowedEnvironmentTypeProperties.properties.provisioningState.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/ProvisioningState` |
| `definitions.AttachedNetworkConnectionProperties.properties.domainJoinType.$ref__deleted` | deleted | `vdi.json#/definitions/DomainJoinType` |
| `definitions.AttachedNetworkConnectionProperties.properties.healthCheckStatus.$ref__deleted` | deleted | `vdi.json#/definitions/HealthCheckStatus` |
| `definitions.AttachedNetworkConnectionProperties.properties.provisioningState.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/ProvisioningState` |
| `definitions.CatalogProperties.properties.provisioningState.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/ProvisioningState` |
| `definitions.CustomizationTaskInstance.properties.parameters.$ref__deleted` | deleted | `#/definitions/DefinitionParameters` |
| `definitions.CustomizationTaskProperties.properties.validationStatus.$ref__deleted` | deleted | `vdi.json#/definitions/CatalogResourceValidationStatus` |
| `definitions.DevBoxDefinitionProperties.properties.imageValidationStatus.$ref__deleted` | deleted | `vdi.json#/definitions/ImageValidationStatus` |
| `definitions.DevBoxDefinitionProperties.properties.provisioningState.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/ProvisioningState` |
| `definitions.DevBoxDefinitionProperties.properties.validationStatus.$ref__deleted` | deleted | `vdi.json#/definitions/CatalogResourceValidationStatus` |
| `definitions.DevCenterEncryptionSetProperties.properties.provisioningState.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/ProvisioningState` |
| `definitions.DevCenterEncryptionSetUpdateProperties.properties.keyEncryptionKeyIdentity.$ref__added` | added | `#/definitions/KeyEncryptionKeyIdentity` |
| `definitions.DevCenterProperties.properties.provisioningState.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/ProvisioningState` |
| `definitions.EnvironmentDefinitionProperties.properties.validationStatus.$ref__deleted` | deleted | `vdi.json#/definitions/CatalogResourceValidationStatus` |
| `definitions.EnvironmentType.properties.tags.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/Tags` |
| `definitions.EnvironmentTypeProperties.properties.provisioningState.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/ProvisioningState` |
| `definitions.EnvironmentTypeUpdate.properties.tags.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/Tags` |
| `definitions.GalleryProperties.properties.provisioningState.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/ProvisioningState` |
| `definitions.ImageDefinitionBuildTask.properties.parameters.items.$ref__added` | added | `#/definitions/ImageDefinitionBuildTaskParametersItem` |
| `definitions.ImageDefinitionProperties.properties.imageValidationStatus.$ref__deleted` | deleted | `vdi.json#/definitions/ImageValidationStatus` |
| `definitions.ImageDefinitionProperties.properties.validationStatus.$ref__deleted` | deleted | `vdi.json#/definitions/CatalogResourceValidationStatus` |
| `definitions.ImageDefinitionReference.properties.parameters.$ref__deleted` | deleted | `#/definitions/DefinitionParameters` |
| `definitions.ImageProperties.properties.provisioningState.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/ProvisioningState` |
| `definitions.ImageVersionProperties.properties.provisioningState.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/ProvisioningState` |
| `definitions.NetworkProperties.properties.provisioningState.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/ProvisioningState` |
| `definitions.PoolProperties.properties.provisioningState.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/ProvisioningState` |
| `definitions.ProjectEnvironmentTypeProperties.properties.provisioningState.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/ProvisioningState` |
| `definitions.ProjectEnvironmentTypeUpdate.properties.tags.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/Tags` |
| `definitions.ProjectEnvironmentTypeUpdateProperties.properties.creatorRoleAssignment.$ref__added` | added | `#/definitions/CreatorRoleAssignment` |
| `definitions.ProjectPolicyProperties.properties.provisioningState.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/ProvisioningState` |
| `definitions.ProjectProperties.properties.provisioningState.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/ProvisioningState` |
| `definitions.ScheduleProperties.properties.provisioningState.$ref__deleted` | deleted | `commonDefinitions.json#/definitions/ProvisioningState` |
| `definitions.TrackedResourceUpdate.properties.tags.$ref__deleted` | deleted | `#/definitions/Tags` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/devcenters'].get.parameters[0].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/locations/{location}/operationStatuses/{operationId}'].get.parameters[0].$ref__added` | added | `../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/locations/{location}/usages'].get.parameters[0].$ref__added` | added | `../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/projects'].get.parameters[0].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters'].get.parameters[0].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/attachednetworks'].get.parameters[1].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs'].get.parameters[1].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/environmentDefinitions'].get.parameters[2].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/encryptionSets'].get.parameters[1].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/environmentTypes'].get.parameters[1].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/galleries'].get.parameters[1].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/galleries/{galleryName}/images'].get.parameters[2].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/images'].get.parameters[1].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/projectPolicies'].get.parameters[1].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects'].get.parameters[0].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/allowedEnvironmentTypes'].get.parameters[1].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/attachednetworks'].get.parameters[1].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/catalogs'].get.parameters[1].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/environmentTypes'].get.parameters[1].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/images'].get.parameters[0].$ref__deleted` | deleted | `commonDefinitions.json#/parameters/ProjectNameParameter` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/devcenters'].get.parameters[0].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/locations/{location}/operationStatuses/{operationId}'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/locations/{location}/usages'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/projects'].get.parameters[0].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters'].get.parameters[0].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/attachednetworks'].get.parameters[1].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs'].get.parameters[1].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/environmentDefinitions'].get.parameters[2].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/encryptionSets'].get.parameters[1].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/environmentTypes'].get.parameters[1].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/galleries'].get.parameters[1].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/galleries/{galleryName}/images'].get.parameters[2].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/images'].get.parameters[1].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/projectPolicies'].get.parameters[1].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects'].get.parameters[0].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/allowedEnvironmentTypes'].get.parameters[1].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/attachednetworks'].get.parameters[1].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/catalogs'].get.parameters[1].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/environmentTypes'].get.parameters[1].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/images'].get.parameters[0].name__added` | added | `projectName` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/devcenters'].get.parameters[0].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/locations/{location}/operationStatuses/{operationId}'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/locations/{location}/usages'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/projects'].get.parameters[0].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters'].get.parameters[0].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/attachednetworks'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/environmentDefinitions'].get.parameters[2].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/encryptionSets'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/environmentTypes'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/galleries'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/galleries/{galleryName}/images'].get.parameters[2].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/images'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/projectPolicies'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects'].get.parameters[0].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/allowedEnvironmentTypes'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/attachednetworks'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/catalogs'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/environmentTypes'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/images'].get.parameters[0].in__added` | added | `path` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AllowedEnvironmentTypeProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.AttachedNetworkConnectionProperties.properties.domainJoinType.type__added` | added | `string` |
| `definitions.AttachedNetworkConnectionProperties.properties.healthCheckStatus.type__added` | added | `string` |
| `definitions.AttachedNetworkConnectionProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.CatalogProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.CustomizationTaskInstance.properties.parameters.type__added` | added | `array` |
| `definitions.CustomizationTaskProperties.properties.validationStatus.type__added` | added | `string` |
| `definitions.DevBoxDefinitionProperties.properties.imageValidationStatus.type__added` | added | `string` |
| `definitions.DevBoxDefinitionProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.DevBoxDefinitionProperties.properties.validationStatus.type__added` | added | `string` |
| `definitions.DevCenterEncryptionSetProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.DevCenterEncryptionSetUpdateProperties.properties.keyEncryptionKeyIdentity.type__deleted` | deleted | `object` |
| `definitions.DevCenterProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.EnvironmentDefinitionProperties.properties.validationStatus.type__added` | added | `string` |
| `definitions.EnvironmentType.properties.tags.type__added` | added | `object` |
| `definitions.EnvironmentTypeProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.EnvironmentTypeUpdate.properties.tags.type__added` | added | `object` |
| `definitions.GalleryProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ImageDefinitionBuildTask.properties.parameters.items.type__deleted` | deleted | `object` |
| `definitions.ImageDefinitionProperties.properties.imageValidationStatus.type__added` | added | `string` |
| `definitions.ImageDefinitionProperties.properties.validationStatus.type__added` | added | `string` |
| `definitions.ImageDefinitionReference.properties.parameters.type__added` | added | `array` |
| `definitions.ImageProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ImageVersionProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.NetworkProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.PoolProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ProjectEnvironmentTypeProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ProjectEnvironmentTypeUpdate.properties.tags.type__added` | added | `object` |
| `definitions.ProjectEnvironmentTypeUpdateProperties.properties.creatorRoleAssignment.type__deleted` | deleted | `object` |
| `definitions.ProjectPolicyProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ProjectProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ScheduleProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.TrackedResourceUpdate.properties.tags.type__added` | added | `object` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/devcenters'].get.parameters[0].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/locations/{location}/operationStatuses/{operationId}'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/locations/{location}/usages'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/projects'].get.parameters[0].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters'].get.parameters[0].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/attachednetworks'].get.parameters[1].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs'].get.parameters[1].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/environmentDefinitions'].get.parameters[2].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/encryptionSets'].get.parameters[1].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/environmentTypes'].get.parameters[1].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/galleries'].get.parameters[1].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/galleries/{galleryName}/images'].get.parameters[2].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/images'].get.parameters[1].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/projectPolicies'].get.parameters[1].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects'].get.parameters[0].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/allowedEnvironmentTypes'].get.parameters[1].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/attachednetworks'].get.parameters[1].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/catalogs'].get.parameters[1].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/environmentTypes'].get.parameters[1].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/images'].get.parameters[0].type__added` | added | `string` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkConnectionUpdateProperties.properties.domainPassword.format__added` | added | `password` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/devcenters'].get.parameters[0].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/projects'].get.parameters[0].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters'].get.parameters[0].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/attachednetworks'].get.parameters[1].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs'].get.parameters[1].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/environmentDefinitions'].get.parameters[2].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/encryptionSets'].get.parameters[1].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/environmentTypes'].get.parameters[1].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/galleries'].get.parameters[1].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/galleries/{galleryName}/images'].get.parameters[2].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/images'].get.parameters[1].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/projectPolicies'].get.parameters[1].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects'].get.parameters[0].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/allowedEnvironmentTypes'].get.parameters[1].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/attachednetworks'].get.parameters[1].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/catalogs'].get.parameters[1].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/environmentTypes'].get.parameters[1].format__added` | added | `int32` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AllowedEnvironmentTypeListResult.required__added` | added | `["value"]` |
| `definitions.AttachedNetworkListResult.required__added` | added | `["value"]` |
| `definitions.CatalogListResult.required__added` | added | `["value"]` |
| `definitions.CustomizationTaskListResult.required__added` | added | `["value"]` |
| `definitions.DefinitionParameters.required__added` | added | `["name","value"]` |
| `definitions.DevBoxDefinitionListResult.required__added` | added | `["value"]` |
| `definitions.DevBoxDefinitionProperties.required__deleted` | deleted | `["imageReference","sku"]` |
| `definitions.DevCenterListResult.required__added` | added | `["value"]` |
| `definitions.DevCenterSku.required__deleted` | deleted | `["name"]` |
| `definitions.EncryptionSetListResult.required__added` | added | `["value"]` |
| `definitions.EnvironmentDefinitionListResult.required__added` | added | `["value"]` |
| `definitions.EnvironmentTypeListResult.required__added` | added | `["value"]` |
| `definitions.GalleryListResult.required__added` | added | `["value"]` |
| `definitions.HealthCheckStatusDetailsListResult.required__added` | added | `["value"]` |
| `definitions.ImageDefinitionBuildListResult.required__added` | added | `["value"]` |
| `definitions.ImageDefinitionBuildTask.properties.parameters.items.required__deleted` | deleted | `["key","value"]` |
| `definitions.ImageDefinitionListResult.required__added` | added | `["value"]` |
| `definitions.ImageListResult.required__added` | added | `["value"]` |
| `definitions.ImageVersionListResult.required__added` | added | `["value"]` |
| `definitions.ListUsagesResult.required__added` | added | `["value"]` |
| `definitions.NetworkConnectionListResult.required__added` | added | `["value"]` |
| `definitions.OutboundEnvironmentEndpointCollection.required__added` | added | `["value"]` |
| `definitions.PoolListResult.required__added` | added | `["value"]` |
| `definitions.PoolProperties.required__deleted` | deleted | `["devBoxDefinitionName","licenseType","localAdministrator","networkConnectionName"]` |
| `definitions.ProjectEnvironmentTypeListResult.required__added` | added | `["value"]` |
| `definitions.ProjectListResult.required__added` | added | `["value"]` |
| `definitions.ProjectPolicyListResult.required__added` | added | `["value"]` |
| `definitions.ScheduleListResult.required__added` | added | `["value"]` |
| `definitions.ScheduleProperties.required__deleted` | deleted | `["frequency","time","timeZone","type"]` |
| `definitions.SkuListResult.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/locations/{location}/operationStatuses/{operationId}'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/locations/{location}/usages'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/images'].get.parameters[0].required__added` | added | `true` |

### Changes for `parameters`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/networkConnections'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/skus'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/environmentDefinitions/{environmentDefinitionName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/environmentDefinitions/{environmentDefinitionName}/getErrorDetails'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/getSyncErrorDetails'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/imageDefinitions'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/imageDefinitions/{imageDefinitionName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/imageDefinitions/{imageDefinitionName}/buildImage'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/imageDefinitions/{imageDefinitionName}/builds'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/imageDefinitions/{imageDefinitionName}/builds/{buildName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/imageDefinitions/{imageDefinitionName}/builds/{buildName}/cancel'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/tasks'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/tasks/{taskName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/tasks/{taskName}/getErrorDetails'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/devboxdefinitions'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/devboxdefinitions/{devBoxDefinitionName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/networkConnections'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/networkConnections/{networkConnectionName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/networkConnections/{networkConnectionName}/healthChecks'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/networkConnections/{networkConnectionName}/outboundNetworkDependenciesEndpoints'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/catalogs/{catalogName}/imageDefinitions'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/catalogs/{catalogName}/imageDefinitions/{imageDefinitionName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/catalogs/{catalogName}/imageDefinitions/{imageDefinitionName}/buildImage'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/catalogs/{catalogName}/imageDefinitions/{imageDefinitionName}/builds'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/catalogs/{catalogName}/imageDefinitions/{imageDefinitionName}/builds/{buildName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/catalogs/{catalogName}/imageDefinitions/{imageDefinitionName}/builds/{buildName}/cancel'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/devboxdefinitions'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/devboxdefinitions/{devBoxDefinitionName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/pools'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/pools/{poolName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/pools/{poolName}/schedules'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/pools/{poolName}/schedules/{scheduleName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/parameters/ApiVersionParame...` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/DevCenter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/DevCenter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/attachednetworks/{attachedNetworkConnectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/AttachedNetworkConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Catalog` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Catalog` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/devboxdefinitions/{devBoxDefinitionName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/DevBoxDefinition` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/devboxdefinitions/{devBoxDefinitionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/DevBoxDefinition` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/encryptionSets/{encryptionSetName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/DevCenterEncryptionSet` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/encryptionSets/{encryptionSetName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/DevCenterEncryptionSet` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/galleries/{galleryName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Gallery` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/projectPolicies/{projectPolicyName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ProjectPolicy` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/projectPolicies/{projectPolicyName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ProjectPolicy` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/networkConnections/{networkConnectionName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NetworkConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/networkConnections/{networkConnectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NetworkConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Project` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Project` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/catalogs/{catalogName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Catalog` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/catalogs/{catalogName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Catalog` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/pools/{poolName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Pool` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/pools/{poolName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Pool` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/pools/{poolName}/schedules/{scheduleName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Schedule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/pools/{poolName}/schedules/{scheduleName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Schedule` |

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/images'].get.parameters[0].minLength__added` | added | `3` |

### Changes for `maxLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/images'].get.parameters[0].maxLength__added` | added | `63` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/images'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$` |

### Changes for `DevCenterUri`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DevCenterUri__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `Tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Tags__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"},"x-ms-mutability":["read","create","update...` |

### Changes for `CreatorRoleAssignment`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CreatorRoleAssignment__added` | added | `{"type":"object","properties":{"roles":{"type":"object","additionalProperties":{"$ref":"#/definition...` |

### Changes for `ImageDefinitionBuildTaskParametersItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ImageDefinitionBuildTaskParametersItem__added` | added | `{"type":"object","properties":{"key":{"type":"string"},"value":{"type":"string"}},"required":["key",...` |

### Changes for `KeyEncryptionKeyIdentity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.KeyEncryptionKeyIdentity__added` | added | `{"type":"object","properties":{"type":{"type":"string","enum":["SystemAssigned","UserAssigned"],"x-m...` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AllowedEnvironmentTypeProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Accepted","Running","Creating","Created","Updating","Updated","Deleting","Deleted",...` |
| `definitions.AttachedNetworkConnectionProperties.properties.domainJoinType.enum__added` | added | `["HybridAzureADJoin","AzureADJoin","None"]` |
| `definitions.AttachedNetworkConnectionProperties.properties.healthCheckStatus.enum__added` | added | `["Unknown","Pending","Running","Passed","Warning","Failed","Informational"]` |
| `definitions.AttachedNetworkConnectionProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Accepted","Running","Creating","Created","Updating","Updated","Deleting","Deleted",...` |
| `definitions.CatalogProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Accepted","Running","Creating","Created","Updating","Updated","Deleting","Deleted",...` |
| `definitions.CustomizationTaskProperties.properties.validationStatus.enum__added` | added | `["Unknown","Pending","Succeeded","Failed"]` |
| `definitions.DevBoxDefinitionProperties.properties.imageValidationStatus.enum__added` | added | `["Unknown","Pending","Succeeded","Failed","TimedOut"]` |
| `definitions.DevBoxDefinitionProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Accepted","Running","Creating","Created","Updating","Updated","Deleting","Deleted",...` |
| `definitions.DevBoxDefinitionProperties.properties.validationStatus.enum__added` | added | `["Unknown","Pending","Succeeded","Failed"]` |
| `definitions.DevCenterEncryptionSetProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Accepted","Running","Creating","Created","Updating","Updated","Deleting","Deleted",...` |
| `definitions.DevCenterProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Accepted","Running","Creating","Created","Updating","Updated","Deleting","Deleted",...` |
| `definitions.EnvironmentDefinitionProperties.properties.validationStatus.enum__added` | added | `["Unknown","Pending","Succeeded","Failed"]` |
| `definitions.EnvironmentTypeProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Accepted","Running","Creating","Created","Updating","Updated","Deleting","Deleted",...` |
| `definitions.GalleryProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Accepted","Running","Creating","Created","Updating","Updated","Deleting","Deleted",...` |
| `definitions.ImageDefinitionProperties.properties.imageValidationStatus.enum__added` | added | `["Unknown","Pending","Succeeded","Failed","TimedOut"]` |
| `definitions.ImageDefinitionProperties.properties.validationStatus.enum__added` | added | `["Unknown","Pending","Succeeded","Failed"]` |
| `definitions.ImageProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Accepted","Running","Creating","Created","Updating","Updated","Deleting","Deleted",...` |
| `definitions.ImageVersionProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Accepted","Running","Creating","Created","Updating","Updated","Deleting","Deleted",...` |
| `definitions.NetworkProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Accepted","Running","Creating","Created","Updating","Updated","Deleting","Deleted",...` |
| `definitions.PoolProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Accepted","Running","Creating","Created","Updating","Updated","Deleting","Deleted",...` |
| `definitions.ProjectEnvironmentTypeProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Accepted","Running","Creating","Created","Updating","Updated","Deleting","Deleted",...` |
| `definitions.ProjectPolicyProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Accepted","Running","Creating","Created","Updating","Updated","Deleting","Deleted",...` |
| `definitions.ProjectProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Accepted","Running","Creating","Created","Updating","Updated","Deleting","Deleted",...` |
| `definitions.ScheduleProperties.properties.provisioningState.enum__added` | added | `["NotSpecified","Accepted","Running","Creating","Created","Updating","Updated","Deleting","Deleted",...` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AllowedEnvironmentTypeProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.AttachedNetworkConnectionProperties.properties.domainJoinType['x-ms-enum__added']` | added | `{"name":"DomainJoinType","modelAsString":true}` |
| `definitions.AttachedNetworkConnectionProperties.properties.healthCheckStatus['x-ms-enum__added']` | added | `{"name":"HealthCheckStatus","modelAsString":true}` |
| `definitions.AttachedNetworkConnectionProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.CatalogProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.CustomizationTaskProperties.properties.validationStatus['x-ms-enum__added']` | added | `{"name":"CatalogResourceValidationStatus","modelAsString":true}` |
| `definitions.DevBoxDefinitionProperties.properties.imageValidationStatus['x-ms-enum__added']` | added | `{"name":"ImageValidationStatus","modelAsString":true}` |
| `definitions.DevBoxDefinitionProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.DevBoxDefinitionProperties.properties.validationStatus['x-ms-enum__added']` | added | `{"name":"CatalogResourceValidationStatus","modelAsString":true}` |
| `definitions.DevCenterEncryptionSetProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.DevCenterProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.EnvironmentDefinitionProperties.properties.validationStatus['x-ms-enum__added']` | added | `{"name":"CatalogResourceValidationStatus","modelAsString":true}` |
| `definitions.EnvironmentTypeProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.GalleryProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ImageDefinitionProperties.properties.imageValidationStatus['x-ms-enum__added']` | added | `{"name":"ImageValidationStatus","modelAsString":true}` |
| `definitions.ImageDefinitionProperties.properties.validationStatus['x-ms-enum__added']` | added | `{"name":"CatalogResourceValidationStatus","modelAsString":true}` |
| `definitions.ImageProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ImageVersionProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.NetworkProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.PoolProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ProjectEnvironmentTypeProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ProjectPolicyProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ProjectProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ScheduleProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CustomizationTaskInstance.properties.parameters.items__added` | added | `{"$ref":"#/definitions/DefinitionParameters"}` |
| `definitions.DefinitionParameters.items__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"value":{"type":"string"}},"required":["name...` |
| `definitions.ImageDefinitionReference.properties.parameters.items__added` | added | `{"$ref":"#/definitions/DefinitionParameters"}` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DefinitionParameters.properties__added` | added | `{"name":{"type":"string"},"value":{"type":"string"}}` |
| `definitions.DevCenterEncryptionSetUpdateProperties.properties.keyEncryptionKeyIdentity.properties__deleted` | deleted | `{"type":{"$ref":"#/definitions/CmkIdentityType","description":"The type of managed identity to use f...` |
| `definitions.ImageDefinitionBuildTask.properties.parameters.items.properties__deleted` | deleted | `{"key":{"type":"string"},"value":{"type":"string"}}` |
| `definitions.ProjectEnvironmentTypeUpdateProperties.properties.creatorRoleAssignment.properties__deleted` | deleted | `{"roles":{"type":"object","description":"A map of roles to assign to the environment creator.","addi...` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentType.properties.tags.additionalProperties__added` | added | `{"type":"string"}` |
| `definitions.EnvironmentTypeUpdate.properties.tags.additionalProperties__added` | added | `{"type":"string"}` |
| `definitions.OperationStatus.properties.properties.additionalProperties__added` | added | `{}` |
| `definitions.ProjectEnvironmentTypeUpdate.properties.tags.additionalProperties__added` | added | `{"type":"string"}` |
| `definitions.TrackedResourceUpdate.properties.tags.additionalProperties__added` | added | `{"type":"string"}` |

### Changes for `x-ms-mutability`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentType.properties.tags['x-ms-mutability__added']` | added | `["create","read","update"]` |
| `definitions.EnvironmentTypeUpdate.properties.tags['x-ms-mutability__added']` | added | `["create","read","update"]` |
| `definitions.ProjectEnvironmentTypeUpdate.properties.tags['x-ms-mutability__added']` | added | `["create","read","update"]` |
| `definitions.TrackedResourceUpdate.properties.tags['x-ms-mutability__added']` | added | `["create","read","update"]` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ProjectEnvironmentType.properties.tags__deleted` | deleted | `{"$ref":"commonDefinitions.json#/definitions/Tags"}` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ProjectEnvironmentType.properties.location__deleted` | deleted | `{"type":"string"}` |

### Changes for `x-ms-client-name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserRoleAssignment['x-ms-client-name__deleted']` | deleted | `userRoleAssignmentValue` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AllowedEnvironmentType.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.AttachedNetworkConnection.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.Catalog.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.CatalogSyncError.properties.errorDetails.items.$ref` | `vdi.json#/definitions/CatalogErrorDetails` | `#/definitions/CatalogErrorDetails` |
| `definitions.DefinitionParameters.type` | `array` | `object` |
| `definitions.DevBoxDefinitionProperties.properties.activeImageReference.$ref` | `vdi.json#/definitions/ImageReference` | `#/definitions/ImageReference` |
| `definitions.DevBoxDefinitionProperties.properties.imageValidationErrorDetails.$ref` | `vdi.json#/definitions/ImageValidationErrorDetails` | `#/definitions/ImageValidationErrorDetails` |
| `definitions.DevBoxDefinitionUpdate.allOf[0].$ref` | `commonDefinitions.json#/definitions/TrackedResourceUpdate` | `#/definitions/TrackedResourceUpdate` |
| `definitions.DevBoxDefinitionUpdateProperties.properties.imageReference.$ref` | `vdi.json#/definitions/ImageReference` | `#/definitions/ImageReference` |
| `definitions.DevCenter.properties.identity.$ref` | `../../../../../common-types/resource-management/v4/managedidentity.json#/definitions/ManagedServiceIdentity` | `../../../../../common-types/resource-management/v5/managedidentity.json#/definitions/ManagedServiceIdentity` |
| `definitions.DevCenterEncryptionSet.properties.identity.$ref` | `../../../../../common-types/resource-management/v4/managedidentity.json#/definitions/ManagedServiceIdentity` | `../../../../../common-types/resource-management/v5/managedidentity.json#/definitions/ManagedServiceIdentity` |
| `definitions.DevCenterUpdate.allOf[0].$ref` | `commonDefinitions.json#/definitions/TrackedResourceUpdate` | `#/definitions/TrackedResourceUpdate` |
| `definitions.DevCenterUpdate.properties.identity.$ref` | `../../../../../common-types/resource-management/v4/managedidentity.json#/definitions/ManagedServiceIdentity` | `../../../../../common-types/resource-management/v5/managedidentity.json#/definitions/ManagedServiceIdentity` |
| `definitions.Encryption.properties.customerManagedKeyEncryption.$ref` | `../../../../../common-types/resource-management/v4/customermanagedkeys.json#/definitions/customerManagedKeyEncryption` | `../../../../../common-types/resource-management/v5/customermanagedkeys.json#/definitions/customerManagedKeyEncryption` |
| `definitions.EncryptionSetUpdate.allOf[0].$ref` | `commonDefinitions.json#/definitions/TrackedResourceUpdate` | `#/definitions/TrackedResourceUpdate` |
| `definitions.EncryptionSetUpdate.properties.identity.$ref` | `../../../../../common-types/resource-management/v4/managedidentity.json#/definitions/ManagedServiceIdentity` | `../../../../../common-types/resource-management/v5/managedidentity.json#/definitions/ManagedServiceIdentity` |
| `definitions.EnvironmentType.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.Gallery.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.HealthCheckStatusDetails.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.ImageDefinitionBuildDetails.properties.imageReference.$ref` | `vdi.json#/definitions/ImageReference` | `#/definitions/ImageReference` |
| `definitions.ImageDefinitionBuildProperties.properties.imageReference.$ref` | `vdi.json#/definitions/ImageReference` | `#/definitions/ImageReference` |
| `definitions.ImageDefinitionProperties.properties.activeImageReference.$ref` | `vdi.json#/definitions/ImageReference` | `#/definitions/ImageReference` |
| `definitions.ImageDefinitionProperties.properties.imageReference.$ref` | `vdi.json#/definitions/ImageReference` | `#/definitions/ImageReference` |
| `definitions.ImageDefinitionProperties.properties.imageValidationErrorDetails.$ref` | `vdi.json#/definitions/ImageValidationErrorDetails` | `#/definitions/ImageValidationErrorDetails` |
| `definitions.NetworkConnectionUpdate.allOf[0].$ref` | `commonDefinitions.json#/definitions/TrackedResourceUpdate` | `#/definitions/TrackedResourceUpdate` |
| `definitions.PoolUpdate.allOf[0].$ref` | `commonDefinitions.json#/definitions/TrackedResourceUpdate` | `#/definitions/TrackedResourceUpdate` |
| `definitions.Project.properties.identity.$ref` | `../../../../../common-types/resource-management/v4/managedidentity.json#/definitions/ManagedServiceIdentity` | `../../../../../common-types/resource-management/v5/managedidentity.json#/definitions/ManagedServiceIdentity` |
| `definitions.ProjectEnvironmentType.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/TrackedResource` |
| `definitions.ProjectEnvironmentType.properties.identity.$ref` | `../../../../../common-types/resource-management/v4/managedidentity.json#/definitions/ManagedServiceIdentity` | `../../../../../common-types/resource-management/v5/managedidentity.json#/definitions/ManagedServiceIdentity` |
| `definitions.ProjectEnvironmentTypeUpdate.properties.identity.$ref` | `../../../../../common-types/resource-management/v4/managedidentity.json#/definitions/ManagedServiceIdentity` | `../../../../../common-types/resource-management/v5/managedidentity.json#/definitions/ManagedServiceIdentity` |
| `definitions.ProjectPolicy.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.ProjectUpdate.allOf[0].$ref` | `commonDefinitions.json#/definitions/TrackedResourceUpdate` | `#/definitions/TrackedResourceUpdate` |
| `definitions.ProjectUpdate.properties.identity.$ref` | `../../../../../common-types/resource-management/v4/managedidentity.json#/definitions/ManagedServiceIdentity` | `../../../../../common-types/resource-management/v5/managedidentity.json#/definitions/ManagedServiceIdentity` |
| `definitions.Schedule.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.ScheduleUpdateProperties.allOf[0].$ref` | `commonDefinitions.json#/definitions/TrackedResourceUpdate` | `#/definitions/TrackedResourceUpdate` |
| `definitions.SkuListResult.properties.value.items.$ref` | `commonDefinitions.json#/definitions/DevCenterSku` | `#/definitions/DevCenterSku` |
| `definitions.SyncErrorDetails.properties.operationError.$ref` | `vdi.json#/definitions/CatalogErrorDetails` | `#/definitions/CatalogErrorDetails` |
| `paths['/providers/microsoft.DevCenter/operations'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/OperationListResult` | `../../../../../common-types/resource-management/v5/types.json#/definitions/OperationListResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/checkNameAvailability'].post.parameters[0].schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/CheckNameAvailabilityRequest` | `../../../../../common-types/resource-management/v5/types.json#/definitions/CheckNameAvailabilityRequest` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/checkNameAvailability'].post.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/CheckNameAvailabilityResponse` | `../../../../../common-types/resource-management/v5/types.json#/definitions/CheckNameAvailabilityResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DevCenter/checkScopedNameAvailability'].post.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/CheckNameAvailabilityResponse` | `../../../../../common-types/resource-management/v5/types.json#/definitions/CheckNameAvailabilityResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/environmentDefinitions/{environmentDefinitionName}/getErrorDetails'].post.responses.200.schema.$ref` | `vdi.json#/definitions/CatalogResourceValidationErrorDetails` | `#/definitions/CatalogResourceValidationErrorDetails` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/imageDefinitions/{imageDefinitionName}/getErrorDetails'].post.responses.200.schema.$ref` | `vdi.json#/definitions/CatalogResourceValidationErrorDetails` | `#/definitions/CatalogResourceValidationErrorDetails` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/devcenters/{devCenterName}/catalogs/{catalogName}/tasks/{taskName}/getErrorDetails'].post.responses.200.schema.$ref` | `vdi.json#/definitions/CatalogResourceValidationErrorDetails` | `#/definitions/CatalogResourceValidationErrorDetails` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/catalogs/{catalogName}/environmentDefinitions/{environmentDefinitionName}/getErrorDetails'].post.responses.200.schema.$ref` | `vdi.json#/definitions/CatalogResourceValidationErrorDetails` | `#/definitions/CatalogResourceValidationErrorDetails` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/catalogs/{catalogName}/imageDefinitions/{imageDefinitionName}/getErrorDetails'].post.responses.200.schema.$ref` | `vdi.json#/definitions/CatalogResourceValidationErrorDetails` | `#/definitions/CatalogResourceValidationErrorDetails` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DevCenter/projects/{projectName}/listSkus'].post.responses.200.schema.$ref` | `vdi.json#/definitions/SkuListResult` | `#/definitions/SkuListResult` |

