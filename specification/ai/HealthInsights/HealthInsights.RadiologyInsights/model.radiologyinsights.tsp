import "../HealthInsights.Common/model.common.request.tsp";
import "../HealthInsights.Common/model.common.response.tsp";
import "../HealthInsights.Common/model.common.shared.tsp";
import "../HealthInsights.Common/model.common.fhir.elements.tsp";
import "./model.radiologyinsights.valuesets.tsp";

using TypeSpec.Rest;

namespace AzureHealthInsights;

@doc("The body of the Radiology Insights request.")
model RadiologyInsightsData {
  ...Request;

  @doc("Configuration affecting the Radiology Insights model's inference.")
  configuration?: RadiologyInsightsModelConfiguration;
}

@doc("Configuration affecting the Radiology Insights model's inference.")
model RadiologyInsightsModelConfiguration {
  ...ModelConfiguration;

  @doc("""
A list of inference types to be inferred for the current request.
This could be used if only part of the Radiology Insights inferences are required.
If this list is omitted or empty, the model will return all the inference types.
""")
  inferenceTypes?: RadiologyInsightsInferenceType[];

  @doc("The options for the Radiology Insights Inferences")
  inferenceOptions?: RadiologyInsightsInferenceOptions;

  @doc("Local for the model to use. If not specified, the model will use the default locale")
  locale?: string;
}

@doc("The options for the Radiology Insights Inferences")
model RadiologyInsightsInferenceOptions {
  @doc("Followup Recommendation Options")
  followupRecommendation?: FollowupRecommendationOptions;

  @doc("Finding Options")
  finding?: FindingOptions;
}

@doc("Followup Recommendation Options")
model FollowupRecommendationOptions {
  @doc("Include/Exclude followup recommendations with no specific radiologic modality, default is false.")
  includeRecommendationsWithNoSpecifiedModality?: boolean;

  @doc("Include/Exclude followup recommendations in references to a guideline or article, default is false.")
  includeRecommendationsInReferences?: boolean;

  @doc("Provide a single focused sentence as evidence for the recommendation, default is false.")
  provideFocusedSentenceEvidence?: boolean;
}

@doc("Finding Options")
model FindingOptions {
  @doc("Provide a single focused sentence as evidence for the finding, default is false.")
  provideFocusedSentenceEvidence?: boolean;
}

@resource("radiology-insights/jobs")
@doc("The response for the Radiology Insights request.")
model RadiologyInsightsResult
  is HealthInsightsOperationStatus<RadiologyInsightsInferenceResult>;

@doc("The inference results for the Radiology Insights request.")
model RadiologyInsightsInferenceResult {
  @doc("Results for the patients given in the request.")
  patientResults: RadiologyInsightsPatientResult[];

  @doc("The version of the model used for inference, expressed as the model date.")
  modelVersion: ModelVersion;
}

