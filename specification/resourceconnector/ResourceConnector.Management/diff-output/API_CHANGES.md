## Changed Paths

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}/upgradeGraphs{upgradeGraph}/getUpgradeGraph
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}/upgradeGraphs/{upgradeGraph}
Change Type: deleted

## Swagger Changes

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}/upgradeGraphs/{upgradeGraph}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}/upgradeGraphs/{upgradeGraph}__deleted']` | deleted | `{"get":{"operationId":"Appliances_GetUpgradeGraph","parameters":[{"name":"resourceName","in":"path",...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}/upgradeGraphs{upgradeGraph}/getUpgradeGraph`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}/upgradeGraphs{upgradeGraph}/getUpgradeGraph__added']` | added | `{"get":{"operationId":"Appliances_GetUpgradeGraph","parameters":[{"name":"resourceName","in":"path",...` |

### Changes for `x-ms-examples`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.ResourceConnector/operations'].get['x-ms-examples__deleted']` | deleted | `{"List Appliances operations":{"$ref":"./examples/AppliancesListOperations.json"}}` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}'].delete.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Appliance` |

### Changes for `appliance`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.appliance__deleted` | deleted | `{"type":"object","properties":{"identity":{"$ref":"#/definitions/Identity"},"properties":{"$ref":"#/...` |

### Changes for `applianceCredentialKubeconfig`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.applianceCredentialKubeconfig__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string","enum":["clusterUser","clusterCustomerUser"],...` |

### Changes for `applianceGetTelemetryConfigResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.applianceGetTelemetryConfigResult__deleted` | deleted | `{"type":"object","properties":{"telemetryInstrumentationKey":{"type":"string","readOnly":true}}}` |

### Changes for `applianceListCredentialResults`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.applianceListCredentialResults__deleted` | deleted | `{"type":"object","properties":{"hybridConnectionConfig":{"$ref":"#/definitions/HybridConnectionConfi...` |

### Changes for `applianceListKeysResults`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.applianceListKeysResults__deleted` | deleted | `{"type":"object","properties":{"artifactProfiles":{"type":"object","additionalProperties":{"$ref":"#...` |

### Changes for `applianceListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.applianceListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"nextLink":{...` |

### Changes for `applianceOperation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.applianceOperation__deleted` | deleted | `{"type":"object","properties":{"display":{"$ref":"#/definitions/applianceOperationValueDisplay","x-m...` |

### Changes for `applianceOperationValueDisplay`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.applianceOperationValueDisplay__deleted` | deleted | `{"type":"object","properties":{"description":{"type":"string","readOnly":true},"operation":{"type":"...` |

### Changes for `applianceOperationsList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.applianceOperationsList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"nextLink":{...` |

### Changes for `applianceProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.applianceProperties__deleted` | deleted | `{"type":"object","properties":{"distro":{"type":"string","default":"AKSEdge","enum":["AKSEdge"],"x-m...` |

### Changes for `patchableAppliance`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.patchableAppliance__deleted` | deleted | `{"type":"object","properties":{"tags":{"type":"object","additionalProperties":{"type":"string"}}},"x...` |

### Changes for `Appliance`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Appliance__added` | added | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ApplianceProperties","x-ms-client...` |

### Changes for `ApplianceCredentialKubeconfig`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplianceCredentialKubeconfig__added` | added | `{"type":"object","properties":{"name":{"type":"string","enum":["clusterUser","clusterCustomerUser"],...` |

### Changes for `ApplianceGetTelemetryConfigResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplianceGetTelemetryConfigResult__added` | added | `{"type":"object","properties":{"telemetryInstrumentationKey":{"type":"string","readOnly":true}}}` |

### Changes for `ApplianceListCredentialResults`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplianceListCredentialResults__added` | added | `{"type":"object","properties":{"hybridConnectionConfig":{"$ref":"#/definitions/HybridConnectionConfi...` |

### Changes for `ApplianceListKeysResults`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplianceListKeysResults__added` | added | `{"type":"object","properties":{"artifactProfiles":{"type":"object","additionalProperties":{"$ref":"#...` |

### Changes for `ApplianceListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplianceListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ApplianceProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplianceProperties__added` | added | `{"type":"object","properties":{"distro":{"type":"string","default":"AKSEdge","enum":["AKSEdge"],"x-m...` |

### Changes for `AppliancePropertiesInfrastructureConfig`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AppliancePropertiesInfrastructureConfig__added` | added | `{"type":"object","properties":{"provider":{"type":"string","enum":["VMWare","HCI","SCVMM"],"x-ms-enu...` |

### Changes for `PatchableAppliance`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PatchableAppliance__added` | added | `{"type":"object","properties":{"tags":{"type":"object","additionalProperties":{"type":"string"}}}}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SupportedVersion.properties.metadata.type__deleted` | deleted | `object` |
| `definitions.SupportedVersionCatalogVersion.properties.data.type__deleted` | deleted | `object` |
| `definitions.SupportedVersionMetadata.properties.catalogVersion.type__deleted` | deleted | `object` |
| `definitions.UpgradeGraph.properties.properties.type__deleted` | deleted | `object` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `paths['/providers/microsoft.ResourceConnector/operations'].get.operationId` | `Appliances_ListOperations` | `Operations_List` |
| `paths['/providers/microsoft.ResourceConnector/operations'].get.responses.200.schema.$ref` | `#/definitions/applianceOperationsList` | `../../../../../common-types/resource-management/v3/types.json#/definitions/OperationListResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ResourceConnector/appliances'].get.responses.200.schema.$ref` | `#/definitions/applianceListResult` | `#/definitions/ApplianceListResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.ResourceConnector/telemetryconfig'].get.responses.200.schema.$ref` | `#/definitions/applianceGetTelemetryConfigResult` | `#/definitions/ApplianceGetTelemetryConfigResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances'].get.responses.200.schema.$ref` | `#/definitions/applianceListResult` | `#/definitions/ApplianceListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}'].get.responses.200.schema.$ref` | `#/definitions/appliance` | `#/definitions/Appliance` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}'].patch.parameters[1].schema.$ref` | `#/definitions/patchableAppliance` | `#/definitions/PatchableAppliance` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}'].patch.responses.200.schema.$ref` | `#/definitions/appliance` | `#/definitions/Appliance` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}'].put.parameters[1].schema.$ref` | `#/definitions/appliance` | `#/definitions/Appliance` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}'].put.responses.200.schema.$ref` | `#/definitions/appliance` | `#/definitions/Appliance` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}'].put.responses.201.schema.$ref` | `#/definitions/appliance` | `#/definitions/Appliance` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}/listClusterUserCredential'].post.responses.200.schema.$ref` | `#/definitions/applianceListCredentialResults` | `#/definitions/ApplianceListCredentialResults` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}/listkeys'].post.responses.200.schema.$ref` | `#/definitions/applianceListKeysResults` | `#/definitions/ApplianceListKeysResults` |

