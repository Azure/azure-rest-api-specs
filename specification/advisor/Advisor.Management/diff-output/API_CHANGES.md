## Swagger Changes

### Changes for `x-typespec-generated`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-typespec-generated__added']` | added | `[{"emitter":"@azure-tools/typespec-autorest"}]` |

### Changes for `deprecated`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceUri}/providers/Microsoft.Advisor/recommendations/{recommendationId}'].get.deprecated__deleted` | deleted | `false` |
| `paths['/{resourceUri}/providers/Microsoft.Advisor/recommendations/{recommendationId}'].patch.deprecated__deleted` | deleted | `false` |
| `paths['/{resourceUri}/providers/Microsoft.Advisor/recommendations/{recommendationId}/suppressions/{name}'].delete.deprecated__deleted` | deleted | `false` |
| `paths['/{resourceUri}/providers/Microsoft.Advisor/recommendations/{recommendationId}/suppressions/{name}'].get.deprecated__deleted` | deleted | `false` |
| `paths['/{resourceUri}/providers/Microsoft.Advisor/recommendations/{recommendationId}/suppressions/{name}'].put.deprecated__deleted` | deleted | `false` |
| `paths['/providers/Microsoft.Advisor/operations'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/advisorScore'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/advisorScore/{name}'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/assessments'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/assessments/{assessmentName}'].delete.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/assessments/{assessmentName}'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/assessments/{assessmentName}'].put.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/assessmentTypes'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/configurations'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/configurations/{configurationName}'].put.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/generateRecommendations'].post.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/generateRecommendations/{operationId}'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/predict'].post.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/recommendations'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}/approve'].post.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}/providers/Microsoft.Advisor/triageResources'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}/providers/Microsoft.Advisor/triageResources/{recommendationResourceId}'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}/reject'].post.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}/reset'].post.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/suppressions'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/workloads'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Advisor/configurations'].get.deprecated__deleted` | deleted | `false` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Advisor/configurations/{configurationName}'].put.deprecated__deleted` | deleted | `false` |

### Changes for `x-ms-skip-url-encoding`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceUri}/providers/Microsoft.Advisor/recommendations/{recommendationId}'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{resourceUri}/providers/Microsoft.Advisor/recommendations/{recommendationId}'].patch.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{resourceUri}/providers/Microsoft.Advisor/recommendations/{recommendationId}/suppressions/{name}'].delete.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{resourceUri}/providers/Microsoft.Advisor/recommendations/{recommendationId}/suppressions/{name}'].get.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |
| `paths['/{resourceUri}/providers/Microsoft.Advisor/recommendations/{recommendationId}/suppressions/{name}'].put.parameters[0]['x-ms-skip-url-encoding__added']` | added | `true` |

### Changes for `advisorScoreEntity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.advisorScoreEntity__deleted` | deleted | `{"type":"object","properties":{"properties":{"type":"object","properties":{"lastRefreshedScore":{"$r...` |

### Changes for `recommendationRejectBody`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.recommendationRejectBody__deleted` | deleted | `{"type":"object","properties":{"reasonForRejection":{"type":"string","enum":["NotARisk","RiskAccepte...` |

### Changes for `resiliencyReview`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.resiliencyReview__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string","format":"arm-id","readOnly":true},"name":{"typ...` |

### Changes for `resiliencyReviewCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.resiliencyReviewCollection__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `resiliencyReviewProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.resiliencyReviewProperties__deleted` | deleted | `{"type":"object","properties":{"reviewName":{"type":"string","readOnly":true},"workloadName":{"type"...` |

### Changes for `scoreEntity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.scoreEntity__deleted` | deleted | `{"type":"object","properties":{"date":{"type":"string"},"score":{"type":"number"},"consumptionUnits"...` |

### Changes for `timeSeriesEntity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.timeSeriesEntity__deleted` | deleted | `{"type":"array","items":{"type":"object","properties":{"aggregationLevel":{"type":"string","descript...` |

### Changes for `triageRecommendation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.triageRecommendation__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string","format":"arm-id","readOnly":true},"name":{"typ...` |

### Changes for `triageRecommendationCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.triageRecommendationCollection__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `triageRecommendationProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.triageRecommendationProperties__deleted` | deleted | `{"type":"object","properties":{"reviewId":{"type":"string","readOnly":true},"title":{"type":"string"...` |

### Changes for `triageResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.triageResource__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/triageResourceProperties","x-ms-c...` |

### Changes for `triageResourceCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.triageResourceCollection__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `triageResourceProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.triageResourceProperties__deleted` | deleted | `{"type":"object","properties":{"reviewId":{"type":"string","readOnly":true},"recommendationId":{"typ...` |

### Changes for `AdvisorScoreEntity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdvisorScoreEntity__added` | added | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/AdvisorScoreEntityProperties","x-...` |

