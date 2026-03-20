## Swagger Changes

### Changes for `x-ms-discriminator-value`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertSyncSettings['x-ms-discriminator-value__deleted']` | deleted | `AlertSyncSettings` |
| `definitions.DataExportSettings['x-ms-discriminator-value__deleted']` | deleted | `DataExportSettings` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertSyncSettings.required__added` | added | `["kind"]` |
| `definitions.DataExportSettings.required__added` | added | `["kind"]` |
| `definitions.SettingsList.required__added` | added | `["value"]` |

### Changes for `kind`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AlertSyncSettings.properties.kind__added` | added | `{"type":"string","description":"the kind of the settings string","enum":["AlertSyncSettings"],"x-ms-...` |
| `definitions.DataExportSettings.properties.kind__added` | added | `{"type":"string","description":"the kind of the settings string","enum":["DataExportSettings"],"x-ms...` |

### Changes for `discriminator`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Setting.discriminator__deleted` | deleted | `kind` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Setting.properties.properties__added` | added | `{"type":"object","description":"The resource-specific properties for this resource."}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.Setting.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `info.description` | `API spec for Microsoft.Security (Microsoft Defender for Cloud) resource provider` | `API spec for Microsoft.Security (Azure Security Center) resource provider` |
| `info.title` | `Microsoft Defender for Cloud` | `SecurityCenter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/settings'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/settings/{settingName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/settings/{settingName}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

