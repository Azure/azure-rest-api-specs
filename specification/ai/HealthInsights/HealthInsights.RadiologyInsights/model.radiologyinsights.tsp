import "../HealthInsights.Common/model.common.request.tsp";
import "../HealthInsights.Common/model.common.response.tsp";
import "../HealthInsights.Common/model.common.shared.tsp";
import "../HealthInsights.Common/model.common.fhir.elements.tsp";
import "./model.radiologyinsights.valuesets.tsp";

using TypeSpec.Rest;

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

@resource("radiology-insights/jobs")
@doc("Response for the Radiology Insights request.")
model RadiologyInsightsResult
  is HealthInsightsOperationStatus<RadiologyInsightsInferenceResult>;

@doc("The inference results for the Radiology Insights request. If field 'status' has value 'succeeded', then field 'result' will contain an instance of RadiologyInsightsInferenceResult.")
model RadiologyInsightsInferenceResult {
  @doc("Results for the patients given in the request.")
  patientResults: RadiologyInsightsPatientResult[];

  @doc("The version of the model used for inference, expressed as the model date.")
  modelVersion: ModelVersion;
}

@doc("Results of the model's work for a single patient.")
model RadiologyInsightsPatientResult {
  @doc("Identifier given for the patient in the request.")
  patientId: string;

  @doc("The model's inferences for the given patient.")
  inferences: RadiologyInsightsInference[];
}

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
  missingBodyParts?: Array<Fhir.R4.CodeableConcept>;

  @doc("List of missing body parts that require measurement by a complete order : SNOMED CT codes.")
  missingBodyPartMeasurements?: Array<Fhir.R4.CodeableConcept>;
}

@doc("A limited order discrepancy occurs when there is a limited order, but all body parts and measurements that are needed for a complete order are present in the document.")
model LimitedOrderDiscrepancyInference extends RadiologyInsightsInference {
  @doc("Inference type.")
  kind: RadiologyInsightsInferenceType.LimitedOrderDiscrepancy;

  @doc("Order type : CPT ultrasound complete code for abdomen, retroperitoneal, pelvis or breast.")
  orderType: Fhir.R4.CodeableConcept;

  @doc("List of body parts found in the document : SNOMED CT codes.")
  presentBodyParts?: Array<Fhir.R4.CodeableConcept>;

  @doc("List of body parts that are measured according to the document : SNOMED CT codes.")
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
  effectiveDateTime?: Fhir.R4.fhirDateTime;

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

@doc("The procedure recommendation can be a generic procedure or an imaging procedure.")
@discriminator("kind")
model ProcedureRecommendation {}

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
model RecommendationFinding is Fhir.R4.Extendible {
  @doc("Finding linked to a recommendation.")
  finding?: Fhir.R4.Observation;

  @doc("Critical result linked to a recommendation.")
  criticalFinding?: CriticalResult;

  @doc("Recommendation finding status.")
  recommendationFindingStatus: RecommendationFindingStatusType;
}

@doc("Follow-up communication involves the exchange of important information, recommendations, or updates between radiologists and other healthcare professionals involved in a patient's care.")
model FollowupCommunicationInference extends RadiologyInsightsInference {
  @doc("Inference type.")
  kind: RadiologyInsightsInferenceType.FollowupCommunication;

  @doc("Communication date and time.")
  dateTime?: Array<utcDateTime>;

  @doc("Recipient of the communication.")
  recipient?: Array<MedicalProfessionalType>;

  @doc("Communication was acknowledged.")
  wasAcknowledged: boolean;
}
