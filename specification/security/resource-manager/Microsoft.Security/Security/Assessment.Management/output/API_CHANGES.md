## Changed Paths

Path: /{resourceId}/providers/microsoft.Security/assessments/{assessmentName}
Change Type: deleted

Path: /{scope}/providers/microsoft.Security/assessments/{assessmentName}
Change Type: added

## Swagger Changes

### Changes for `/{resourceId}/providers/microsoft.Security/assessments/{assessmentName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceId}/providers/microsoft.Security/assessments/{assessmentName}__deleted']` | deleted | `{"get":{"operationId":"Assessments_Get","tags":["Assessments"],"description":"Get a security assessm...` |

### Changes for `/{scope}/providers/microsoft.Security/assessments/{assessmentName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/assessments/{assessmentName}__added']` | added | `{"get":{"operationId":"Assessments_Get","tags":["SecurityAssessmentResponses"],"description":"Get a ...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityAssessmentMetadataPropertiesResponse.properties.publishDates.$ref__added` | added | `#/definitions/SecurityAssessmentMetadataPropertiesResponsePublishDates` |
| `definitions.SecurityAssessmentPropertiesBase.properties.risk.$ref__added` | added | `#/definitions/SecurityAssessmentPropertiesBaseRisk` |
| `paths['/{scope}/providers/microsoft.Security/assessments'].get.parameters[0].$ref__deleted` | deleted | `./common/v1/types.json#/parameters/Scope` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/assessments'].get.parameters[0].name__added` | added | `scope` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/assessments'].get.parameters[0].in__added` | added | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityAssessmentList.required__added` | added | `["value"]` |
| `definitions.SecurityAssessmentMetadataPropertiesResponse.properties.publishDates.required__deleted` | deleted | `["public"]` |
| `definitions.SecurityAssessmentMetadataResponseList.required__added` | added | `["value"]` |
| `paths['/{scope}/providers/microsoft.Security/assessments'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityAssessmentMetadataPropertiesResponse.properties.publishDates.type__deleted` | deleted | `object` |
| `definitions.SecurityAssessmentPropertiesBase.properties.risk.type__deleted` | deleted | `object` |
| `paths['/{scope}/providers/microsoft.Security/assessments'].get.parameters[0].type__added` | added | `string` |

### Changes for `x-ms-skip-url-encoding`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{scope}/providers/microsoft.Security/assessments'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |

### Changes for `EdgeIdentifiers`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EdgeIdentifiers__deleted` | deleted | `{"type":"object","description":"Represents an edge in the path","properties":{"source":{"type":"stri...` |

### Changes for `NodeIdentifier`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NodeIdentifier__deleted` | deleted | `{"type":"object","description":"Represents a node in the path","properties":{"id":{"type":"string","...` |

### Changes for `Path`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Path__deleted` | deleted | `{"type":"object","description":"Represents a path that composes the risk","properties":{"id":{"type"...` |

### Changes for `attackPathsReferences`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.attackPathsReferences__deleted` | deleted | `{"type":"array","description":"The attack paths references of the risk","items":{"type":"string"}}` |

### Changes for `isContextualRisk`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.isContextualRisk__deleted` | deleted | `{"type":"boolean","description":"Indicates if the risk is contextual or static"}` |

### Changes for `level`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.level__deleted` | deleted | `{"$ref":"#/definitions/RiskLevel","description":"The risk level"}` |

### Changes for `paths`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.paths__deleted` | deleted | `{"type":"array","description":"The paths that compose the risk","items":{"$ref":"#/definitions/Path"...` |

### Changes for `riskFactors`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.riskFactors__deleted` | deleted | `{"type":"array","description":"The factors of the risk adding base factor","items":{"type":"string"}...` |

### Changes for `AzureResourceDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureResourceDetails__added` | added | `{"type":"object","description":"Details of the Azure resource that was assessed","properties":{"id":...` |

### Changes for `Components1Uu4J47SchemasSecurityassessmentpropertiesbasePropertiesRiskPropertiesPathsItemsPropertiesEdgesItems`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Components1Uu4J47SchemasSecurityassessmentpropertiesbasePropertiesRiskPropertiesPathsItemsPropertiesEdgesItems__added` | added | `{"type":"object","properties":{"id":{"type":"string","description":"Edge identifier"},"targetId":{"t...` |

### Changes for `OnPremiseResourceDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnPremiseResourceDetails__added` | added | `{"type":"object","description":"Details of the On Premise resource that was assessed","properties":{...` |

### Changes for `OnPremiseSqlResourceDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OnPremiseSqlResourceDetails__added` | added | `{"type":"object","description":"Details of the On Premise Sql resource that was assessed","propertie...` |

### Changes for `Resource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Resource__added` | added | `{"type":"object","description":"Describes an Azure resource.","properties":{"id":{"type":"string","d...` |

### Changes for `ResourceDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResourceDetails__added` | added | `{"type":"object","description":"Details of the resource that was assessed","properties":{"source":{"...` |

