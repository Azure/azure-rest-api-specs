import "../HealthInsights.Common/model.common.request.tsp";
import "../HealthInsights.Common/model.common.response.tsp";
import "../HealthInsights.Common/model.common.shared.tsp";
import "../HealthInsights.Common/model.common.fhir.elements.tsp";
import "./model.radiologyinsights.valuesets.tsp";

using TypeSpec.Rest;

using TypeSpec.Versioning;

namespace AzureHealthInsights;

@doc("Contains the list of patients, and configuration data.")
model RadiologyInsightsData {
  ...Request;

  @doc("Configuration affecting the Radiology Insights model's inference.")
  configuration?: RadiologyInsightsModelConfiguration;
}

@doc("Configuration affecting the Radiology Insights model's inference.")
model RadiologyInsightsModelConfiguration {
  ...ModelConfiguration;

  @doc("This is a list of inference types to be inferred for the current request. It could be used if only part of the Radiology Insights inferences are required. If this list is omitted or empty, the model will return all the inference types.")
  @minItems(1)
  inferenceTypes?: RadiologyInsightsInferenceType[];

  @doc("Options regarding follow up recommendation inferences and finding inferences.")
  inferenceOptions?: RadiologyInsightsInferenceOptions;

  @doc("Local for the model to use. If not specified, the model will use the default locale.")
  locale?: string;
}

@doc("Options regarding follow up recommendation inferences and finding inferences.")
model RadiologyInsightsInferenceOptions {
  @doc("Follow-up recommendation options.")
  followupRecommendationOptions?: FollowupRecommendationOptions;

  @doc("Finding options.")
  findingOptions?: FindingOptions;

  @added(ApiVersion.v2024_10_01)
  @doc("Guidance options.")
  guidanceOptions?: GuidanceOptions;

  @added(ApiVersion.v2024_10_01)
  @doc("QualityMeasureOptions.")
  qualityMeasureOptions?: QualityMeasureOptions;
}

@doc("Follow-up recommendation options.")
model FollowupRecommendationOptions {
  @doc("Include/Exclude follow-up recommendations without a specific radiology procedure. Default is false.")
  includeRecommendationsWithNoSpecifiedModality?: boolean;

  @doc("Include/Exclude follow-up recommendations in references to a guideline or article. Default is false.")
  includeRecommendationsInReferences?: boolean;

  @doc("If this is true, provide one or more sentences as evidence for the recommendation, next to the token evidence. The start and end positions of these sentences will be put in an extension with url 'modality_sentences'. Default is false.")
  provideFocusedSentenceEvidence?: boolean;
}

@doc("Finding options.")
model FindingOptions {
  @doc("If this is true, provide the sentence that contains the first token of the finding's clinical indicator (i.e. the medical problem), if there is one. This sentence is provided as an extension with url 'ci_sentence', next to the token evidence. Default is false.")
  provideFocusedSentenceEvidence?: boolean;
}

@added(ApiVersion.v2024_10_01)
@doc("Guidance options.")
model GuidanceOptions {
  @doc("If this is true, also show guidances from a clinical history section i.e. if the first token of the associated finding's clinical indicator is in this section. Default is false.")
  showGuidanceInHistory: boolean;
}

@added(ApiVersion.v2024_10_01)
@doc("Quality Measure Options.")
model QualityMeasureOptions {
  @doc("Id(s) of the MIPS measures that need to be evaluated in the document")
  @minItems(1)
  measureTypes: Array<QualityMeasureType>;
}

