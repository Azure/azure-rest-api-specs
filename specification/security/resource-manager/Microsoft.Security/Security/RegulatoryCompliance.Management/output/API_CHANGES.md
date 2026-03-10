## Swagger Changes

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/regulatoryComplianceStandards'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/ODataFilter` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/regulatoryComplianceStandards'].get.parameters[0].name__added` | added | `$filter` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/regulatoryComplianceStandards'].get.parameters[0].in__added` | added | `query` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/regulatoryComplianceStandards'].get.parameters[0].type__added` | added | `string` |

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

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RegulatoryComplianceAssessmentProperties.properties.failedResources.format__added` | added | `int32` |
| `definitions.RegulatoryComplianceAssessmentProperties.properties.passedResources.format__added` | added | `int32` |
| `definitions.RegulatoryComplianceAssessmentProperties.properties.skippedResources.format__added` | added | `int32` |
| `definitions.RegulatoryComplianceAssessmentProperties.properties.unsupportedResources.format__added` | added | `int32` |
| `definitions.RegulatoryComplianceControlProperties.properties.failedAssessments.format__added` | added | `int32` |
| `definitions.RegulatoryComplianceControlProperties.properties.passedAssessments.format__added` | added | `int32` |
| `definitions.RegulatoryComplianceControlProperties.properties.skippedAssessments.format__added` | added | `int32` |
| `definitions.RegulatoryComplianceStandardProperties.properties.failedControls.format__added` | added | `int32` |
| `definitions.RegulatoryComplianceStandardProperties.properties.passedControls.format__added` | added | `int32` |
| `definitions.RegulatoryComplianceStandardProperties.properties.skippedControls.format__added` | added | `int32` |
| `definitions.RegulatoryComplianceStandardProperties.properties.unsupportedControls.format__added` | added | `int32` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.RegulatoryComplianceAssessment.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.RegulatoryComplianceAssessmentProperties.properties.state.description` | `Aggregative state based on the assessment's scanned resources states` | `Aggregative state based on the standard's supported controls states` |
| `definitions.RegulatoryComplianceControl.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.RegulatoryComplianceControlProperties.properties.state.description` | `Aggregative state based on the control's supported assessments states` | `Aggregative state based on the standard's supported controls states` |
| `definitions.RegulatoryComplianceStandard.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/regulatoryComplianceStandards'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/regulatoryComplianceStandards/{regulatoryComplianceStandardName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/regulatoryComplianceStandards/{regulatoryComplianceStandardName}/regulatoryComplianceControls'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/regulatoryComplianceStandards/{regulatoryComplianceStandardName}/regulatoryComplianceControls/{regulatoryComplianceControlName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/regulatoryComplianceStandards/{regulatoryComplianceStandardName}/regulatoryComplianceControls/{regulatoryComplianceControlName}/regulatoryComplianceAssessments'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/regulatoryComplianceStandards/{regulatoryComplianceStandardName}/regulatoryComplianceControls/{regulatoryComplianceControlName}/regulatoryComplianceAssessments/{regulatoryComplianceAssessmentName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `#/definitions/CloudError` |