### Changes for `SecurityAssessmentMetadataPropertiesResponsePublishDates`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityAssessmentMetadataPropertiesResponsePublishDates__added` | added | `{"type":"object","properties":{"GA":{"type":"string","pattern":"^([0-9]{2}/){2}[0-9]{4}$"},"public":...` |

### Changes for `SecurityAssessmentPropertiesBaseRisk`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityAssessmentPropertiesBaseRisk__added` | added | `{"type":"object","description":"External model of risk result","properties":{"riskFactors":{"type":"...` |

### Changes for `SecurityAssessmentPropertiesBaseRiskPathsItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityAssessmentPropertiesBaseRiskPathsItem__added` | added | `{"type":"object","properties":{"id":{"type":"string","description":"Unique identifier for the path"}...` |

### Changes for `SecurityAssessmentPropertiesBaseRiskPathsPropertiesItemsItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityAssessmentPropertiesBaseRiskPathsPropertiesItemsItem__added` | added | `{"type":"object","properties":{"id":{"type":"string","description":"Node identifier"},"nodePropertie...` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssessmentLinks.readOnly__deleted` | deleted | `true` |
| `definitions.SecurityAssessmentList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.SecurityAssessmentMetadataResponseList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.SecurityAssessmentPropertiesBase.properties.links.readOnly__added` | added | `true` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityAssessment.properties.properties.description__added` | added | `Describes properties of an assessment.` |
| `definitions.SecurityAssessmentMetadata.properties.properties.description__added` | added | `Describes properties of an assessment metadata.` |
| `definitions.SecurityAssessmentMetadataProperties.properties.partnerData.description__added` | added | `Describes the partner that created the assessment` |
| `definitions.SecurityAssessmentMetadataResponse.properties.properties.description__added` | added | `Describes properties of an assessment metadata response.` |
| `definitions.SecurityAssessmentProperties.properties.status.description__added` | added | `The result of the assessment` |
| `definitions.SecurityAssessmentPropertiesBase.properties.links.description__added` | added | `Links relevant to the assessment` |
| `definitions.SecurityAssessmentPropertiesBase.properties.metadata.description__added` | added | `Describes properties of an assessment metadata.` |
| `definitions.SecurityAssessmentPropertiesBase.properties.partnersData.description__added` | added | `Data regarding 3rd party partner integration` |
| `definitions.SecurityAssessmentPropertiesBase.properties.resourceDetails.description__added` | added | `Details of the resource that was assessed` |
| `definitions.SecurityAssessmentPropertiesResponse.properties.status.description__added` | added | `The result of the assessment` |
| `definitions.SecurityAssessmentResponse.properties.properties.description__added` | added | `Describes properties of an assessment.` |

### Changes for `x-ms-secret`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityAssessmentMetadataPartnerData.properties.secret['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.SecurityAssessmentPartnerData.properties.secret['x-ms-secret__deleted']` | deleted | `true` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityAssessmentMetadataPropertiesResponse.properties.publishDates.properties__deleted` | deleted | `{"GA":{"type":"string","pattern":"^([0-9]{2}/){2}[0-9]{4}$"},"public":{"type":"string","pattern":"^(...` |
| `definitions.SecurityAssessmentPropertiesBase.properties.risk.properties__deleted` | deleted | `{"riskFactors":{"type":"array","description":"The factors of the risk adding base factor","uniqueIte...` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.SecurityAssessment.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `#/definitions/Resource` |
| `definitions.SecurityAssessmentMetadata.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `#/definitions/Resource` |
| `definitions.SecurityAssessmentMetadataResponse.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.SecurityAssessmentPropertiesBase.properties.metadata.$ref` | `./assessmentMetadata.json#/definitions/SecurityAssessmentMetadataProperties` | `#/definitions/SecurityAssessmentMetadataProperties` |
| `definitions.SecurityAssessmentPropertiesBase.properties.resourceDetails.$ref` | `./common/v1/types.json#/definitions/ResourceDetails` | `#/definitions/ResourceDetails` |
| `definitions.SecurityAssessmentResponse.allOf[0].$ref` | `./common/v1/types.json#/definitions/Resource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `info.description` | `API spec for Microsoft.Security (Microsoft Defender for Cloud) resource provider` | `API spec for Microsoft.Security (Azure Security Center) resource provider` |
| `info.title` | `Microsoft Defender for Cloud` | `SecurityCenter` |
| `paths['/{scope}/providers/microsoft.Security/assessments'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Security/assessmentMetadata'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Security/assessmentMetadata/{assessmentMetadataName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/assessmentMetadata'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/assessmentMetadata/{assessmentMetadataName}'].delete.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/assessmentMetadata/{assessmentMetadataName}'].get.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Security/assessmentMetadata/{assessmentMetadataName}'].put.responses.default.schema.$ref` | `./common/v1/types.json#/definitions/CloudError` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

