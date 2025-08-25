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

@@clientName(Microsoft.Advisor, "AdvisorManagementClient", "javascript,python");
@@clientName(Microsoft.Advisor.CpuThreshold.`5`, "Five", "javascript,go");
@@clientName(Microsoft.Advisor.CpuThreshold.`10`, "Ten", "javascript,go");
@@clientName(Microsoft.Advisor.CpuThreshold.`15`, "Fifteen", "javascript,go");
@@clientName(Microsoft.Advisor.CpuThreshold.`20`, "Twenty", "javascript,go");
@@clientName(Microsoft.Advisor.CpuThreshold.`5`, "FIVE", "python");
@@clientName(Microsoft.Advisor.CpuThreshold.`10`, "TEN", "python");
@@clientName(Microsoft.Advisor.CpuThreshold.`15`, "FIFTEEN", "python");
@@clientName(Microsoft.Advisor.CpuThreshold.`20`, "TWENTY", "python");
