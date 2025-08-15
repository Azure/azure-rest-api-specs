import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Advisor;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConfigData.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PredictionRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PredictionResponse.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MetadataEntity.properties);

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

@@clientName(SuppressionContracts.create::parameters.resource,
  "suppressionContract"
);
@@clientName(predict::parameters.body, "predictionRequest");

@@clientName(AdvisorScoreEntity, "ScoreEntityForAdvisor", "go");

// @@clientName decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output

@@clientLocation(MetadataEntities.get, "RecommendationMetadata");
@@clientLocation(MetadataEntities.list, "RecommendationMetadata");

@@clientLocation(ResourceRecommendationBases.list, "Recommendations");
@@clientLocation(ResourceRecommendationBases.get, "Recommendations");
@@clientLocation(ResourceRecommendationBases.patch, "Recommendations");
@@clientName(ResourceRecommendationBases.patch::parameters.properties,
  "trackedProperties"
);
@@clientLocation(ResourceRecommendationBases.listByTenant, "Recommendations");

@@clientLocation(SuppressionContracts.get, "Suppressions");
@@clientLocation(SuppressionContracts.create, "Suppressions");
@@clientName(SuppressionContracts.create::parameters.resource,
  "suppressionContract"
);
@@clientLocation(SuppressionContracts.delete, "Suppressions");

@@clientLocation(AdvisorScoreEntities.get, "AdvisorScores");
@@clientLocation(AdvisorScoreEntities.list, "AdvisorScores");

@@clientLocation(AssessmentResults.get, "Assessments");
@@clientLocation(AssessmentResults.put, "Assessments");
@@clientName(AssessmentResults.put::parameters.resource, "assessmentContract");
@@clientLocation(AssessmentResults.delete, "Assessments");
@@clientLocation(AssessmentResults.list, "Assessments");

@@clientLocation(ConfigurationsOperationGroup.listBySubscription,
  "Configurations"
);
@@clientLocation(ConfigurationsOperationGroup.createInSubscription,
  "Configurations"
);
@@clientLocation(ConfigurationsOperationGroup.listByResourceGroup,
  "Configurations"
);
@@clientLocation(ConfigurationsOperationGroup.createInResourceGroup,
  "Configurations"
);

@@clientLocation(RecommendationsOperationGroup.generate, "Recommendations");
@@clientLocation(RecommendationsOperationGroup.getGenerateStatus,
  "Recommendations"
);

@@clientLocation(SuppressionsOperationGroup.list, "Suppressions");

@@clientLocation(AssessmentTypesOperationGroup.list, "AssessmentTypes");

@@clientLocation(WorkloadsOperationGroup.list, "Workloads");

@@clientName(AdvisorScoreEntity, "advisorScoreEntity");
@@clientName(ResiliencyReviewCollection, "resiliencyReviewCollection");
@@clientName(TriageRecommendationCollection, "triageRecommendationCollection");
@@clientName(ResiliencyReview, "resiliencyReview");
@@clientName(TriageResource, "triageResource");
@@clientName(TriageResourceCollection, "triageResourceCollection");
@@clientName(TriageRecommendation, "triageRecommendation");
