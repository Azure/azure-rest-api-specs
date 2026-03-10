## Swagger Changes

### Changes for `definitions`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions__added` | added | `{"AscLocation":{"type":"object","description":"The ASC location of the subscription is in the \\"name...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/AscLocation` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}'].get.parameters[0].name__added` | added | `ascLocation` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}'].get.parameters[0].in__added` | added | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}'].get.parameters[0].type__added` | added | `string` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `info.description` | `API spec for Microsoft.Security (Microsoft Defender for Cloud) resource provider` | `API spec for Microsoft.Security (Azure Security Center) resource provider` |
| `info.title` | `Microsoft Defender for Cloud` | `SecurityCenter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations'].get.responses.200.schema.$ref` | `./common/v1/types.json#/definitions/AscLocationList` | `#/definitions/AscLocationList` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}'].get.responses.200.schema.$ref` | `./common/v1/types.json#/definitions/AscLocation` | `#/definitions/AscLocation` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/locations/{ascLocation}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

