## Swagger Changes

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

### Changes for `AzureResourceDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureResourceDetails__added` | added | `{"type":"object","description":"Details of the Azure resource that was assessed","properties":{"id":...` |

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

### Changes for `ResourceDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResourceDetails__added` | added | `{"type":"object","description":"Details of the resource that was assessed","properties":{"source":{"...` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CVSS.properties.base.format__added` | added | `float` |

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
| `definitions.SecuritySubAssessment.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.SecuritySubAssessmentProperties.properties.resourceDetails.$ref` | `./common/v1/types.json#/definitions/ResourceDetails` | `#/definitions/ResourceDetails` |
| `paths['/{scope}/providers/microsoft.Security/assessments/{assessmentName}/subAssessments'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{scope}/providers/microsoft.Security/assessments/{assessmentName}/subAssessments/{subAssessmentName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/{scope}/providers/microsoft.Security/subAssessments'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

