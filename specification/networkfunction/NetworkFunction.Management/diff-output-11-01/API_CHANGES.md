## Swagger Changes

### Changes for `license`

| Path | Change Type | Value |
|------|------------|-------|
| `info.license__deleted` | deleted | `{"name":"Microsoft"}` |

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

### Changes for `ProxyResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ProxyResource__deleted` | deleted | `{"type":"object","description":"An azure resource object","properties":{"id":{"type":"string","descr...` |

### Changes for `SystemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SystemData__deleted` | deleted | `{"type":"object","description":"Metadata pertaining to creation and last modification of the resourc...` |

### Changes for `TrackedResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TrackedResource__deleted` | deleted | `{"type":"object","description":"Common resource representation.","properties":{"id":{"type":"string"...` |

### Changes for `OperationDisplay`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationDisplay__added` | added | `{"type":"object","description":"Display metadata associated with the operation.","properties":{"prov...` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureTrafficCollector.properties.location__added` | added | `{"type":"string","description":"Resource location."}` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureTrafficCollector.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureTrafficCollectorListResult.required__added` | added | `["value"]` |
| `definitions.CollectorPolicyListResult.required__added` | added | `["value"]` |
| `definitions.OperationListResult.required__added` | added | `["value"]` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureTrafficCollectorPropertiesFormat.properties.collectorPolicies.readOnly__deleted` | deleted | `true` |

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
| `definitions.AzureTrafficCollector.allOf[0].$ref` | `#/definitions/TrackedResource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.AzureTrafficCollectorPropertiesFormat.properties.collectorPolicies.items.$ref` | `#/definitions/ResourceReference` | `#/definitions/CollectorPolicy` |
| `definitions.CollectorPolicy.allOf[0].$ref` | `#/definitions/TrackedResource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |

