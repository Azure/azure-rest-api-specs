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
@@clientName(PredictsOperationGroup.predict::parameters.body,
  "predictionRequest"
);

@@clientName(AdvisorScoreEntity, "ScoreEntityForAdvisor", "go");

// @@clientLocation decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output

// ResourceRecommendationBases operations
@@clientLocation(ResourceRecommendationBases.get, "Recommendations");
@@clientLocation(ResourceRecommendationBases.patch, "Recommendations");
@@clientLocation(ResourceRecommendationBases.list, "Recommendations");

// AdvisorScoreEntities operations
@@clientLocation(AdvisorScoreEntities.get, "AdvisorScore");
@@clientLocation(AdvisorScoreEntities.list, "AdvisorScore");

// SuppressionContracts operations
@@clientLocation(SuppressionContracts.get, "Suppressions");
@@clientLocation(SuppressionContracts.create, "Suppressions");
@@clientLocation(SuppressionContracts.delete, "Suppressions");

// ConfigurationsOperationGroup operations
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

// RecommendationsOperationGroup operations
@@clientLocation(RecommendationsOperationGroup.generate, "Recommendations");
@@clientLocation(RecommendationsOperationGroup.getGenerateStatus,
  "Recommendations"
);

// SuppressionsOperationGroup operations
@@clientLocation(SuppressionsOperationGroup.list, "Suppressions");

// PredictsOperationGroup operations
@@clientLocation(PredictsOperationGroup.predict, "Predict");

// AssessmentTypesOperationGroup operations
@@clientLocation(AssessmentTypesOperationGroup.list, "AssessmentTypes");

// WorkloadsOperationGroup operations
@@clientLocation(WorkloadsOperationGroup.list, "Workloads");

// AssessmentResults operations
@@clientLocation(AssessmentResults.get, "Assessments");
@@clientLocation(AssessmentResults.put, "Assessments");
@@clientLocation(AssessmentResults.delete, "Assessments");
@@clientLocation(AssessmentResults.list, "Assessments");

// MetadataEntities operations
@@clientLocation(MetadataEntities.get, "RecommendationMetadata");
@@clientLocation(MetadataEntities.list, "RecommendationMetadata");

// ResiliencyReviews operations
@@clientLocation(ResiliencyReviews.get, "resiliencyReviews");
@@clientLocation(ResiliencyReviews.list, "resiliencyReviews");