### Changes for `AdvisorScoreEntityProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdvisorScoreEntityProperties__added` | added | `{"type":"object","properties":{"lastRefreshedScore":{"$ref":"#/definitions/ScoreEntity"},"timeSeries...` |

### Changes for `Azure.Core.uuid`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.Core.uuid__added']` | added | `{"type":"string","format":"uuid"}` |

### Changes for `RecommendationPropertiesResourceWorkload`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RecommendationPropertiesResourceWorkload__added` | added | `{"type":"object","properties":{"id":{"type":"string"},"name":{"type":"string"}}}` |

### Changes for `RecommendationPropertiesReview`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RecommendationPropertiesReview__added` | added | `{"type":"object","properties":{"id":{"type":"string"},"name":{"type":"string"}}}` |

### Changes for `RecommendationRejectBody`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RecommendationRejectBody__added` | added | `{"type":"object","properties":{"reasonForRejection":{"type":"string","enum":["NotARisk","RiskAccepte...` |

### Changes for `ResiliencyReview`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResiliencyReview__added` | added | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ResiliencyReviewProperties","x-ms...` |

### Changes for `ResiliencyReviewCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResiliencyReviewCollection__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ResiliencyReviewProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResiliencyReviewProperties__added` | added | `{"type":"object","properties":{"reviewName":{"type":"string","readOnly":true},"workloadName":{"type"...` |

### Changes for `ScoreEntity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScoreEntity__added` | added | `{"type":"object","properties":{"date":{"type":"string"},"score":{"type":"number","format":"float"},"...` |

### Changes for `TimeSeriesEntity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TimeSeriesEntity__added` | added | `{"type":"object","properties":{"aggregationLevel":{"type":"string","enum":["week","day","month"],"x-...` |

### Changes for `TrackedRecommendationPropertiesPayloadProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TrackedRecommendationPropertiesPayloadProperties__added` | added | `{"type":"object","properties":{"trackedProperties":{"$ref":"#/definitions/TrackedRecommendationPrope...` |

### Changes for `TriageRecommendation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TriageRecommendation__added` | added | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/TriageRecommendationProperties","...` |

### Changes for `TriageRecommendationCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TriageRecommendationCollection__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `TriageRecommendationProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TriageRecommendationProperties__added` | added | `{"type":"object","properties":{"reviewId":{"type":"string","readOnly":true},"title":{"type":"string"...` |

### Changes for `TriageResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TriageResource__added` | added | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/TriageResourceProperties","x-ms-c...` |

