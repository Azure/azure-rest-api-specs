## Swagger Changes

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/healthReports'].get.parameters[0].$ref__deleted` | deleted | `../../../../../../common-types/resource-management/v5/types.json#/parameters/ScopeParameter` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/healthReports'].get.parameters[0].name__added` | added | `scope` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/healthReports'].get.parameters[0].in__added` | added | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HealthReportsList.required__added` | added | `["value"]` |
| `paths['/{scope}/providers/microsoft.Security/healthReports'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/healthReports'].get.parameters[0].type__added` | added | `string` |

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/healthReports'].get.parameters[0].minLength__added` | added | `1` |

### Changes for `x-ms-skip-url-encoding`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/healthReports'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |

### Changes for `environmentDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.environmentDetails__deleted` | deleted | `{"type":"object","description":"The environment details of the resource","properties":{"nativeResour...` |

### Changes for `healthDataClassification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.healthDataClassification__deleted` | deleted | `{"type":"object","description":"The classification of the health report","properties":{"component":{...` |

### Changes for `issue`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.issue__deleted` | deleted | `{"type":"object","description":"The issue that caused the resource to by unhealthy","properties":{"i...` |

### Changes for `EnvironmentDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EnvironmentDetails__added` | added | `{"type":"object","description":"The environment details of the resource","properties":{"nativeResour...` |

### Changes for `HealthDataClassification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HealthDataClassification__added` | added | `{"type":"object","description":"The classification of the health report","properties":{"component":{...` |

### Changes for `Issue`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Issue__added` | added | `{"type":"object","description":"The issue that caused the resource to by unhealthy","properties":{"i...` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HealthReportProperties.properties.affectedDefendersPlans.items.description__deleted` | deleted | `plan name` |
| `definitions.HealthReportProperties.properties.affectedDefendersSubPlans.items.description__deleted` | deleted | `sub plan name` |
| `definitions.HealthReportProperties.properties.environmentDetails.description__added` | added | `The environment details of the resource` |
| `definitions.HealthReportProperties.properties.healthDataClassification.description__added` | added | `The classification of the health report` |
| `definitions.HealthReportProperties.properties.resourceDetails.description__added` | added | `The resource details of the health report` |
| `definitions.HealthReportProperties.properties.status.description__added` | added | `The status of the health report` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HealthReportsList.properties.value.readOnly__deleted` | deleted | `true` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.HealthReport.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.HealthReportProperties.properties.environmentDetails.$ref` | `#/definitions/environmentDetails` | `#/definitions/EnvironmentDetails` |
| `definitions.HealthReportProperties.properties.healthDataClassification.$ref` | `#/definitions/healthDataClassification` | `#/definitions/HealthDataClassification` |
| `definitions.HealthReportProperties.properties.issues.items.$ref` | `#/definitions/issue` | `#/definitions/Issue` |
| `paths['/{resourceId}/providers/microsoft.Security/healthReports/{healthReportName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Security/healthReports'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |

