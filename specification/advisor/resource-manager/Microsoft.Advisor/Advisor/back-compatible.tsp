import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Advisor;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConfigData.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PredictionRequest.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PredictionResponse.properties
);

@@clientLocation(ResourceRecommendationBases.get, "Recommendations", "!csharp");
@@clientLocation(ResourceRecommendationBases.patch,
  "Recommendations",
  "!csharp"
);
@@clientName(ResourceRecommendationBases.patch::parameters.properties,
  "trackedProperties",
  "!csharp"
);
@@clientLocation(ResourceRecommendationBases.list,
  "Recommendations",
  "!csharp"
);
@@clientLocation(ResourceRecommendationBases.listByTenant,
  "Recommendations",
  "!csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceRecommendationBase.properties
);

@@clientLocation(SuppressionContracts.get, "Suppressions", "!csharp");
@@clientLocation(SuppressionContracts.create, "Suppressions", "!csharp");
@@clientName(SuppressionContracts.create::parameters.resource,
  "suppressionContract",
  "!csharp"
);
@@clientLocation(SuppressionContracts.delete, "Suppressions", "!csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SuppressionContract.properties
);

@@clientLocation(MetadataEntities.get, "RecommendationMetadata", "!csharp");
@@clientLocation(MetadataEntities.list, "RecommendationMetadata", "!csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MetadataEntity.properties);

@@clientLocation(AdvisorScoreEntities.get, "AdvisorScores", "!csharp");
@@clientLocation(AdvisorScoreEntities.list, "AdvisorScores", "!csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AdvisorScoreEntity.properties
);

@@clientLocation(AssessmentResults.get, "Assessments", "!csharp");
@@clientLocation(AssessmentResults.put, "Assessments", "!csharp");
@@clientName(AssessmentResults.put::parameters.resource,
  "assessmentContract",
  "!csharp"
);
@@clientLocation(AssessmentResults.delete, "Assessments", "!csharp");
@@clientLocation(AssessmentResults.list, "Assessments", "!csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AssessmentResult.properties
);

@@clientLocation(ResiliencyReviews.get, "resiliencyReviews", "!csharp");
@@clientLocation(ResiliencyReviews.list, "resiliencyReviews", "!csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResiliencyReview.properties
);

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
  "recommendationRejectBody",
  "!csharp"
);
@@clientLocation(TriageRecommendations.resetTriageRecommendation,
  "triageRecommendations",
  "!csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(TriageRecommendation.properties
);

@@clientLocation(TriageResources.get, "triageResources", "!csharp");
@@clientLocation(TriageResources.list, "triageResources", "!csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(TriageResource.properties);

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

@@clientName(AdvisorScoreEntity, "advisorScoreEntity", "!csharp,!go");
@@clientName(ResiliencyReviewCollection,
  "resiliencyReviewCollection",
  "!csharp"
);
@@clientName(TriageRecommendationCollection,
  "triageRecommendationCollection",
  "!csharp"
);
@@clientName(ResiliencyReview, "resiliencyReview", "!csharp");
@@clientName(TriageResource, "triageResource", "!csharp");
@@clientName(TriageResourceCollection, "triageResourceCollection", "!csharp");
@@clientName(TriageRecommendation, "triageRecommendation", "!csharp");
@@clientName(predict::parameters.body, "predictionRequest", "!csharp");
