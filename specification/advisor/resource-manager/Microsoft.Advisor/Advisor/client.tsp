import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Advisor;

@@clientName(ResourceRecommendationBases.patch::parameters.properties,
  "trackedProperties"
);
@@clientName(SuppressionContracts.create::parameters.resource,
  "suppressionContract"
);
@@clientName(AssessmentResults.put::parameters.resource, "assessmentContract");
@@clientName(TriageRecommendations.rejectTriageRecommendation::parameters.body,
  "recommendationRejectBody"
);
@@clientName(AdvisorScoreEntity, "ScoreEntityForAdvisor", "go");
@@clientName(Microsoft.Advisor, "AdvisorManagementClient", "javascript,python");
@@clientName(Microsoft.Advisor.CpuThreshold.`5`,
  "Five",
  "javascript,go,csharp"
);
@@clientName(Microsoft.Advisor.CpuThreshold.`10`,
  "Ten",
  "javascript,go,csharp"
);
@@clientName(Microsoft.Advisor.CpuThreshold.`15`,
  "Fifteen",
  "javascript,go,csharp"
);
@@clientName(Microsoft.Advisor.CpuThreshold.`20`,
  "Twenty",
  "javascript,go,csharp"
);
@@clientName(Microsoft.Advisor.CpuThreshold.`5`, "FIVE", "python");
@@clientName(Microsoft.Advisor.CpuThreshold.`10`, "TEN", "python");
@@clientName(Microsoft.Advisor.CpuThreshold.`15`, "FIFTEEN", "python");
@@clientName(Microsoft.Advisor.CpuThreshold.`20`, "TWENTY", "python");

