import "@azure-tools/typespec-client-generator-core";
import "./route.trialmatcher.tsp";

import "@typespec/rest";
import "@typespec/http";
import "../HealthInsights.OpenAPI/service.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(
  AzureHealthInsights.ApiVersion.v2023_09_01_Preview
)
namespace ClientForAzureHealthInsights;

@client({
  name: "ClinicalMatchingClient",
  service: AzureHealthInsights,
})
interface ClinicalMatchingClient {
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling through operation-location"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "https://github.com/microsoft/typespec/issues/2037"
  matchTrials is AzureHealthInsights.TrialMatcher.createJob;
}

@@projectedName(Fhir.R4.Extension, "java", "Fhir_R4_Extension");
@@projectedName(Fhir.R4.Extension, "csharp", "Fhir_R4_Extension");
@@projectedName(Fhir.R4.Extendible, "java", "Fhir_R4_Extendible");
@@projectedName(Fhir.R4.Extendible, "csharp", "Fhir_R4_Extendible");
@@projectedName(Fhir.R4.Element, "java", "Fhir_R4_Element");
@@projectedName(Fhir.R4.Element, "csharp", "Fhir_R4_Element");
@@projectedName(Fhir.R4.Coding, "java", "Fhir_R4_Coding");
@@projectedName(Fhir.R4.Coding, "csharp", "Fhir_R4_Coding");
@@projectedName(Fhir.R4.CodeableConcept, "java", "Fhir_R4_CodeableConcept");
@@projectedName(Fhir.R4.CodeableConcept, "csharp", "Fhir_R4_CodeableConcept");
@@projectedName(Fhir.R4.Meta, "java", "Fhir_R4_Meta");
@@projectedName(Fhir.R4.Meta, "csharp", "Fhir_R4_Meta");
@@projectedName(Fhir.R4.Narrative, "java", "Fhir_R4_Narrative");
@@projectedName(Fhir.R4.Narrative, "csharp", "Fhir_R4_Narrative");
@@projectedName(Fhir.R4.Reference, "java", "Fhir_R4_Reference");
@@projectedName(Fhir.R4.Reference, "csharp", "Fhir_R4_Reference");
@@projectedName(Fhir.R4.Identifier, "java", "Fhir_R4_Identifier");
@@projectedName(Fhir.R4.Identifier, "csharp", "Fhir_R4_Identifier");
@@projectedName(Fhir.R4.Period, "java", "Fhir_R4_Period");
@@projectedName(Fhir.R4.Period, "csharp", "Fhir_R4_Period");
@@projectedName(Fhir.R4.Quantity, "java", "Fhir_R4_Quantity");
@@projectedName(Fhir.R4.Quantity, "csharp", "Fhir_R4_Quantity");
@@projectedName(Fhir.R4.Range, "java", "Fhir_R4_Range");
@@projectedName(Fhir.R4.Range, "csharp", "Fhir_R4_Range");
@@projectedName(Fhir.R4.Ratio, "java", "Fhir_R4_Ratio");
@@projectedName(Fhir.R4.Ratio, "csharp", "Fhir_R4_Ratio");
@@projectedName(Fhir.R4.Annotation, "java", "Fhir_R4_Annotation");
@@projectedName(Fhir.R4.Annotation, "csharp", "Fhir_R4_Annotation");
@@projectedName(Fhir.R4.SampledData, "java", "Fhir_R4_SampledData");
@@projectedName(Fhir.R4.SampledData, "csharp", "Fhir_R4_SampledData");
@@projectedName(Fhir.R4.ContactDetail, "java", "Fhir_R4_ContactDetail");
@@projectedName(Fhir.R4.ContactDetail, "csharp", "Fhir_R4_ContactDetail");
@@projectedName(Fhir.R4.ContactPoint, "java", "Fhir_R4_ContactPoint");
@@projectedName(Fhir.R4.ContactPoint, "csharp", "Fhir_R4_ContactPoint");
@@projectedName(Fhir.R4.Resource, "java", "Fhir_R4_Resource");
@@projectedName(Fhir.R4.Resource, "csharp", "Fhir_R4_Resource");
@@projectedName(Fhir.R4.DomainResource, "java", "Fhir_R4_DomainResource");
@@projectedName(Fhir.R4.DomainResource, "csharp", "Fhir_R4_DomainResource");
@@projectedName(Fhir.R4.Condition, "java", "Fhir_R4_Condition");
@@projectedName(Fhir.R4.Condition, "csharp", "Fhir_R4_Condition");
@@projectedName(Fhir.R4.ConditionStage, "java", "Fhir_R4_ConditionStage");
@@projectedName(Fhir.R4.ConditionStage, "csharp", "Fhir_R4_ConditionStage");
@@projectedName(Fhir.R4.Observation, "java", "Fhir_R4_Observation");
@@projectedName(Fhir.R4.Observation, "csharp", "Fhir_R4_Observation");
@@projectedName(Fhir.R4.ObservationReferenceRange,
  "java",
  "Fhir_R4_ObservationReferenceRange"
);
@@projectedName(Fhir.R4.ObservationReferenceRange,
  "csharp",
  "Fhir_R4_ObservationReferenceRange"
);
@@projectedName(Fhir.R4.ObservationComponent,
  "java",
  "Fhir_R4_ObservationComponent"
);
@@projectedName(Fhir.R4.ObservationComponent,
  "csharp",
  "Fhir_R4_ObservationComponent"
);
@@projectedName(Fhir.R4.ResearchStudy, "java", "Fhir_R4_ResearchStudy");
@@projectedName(Fhir.R4.ResearchStudy, "csharp", "Fhir_R4_ResearchStudy");
@@projectedName(AzureHealthInsights.PatientInfoSex, "client", "PatientSex");
@@projectedName(AzureHealthInsights.PatientInfo, "client", "PatientDetails");
