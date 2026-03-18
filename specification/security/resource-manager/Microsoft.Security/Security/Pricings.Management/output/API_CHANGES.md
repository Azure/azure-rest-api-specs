## Changed Paths

Path: /{scope}/providers/microsoft.Security/pricings
Change Type: added

Path: /{scope}/providers/microsoft.Security/pricings/{pricingName}
Change Type: added

Path: /{scopeId}/providers/microsoft.Security/pricings
Change Type: deleted

Path: /{scopeId}/providers/microsoft.Security/pricings/{pricingName}
Change Type: deleted

## Swagger Changes

### Changes for `/{scopeId}/providers/microsoft.Security/pricings`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scopeId}/providers/microsoft.Security/pricings__deleted']` | deleted | `{"get":{"operationId":"Pricings_List","tags":["Pricings"],"description":"Lists Microsoft Defender fo...` |

### Changes for `/{scopeId}/providers/microsoft.Security/pricings/{pricingName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scopeId}/providers/microsoft.Security/pricings/{pricingName}__deleted']` | deleted | `{"get":{"operationId":"Pricings_Get","tags":["Pricings"],"description":"Get the Defender plans prici...` |

### Changes for `/{scope}/providers/microsoft.Security/pricings`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/pricings__added']` | added | `{"get":{"operationId":"Pricings_List","tags":["Pricings"],"description":"Lists Microsoft Defender fo...` |

### Changes for `/{scope}/providers/microsoft.Security/pricings/{pricingName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/pricings/{pricingName}__added']` | added | `{"get":{"operationId":"Pricings_Get","tags":["Pricings"],"description":"Get the Defender plans prici...` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Extension.properties.operationStatus.type__deleted` | deleted | `object` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.Pricing.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `info.description` | `API spec for Microsoft.Security (Microsoft Defender for Cloud) resource provider` | `API spec for Microsoft.Security (Azure Security Center) resource provider` |
| `info.title` | `Microsoft Defender for Cloud` | `SecurityCenter` |