@@scope(ResourceRecommendationBases.list, "!csharp");
@@scope(Operations.list, "!csharp");
@@clientName(PredictionResponse, "AdvisorPredictionResult", "csharp");
@@clientName(PredictionResponseProperties,
  "AdvisorPredictionResultProperties",
  "csharp"
);
@@clientName(TriageResource, "AdvisorTriageResourceData", "csharp");
@@clientName(TriageResourceCollection, "AdvisorTriageListResult", "csharp");
@@clientName(AssessmentResult, "AdvisorAssessment", "csharp");
@@clientName(AssessmentResultProperties,
  "AdvisorAssessmentProperties",
  "csharp"
);
@@clientName(ResiliencyReview, "AdvisorResiliencyReview", "csharp");
@@clientName(ResiliencyReviewProperties,
  "AdvisorResiliencyReviewProperties",
  "csharp"
);
@@clientName(ResiliencyReviewCollection,
  "AdvisorResiliencyReviewListResult",
  "csharp"
);
@@clientName(Control, "RecommendationControlType", "csharp");
@@clientName(Duration, "AdvisorLowCpuEvaluationDuration", "csharp");
@@clientName(OperationEntity, "AdvisorOperationEntity", "csharp");
@@clientName(OperationDisplayInfo, "AdvisorOperationDisplayInfo", "csharp");
@@clientName(Category, "RecommendationCategory", "csharp");
@@clientName(Impact, "RecommendationBusinessImpact", "csharp");
@@clientName(PredictionResponseProperties.lastUpdated,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(Priority, "RecommendationPriority", "csharp");
@@clientName(PriorityName, "RecommendationPriorityName", "csharp");
@@clientName(Reason, "RecommendationStateChangeReason", "csharp");
@@clientName(RecommendationPropertiesResourceWorkload,
  "RecommendationResourceWorkload",
  "csharp"
);
@@clientName(RecommendationPropertiesReview, "RecommendationReview", "csharp");
@@clientName(Aggregated, "ScoreAggregationLevel", "csharp");
@@clientName(ReviewStatus, "ResiliencyReviewStatus", "csharp");
@@clientName(ScoreEntity, "AdvisorScoreEntityContent", "csharp");
@@clientName(State, "RecommendationState", "csharp");
@@clientName(WorkloadResult, "AdvisorWorkload", "csharp");
@@clientName(AssessmentTypeResult, "AdvisorAssessmentType", "csharp");
@@clientName(TimeSeriesEntity, "AdvisorTimeSeriesEntity", "csharp");
@@clientName(PredictionType, "AdvisorPredictionType", "csharp");
@@clientName(ReasonForRejectionName, "AdvisorReasonForRejectionName", "csharp");
@@clientName(PredictionRequest, "AdvisorPredictionContent", "csharp");
@@clientName(PredictionRequestProperties,
  "AdvisorPredictionContentProperties",
  "csharp"
);
@@clientName(TriageResourceProperties.resourceType,
  "TriageResourceType",
  "csharp"
);
@@clientName(ResiliencyReviewProperties.publishedAt, "PublishedOn", "csharp");
@@clientName(ResiliencyReviewProperties.updatedAt, "UpdatedOn", "csharp");
@@alternateType(ResiliencyReviewProperties.publishedAt, utcDateTime, "csharp");
@@alternateType(ResiliencyReviewProperties.updatedAt, utcDateTime, "csharp");
@@clientName(ConfigurationsOperationGroup, "Configurations", "csharp");
@@clientName(RecommendationsOperationGroup.generate,
  "GenerateRecommendation",
  "csharp"
);
@@clientName(RecommendationsOperationGroup.getGenerateStatus,
  "GetGenerateStatusRecommendation",
  "csharp"
);
@@clientName(predict, "AdvisorPredict", "csharp");
@@clientName(AssessmentTypesOperationGroup.list,
  "GetAdvisorAssessmentTypes",
  "csharp"
);
@@clientName(WorkloadsOperationGroup.list, "GetAdvisorWorkloads", "csharp");
@@alternateType(RecommendationsOperationGroup.getGenerateStatus::parameters.operationId,
  Azure.Core.uuid,
  "csharp"
);
@@clientName(TriageResource, "AdvisorTriage", "csharp");
@@clientName(TriageResourceProperties, "AdvisorTriageProperties", "csharp");
@@clientName(MetadataEntity, "AdvisorMetadataEntity", "csharp");
@@clientName(MetadataEntityProperties,
  "AdvisorMetadataEntityProperties",
  "csharp"
);
@@clientName(ResourceRecommendationBase, "AdvisorRecommendation", "csharp");
@@clientName(RecommendationProperties,
  "AdvisorRecommendationProperties",
  "csharp"
);
@@clientName(RecommendationProperties.tracked, "IsTracked", "csharp");
@@clientName(RecommendationProperties.lastUpdated, "LastUpdatedOn", "csharp");
@@clientName(SuppressionContract, "AdvisorSuppressionContract", "csharp");
@@clientName(SuppressionProperties, "AdvisorSuppressionProperties", "csharp");
@@clientName(SuppressionProperties.expirationTimeStamp, "ExpireOn", "csharp");
@@clientName(TriageRecommendation, "AdvisorTriageRecommendation", "csharp");
@@clientName(TriageRecommendationProperties,
  "AdvisorTriageRecommendationProperties",
  "csharp"
);
@@clientName(TriageRecommendationProperties.updatedAt, "UpdatedOn", "csharp");
@@alternateType(TriageRecommendationProperties.updatedAt,
  utcDateTime,
  "csharp"
);
@@clientName(TrackedRecommendationPropertiesPayload,
  "AdvisorRecommendationPatch",
  "csharp"
);
@@clientName(TrackedRecommendationPropertiesPayloadProperties,
  "AdvisorRecommendationPatchProperties",
  "csharp"
);
@@clientName(AdvisorScoreResponse, "AdvisorScoreResult", "csharp");
@@clientName(ConfigData, "AdvisorConfigurationData", "csharp");
@@clientName(ConfigDataProperties, "AdvisorConfigurationProperties", "csharp");
@@clientName(ConfigDataProperties.exclude, "IsExcluded", "csharp");
@@clientName(ConfigurationListResult,
  "AdvisorConfigurationListResult",
  "csharp"
);
@@clientName(DigestConfig, "AdvisorDigestConfiguration", "csharp");
@@clientName(CpuThreshold, "AdvisorCpuThreshold", "csharp");
@@clientName(DigestConfigState, "AdvisorDigestConfigurationState", "csharp");
@@clientName(RecommendationRejectBody, "RecommendationRejectContent", "csharp");
@@clientName(ReasonForRejectionName, "RejectingRecommendationReason", "csharp");
@@clientName(ResourceMetadata, "RecommendationResourceMetadata", "csharp");
@@alternateType(ResourceMetadata.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(Risk, "RecommendationRisk", "csharp");
@@clientName(Scenario, "MetadataScenarioType", "csharp");
@@clientName(ShortDescription, "RecommendationShortDescription", "csharp");
@@clientName(TrackedRecommendationProperties.postponedTime,
  "PostponedUntil",
  "csharp"
);
@@clientName(TriageRecommendationCollection,
  "AdvisorTriageRecommendationListResult",
  "csharp"
);
@@clientName(ConfigurationName, "AdvisorConfigurationName", "csharp");

@@clientName(ConfigurationsOperationGroup.listBySubscription,
  "GetAdvisorConfigurationsBySubscription",
  "csharp"
);
@@clientName(ConfigurationsOperationGroup.listByResourceGroup,
  "GetAdvisorConfigurationsByResourceGroup",
  "csharp"
);
@@clientName(ConfigurationsOperationGroup.createInSubscription,
  "CreateAdvisorConfigurationInSubscription",
  "csharp"
);
@@clientName(ConfigurationsOperationGroup.createInResourceGroup,
  "CreateAdvisorConfigurationInResourceGroup",
  "csharp"
);
@@clientName(SuppressionsOperationGroup.list,
  "GetAdvisorSuppressionContracts",
  "csharp"
);
