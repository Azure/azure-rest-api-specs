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
@@clientName(AzureHealthInsights.QualityMeasureType.Mips76, "MIPS_76", "java");
@@clientName(AzureHealthInsights.QualityMeasureType.Mips147,
  "MIPS_147",
  "java"
);
@@clientName(AzureHealthInsights.QualityMeasureType.Mips195,
  "MIPS_195",
  "java"
);
@@clientName(AzureHealthInsights.QualityMeasureType.Mips360,
  "MIPS_360",
  "java"
);
@@clientName(AzureHealthInsights.QualityMeasureType.Mips364,
  "MIPS_364",
  "java"
);
@@clientName(AzureHealthInsights.QualityMeasureType.Mips405,
  "MIPS_405",
  "java"
);
@@clientName(AzureHealthInsights.QualityMeasureType.Mips406,
  "MIPS_406",
  "java"
);
@@clientName(AzureHealthInsights.QualityMeasureType.Mips436,
  "MIPS_436",
  "java"
);
@@clientName(AzureHealthInsights.QualityMeasureType.Mips145,
  "MIPS_145",
  "java"
);
@@clientName(AzureHealthInsights.QualityMeasureType.Acrad36,
  "ACRAD_36",
  "java"
);
@@clientName(AzureHealthInsights.QualityMeasureType.Acrad37,
  "ACRAD_37",
  "java"
);
@@clientName(AzureHealthInsights.QualityMeasureType.Acrad38,
  "ACRAD_38",
  "java"
);
@@clientName(AzureHealthInsights.QualityMeasureType.Acrad39,
  "ACRAD_39",
  "java"
);
@@clientName(AzureHealthInsights.QualityMeasureType.Acrad40,
  "ACRAD_40",
  "java"
);
@@clientName(AzureHealthInsights.QualityMeasureType.Acrad41,
  "ACRAD_41",
  "java"
);
@@clientName(AzureHealthInsights.QualityMeasureType.Acrad42,
  "ACRAD_42",
  "java"
);
@@clientName(AzureHealthInsights.QualityMeasureType.Mednax55,
  "MEDNAX_55",
  "java"
);
@@clientName(AzureHealthInsights.QualityMeasureType.Msn13, "MSN_13", "java");
@@clientName(AzureHealthInsights.QualityMeasureType.Msn15, "MSN_15", "java");
@@clientName(AzureHealthInsights.QualityMeasureType.Qmm26, "QMM_26", "java");
@@clientName(AzureHealthInsights.QualityMeasureType.Qmm17, "QMM_17", "java");
@@clientName(AzureHealthInsights.QualityMeasureType.Qmm18, "QMM_18", "java");
@@clientName(AzureHealthInsights.QualityMeasureType.Qmm19, "QMM_19", "java");
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.BIRADS,
  "Birads",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.C_RADS_COLONIC_FINDINGS,
  "CRadsColonicFindings",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.CAD_RADS,
  "CadRads",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.LI_RADS,
  "LiRads",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.LUNG_RADS,
  "LungRads",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.NI_RADS,
  "NiRads",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.O_RADS,
  "ORads",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.PI_RADS,
  "PiRads",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.TI_RADS,
  "TiRads",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.C_RADS_EXTRACOLONIC_FINDINGS,
  "CRadsExtracolonicFindings",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.LIFETIME_BREAST_CANCER_RISK,
  "LifetimeBreastCancerRisk",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.ASCVD_RISK,
  "AscvdRisk",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.MODIFIED_GAIL_MODEL_RISK,
  "ModifiedGailModelRisk",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.TYRER_CUSICK_MODEL_RISK,
  "TyrerCusickModelRisk",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.AGATSTON_SCORE,
  "AgatstonScore",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.TEN_YEAR_CHD_RISK,
  "TenYearChdRisk",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.Z_SCORE,
  "ZScore",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.T_SCORE,
  "TScore",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.CALCIUM_VOLUME_SCORE,
  "CalciumVolumeScore",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.US_LI_RADS_VISUALIZATION_SCORE,
  "UsLiRadsVisualizationScore",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.US_LI_RADS,
  "UsLiRads",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.CEUS_LI_RADS,
  "CeusLiRads",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.TREATMENT_RESPONSE_LI_RADS,
  "TreatmentResponseLiRads",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.O_RADS_MRI,
  "ORadsMri",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.CALCIUM_MASS_SCORE,
  "CalciumMassScore",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.RISK_OF_MALIGNANCY_INDEX,
  "RiskOfMalignancyIndex",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.HNPCC_MUTATION_RISK,
  "HnpccMutationRisk",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.ALBERTA_STROKE_PROGRAM_EARLY_CT_SCORE,
  "AlbertaStrokeProgramEarlyCtScore",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.KELLGREN_LAWRENCE_GRADING_SCALE,
  "KellgrenLawrenceGradingScale",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.TONNIS_CLASSIFICATION,
  "TonnisClassification",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.CALCIUM_SCORE_UNSPECIFIED,
  "CalciumScoreUnspecified",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.TEN_YEAR_CHD_RISK_OBSERVED_AGE,
  "TenYearChdRiskObservedAge",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.TEN_YEAR_CHD_RISK_ARTERIAL_AGE,
  "TenYearChdRiskArterialAge",
  "csharp"
);
@@clientName(AzureHealthInsights.ScoringAndAssessmentCategoryType.FRAX_SCORE,
  "FraxScore",
  "csharp"
);
