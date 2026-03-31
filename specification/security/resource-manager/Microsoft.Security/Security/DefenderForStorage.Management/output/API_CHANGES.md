## Swagger Changes

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceId}/providers/microsoft.Security/defenderForStorageSettings'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/ResourceId` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceId}/providers/microsoft.Security/defenderForStorageSettings'].get.parameters[0].name__added` | added | `resourceId` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceId}/providers/microsoft.Security/defenderForStorageSettings'].get.parameters[0].in__added` | added | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DefenderForStorageSettingList.required__added` | added | `["value"]` |
| `paths['/{resourceId}/providers/microsoft.Security/defenderForStorageSettings'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MalwareScanningProperties.properties.operationStatus.type__deleted` | deleted | `object` |
| `definitions.MalwareScanProperties.properties.scanSummary.type__deleted` | deleted | `object` |
| `definitions.ScanSummary.properties.blobs.type__deleted` | deleted | `object` |
| `definitions.ScanSummary.properties.files.type__deleted` | deleted | `object` |
| `definitions.SensitiveDataDiscoveryProperties.properties.operationStatus.type__deleted` | deleted | `object` |
| `paths['/{resourceId}/providers/microsoft.Security/defenderForStorageSettings'].get.parameters[0].type__added` | added | `string` |

### Changes for `x-ms-skip-url-encoding`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceId}/providers/microsoft.Security/defenderForStorageSettings'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |

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
| `definitions.DefenderForStorageSetting.properties.properties.description__added` | added | `Defender for Storage resource properties.` |
| `definitions.DefenderForStorageSettingProperties.properties.malwareScanning.description__added` | added | `Properties of Malware Scanning.` |
| `definitions.DefenderForStorageSettingProperties.properties.sensitiveDataDiscovery.description__added` | added | `Properties of Sensitive Data Discovery.` |
| `definitions.MalwareScanningProperties.properties.onUpload.description__added` | added | `Properties of On Upload malware scanning.` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DefenderForStorageSettingList.properties.value.readOnly__deleted` | deleted | `true` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnUploadFilters.properties.excludeBlobsLargerThan.format__deleted` | deleted | `int64` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.DefenderForStorageSetting.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `paths['/{resourceId}/providers/microsoft.Security/defenderForStorageSettings'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/malwareScans/{scanId}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/malwareScans/{scanId}/cancelMalwareScan'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/startMalwareScan'].post.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

