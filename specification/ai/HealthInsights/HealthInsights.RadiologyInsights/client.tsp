import "@azure-tools/typespec-client-generator-core";
import "./route.radiologyinsights.tsp";

import "@typespec/rest";
import "@typespec/http";
import "../service.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(
  AzureHealthInsights.ApiVersion.v2023_09_01_Preview
)
namespace ClientForAzureHealthInsights;

@client({
  name: "RadiologyInsightsClient",
  service: AzureHealthInsights,
})
interface RadiologyInsightsClient {
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling through operation-location"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "https://github.com/microsoft/typespec/issues/2037"
  inferRadiologyInsights is AzureHealthInsights.RadiologyInsights.createJob;
}

@@clientName("Extension" ,"Fhir_R4_Extension", "java")
@@clientName("Extension" ,"Fhir_R4_Extension", "csharp")
@@clientName("Extendible" ,"Fhir_R4_Extendible", "java")
@@clientName("Extendible" ,"Fhir_R4_Extendible", "csharp")
@@clientName("Element" ,"Fhir_R4_Element", "java")
@@clientName("Element" ,"Fhir_R4_Element", "csharp")
@@clientName("Coding" ,"Fhir_R4_Coding", "java")
@@clientName("Coding" ,"Fhir_R4_Coding", "csharp")
@@clientName("CodeableConcept" ,"Fhir_R4_CodeableConcept", "java")
@@clientName("CodeableConcept" ,"Fhir_R4_CodeableConcept", "csharp")
@@clientName("Meta" ,"Fhir_R4_Meta", "java")
@@clientName("Meta" ,"Fhir_R4_Meta", "csharp")
@@clientName("Narrative" ,"Fhir_R4_Narrative", "java")
@@clientName("Narrative" ,"Fhir_R4_Narrative", "csharp")
@@clientName("Reference" ,"Fhir_R4_Reference", "java")
@@clientName("Reference" ,"Fhir_R4_Reference", "csharp")
@@clientName("Identifier" ,"Fhir_R4_Identifier", "java")
@@clientName("Identifier" ,"Fhir_R4_Identifier", "csharp")
@@clientName("Period" ,"Fhir_R4_Period", "java")
@@clientName("Period" ,"Fhir_R4_Period", "csharp")
@@clientName("Quantity" ,"Fhir_R4_Quantity", "java")
@@clientName("Quantity" ,"Fhir_R4_Quantity", "csharp")
@@clientName("Range" ,"Fhir_R4_Range", "java")
@@clientName("Range" ,"Fhir_R4_Range", "csharp")
@@clientName("Ratio" ,"Fhir_R4_Ratio", "java")
@@clientName("Ratio" ,"Fhir_R4_Ratio", "csharp")
@@clientName("Annotation" ,"Fhir_R4_Annotation", "java")
@@clientName("Annotation" ,"Fhir_R4_Annotation", "csharp")
@@clientName("SampledData" ,"Fhir_R4_SampledData", "java")
@@clientName("SampledData" ,"Fhir_R4_SampledData", "csharp")
@@clientName("ContactDetail" ,"Fhir_R4_ContactDetail", "java")
@@clientName("ContactDetail" ,"Fhir_R4_ContactDetail", "csharp")
@@clientName("ContactPoint" ,"Fhir_R4_ContactPoint", "java")
@@clientName("ContactPoint" ,"Fhir_R4_ContactPoint", "csharp")
@@clientName("Resource" ,"Fhir_R4_Resource", "java")
@@clientName("Resource" ,"Fhir_R4_Resource", "csharp")
@@clientName("DomainResource" ,"Fhir_R4_DomainResource", "java")
@@clientName("DomainResource" ,"Fhir_R4_DomainResource", "csharp")
@@clientName("Condition" ,"Fhir_R4_Condition", "java")
@@clientName("Condition" ,"Fhir_R4_Condition", "csharp")
@@clientName("ConditionStage" ,"Fhir_R4_ConditionStage", "java")
@@clientName("ConditionStage" ,"Fhir_R4_ConditionStage", "csharp")
@@clientName("Observation" ,"Fhir_R4_Observation", "java")
@@clientName("Observation" ,"Fhir_R4_Observation", "csharp")
@@clientName("ObservationReferenceRange" ,"Fhir_R4_ObservationReferenceRange", "java")
@@clientName("ObservationReferenceRange" ,"Fhir_R4_ObservationReferenceRange", "csharp")
@@clientName("ObservationComponent" ,"Fhir_R4_ObservationComponent", "java")
@@clientName("ObservationComponent" ,"Fhir_R4_ObservationComponent", "csharp")
@@clientName("ResearchStudy" ,"Fhir_R4_ResearchStudy", "java")
@@clientName("ResearchStudy" ,"Fhir_R4_ResearchStudy", "csharp")
@@clientName("PatientInfoSex", "PatientSex")
@@clientName("PatientInfo", "PatientDetails")