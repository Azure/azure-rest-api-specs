## Changed Paths

Path: /{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}
Change Type: deleted

Path: /{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/malwareScans/{scanId}
Change Type: deleted

Path: /{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/malwareScans/{scanId}/cancelMalwareScan
Change Type: deleted

Path: /{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/startMalwareScan
Change Type: deleted

Path: /{scope}/providers/microsoft.Security/defenderForStorageSettings/{settingName}
Change Type: added

Path: /{scope}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/{scanId}/{scanId}
Change Type: added

Path: /{scope}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/{scanId}/cancelMalwareScan
Change Type: added

Path: /{scope}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/startMalwareScan
Change Type: added

## Swagger Changes

### Changes for `/{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}__deleted']` | deleted | `{"get":{"operationId":"DefenderForStorage_Get","tags":["DefenderForStorage"],"description":"Gets the...` |

### Changes for `/{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/malwareScans/{scanId}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/malwareScans/{scanId}__deleted']` | deleted | `{"get":{"operationId":"DefenderForStorage_GetMalwareScan","tags":["DefenderForStorage","Antimalware"...` |

### Changes for `/{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/malwareScans/{scanId}/cancelMalwareScan`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/malwareScans/{scanId}/cancelMalwareScan__deleted']` | deleted | `{"post":{"operationId":"DefenderForStorage_CancelMalwareScan","tags":["DefenderForStorage","Antimalw...` |

### Changes for `/{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/startMalwareScan`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceId}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/startMalwareScan__deleted']` | deleted | `{"post":{"operationId":"DefenderForStorage_StartMalwareScan","tags":["DefenderForStorage","Antimalwa...` |

### Changes for `/{scope}/providers/microsoft.Security/defenderForStorageSettings/{settingName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/defenderForStorageSettings/{settingName}__added']` | added | `{"get":{"operationId":"DefenderForStorage_Get","tags":["DefenderForStorageSettings"],"description":"...` |

### Changes for `/{scope}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/{scanId}/{scanId}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/{scanId}/{scanId}__added']` | added | `{"get":{"operationId":"DefenderForStorage_GetMalwareScan","tags":["DefenderForStorageSettings"],"des...` |

### Changes for `/{scope}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/{scanId}/cancelMalwareScan`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/{scanId}/cancelMalwareScan__added']` | added | `{"post":{"operationId":"DefenderForStorage_CancelMalwareScan","tags":["DefenderForStorageSettings"],...` |

### Changes for `/{scope}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/startMalwareScan`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/defenderForStorageSettings/{settingName}/startMalwareScan__added']` | added | `{"post":{"operationId":"DefenderForStorage_StartMalwareScan","tags":["DefenderForStorageSettings"],"...` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DefenderForStorageSetting.properties.properties.description__added` | added | `Defender for Storage resource properties.` |
| `definitions.DefenderForStorageSettingProperties.properties.malwareScanning.description__added` | added | `Properties of Malware Scanning.` |
| `definitions.DefenderForStorageSettingProperties.properties.sensitiveDataDiscovery.description__added` | added | `Properties of Sensitive Data Discovery.` |
| `definitions.MalwareScanningProperties.properties.onUpload.description__added` | added | `Properties of On Upload malware scanning.` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MalwareScanningProperties.properties.operationStatus.type__deleted` | deleted | `object` |
| `definitions.MalwareScanProperties.properties.scanSummary.type__deleted` | deleted | `object` |
| `definitions.ScanSummary.properties.blobs.type__deleted` | deleted | `object` |
| `definitions.SensitiveDataDiscoveryProperties.properties.operationStatus.type__deleted` | deleted | `object` |

### Changes for `x-nullable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnUploadFilters.properties.excludeBlobsLargerThan['x-nullable__deleted']` | deleted | `true` |
| `definitions.OnUploadFilters.properties.excludeBlobsWithPrefix['x-nullable__deleted']` | deleted | `true` |
| `definitions.OnUploadFilters.properties.excludeBlobsWithSuffix['x-nullable__deleted']` | deleted | `true` |
| `definitions.OnUploadProperties.properties.filters['x-nullable__deleted']` | deleted | `true` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnUploadFilters.properties.excludeBlobsLargerThan.format__deleted` | deleted | `int64` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.DefenderForStorageSetting.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `info.title` | `Security Center` | `SecurityCenter` |

