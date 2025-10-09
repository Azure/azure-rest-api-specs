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

### Changes for `ConfigurationDictionary`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConfigurationDictionary__deleted` | deleted | `{"type":"object","description":"The custom configuration for configuration profile. Name and value p...` |

### Changes for `ManagedBy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ManagedBy__deleted` | deleted | `{"type":"string","description":"Azure resource id. Indicates if this resource is managed by another ...` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BestPractice.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}...` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BestPractice.properties.id__deleted` | deleted | `{"type":"string","description":"The fully qualified ID for the best practice.  For example, /provide...` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BestPractice.properties.type__deleted` | deleted | `{"type":"string","description":"The type of the resource.  For example, Microsoft.Automanage/bestPra...` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BestPractice.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the best practice. For example, azureBestPracticesProduc...` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BestPractice.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","des...` |
| `definitions.ConfigurationProfile.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","des...` |
| `definitions.ConfigurationProfileAssignment.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","des...` |
| `definitions.Report.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","des...` |
| `definitions.ServicePrincipal.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","des...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BestPracticeList.required__added` | added | `["value"]` |
| `definitions.ConfigurationProfileAssignmentList.required__added` | added | `["value"]` |
| `definitions.ConfigurationProfileList.required__added` | added | `["value"]` |
| `definitions.ReportList.required__added` | added | `["value"]` |
| `definitions.ServicePrincipalListResult.required__added` | added | `["value"]` |

### Changes for `nextLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BestPracticeList.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.ConfigurationProfileAssignmentList.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.ConfigurationProfileList.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.ReportList.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.ServicePrincipalListResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConfigurationProfileProperties.properties.configuration.$ref__deleted` | deleted | `#/definitions/ConfigurationDictionary` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AssignmentReportProperties.properties.error.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorDetail` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorDetail` |
| `definitions.BestPracticeList.description` | `The response of the list best practice operation.` | `[Placeholder] Discription for page model` |
| `definitions.BestPracticeList.properties.value.description` | `Result of the list best practice operation.` | `[Placeholder] Discription for value property` |
| `definitions.ConfigurationProfile.allOf[0].$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/TrackedResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.ConfigurationProfileAssignment.allOf[0].$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ConfigurationProfileAssignmentList.description` | `The response of the list configuration profile assignment operation.` | `[Placeholder] Discription for page model` |
| `definitions.ConfigurationProfileAssignmentList.properties.value.description` | `Result of the list configuration profile assignment operation.` | `[Placeholder] Discription for value property` |
| `definitions.ConfigurationProfileList.description` | `The response of the list configuration profile operation.` | `[Placeholder] Discription for page model` |
| `definitions.ConfigurationProfileList.properties.value.description` | `Result of the list ConfigurationProfile operation.` | `[Placeholder] Discription for value property` |
| `definitions.Report.allOf[0].$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ReportList.description` | `The response of the list report operation.` | `[Placeholder] Discription for page model` |
| `definitions.ReportList.properties.value.description` | `Result of the list report operation.` | `[Placeholder] Discription for value property` |
| `definitions.ReportResource.properties.error.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorDetail` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorDetail` |
| `definitions.ServicePrincipal.allOf[0].$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ServicePrincipalListResult.description` | `The list of ServicePrincipals.` | `[Placeholder] Discription for page model` |
| `definitions.ServicePrincipalListResult.properties.value.description` | `The list of servicePrincipals.` | `[Placeholder] Discription for value property` |
| `paths['/providers/microsoft.Automanage/bestPractices'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Automanage/bestPractices/{bestPracticeName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Automanage/bestPractices/{bestPracticeName}/versions'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Automanage/bestPractices/{bestPracticeName}/versions/{versionName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Automanage/operations'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/OperationListResult` | `../../../../../common-types/resource-management/v3/types.json#/definitions/OperationListResult` |
| `paths['/providers/microsoft.Automanage/operations'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Automanage/configurationProfileAssignments'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Automanage/configurationProfiles'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Automanage/servicePrincipals'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Automanage/servicePrincipals/default'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfileAssignments'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}'].delete.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}'].patch.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}'].put.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions'].get.description` | `Retrieve a list of configuration profile version for a configuration profile ` | `Retrieve a list of configuration profile version for a configuration profile` |
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

