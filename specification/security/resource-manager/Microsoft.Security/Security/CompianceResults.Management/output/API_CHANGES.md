## Changed Paths

Path: /{resourceId}/providers/microsoft.Security/complianceResults/{complianceResultName}
Change Type: deleted

Path: /{scope}/providers/microsoft.Security/complianceResults/{complianceResultName}
Change Type: added

## Swagger Changes

### Changes for `/{resourceId}/providers/microsoft.Security/complianceResults/{complianceResultName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceId}/providers/microsoft.Security/complianceResults/{complianceResultName}__deleted']` | deleted | `{"get":{"operationId":"ComplianceResults_Get","tags":["Compliance Results"],"description":"Security ...` |

### Changes for `/{scope}/providers/microsoft.Security/complianceResults/{complianceResultName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/complianceResults/{complianceResultName}__added']` | added | `{"get":{"operationId":"ComplianceResults_Get","tags":["ComplianceResults"],"description":"Security C...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/complianceResults'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/Scope` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/complianceResults'].get.parameters[0].name__added` | added | `scope` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/complianceResults'].get.parameters[0].in__added` | added | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/complianceResults'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/complianceResults'].get.parameters[0].type__added` | added | `string` |

### Changes for `x-ms-skip-url-encoding`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/complianceResults'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ComplianceResult.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `info.description` | `API spec for Microsoft.Security (Microsoft Defender for Cloud) resource provider` | `API spec for Microsoft.Security (Azure Security Center) resource provider` |
| `info.title` | `Microsoft Defender for Cloud` | `SecurityCenter` |
| `paths['/{scope}/providers/microsoft.Security/complianceResults'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

