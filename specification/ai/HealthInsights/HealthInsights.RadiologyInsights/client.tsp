import "@azure-tools/typespec-client-generator-core";
import "./route.radiologyinsights.tsp";

import "@typespec/rest";
import "@typespec/http";
import "../HealthInsights.OpenAPI/service.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(AzureHealthInsights.ApiVersion.v2024_04_01)
namespace ClientForAzureHealthInsights;

@client({
  name: "RadiologyInsightsClient",
  service: AzureHealthInsights,
})
interface RadiologyInsightsClient {
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling through operation-location"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "https://github.com/microsoft/typespec/issues/2037"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name"
  inferRadiologyInsights is AzureHealthInsights.RadiologyInsights.createJob;
}

@@clientName(Fhir.R4.Extension, "Fhir_R4_Extension", "java");
@@clientName(Fhir.R4.Extension, "Fhir_R4_Extension", "csharp");
@@clientName(Fhir.R4.Extendible, "Fhir_R4_Extendible", "java");
@@clientName(Fhir.R4.Extendible, "Fhir_R4_Extendible", "csharp");
@@clientName(Fhir.R4.Element, "Fhir_R4_Element", "java");
@@clientName(Fhir.R4.Element, "Fhir_R4_Element", "csharp");
@@clientName(Fhir.R4.Coding, "Fhir_R4_Coding", "java");
@@clientName(Fhir.R4.Coding, "Fhir_R4_Coding", "csharp");
@@clientName(Fhir.R4.CodeableConcept, "Fhir_R4_CodeableConcept", "java");
@@clientName(Fhir.R4.CodeableConcept, "Fhir_R4_CodeableConcept", "csharp");
@@clientName(Fhir.R4.Meta, "Fhir_R4_Meta", "java");
@@clientName(Fhir.R4.Meta, "Fhir_R4_Meta", "csharp");
@@clientName(Fhir.R4.Narrative, "Fhir_R4_Narrative", "java");
@@clientName(Fhir.R4.Narrative, "Fhir_R4_Narrative", "csharp");
@@clientName(Fhir.R4.Reference, "Fhir_R4_Reference", "java");
@@clientName(Fhir.R4.Reference, "Fhir_R4_Reference", "csharp");
@@clientName(Fhir.R4.Identifier, "Fhir_R4_Identifier", "java");
@@clientName(Fhir.R4.Identifier, "Fhir_R4_Identifier", "csharp");
@@clientName(Fhir.R4.Period, "Fhir_R4_Period", "java");
@@clientName(Fhir.R4.Period, "Fhir_R4_Period", "csharp");
@@clientName(Fhir.R4.Quantity, "Fhir_R4_Quantity", "java");
@@clientName(Fhir.R4.Quantity, "Fhir_R4_Quantity", "csharp");
@@clientName(Fhir.R4.Range, "Fhir_R4_Range", "java");
@@clientName(Fhir.R4.Range, "Fhir_R4_Range", "csharp");
@@clientName(Fhir.R4.Ratio, "Fhir_R4_Ratio", "java");
@@clientName(Fhir.R4.Ratio, "Fhir_R4_Ratio", "csharp");
@@clientName(Fhir.R4.Annotation, "Fhir_R4_Annotation", "java");
@@clientName(Fhir.R4.Annotation, "Fhir_R4_Annotation", "csharp");
@@clientName(Fhir.R4.SampledData, "Fhir_R4_SampledData", "java");
@@clientName(Fhir.R4.SampledData, "Fhir_R4_SampledData", "csharp");
@@clientName(Fhir.R4.ContactDetail, "Fhir_R4_ContactDetail", "java");
@@clientName(Fhir.R4.ContactDetail, "Fhir_R4_ContactDetail", "csharp");
@@clientName(Fhir.R4.ContactPoint, "Fhir_R4_ContactPoint", "java");
@@clientName(Fhir.R4.ContactPoint, "Fhir_R4_ContactPoint", "csharp");
@@clientName(Fhir.R4.Resource, "Fhir_R4_Resource", "java");
@@clientName(Fhir.R4.Resource, "Fhir_R4_Resource", "csharp");
@@clientName(Fhir.R4.DomainResource, "Fhir_R4_DomainResource", "java");
@@clientName(Fhir.R4.DomainResource, "Fhir_R4_DomainResource", "csharp");
@@clientName(Fhir.R4.Condition, "Fhir_R4_Condition", "java");
@@clientName(Fhir.R4.Condition, "Fhir_R4_Condition", "csharp");
@@clientName(Fhir.R4.ConditionStage, "Fhir_R4_ConditionStage", "java");
@@clientName(Fhir.R4.ConditionStage, "Fhir_R4_ConditionStage", "csharp");
@@clientName(Fhir.R4.Observation, "Fhir_R4_Observation", "java");
@@clientName(Fhir.R4.Observation, "Fhir_R4_Observation", "csharp");
@@clientName(Fhir.R4.ObservationReferenceRange,
  "Fhir_R4_ObservationReferenceRange",
  "java"
);
@@clientName(Fhir.R4.ObservationReferenceRange,
  "Fhir_R4_ObservationReferenceRange",
  "csharp"
);
@@clientName(Fhir.R4.ObservationComponent,
  "Fhir_R4_ObservationComponent",
  "java"
);
@@clientName(Fhir.R4.ObservationComponent,
  "Fhir_R4_ObservationComponent",
  "csharp"
);
@@clientName(Fhir.R4.ResearchStudy, "Fhir_R4_ResearchStudy", "java");
@@clientName(Fhir.R4.ResearchStudy, "Fhir_R4_ResearchStudy", "csharp");

@@clientName(AzureHealthInsights.FollowupCommunicationInference.wasAcknowledged,
  "acknowledged",
  "java"
);

@@clientName(AzureHealthInsights.DocumentAuthor,
  "ClinicalDocumentAuthor",
  "csharp, java"
);
@@clientName(AzureHealthInsights.DocumentType,
  "ClinicalDocumentContentType",
  "csharp, java"
);
@@clientName(AzureHealthInsights.DocumentContent,
  "ClinicalDocumentContent",
  "csharp, java"
);