### Changes for `TriageResourceCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TriageResourceCollection__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `TriageResourceProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TriageResourceProperties__added` | added | `{"type":"object","properties":{"reviewId":{"type":"string","readOnly":true},"recommendationId":{"typ...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssessmentListResult.required__added` | added | `["value"]` |
| `definitions.AssessmentTypeListResult.required__added` | added | `["value"]` |
| `definitions.ConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.MetadataEntityListResult.required__added` | added | `["value"]` |
| `definitions.OperationEntityListResult.required__added` | added | `["value"]` |
| `definitions.ResourceRecommendationBaseListResult.required__added` | added | `["value"]` |
| `definitions.SuppressionContractListResult.required__added` | added | `["value"]` |
| `definitions.WorkloadListResult.required__added` | added | `["value"]` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssessmentResult.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v4/types.json#/definitions/ProxyResource"}...` |
| `definitions.MetadataEntity.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v4/types.json#/definitions/ProxyResource"}...` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssessmentResult.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.MetadataEntity.properties.id__deleted` | deleted | `{"type":"string"}` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssessmentResult.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.MetadataEntity.properties.name__deleted` | deleted | `{"type":"string"}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssessmentResult.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.DigestConfig.properties.categories.items.type__deleted` | deleted | `string` |
| `definitions.MetadataEntity.properties.type__deleted` | deleted | `{"type":"string"}` |
| `definitions.MetadataEntityProperties.properties.applicableScenarios.items.type__deleted` | deleted | `string` |
| `definitions.RecommendationProperties.properties.actions.items.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.RecommendationProperties.properties.exposedMetadataProperties.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.RecommendationProperties.properties.metadata.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.RecommendationProperties.properties.remediation.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.RecommendationProperties.properties.resourceWorkload.type__deleted` | deleted | `object` |
| `definitions.RecommendationProperties.properties.review.type__deleted` | deleted | `object` |
| `definitions.RecommendationProperties.properties.suppressionIds.items.type__deleted` | deleted | `string` |
| `definitions.ResourceMetadata.properties.action.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.TrackedRecommendationPropertiesPayload.properties.properties.type__deleted` | deleted | `object` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AssessmentResult.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v4/types.json#/definitions/systemData","rea...` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DigestConfig.properties.categories.items.enum__deleted` | deleted | `["HighAvailability","Security","Performance","Cost","OperationalExcellence"]` |
| `definitions.MetadataEntityProperties.properties.applicableScenarios.items.enum__deleted` | deleted | `["Alerts"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DigestConfig.properties.categories.items['x-ms-enum__deleted']` | deleted | `{"name":"Category","modelAsString":true}` |
| `definitions.MetadataEntityProperties.properties.applicableScenarios.items['x-ms-enum__deleted']` | deleted | `{"name":"Scenario","modelAsString":true}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DigestConfig.properties.categories.items.$ref__added` | added | `#/definitions/Category` |
| `definitions.MetadataEntityProperties.properties.applicableScenarios.items.$ref__added` | added | `#/definitions/Scenario` |
| `definitions.RecommendationProperties.properties.resourceWorkload.$ref__added` | added | `#/definitions/RecommendationPropertiesResourceWorkload` |
| `definitions.RecommendationProperties.properties.review.$ref__added` | added | `#/definitions/RecommendationPropertiesReview` |
| `definitions.RecommendationProperties.properties.suppressionIds.items.$ref__added` | added | `#/definitions/Azure.Core.uuid` |
| `definitions.TrackedRecommendationPropertiesPayload.properties.properties.$ref__added` | added | `#/definitions/TrackedRecommendationPropertiesPayloadProperties` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PredictionRequestProperties.properties.extendedProperties.additionalProperties__added` | added | `{}` |
| `definitions.PredictionResponseProperties.properties.extendedProperties.additionalProperties__added` | added | `{}` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RecommendationProperties.properties.suppressionIds.items.format__deleted` | deleted | `uuid` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RecommendationProperties.properties.resourceWorkload.properties__deleted` | deleted | `{"id":{"type":"string","description":"The Id of the Workload"},"name":{"type":"string","description"...` |
| `definitions.RecommendationProperties.properties.review.properties__deleted` | deleted | `{"id":{"type":"string","description":"The ARM Resource Id of the Review"},"name":{"type":"string","d...` |
| `definitions.TrackedRecommendationPropertiesPayload.properties.properties.properties__deleted` | deleted | `{"trackedProperties":{"$ref":"#/definitions/TrackedRecommendationProperties"}}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AdvisorScoreResponse.properties.value.items.$ref` | `#/definitions/advisorScoreEntity` | `#/definitions/AdvisorScoreEntity` |
| `definitions.ResourceRecommendationBase.allOf[0].$ref` | `../../../../../common-types/resource-management/v4/types.json#/definitions/Resource` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ProxyResource` |
| `definitions.SuppressionContract.allOf[0].$ref` | `../../../../../common-types/resource-management/v4/types.json#/definitions/Resource` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ProxyResource` |
| `info.description` | `REST APIs for Azure Advisor Resiliency Reviews.` | `REST APIs for Azure Advisor` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/advisorScore/{name}'].get.responses.200.schema.$ref` | `#/definitions/advisorScoreEntity` | `#/definitions/AdvisorScoreEntity` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/assessments'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/assessments/{assessmentName}'].delete.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/assessments/{assessmentName}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/assessments/{assessmentName}'].put.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/assessmentTypes'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/configurations'].get['x-ms-examples'].GetConfigurations.$ref` | `./examples/ListConfigurations.json` | `./examples/ListConfigurations_ListBySubscription.json` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/configurations/{configurationName}'].put['x-ms-examples'].PutConfigurations.$ref` | `./examples/CreateConfiguration.json` | `./examples/CreateConfiguration_CreateInSubscription.json` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews'].get.responses.200.schema.$ref` | `#/definitions/resiliencyReviewCollection` | `#/definitions/ResiliencyReviewCollection` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}'].get.responses.200.schema.$ref` | `#/definitions/resiliencyReview` | `#/definitions/ResiliencyReview` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations'].get.responses.200.schema.$ref` | `#/definitions/triageRecommendationCollection` | `#/definitions/TriageRecommendationCollection` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}'].get.responses.200.schema.$ref` | `#/definitions/triageRecommendation` | `#/definitions/TriageRecommendation` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}/approve'].post.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}/providers/Microsoft.Advisor/triageResources'].get.responses.200.schema.$ref` | `#/definitions/triageResourceCollection` | `#/definitions/TriageResourceCollection` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}/providers/Microsoft.Advisor/triageResources'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}/providers/Microsoft.Advisor/triageResources/{recommendationResourceId}'].get.responses.200.schema.$ref` | `#/definitions/triageResource` | `#/definitions/TriageResource` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}/providers/Microsoft.Advisor/triageResources/{recommendationResourceId}'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}/reject'].post.parameters[2].schema.$ref` | `#/definitions/recommendationRejectBody` | `#/definitions/RecommendationRejectBody` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}/reject'].post.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}/reset'].post.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/workloads'].get.responses.default.schema.$ref` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v4/types.json#/definitions/ErrorResponse` |