@doc("The results of the model's work for a single patient.")
model RadiologyInsightsPatientResult {
  @doc("The identifier given for the patient in the request.")
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
model RadiologyInsightsInference extends FHIR.R4.Extendible {}

@doc("""
Age mismatch returns when there is a conflict between an age that mentioned in the clinical note and the age of the patient.
The age of the patient is calculated by the date of birth that is set in the patient information along with the time of the service that is being documented.
EvidenceExtension with DocumentReference evidence may be added to this inference as an extension.
""")
model AgeMismatchInference extends RadiologyInsightsInference {
  @doc("The type of the inference.")
  kind: RadiologyInsightsInferenceType.AgeMismatch;
}

@doc("""
Sex mismatch returns when there is a conflict between the patient references (female/male, he/she/his/her), documented clinical procedures, or documented body parts to the patient Sex that mentioned in the patient info.
""")
model SexMismatchInference extends RadiologyInsightsInference {
  @doc("The type of the inference.")
  kind: RadiologyInsightsInferenceType.SexMismatch;

  @doc("sex indication")
  sexIndication: FHIR.R4.CodeableConcept;
}

@doc("""
Laterality discrepancy, returns in 3 different cases:
OrderLateralityMismatch: there is a discrepancy between the text and the procedure/order related to the clinical document.
TextLateralityContradiction: there is a contradiction within the text of the clinical document.
TextLateralityMissing: laterality is missing/not mentioned in the clinical document.
""")
model LateralityDiscrepancyInference extends RadiologyInsightsInference {
  @doc("The type of the inference.")
  kind: RadiologyInsightsInferenceType.LateralityDiscrepancy;

  @doc("laterality indication")
  lateralityIndication?: FHIR.R4.CodeableConcept;

  @doc("mismatch type")
  discrepancyType: LateralityDiscrepancyType;
}

@doc("""
Completed Order mismatch
A complete order requires that all the body parts listed in the order will be document (some body parts requires measurements).
This inference is relevant only for ultrasound procedure/order of type US ABDOMEN, US RETROPERITONEAL, US PELVIS, or US BREAST.
This inference returns when there is a missing body part or a missing measurement of a body part that is required by the order.
""")
model CompleteOrderDiscrepancyInference extends RadiologyInsightsInference {
  @doc("The type of the inference.")
  kind: RadiologyInsightsInferenceType.CompleteOrderDiscrepancy;

  @doc("Order Type.")
  orderType: FHIR.R4.CodeableConcept;

  @doc("""
  List of missing body parts required by a complete order.
  """)
  missingBodyParts?: Array<FHIR.R4.CodeableConcept>;

  @doc("""
  List of missing body parts that require measurement by a complete order.
  """)
  missingBodyPartMeasurements?: Array<FHIR.R4.CodeableConcept>;
}

@doc("""
Limited Order mismatch
A limited order requires that not all the body parts listed in the order will be document.
This inference is relevant only for ultrasound procedure/order of type US ABDOMEN, US RETROPERITONEAL, US PELVIS, or US BREAST.
This inference returns when all body parts and measurement of a body part required by the order, mentioned in the text.
""")
model LimitedOrderDiscrepancyInference extends RadiologyInsightsInference {
  @doc("The type of the inference.")
  kind: RadiologyInsightsInferenceType.LimitedOrderDiscrepancy;

  @doc("Order Type.")
  orderType: FHIR.R4.CodeableConcept;

  @doc("""
  Complete list of body parts found in the document.
  """)
  presentBodyParts?: Array<FHIR.R4.CodeableConcept>;

  @doc("""
  Complete list of body parts that require measurement by a complete order.
  """)
  presentBodyPartMeasurements?: Array<FHIR.R4.CodeableConcept>;
}

@doc("""
Finding Inference
Clinical Finding can be an observation or condition that is mentioned in the clinical document.
""")
model FindingInference extends RadiologyInsightsInference {
  @doc("The type of the inference.")
  kind: RadiologyInsightsInferenceType.Finding;

  @doc("The finding data")
  finding: FHIR.R4.Observation;
}

@doc("""
Identifies and highlights potential Critical Findings found in a clinical document.
""")
model CriticalResultInference extends RadiologyInsightsInference {
  @doc("The type of the inference.")
  kind: RadiologyInsightsInferenceType.CriticalResult;

  @doc("Critical Result")
  result: CriticalResult;
}

@doc("Critical Result")
model CriticalResult {
  @doc("description of the critical result")
  description: string;

  @doc("finding inference")
  finding?: FHIR.R4.Observation;
}

@doc("Procedures found in the document text or associated with the document administrative metadata.")
model RadiologyProcedureInference extends RadiologyInsightsInference {
  @doc("The type of the inference.")
  kind: RadiologyInsightsInferenceType.RadiologyProcedure;

  @doc("The LOINC codes for the procedure.")
  procedureCodes?: Array<FHIR.R4.CodeableConcept>;

  @minItems(1)
  @doc("Imaging procedure.")
  imagingProcedures: Array<ImagingProcedure>;

  @doc("The related procedure information from the document administration information or as extracted from the document.")
  orderedProcedure: OrderedProcedure;
}

@doc("Recommendation Inference")
model FollowupRecommendationInference extends RadiologyInsightsInference {
  @doc("The type of the inference.")
  kind: RadiologyInsightsInferenceType.FollowupRecommendation;

  @doc("Clinically relevant time/time-period for recommendation")
  effectiveDateTime?: FHIR.R4.fhirDateTime;

  @doc("Clinically relevant time/time-period for recommendation")
  effectivePeriod?: FHIR.R4.Period;

  @doc("Findings related to this recommendation.")
  @minItems(1)
  findings?: Array<RecommendationFinding>;

  @doc("""
  Indicate that the sentence with the recommendation holds a conditional statement.
  Examples of conditional phrases: If the patient remains clinically symptomatic, Unless otherwise indicated clinically in the interim.
  """)
  isConditional: boolean;

  @doc("""
  Indicate that the sentence with the recommendation holds an optional statement.
  Examples of Optional phrases: 'If there is suspicion for a fracture, recommend a dedicated x-ray of the right clavicle.
  Consider F/U exam in 6-12 months if patient has severe primary hyperparathyroidism, is being treated with high dose steroids or in any medical condition where rapid and severe loss of bone mass could occur.
  If the patient is high risk, follow-up CT thorax is recommended in 12 months to ensure stability.
  """)
  isOption: boolean;

  @doc("Recommendation is a guideline section describing all the recommendations for the follow-up of a particular finding.")
  isGuideline: boolean;

  @doc("""
  Ambiguous, vague, or imprecise language, that can be considered a Hedging Statement within the sentence of the recommendation.
  Examples of hedging: 'can be considered', 'may be further evaluated', 'correlate clinically', 'as clinically indicated'.
  """)
  isHedging: boolean;

  @doc("Recommended procedure.")
  recommendedProcedure: ProcedureRecommendation;
}

@doc("Radiology Insights abstract procedure.")
@discriminator("kind")
model ProcedureRecommendation {}

@doc("Generic procedure information.")
model GenericProcedureRecommendation extends ProcedureRecommendation {
  @doc("The type of the procedure.")
  kind: "genericProcedureRecommendation";

  @doc("The procedure modality")
  code: FHIR.R4.CodeableConcept;

  @doc("The procedure description")
  description?: string;
}

@doc("Radiology procedure.")
model ImagingProcedureRecommendation extends ProcedureRecommendation {
  @doc("The type of the procedure.")
  kind: "imagingProcedureRecommendation";

  @doc("The LOINC codes for the procedure.")
  procedureCodes?: Array<FHIR.R4.CodeableConcept>;

  @minItems(1)
  @doc("Imaging procedure.")
  imagingProcedures: Array<ImagingProcedure>;
}

@doc("Order Procedure - is this always a radiology procedure?")
model ImagingProcedure {
  @doc("The procedure modality")
  modality: FHIR.R4.CodeableConcept;

  @doc("The procedure anatomy")
  anatomy: FHIR.R4.CodeableConcept;

  @doc("The procedure laterality")
  laterality?: FHIR.R4.CodeableConcept;

  @doc("The procedure contrast")
  contrast?: RadiologyCodeWithTypes;

  @doc("The procedure view")
  view?: RadiologyCodeWithTypes;
}

@doc("Code with types")
model RadiologyCodeWithTypes {
  @doc("Code")
  code: FHIR.R4.CodeableConcept;

  @doc("Collection of types")
  types: Array<FHIR.R4.CodeableConcept>;
}

@doc("Recommendation Finding - finding reference for recommendation")
model RecommendationFinding extends FHIR.R4.Extendible {
  @doc("finding inference")
  finding?: FHIR.R4.Observation;

  @doc("critical finding inference")
  criticalFinding?: CriticalResult;

  @doc("recommendation finding status")
  recommendationFindingStatus: RecommendationFindingStatusType;
}

@doc("Communication Inference")
model FollowupCommunicationInference extends RadiologyInsightsInference {
  @doc("The type of the inference.")
  kind: RadiologyInsightsInferenceType.FollowupCommunication;

  @doc("The communication date/time.")
  dateTime?: Array<utcDateTime>;

  @doc("The recipient of the communication.")
  recipient?: Array<MedicalProfessionalType>;

  @doc("Communication was acknowledged")
  wasAcknowledged: boolean;
}
