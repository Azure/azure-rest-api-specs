## Changed Paths

Path: /providers/microsoft.Automanage/bestPractices
Change Type: deleted

Path: /providers/microsoft.Automanage/bestPractices/{bestPracticeName}/bestPractices
Change Type: added

Path: /providers/microsoft.Automanage/bestPractices/{bestPracticeName}/versions
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Automanage/configurationProfileAssignments
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Automanage/configurationProfiles
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles
Change Type: deleted

## Swagger Changes

### Changes for `produces`

| Path | Change Type | Value |
|------|------------|-------|
| `produces__added` | added | `["application/json"]` |

### Changes for `consumes`

| Path | Change Type | Value |
|------|------------|-------|
| `consumes__added` | added | `["application/json"]` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `info.description__added` | added | `Automanage Client` |

### Changes for `/providers/microsoft.Automanage/bestPractices`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Automanage/bestPractices__deleted']` | deleted | `{"get":{"operationId":"BestPractices_ListByTenant","parameters":[],"responses":{"200":{"description"...` |

### Changes for `/providers/microsoft.Automanage/bestPractices/{bestPracticeName}/versions`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Automanage/bestPractices/{bestPracticeName}/versions__deleted']` | deleted | `{"get":{"operationId":"BestPracticesVersions_ListByTenant","parameters":[{"name":"bestPracticeName",...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Automanage/configurationProfileAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Automanage/configurationProfileAssignments__deleted']` | deleted | `{"get":{"operationId":"ConfigurationProfileAssignments_ListBySubscription","parameters":[],"response...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Automanage/configurationProfiles`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Automanage/configurationProfiles__deleted']` | deleted | `{"get":{"operationId":"ConfigurationProfiles_ListBySubscription","parameters":[],"responses":{"200":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles__deleted']` | deleted | `{"get":{"operationId":"ConfigurationProfiles_ListByResourceGroup","parameters":[],"responses":{"200"...` |

### Changes for `/providers/microsoft.Automanage/bestPractices/{bestPracticeName}/bestPractices`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Automanage/bestPractices/{bestPracticeName}/bestPractices__added']` | added | `{"get":{"operationId":"BestPractices_ListByTenant","parameters":[{"name":"bestPracticeName","in":"pa...` |

### Changes for `x-ms-pageable`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Automanage/servicePrincipals'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfileAssignments'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHci/clusters/{clusterName}/providers/microsoft.Automanage/configurationProfileAssignments'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHci/clusters/{clusterName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachines/{vmName}/providers/microsoft.Automanage/configurationProfileAssignments'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachines/{vmName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/providers/microsoft.Automanage/configurationProfileAssignments'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |

### Changes for `List configuration profile versions by configuration profile`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions'].get['x-ms-examples']['List configuration profile versions by configuration profile__deleted']` | deleted | `{"$ref":"./examples/listConfigurationProfileVersions.json"}` |

### Changes for `List configuration profiles by resource group`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions'].get['x-ms-examples']['List configuration profiles by resource group__added']` | added | `{"$ref":"./examples/listConfigurationProfilesByResourceGroup.json"}` |

### Changes for `ConfigurationDictionary`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConfigurationDictionary__deleted` | deleted | `{"type":"object","example":{"Antimalware/Enable":true}}` |

### Changes for `ManagedBy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedBy__deleted` | deleted | `{"type":"string"}` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BestPractice.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}...` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BestPractice.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BestPractice.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BestPractice.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BestPractice.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","rea...` |
| `definitions.ConfigurationProfile.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","rea...` |
| `definitions.ConfigurationProfileAssignment.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","rea...` |
| `definitions.Report.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","rea...` |
| `definitions.ServicePrincipal.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","rea...` |

### Changes for `title`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BestPractice.properties.properties.title__deleted` | deleted | `Properties` |
| `definitions.ConfigurationProfileProperties.properties.configuration.title__deleted` | deleted | `configuration` |
| `definitions.Report.properties.properties.title__deleted` | deleted | `Properties` |
| `definitions.ServicePrincipal.properties.properties.title__deleted` | deleted | `Properties` |

### Changes for `x-ms-client-flatten`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BestPractice.properties.properties['x-ms-client-flatten__added']` | added | `true` |
| `definitions.ConfigurationProfile.properties.properties['x-ms-client-flatten__added']` | added | `true` |
| `definitions.ConfigurationProfileAssignment.properties.properties['x-ms-client-flatten__added']` | added | `true` |
| `definitions.Report.properties.properties['x-ms-client-flatten__added']` | added | `true` |
| `definitions.ServicePrincipal.properties.properties['x-ms-client-flatten__added']` | added | `true` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConfigurationProfileProperties.properties.configuration.$ref__deleted` | deleted | `#/definitions/ConfigurationDictionary` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AssignmentReportProperties.properties.error.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorDetail` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorDetail` |
| `definitions.ConfigurationProfile.allOf[0].$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/TrackedResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.ConfigurationProfileAssignment.allOf[0].$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.Report.allOf[0].$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ReportResource.properties.error.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorDetail` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorDetail` |
| `definitions.ServicePrincipal.allOf[0].$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `info.title` | `Automanage` | `AutomanageClient` |
| `paths['/providers/microsoft.Automanage/bestPractices/{bestPracticeName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Automanage/bestPractices/{bestPracticeName}/versions/{versionName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Automanage/operations'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/OperationListResult` | `../../../../../common-types/resource-management/v3/types.json#/definitions/OperationListResult` |
| `paths['/providers/microsoft.Automanage/operations'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Automanage/servicePrincipals'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Automanage/servicePrincipals/default'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfileAssignments'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}'].delete.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}'].patch.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}'].put.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions'].get.operationId` | `ConfigurationProfilesVersions_ListChildResources` | `ConfigurationProfiles_ListByResourceGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions/{versionName}'].delete.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions/{versionName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions/{versionName}'].put.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHci/clusters/{clusterName}/providers/microsoft.Automanage/configurationProfileAssignments'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHci/clusters/{clusterName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}'].delete.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHci/clusters/{clusterName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHci/clusters/{clusterName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}'].put.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHci/clusters/{clusterName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.AzureStackHci/clusters/{clusterName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachines/{vmName}/providers/microsoft.Automanage/configurationProfileAssignments'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachines/{vmName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}'].delete.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachines/{vmName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachines/{vmName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}'].put.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachines/{vmName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachines/{vmName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/providers/microsoft.Automanage/configurationProfileAssignments'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}'].delete.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}'].put.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.HybridCompute/machines/{machineName}/providers/microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

