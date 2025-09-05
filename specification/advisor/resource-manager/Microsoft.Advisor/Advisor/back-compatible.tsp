import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Advisor;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConfigData.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PredictionRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PredictionResponse.properties);

@@clientLocation(ResourceRecommendationBases.get, "Recommendations", "!csharp");
@@clientLocation(ResourceRecommendationBases.patch,
  "Recommendations",
  "!csharp"
);
@@clientName(ResourceRecommendationBases.patch::parameters.properties,
  "trackedProperties"
);
@@clientLocation(ResourceRecommendationBases.list,
  "Recommendations",
  "!csharp"
);
@@clientLocation(ResourceRecommendationBases.listByTenant,
  "Recommendations",
  "!csharp"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ResourceRecommendationBase.properties);

@@clientLocation(SuppressionContracts.get, "Suppressions", "!csharp");
@@clientLocation(SuppressionContracts.create, "Suppressions", "!csharp");
@@clientName(SuppressionContracts.create::parameters.resource,
  "suppressionContract"
);
@@clientLocation(SuppressionContracts.delete, "Suppressions", "!csharp");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SuppressionContract.properties);

@@clientLocation(MetadataEntities.get, "RecommendationMetadata", "!csharp");
@@clientLocation(MetadataEntities.list, "RecommendationMetadata", "!csharp");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MetadataEntity.properties);

@@clientLocation(AdvisorScoreEntities.get, "AdvisorScores", "!csharp");
@@clientLocation(AdvisorScoreEntities.list, "AdvisorScores", "!csharp");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AdvisorScoreEntity.properties);

@@clientLocation(AssessmentResults.get, "Assessments", "!csharp");
@@clientLocation(AssessmentResults.put, "Assessments", "!csharp");
@@clientName(AssessmentResults.put::parameters.resource, "assessmentContract");
@@clientLocation(AssessmentResults.delete, "Assessments", "!csharp");
@@clientLocation(AssessmentResults.list, "Assessments", "!csharp");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AssessmentResult.properties);

@@clientLocation(ResiliencyReviews.get, "resiliencyReviews", "!csharp");
@@clientLocation(ResiliencyReviews.list, "resiliencyReviews", "!csharp");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ResiliencyReview.properties);

@@clientLocation(TriageRecommendations.get, "triageRecommendations", "!csharp");
@@clientLocation(TriageRecommendations.list,
  "triageRecommendations",
  "!csharp"
);
@@clientLocation(TriageRecommendations.approveTriageRecommendation,
  "triageRecommendations",
  "!csharp"
);
@@clientLocation(TriageRecommendations.rejectTriageRecommendation,
  "triageRecommendations",
  "!csharp"
);
@@clientName(TriageRecommendations.rejectTriageRecommendation::parameters.body,
  "recommendationRejectBody"
);
@@clientLocation(TriageRecommendations.resetTriageRecommendation,
  "triageRecommendations",
  "!csharp"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TriageRecommendation.properties);

@@clientLocation(TriageResources.get, "triageResources", "!csharp");
@@clientLocation(TriageResources.list, "triageResources", "!csharp");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TriageResource.properties);

@@clientLocation(RecommendationsOperationGroup.generate,
  "Recommendations",
  "!csharp"
);
@@clientLocation(RecommendationsOperationGroup.getGenerateStatus,
  "Recommendations",
  "!csharp"
);

@@clientLocation(SuppressionsOperationGroup.list, "Suppressions", "!csharp");

@@clientLocation(AssessmentTypesOperationGroup.list,
  "AssessmentTypes",
  "!csharp"
);

@@clientLocation(ConfigurationsOperationGroup.listBySubscription,
  "Configurations",
  "!csharp"
);
@@clientLocation(ConfigurationsOperationGroup.createInSubscription,
  "Configurations",
  "!csharp"
);
@@clientLocation(ConfigurationsOperationGroup.listByResourceGroup,
  "Configurations",
  "!csharp"
);
@@clientLocation(ConfigurationsOperationGroup.createInResourceGroup,
  "Configurations",
  "!csharp"
);

@@clientLocation(WorkloadsOperationGroup.list, "Workloads", "!csharp");

@@clientName(AdvisorScoreEntity, "advisorScoreEntity");
@@clientName(ResiliencyReviewCollection, "resiliencyReviewCollection");
@@clientName(TriageRecommendationCollection, "triageRecommendationCollection");
@@clientName(ResiliencyReview, "resiliencyReview");
@@clientName(TriageResource, "triageResource");
@@clientName(TriageResourceCollection, "triageResourceCollection");
@@clientName(TriageRecommendation, "triageRecommendation");
@@clientName(predict::parameters.body, "predictionRequest");

@@clientName(AdvisorScoreEntity, "ScoreEntityForAdvisor", "go");
