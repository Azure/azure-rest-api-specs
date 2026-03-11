## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/subAssessments'].get.tags__deleted` | deleted | `["SubAssessments"]` |

### Changes for `x-ms-pageable`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/subAssessments'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/subAssessments'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/Scope` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/subAssessments'].get.parameters[0].name__added` | added | `scope` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/subAssessments'].get.parameters[0].in__added` | added | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecuritySubAssessmentList.required__added` | added | `["value"]` |
| `paths['/{scope}/providers/microsoft.Security/subAssessments'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/subAssessments'].get.parameters[0].type__added` | added | `string` |

### Changes for `x-ms-skip-url-encoding`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/subAssessments'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |

### Changes for `CVSS`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CVSS__deleted` | deleted | `{"type":"object","description":"CVSS details","properties":{"base":{"type":"number","description":"C...` |

### Changes for `AzureResourceDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureResourceDetails__added` | added | `{"type":"object","description":"Details of the Azure resource that was assessed","properties":{"id":...` |

### Changes for `Cvss`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Cvss__added` | added | `{"type":"object","description":"CVSS details","properties":{"base":{"type":"number","format":"float"...` |

### Changes for `OnPremiseResourceDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnPremiseResourceDetails__added` | added | `{"type":"object","description":"Details of the On Premise resource that was assessed","properties":{...` |

### Changes for `OnPremiseSqlResourceDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnPremiseSqlResourceDetails__added` | added | `{"type":"object","description":"Details of the On Premise Sql resource that was assessed","propertie...` |

### Changes for `ResourceDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResourceDetails__added` | added | `{"type":"object","description":"Details of the resource that was assessed","properties":{"source":{"...` |

### Changes for `SecuritySubAssessmentListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecuritySubAssessmentListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecuritySubAssessment.properties.properties.description__added` | added | `Describes properties of an sub-assessment.` |
| `definitions.SecuritySubAssessmentProperties.properties.additionalData.description__added` | added | `Details of the sub-assessment` |
| `definitions.SecuritySubAssessmentProperties.properties.resourceDetails.description__added` | added | `Details of the resource that was assessed` |
| `definitions.SecuritySubAssessmentProperties.properties.status.description__added` | added | `Status of the sub-assessment` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecuritySubAssessmentList.properties.value.readOnly__deleted` | deleted | `true` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ContainerRegistryVulnerabilityProperties.properties.cvss.additionalProperties.$ref` | `#/definitions/CVSS` | `#/definitions/Cvss` |
| `definitions.SecuritySubAssessment.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.SecuritySubAssessmentProperties.properties.resourceDetails.$ref` | `./common/v1/types.json#/definitions/ResourceDetails` | `#/definitions/ResourceDetails` |
| `definitions.ServerVulnerabilityProperties.properties.cvss.additionalProperties.$ref` | `#/definitions/CVSS` | `#/definitions/Cvss` |
| `paths['/{scope}/providers/microsoft.Security/assessments/{assessmentName}/subAssessments'].get.responses.200.schema.$ref` | `#/definitions/SecuritySubAssessmentList` | `#/definitions/SecuritySubAssessmentListResult` |
| `paths['/{scope}/providers/microsoft.Security/assessments/{assessmentName}/subAssessments'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Security/assessments/{assessmentName}/subAssessments/{subAssessmentName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Security/subAssessments'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

