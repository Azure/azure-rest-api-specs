## Swagger Changes

### Changes for `x-ms-skip-url-encoding`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/customRecommendations'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/customRecommendations/{customRecommendationName}'].delete.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/customRecommendations/{customRecommendationName}'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/customRecommendations/{customRecommendationName}'].put.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/securityStandards'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/securityStandards/{standardId}'].delete.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/securityStandards/{standardId}'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/securityStandards/{standardId}'].put.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{scope}/providers/microsoft.Security/standardAssignments'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |

### Changes for `StandardAssignmentPropertiesAttestationData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StandardAssignmentPropertiesAttestationData__added` | added | `{"type":"object","description":"Additional data about assignment that has Attest effect","properties...` |

### Changes for `StandardAssignmentPropertiesExemptionData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StandardAssignmentPropertiesExemptionData__added` | added | `{"type":"object","description":"Additional data about assignment that has Exempt effect","properties...` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CustomRecommendation.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v6/types.json#/definitions/systemData","...` |

### Changes for `x-ms-client-default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CustomRecommendationProperties.properties.securityIssue['x-ms-client-default__deleted']` | deleted | `BestPractices` |
| `definitions.CustomRecommendationProperties.properties.severity['x-ms-client-default__deleted']` | deleted | `Low` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StandardAssignmentProperties.properties.excludedScopes.items.description__deleted` | deleted | `The excluded scope` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StandardAssignmentProperties.properties.attestationData.type__deleted` | deleted | `object` |
| `definitions.StandardAssignmentProperties.properties.exemptionData.type__deleted` | deleted | `object` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StandardAssignmentProperties.properties.attestationData.properties__deleted` | deleted | `{"complianceState":{"type":"string","description":"Attest category of this assignment","enum":["unkn...` |
| `definitions.StandardAssignmentProperties.properties.exemptionData.properties__deleted` | deleted | `{"exemptionCategory":{"type":"string","description":"Exemption category of this assignment","enum":[...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StandardAssignmentProperties.properties.attestationData.$ref__added` | added | `#/definitions/StandardAssignmentPropertiesAttestationData` |
| `definitions.StandardAssignmentProperties.properties.exemptionData.$ref__added` | added | `#/definitions/StandardAssignmentPropertiesExemptionData` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.CustomRecommendation.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.SecurityStandard.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.StandardAssignment.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `paths['/{resourceId}/providers/microsoft.Security/standardAssignments/{standardAssignmentName}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/{resourceId}/providers/microsoft.Security/standardAssignments/{standardAssignmentName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/{resourceId}/providers/microsoft.Security/standardAssignments/{standardAssignmentName}'].put.description` | ` This operation creates or updates a standard assignment with the given scope and name. standard assignments apply to all resources contained within their scope. For example, when you assign a policy at resource group scope, that policy applies to all resources in the group.` | `This operation creates or updates a standard assignment with the given scope and name. standard assignments apply to all resources contained within their scope. For example, when you assign a policy at resource group scope, that policy applies to all resources in the group.` |
| `paths['/{resourceId}/providers/microsoft.Security/standardAssignments/{standardAssignmentName}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Security/customRecommendations'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Security/customRecommendations/{customRecommendationName}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Security/customRecommendations/{customRecommendationName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Security/customRecommendations/{customRecommendationName}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Security/securityStandards'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Security/securityStandards/{standardId}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Security/securityStandards/{standardId}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Security/securityStandards/{standardId}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/{scope}/providers/microsoft.Security/standardAssignments'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |

