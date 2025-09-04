## Swagger Changes

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}'].delete.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ResourceConnector/appliances/{resourceName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/appliance` |

### Changes for `appliancePropertiesInfrastructureConfig`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.appliancePropertiesInfrastructureConfig__added` | added | `{"type":"object","properties":{"provider":{"type":"string","enum":["VMWare","HCI","SCVMM"],"x-ms-enu...` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.applianceProperties.properties.infrastructureConfig.type__deleted` | deleted | `object` |
| `definitions.SupportedVersion.properties.metadata.type__deleted` | deleted | `object` |
| `definitions.SupportedVersionCatalogVersion.properties.data.type__deleted` | deleted | `object` |
| `definitions.SupportedVersionMetadata.properties.catalogVersion.type__deleted` | deleted | `object` |
| `definitions.UpgradeGraph.properties.properties.type__deleted` | deleted | `object` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.applianceListResult.required__added` | added | `["value"]` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.applianceProperties.properties.infrastructureConfig.properties__deleted` | deleted | `{"provider":{"type":"string","description":"Information about the connected appliance.","enum":["VMW...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.applianceProperties.properties.infrastructureConfig.$ref__added` | added | `#/definitions/appliancePropertiesInfrastructureConfig` |

### Changes for `x-ms-client-flatten`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.patchableAppliance['x-ms-client-flatten__deleted']` | deleted | `true` |

