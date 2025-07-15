## Changed Paths

Path: /providers/Microsoft.Automanage/bestPractices/{bestPracticeName}/versions
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/Microsoft.Automanage/configurationProfiles
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/clusters/{clusterName}/configurationProfileAssignments
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/clusters/{clusterName}/configurationProfileAssignments/{configurationProfileAssignmentName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/clusters/{clusterName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/clusters/{clusterName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/configurationProfiles
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/machines/{machineName}/configurationProfileAssignments
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/machines/{machineName}/configurationProfileAssignments/{configurationProfileAssignmentName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/machines/{machineName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/machines/{machineName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/virtualMachines/{vmName}/configurationProfileAssignments
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/virtualMachines/{vmName}/configurationProfileAssignments/{configurationProfileAssignmentName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/virtualMachines/{vmName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/virtualMachines/{vmName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.Automanage/configurationProfileAssignments
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}
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

### Changes for `/providers/Microsoft.Automanage/bestPractices/{bestPracticeName}/versions`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/Microsoft.Automanage/bestPractices/{bestPracticeName}/versions__deleted']` | deleted | `{"get":{"operationId":"BestPracticesVersions_ListByTenant","parameters":[{"name":"bestPracticeName",...` |

### Changes for `/subscriptions/{subscriptionId}/providers/Microsoft.Automanage/configurationProfiles`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Automanage/configurationProfiles__deleted']` | deleted | `{"get":{"operationId":"ConfigurationProfiles_ListBySubscription","parameters":[],"responses":{"200":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions__deleted']` | deleted | `{"get":{"operationId":"ConfigurationProfilesVersions_ListChildResources","parameters":[{"name":"conf...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments__deleted']` | deleted | `{"get":{"operationId":"ConfigurationProfileAssignments_ListByClusterName","parameters":[{"name":"clu...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}__deleted']` | deleted | `{"get":{"operationId":"ConfigurationProfileHCIAssignments_Get","parameters":[{"name":"clusterName","...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports__deleted']` | deleted | `{"get":{"operationId":"HCIReports_ListByConfigurationProfileAssignments","parameters":[{"name":"clus...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHci/clusters/{clusterName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}__deleted']` | deleted | `{"get":{"operationId":"HCIReports_Get","parameters":[{"name":"clusterName","in":"path","required":tr...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.Automanage/configurationProfileAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.Automanage/configurationProfileAssignments__deleted']` | deleted | `{"get":{"operationId":"ConfigurationProfileAssignments_ListByVirtualMachines","parameters":[{"name":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}__deleted']` | deleted | `{"get":{"operationId":"ConfigurationProfileAssignments_Get","parameters":[{"name":"configurationProf...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports__deleted']` | deleted | `{"get":{"operationId":"reports_ListByConfigurationProfileAssignments","parameters":[{"name":"configu...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}__deleted']` | deleted | `{"get":{"operationId":"reports_Get","parameters":[{"name":"configurationProfileAssignmentName","in":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments__deleted']` | deleted | `{"get":{"operationId":"ConfigurationProfileAssignments_ListByMachineName","parameters":[{"name":"mac...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}__deleted']` | deleted | `{"get":{"operationId":"ConfigurationProfileHCRPAssignments_Get","parameters":[{"name":"machineName",...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports__deleted']` | deleted | `{"get":{"operationId":"HCRPReports_ListByConfigurationProfileAssignments","parameters":[{"name":"mac...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.Automanage/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}__deleted']` | deleted | `{"get":{"operationId":"HCRPReports_Get","parameters":[{"name":"machineName","in":"path","required":t...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/clusters/{clusterName}/configurationProfileAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/clusters/{clusterName}/configurationProfileAssignments__added']` | added | `{"get":{"operationId":"ConfigurationProfileAssignments_ListByClusterName","parameters":[{"name":"clu...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/clusters/{clusterName}/configurationProfileAssignments/{configurationProfileAssignmentName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/clusters/{clusterName}/configurationProfileAssignments/{configurationProfileAssignmentName}__added']` | added | `{"get":{"operationId":"ConfigurationProfileHCIAssignments_Get","parameters":[{"name":"clusterName","...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/clusters/{clusterName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/clusters/{clusterName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports__added']` | added | `{"get":{"operationId":"HCIReports_ListByConfigurationProfileAssignments","parameters":[{"name":"clus...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/clusters/{clusterName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/clusters/{clusterName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}__added']` | added | `{"get":{"operationId":"HCIReports_Get","parameters":[{"name":"clusterName","in":"path","required":tr...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/configurationProfiles`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/configurationProfiles__added']` | added | `{"get":{"operationId":"ConfigurationProfiles_ListByResourceGroup","parameters":[{"name":"configurati...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/machines/{machineName}/configurationProfileAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/machines/{machineName}/configurationProfileAssignments__added']` | added | `{"get":{"operationId":"ConfigurationProfileAssignments_ListByMachineName","parameters":[{"name":"mac...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/machines/{machineName}/configurationProfileAssignments/{configurationProfileAssignmentName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/machines/{machineName}/configurationProfileAssignments/{configurationProfileAssignmentName}__added']` | added | `{"get":{"operationId":"ConfigurationProfileHCRPAssignments_Get","parameters":[{"name":"machineName",...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/machines/{machineName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/machines/{machineName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports__added']` | added | `{"get":{"operationId":"HCRPReports_ListByConfigurationProfileAssignments","parameters":[{"name":"mac...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/machines/{machineName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/machines/{machineName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}__added']` | added | `{"get":{"operationId":"HCRPReports_Get","parameters":[{"name":"machineName","in":"path","required":t...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/virtualMachines/{vmName}/configurationProfileAssignments`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/virtualMachines/{vmName}/configurationProfileAssignments__added']` | added | `{"get":{"operationId":"ConfigurationProfileAssignments_ListByVirtualMachines","parameters":[{"name":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/virtualMachines/{vmName}/configurationProfileAssignments/{configurationProfileAssignmentName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/virtualMachines/{vmName}/configurationProfileAssignments/{configurationProfileAssignmentName}__added']` | added | `{"get":{"operationId":"ConfigurationProfileAssignments_Get","parameters":[{"name":"vmName","in":"pat...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/virtualMachines/{vmName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/virtualMachines/{vmName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports__added']` | added | `{"get":{"operationId":"reports_ListByConfigurationProfileAssignments","parameters":[{"name":"vmName"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/virtualMachines/{vmName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/virtualMachines/{vmName}/configurationProfileAssignments/{configurationProfileAssignmentName}/reports/{reportName}__added']` | added | `{"get":{"operationId":"reports_Get","parameters":[{"name":"vmName","in":"path","required":true,"type...` |

### Changes for `x-ms-pageable`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/Microsoft.Automanage/bestPractices'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Automanage/configurationProfileAssignments'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Automanage/servicePrincipals'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfileAssignments'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |

### Changes for `List configuration profiles by resource group`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles'].get['x-ms-examples']['List configuration profiles by resource group__deleted']` | deleted | `{"$ref":"./examples/listConfigurationProfilesByResourceGroup.json"}` |

### Changes for `List configuration profiles by subscription`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles'].get['x-ms-examples']['List configuration profiles by subscription__added']` | added | `{"$ref":"./examples/listConfigurationProfilesBySubscription.json"}` |

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
| `definitions.ConfigurationProfileProperties.properties.configuration.type__added` | added | `object` |

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

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConfigurationProfileProperties.properties.configuration.additionalProperties__added` | added | `{}` |

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
| `paths['/providers/Microsoft.Automanage/bestPractices'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/Microsoft.Automanage/bestPractices/{bestPracticeName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/Microsoft.Automanage/bestPractices/{bestPracticeName}/versions/{versionName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/Microsoft.Automanage/operations'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/OperationListResult` | `../../../../../common-types/resource-management/v3/types.json#/definitions/OperationListResult` |
| `paths['/providers/Microsoft.Automanage/operations'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Automanage/configurationProfileAssignments'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Automanage/servicePrincipals'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Automanage/servicePrincipals/default'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfileAssignments'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles'].get.operationId` | `ConfigurationProfiles_ListByResourceGroup` | `ConfigurationProfiles_ListBySubscription` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}'].delete.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}'].patch.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}'].put.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions/{versionName}'].delete.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions/{versionName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfiles/{configurationProfileName}/versions/{versionName}'].put.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

