## Swagger Changes

### Changes for `license`

| Path | Change Type | Value |
|------|------------|-------|
| `info.license__deleted` | deleted | `{"name":"Microsoft"}` |

### Changes for `x-ms-examples`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.NetworkFunction/operations'].get['x-ms-examples__deleted']` | deleted | `{"OperationsList":{"$ref":"./examples/OperationsList.json"}}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.NetworkFunction/azureTrafficCollectors'].get['x-ms-examples__deleted']` | deleted | `{"List of Traffic Collectors by Subscription":{"$ref":"./examples/AzureTrafficCollectorsBySubscripti...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.NetworkFunction/azureTrafficCollectors'].get['x-ms-examples__deleted']` | deleted | `{"List of Traffic Collectors by ResourceGroup":{"$ref":"./examples/AzureTrafficCollectorsByResourceG...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}'].delete['x-ms-examples__deleted']` | deleted | `{"Delete Traffic Collector":{"$ref":"./examples/AzureTrafficCollectorDelete.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}'].get['x-ms-examples__deleted']` | deleted | `{"Get Traffic Collector":{"$ref":"./examples/AzureTrafficCollectorGet.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}'].patch['x-ms-examples__deleted']` | deleted | `{"Update Traffic Collector tags":{"$ref":"./examples/AzureTrafficCollectorUpdateTags.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}'].put['x-ms-examples__deleted']` | deleted | `{"Create a traffic collector":{"$ref":"./examples/AzureTrafficCollectorCreate.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}/collectorPolicies'].get['x-ms-examples__deleted']` | deleted | `{"List of Collection Policies":{"$ref":"./examples/CollectorPoliciesList.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}/collectorPolicies/{collectorPolicyName}'].delete['x-ms-examples__deleted']` | deleted | `{"Delete Collection Policy":{"$ref":"./examples/CollectorPolicyDelete.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}/collectorPolicies/{collectorPolicyName}'].get['x-ms-examples__deleted']` | deleted | `{"Get Collection Policy":{"$ref":"./examples/CollectorPolicyGet.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}/collectorPolicies/{collectorPolicyName}'].put['x-ms-examples__deleted']` | deleted | `{"Create a collection policy":{"$ref":"./examples/CollectorPolicyCreate.json"}}` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}/collectorPolicies/{collectorPolicyName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}/collectorPolicies/{collectorPolicyName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/AzureTrafficCollector` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}/collectorPolicies/{collectorPolicyName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/CollectorPolicy` |

### Changes for `patch`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.NetworkFunction/azureTrafficCollectors/{azureTrafficCollectorName}/collectorPolicies/{collectorPolicyName}'].patch__added` | added | `{"operationId":"CollectorPolicies_UpdateTags","parameters":[{"name":"azureTrafficCollectorName","in"...` |

### Changes for `ProxyResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ProxyResource__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string","readOnly":true},"type":{"type":"string","readO...` |

### Changes for `SystemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SystemData__deleted` | deleted | `{"type":"object","properties":{"createdBy":{"type":"string"},"createdByType":{"type":"string","enum"...` |

### Changes for `TrackedResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TrackedResource__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string","readOnly":true},"name":{"type":"string","readO...` |

### Changes for `OperationDisplay`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationDisplay__added` | added | `{"type":"object","properties":{"provider":{"type":"string"},"resource":{"type":"string"},"operation"...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureTrafficCollectorListResult.required__added` | added | `["value"]` |
| `definitions.CollectorPolicyListResult.required__added` | added | `["value"]` |
| `definitions.OperationListResult.required__added` | added | `["value"]` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CollectorPolicy.properties.systemData__deleted` | deleted | `{"allOf":[{"$ref":"#/definitions/SystemData"}],"readOnly":true}` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation.properties.isDataAction.default__deleted` | deleted | `false` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation.properties.display.type__deleted` | deleted | `object` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation.properties.display.properties__deleted` | deleted | `{"provider":{"type":"string","description":"Service provider: Microsoft NetworkFunction."},"resource...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation.properties.display.$ref__added` | added | `#/definitions/OperationDisplay` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AzureTrafficCollector.allOf[0].$ref` | `#/definitions/TrackedResource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.CollectorPolicy.allOf[0].$ref` | `#/definitions/ProxyResource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |

