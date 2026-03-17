## Changed Paths

Path: /{resourceId}/providers/microsoft.Security/advancedThreatProtectionSettings/{settingName}
Change Type: deleted

Path: /{scope}/providers/microsoft.Security/advancedThreatProtectionSettings/default
Change Type: added

## Swagger Changes

### Changes for `/{resourceId}/providers/microsoft.Security/advancedThreatProtectionSettings/{settingName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceId}/providers/microsoft.Security/advancedThreatProtectionSettings/{settingName}__deleted']` | deleted | `{"get":{"operationId":"AdvancedThreatProtection_Get","tags":["AdvancedThreatProtection"],"descriptio...` |

### Changes for `/{scope}/providers/microsoft.Security/advancedThreatProtectionSettings/default`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/advancedThreatProtectionSettings/default__added']` | added | `{"get":{"operationId":"AdvancedThreatProtection_Get","tags":["AdvancedThreatProtectionSettings"],"de...` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdvancedThreatProtectionSetting.properties.properties.description__added` | added | `The Advanced Threat Protection settings.` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AdvancedThreatProtectionSetting.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `info.title` | `Security Center` | `SecurityCenter` |