@doc("Response for the Radiology Insights request.")
@resource("radiology-insights/jobs")
model RadiologyInsightsJob {
  @doc("The request data for the operation.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobData?: RadiologyInsightsData;

  @doc("The result of the operation.")
  @visibility(Lifecycle.Read)
  result?: RadiologyInsightsInferenceResult;

  ...HealthInsightsJobBase;
}

@doc("The inference results for the Radiology Insights request. If field 'status' has value 'succeeded', then field 'result' will contain an instance of RadiologyInsightsInferenceResult.")
model RadiologyInsightsInferenceResult {
  @doc("Results for the patients given in the request.")
  @minItems(1)
  patientResults: RadiologyInsightsPatientResult[];

  @doc("The version of the model used for inference, expressed as the model date.")
  @pattern("^(?:[2][0-9]{3}-(?:0[1-9]|1[0-2])-(?:0[1-9]|[12][0-9]|3[01])(?:-preview)?)$")
  modelVersion: ModelVersion;
}

@doc("Results of the model's work for a single patient.")
model RadiologyInsightsPatientResult {
  @doc("Identifier given for the patient in the request.")
  patientId: string;

  @doc("The model's inferences for the given patient.")
  @minItems(1)
  inferences: RadiologyInsightsInference[];
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
@doc("""
  An inference made by the Radiology Insights model regarding a patient.
    - AgeMismatch
    - SexMismatch
    - LateralityDiscrepancy
    - CompleteOrderDiscrepancy
    - LimitedOrderDiscrepancy
    - Finding
    - CriticalResult
    - FollowupRecommendation
    - RadiologyProcedure
    - FollowupCommunication
  """)
@discriminator("kind")
model RadiologyInsightsInference {
  ...Fhir.R4.Extendible;
}

@doc("A notification for age mismatch is displayed when the age mentioned in a document for a specific patient does not match the age specified in the patient information.")
model AgeMismatchInference extends RadiologyInsightsInference {
  @doc("Inference type.")
  kind: RadiologyInsightsInferenceType.AgeMismatch;
}

@doc("A notification for a sex mismatch is displayed when the gender, personal pronouns, gender-related body parts, or gender-related procedures mentioned in a patient's clinical document are either inconsistent or do not match the gender specified in the patient information.")
model SexMismatchInference extends RadiologyInsightsInference {
  @doc("Inference type.")
  kind: RadiologyInsightsInferenceType.SexMismatch;

  @doc("Sex indication : SNOMED CT code for gender finding.")
  sexIndication: Fhir.R4.CodeableConcept;
}

@doc("A laterality mismatch occurs when there is a discrepancy between the clinical documentation and the ordered procedure (orderLateralityMismatch), a contradiction within the clinical document (textLateralityContradiction), or when no laterality is mentioned (textLateralityMissing).")
model LateralityDiscrepancyInference extends RadiologyInsightsInference {
  @doc("Inference type.")
  kind: RadiologyInsightsInferenceType.LateralityDiscrepancy;

  @doc("Laterality indication : SNOMED CT code for laterality qualifier value.")
  lateralityIndication?: Fhir.R4.CodeableConcept;

  @doc("Mismatch type : orderLateralityMismatch, textLateralityContradiction, textLateralityMissing.")
  discrepancyType: LateralityDiscrepancyType;
}

@doc("A complete order discrepancy is shown when one or more body parts and/or measurements that should be in the document (because there is a complete order) are not present.")
model CompleteOrderDiscrepancyInference extends RadiologyInsightsInference {
  @doc("Inference type.")
  kind: RadiologyInsightsInferenceType.CompleteOrderDiscrepancy;

  @doc("Order type : CPT ultrasound complete code for abdomen, retroperitoneal, pelvis or breast.")
  orderType: Fhir.R4.CodeableConcept;

  @doc("List of missing body parts required by a complete order : SNOMED CT codes.")
  @minItems(1)
  missingBodyParts?: Array<Fhir.R4.CodeableConcept>;

  @doc("List of missing body parts that require measurement by a complete order : SNOMED CT codes.")
  @minItems(1)
  missingBodyPartMeasurements?: Array<Fhir.R4.CodeableConcept>;
}

@doc("A limited order discrepancy occurs when there is a limited order, but all body parts and measurements that are needed for a complete order are present in the document.")
model LimitedOrderDiscrepancyInference extends RadiologyInsightsInference {
  @doc("Inference type.")
  kind: RadiologyInsightsInferenceType.LimitedOrderDiscrepancy;

  @doc("Order type : CPT ultrasound complete code for abdomen, retroperitoneal, pelvis or breast.")
  orderType: Fhir.R4.CodeableConcept;

  @doc("List of body parts found in the document : SNOMED CT codes.")
  @minItems(1)
  presentBodyParts?: Array<Fhir.R4.CodeableConcept>;

  @doc("List of body parts that are measured according to the document : SNOMED CT codes.")
  @minItems(1)
  presentBodyPartMeasurements?: Array<Fhir.R4.CodeableConcept>;
}

@doc("Findings in a radiology report typically describe abnormalities, lesions, or other notable observations related to the anatomy or pathology of the imaged area.")
model FindingInference extends RadiologyInsightsInference {
  @doc("Inference type.")
  kind: RadiologyInsightsInferenceType.Finding;

  @doc("Finding data : contains extensions, fields and components linked with the finding.")
  finding: Fhir.R4.Observation;
}

@doc("Critical results refer to findings of utmost importance that may require timely attention due to their potential impact on patient care.")
model CriticalResultInference extends RadiologyInsightsInference {
  @doc("Inference type.")
  kind: RadiologyInsightsInferenceType.CriticalResult;

  @doc("The complete Critical Result, as outlined below, will be reused for the recommendation.")
  result: CriticalResult;
}

@doc("Critical Result consists of two properties.")
model CriticalResult {
  @doc("Description : medical problem.")
  description: string;

  @doc("Finding linked to the critical result.")
  finding?: Fhir.R4.Observation;
}

@doc("Radiology procedures are the specific imaging studies or examinations ordered for the patient, extracted from the document information and text.")
model RadiologyProcedureInference extends RadiologyInsightsInference {
  @doc("Inference type.")
  kind: RadiologyInsightsInferenceType.RadiologyProcedure;

  @doc("LOINC codes for the procedure.")
  procedureCodes?: Array<Fhir.R4.CodeableConcept>;

  @minItems(1)
  @doc("Imaging procedures.")
  imagingProcedures: Array<ImagingProcedure>;

  @doc("Ordered procedure information from the document information or text.")
  orderedProcedure: OrderedProcedure;
}

@doc("Follow-up recommendations offer guidance to healthcare providers on managing and monitoring patients based on the findings of imaging studies.")
model FollowupRecommendationInference extends RadiologyInsightsInference {
  @doc("Inference type.")
  kind: RadiologyInsightsInferenceType.FollowupRecommendation;

  @doc("Date and time are displayed when the procedure is recommended to be done at a specific point in time.")
  effectiveAt?: Fhir.R4.fhirDateTime;

  @doc("The period is shown if a specific period is mentioned, with a start and end date-time.")
  effectivePeriod?: Fhir.R4.Period;

  @doc("Findings related to the recommendation.")
  @minItems(1)
  findings?: Array<RecommendationFinding>;

  @doc("The conditional value indicates whether or not the sentence containing the recommendation includes a conditional statement. Keywords for conditional statements include 'if', 'when', 'unless', and so on.")
  isConditional: boolean;

  @doc("The option value indicates whether or not the sentence containing the recommendation includes an optional statement. Keywords for optional statements include 'recommend', 'consider', and so on.")
  isOption: boolean;

  @doc("The guideline value indicates whether or not the recommendation is part of a guideline section that compiles all recommendations applicable to various findings.")
  isGuideline: boolean;

  @doc("Hedging refers to ambiguous, vague or imprecise language within the sentence of the recommendation. Keywords for hedging are 'can be','may be',and so on.")
  isHedging: boolean;

  @doc("The procedure recommendation can be a generic procedure or an imaging procedure.")
  recommendedProcedure: ProcedureRecommendation;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
@doc("The procedure recommendation can be a generic procedure or an imaging procedure.")
@discriminator("kind")
model ProcedureRecommendation {
  ...Fhir.R4.Extendible;
}

@doc("Generic procedure information.")
model GenericProcedureRecommendation extends ProcedureRecommendation {
  @doc("Procedure type : generic.")
  kind: "genericProcedureRecommendation";

  @doc("Procedure modality : SNOMED CT code.")
  code: Fhir.R4.CodeableConcept;

  @doc("Procedure description : MANAGEMENT PROCEDURE (PROCEDURE) or CONSULTATION (PROCEDURE) based on SNOMED CT.")
  description?: string;
}

@doc("Imaging procedures.")
model ImagingProcedureRecommendation extends ProcedureRecommendation {
  @doc("Procedure type : imaging.")
  kind: "imagingProcedureRecommendation";

  @doc("LOINC codes for the procedure.")
  procedureCodes?: Array<Fhir.R4.CodeableConcept>;

  @minItems(1)
  @doc("Imaging procedures.")
  imagingProcedures: Array<ImagingProcedure>;
}

@doc("Imaging procedure.")
model ImagingProcedure {
  @doc("Modality : SNOMED CT code.")
  modality: Fhir.R4.CodeableConcept;

  @doc("Anatomy : SNOMED CT code.")
  anatomy: Fhir.R4.CodeableConcept;

  @doc("Laterality : SNOMED CT code.")
  laterality?: Fhir.R4.CodeableConcept;

  @doc("Contrast : see RadiologyCodeWithTypes (below).")
  contrast?: RadiologyCodeWithTypes;

  @doc("View : see RadiologyCodeWithTypes (below).")
  view?: RadiologyCodeWithTypes;
}

@doc("Radiology code with types : used in imaging procedure recommendation for contrast and view.")
model RadiologyCodeWithTypes {
  @doc("The SNOMED CT code indicates whether imaging was conducted with or without contrast in the case of contrast, and in the case of views, it denotes the number of views.")
  code: Fhir.R4.CodeableConcept;

  @doc("The collection of types will indicate the contrast substance used in the case of contrast and, in the case of views, it will specify the types of views, such as lateral and frontal, etc.")
  types: Array<Fhir.R4.CodeableConcept>;
}

@doc("Finding reference for recommendation.")
model RecommendationFinding {
  @doc("Finding linked to a recommendation.")
  finding?: Fhir.R4.Observation;

  @doc("Critical result linked to a recommendation.")
  criticalFinding?: CriticalResult;

  @doc("Recommendation finding status.")
  recommendationFindingStatus: RecommendationFindingStatusType;

  ...Fhir.R4.Extendible;
}

@doc("Follow-up communication involves the exchange of important information, recommendations, or updates between radiologists and other healthcare professionals involved in a patient's care.")
model FollowupCommunicationInference extends RadiologyInsightsInference {
  @doc("Inference type.")
  kind: RadiologyInsightsInferenceType.FollowupCommunication;

  @doc("Communication date and time.")
  @minItems(1)
  communicatedAt?: Array<utcDateTime>;

  @doc("Recipient of the communication.")
  @minItems(1)
  recipient?: Array<MedicalProfessionalType>;

  @doc("Communication was acknowledged.")
  wasAcknowledged: boolean;
}

// For scoring and assessment:
@doc("Identifies and highlights Risk, Scoring, Assessment and Classifications and correspondent values dictated in a report, e.g. 'BIRADS 5'")
@added(ApiVersion.v2024_10_01)
model ScoringAndAssessmentInference extends RadiologyInsightsInference {
  @doc("Inference type.")
  kind: RadiologyInsightsInferenceType.ScoringAndAssessment;

  @doc("Category, e.g. BIRADS")
  category: ScoringAndAssessmentCategoryType;

  @doc("The expansion of the category (which is an abbreviation.)")
  categoryDescription: string;

  @doc("The value. If the value is a range, use field rangeValue.")
  singleValue?: string;

  @doc("The range.")
  rangeValue?: AssessmentValueRange;
}

@added(ApiVersion.v2024_10_01)
@doc("A range of values.")
model AssessmentValueRange {
  @doc("The minimum value.")
  minimum: string;

  @doc("The maximum value.")
  maximum: string;
}

// For guidance: Clinical Guidance or (Guided) Follow-up Finding

@added(ApiVersion.v2024_10_01)
@doc("A guidance inference collects structured information about a specific finding in the report and can possibly propose appropriate follow-up recommendations, based upon established, evidence-based best practices i.e. ACR guidelines.")
model GuidanceInference extends RadiologyInsightsInference {
  @doc("Inference type.")
  kind: RadiologyInsightsInferenceType.Guidance;

  @doc("The finding associated with the guidance.")
  finding: FindingInference;

  @doc("The guidance identifier, as a concept")
  identifier: Fhir.R4.CodeableConcept;

  @doc("presentGuidanceInformation lists each item of the structured information (e.g. laterality) and corresponding details (left, right, bilateral) that is present in the document.")
  @minItems(1)
  presentGuidanceInformation?: Array<PresentGuidanceInformation>;

  @doc("See doc of GuidanceRankingType.")
  ranking: GuidanceRankingType;

  @doc("The proposed follow-up recommendations, if any. If this is filled, missingGuidanceInformation cannot be filled (and vice versa).")
  @minItems(1)
  recommendationProposals?: Array<FollowupRecommendationInference>;

  @doc("Contains all missing items that are needed to determine follow-up.")
  @minItems(1)
  missingGuidanceInformation?: Array<string>;
}

@added(ApiVersion.v2024_10_01)
@doc("An item of the structured information (e.g. laterality or size) and one or more corresponding details (e.g. left or size-value)")
model PresentGuidanceInformation {
  @doc("The item of the structured information ")
  presentGuidanceItem: string;

  @doc("A list of size values, if the item is about size.")
  @minItems(1)
  sizes?: Array<Fhir.R4.Observation>;

  @doc("The maximum diameter value, if the item is about the maximum diameter.")
  maximumDiameterAsInText?: Fhir.R4.Quantity;

  @doc("The list of item values that are mentioned in the report.")
  @minItems(1)
  presentGuidanceValues?: Array<string>;

  ...Fhir.R4.Extendible;
}

// For quality measure:
@added(ApiVersion.v2024_10_01)
@doc("A QualityMeasure inference captures the  MIPS ('measure based incentive payment system') quality measure criteria in the document that are used to measure the data completeness.")
model QualityMeasureInference extends RadiologyInsightsInference {
  @doc("Inference type.")
  kind: RadiologyInsightsInferenceType.QualityMeasure;

  @doc("The denominator, which identifies the QualityMeasure kind.")
  qualityMeasureDenominator: string;

  @doc("The ComplianceType indicates whether the document is compliant for the specified QualityMeasure or not, or if exceptions apply.")
  complianceType: QualityMeasureComplianceType;

  @doc("List of quality criteria identified in the document, if any. ")
  @minItems(1)
  qualityCriteria?: Array<string>;
}
