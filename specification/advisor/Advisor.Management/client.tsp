import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Advisor;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConfigData.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PredictionRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PredictionResponse.properties);

@@clientName(ResourceRecommendationBases.patch::parameters.properties,
  "trackedProperties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ResourceRecommendationBase.properties);

@@clientName(SuppressionContracts.create::parameters.resource,
  "suppressionContract"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SuppressionContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MetadataEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AdvisorScoreEntity.properties);

@@clientName(AssessmentResults.put::parameters.resource, "assessmentContract");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AssessmentResult.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ResiliencyReview.properties);

@@clientName(TriageRecommendations.rejectTriageRecommendation::parameters.body,
  "recommendationRejectBody"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TriageRecommendation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TriageResource.properties);

@@scope(ResourceRecommendationBases.list, "!csharp");

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

@@clientName(PredictionResponse, "AdvisorPredictionResult", "csharp");
@@clientName(TriageResource, "AdvisorTriageResourceData", "csharp");
@@clientName(TriageResourceCollection,
  "AdvisorTriageResourceDataList",
  "csharp"
);
@@clientName(AssessmentResult, "AdvisorAssessmentResult", "csharp");
@@clientName(ResiliencyReview, "AdvisorResiliencyReview", "csharp");
@@clientName(ResiliencyReviewCollection,
  "AdvisorResiliencyReviewList",
  "csharp"
);
@@clientName(Control, "RecommendationControlType", "csharp");
@@clientName(Duration, "MinimumDuration", "csharp");
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
@@clientName(RecommendationProperties.tracked, "IsTracked", "csharp");
@@clientName(Aggregated, "ScoreAggregationLevel", "csharp");
@@clientName(ReviewStatus, "ResiliencyReviewStatus", "csharp");
@@clientName(ScoreEntity, "AdvisorScoreEntityContent", "csharp");
@@clientName(State, "RecommendationState", "csharp");
@@clientName(WorkloadResult, "AdvisorWorkloadResult", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" ""
@@clientName(ConfigurationsOperationGroup.listBySubscription,
  "GetConfigurations",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" ""
@@clientName(ConfigurationsOperationGroup.listByResourceGroup,
  "GetConfigurations",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" ""
@@clientName(ConfigurationsOperationGroup.createInSubscription,
  "CreateConfiguration",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" ""
@@clientName(ConfigurationsOperationGroup.createInResourceGroup,
  "CreateConfiguration",
  "csharp"
);
@@clientName(ConfigurationsOperationGroup, "Configurations", "csharp");
@@clientName(RecommendationsOperationGroup.generate,
  "GenerateRecommendation",
  "csharp"
);
@@clientName(RecommendationsOperationGroup.getGenerateStatus,
  "GetGenerateStatusRecommendation",
  "csharp"
);
@@alternateType(RecommendationsOperationGroup.getGenerateStatus::parameters.operationId,
  Azure.Core.uuid,
  "csharp"
);
@@usage(ResourceRecommendationBase, Usage.input, "csharp");
