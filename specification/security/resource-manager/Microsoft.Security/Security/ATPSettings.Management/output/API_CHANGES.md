## Changed Paths

Path: /{resourceId}/providers/microsoft.Security/advancedThreatProtectionSettings/{settingName}
Change Type: deleted

Path: /{resourceId}/providers/microsoft.Security/advancedThreatProtectionSettings/current
Change Type: added

## Swagger Changes

### Changes for `/{resourceId}/providers/microsoft.Security/advancedThreatProtectionSettings/{settingName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceId}/providers/microsoft.Security/advancedThreatProtectionSettings/{settingName}__deleted']` | deleted | `{"get":{"operationId":"AdvancedThreatProtection_Get","tags":["AdvancedThreatProtection"],"descriptio...` |

### Changes for `/{resourceId}/providers/microsoft.Security/advancedThreatProtectionSettings/current`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceId}/providers/microsoft.Security/advancedThreatProtectionSettings/current__added']` | added | `{"get":{"operationId":"AdvancedThreatProtection_Get","tags":["AdvancedThreatProtection"],"descriptio...` |

### Changes for `CloudError`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudError__added` | added | `{"type":"object","description":"Common error response for all Azure Resource Manager APIs to return ...` |

### Changes for `CloudErrorBody`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudErrorBody__added` | added | `{"type":"object","description":"The error detail.","properties":{"code":{"type":"string","descriptio...` |

### Changes for `ErrorAdditionalInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorAdditionalInfo__added` | added | `{"type":"object","description":"The resource management error additional info.","properties":{"type"...` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdvancedThreatProtectionSetting.properties.properties.description__added` | added | `The Advanced Threat Protection settings.` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AdvancedThreatProtectionSetting.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |

