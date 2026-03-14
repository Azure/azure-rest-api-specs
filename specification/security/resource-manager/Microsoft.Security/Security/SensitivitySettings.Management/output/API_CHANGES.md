## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Security/sensitivitySettings'].get.tags__added` | added | `["GetSensitivitySettingsResponses"]` |

### Changes for `Labels`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Labels__deleted` | deleted | `{"type":"array","description":"List of Microsoft information protection sensitivity labels","items":...` |

### Changes for `SensitiveInfoTypesIds`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SensitiveInfoTypesIds__deleted` | deleted | `{"type":"array","description":"List of selected sensitive info types' IDs.","items":{"type":"string"...` |

### Changes for `GetSensitivitySettingsResponseProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GetSensitivitySettingsResponseProperties__added` | added | `{"type":"object","description":"The sensitivity settings properties","properties":{"sensitiveInfoTyp...` |

### Changes for `GetSensitivitySettingsResponsePropertiesMipInformation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GetSensitivitySettingsResponsePropertiesMipInformation__added` | added | `{"type":"object","description":"Microsoft information protection built-in and custom information typ...` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GetSensitivitySettingsResponse.allOf__added` | added | `[{"$ref":"../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyReso...` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GetSensitivitySettingsResponse.properties.id__deleted` | deleted | `{"type":"string","description":"The ID of the sensitivity settings","readOnly":true}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GetSensitivitySettingsResponse.properties.properties.type__deleted` | deleted | `object` |
| `definitions.GetSensitivitySettingsResponse.properties.type__deleted` | deleted | `{"type":"string","description":"The type of the sensitivity settings","readOnly":true}` |
| `definitions.UpdateSensitivitySettingsRequest.properties.sensitiveInfoTypesIds.type__added` | added | `array` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GetSensitivitySettingsResponse.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the sensitivity settings","readOnly":true}` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GetSensitivitySettingsResponse.properties.properties.properties__deleted` | deleted | `{"sensitiveInfoTypesIds":{"$ref":"#/definitions/SensitiveInfoTypesIds"},"sensitivityThresholdLabelOr...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GetSensitivitySettingsResponse.properties.properties.$ref__added` | added | `#/definitions/GetSensitivitySettingsResponseProperties` |
| `definitions.UpdateSensitivitySettingsRequest.properties.sensitiveInfoTypesIds.$ref__deleted` | deleted | `#/definitions/SensitiveInfoTypesIds` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Label.properties.order.format__added` | added | `float` |
| `definitions.UpdateSensitivitySettingsRequest.properties.sensitivityThresholdLabelOrder.format__added` | added | `float` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdateSensitivitySettingsRequest.properties.sensitiveInfoTypesIds.description__added` | added | `List of selected sensitive info types' IDs.` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UpdateSensitivitySettingsRequest.properties.sensitiveInfoTypesIds.items__added` | added | `{"type":"string"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `info.description` | `API spec for Microsoft.Security Data Sensitivity Settings` | `API spec for Microsoft.Security (Azure Security Center) resource provider` |
| `info.title` | `Data Sensitivity Settings` | `SecurityCenter` |
| `paths['/providers/microsoft.Security/sensitivitySettings'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Security/sensitivitySettings/current'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Security/sensitivitySettings/current'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

