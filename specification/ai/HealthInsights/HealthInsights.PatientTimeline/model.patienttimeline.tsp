import "../HealthInsights.Common/model.common.request.tsp";
import "../HealthInsights.Common/model.common.response.tsp";
import "../HealthInsights.Common/model.common.shared.tsp";
import "../HealthInsights.Common/model.common.fhir.elements.tsp";
import "../HealthInsights.Common/model.common.fhir.resources.tsp";

using TypeSpec.Rest;

namespace AzureHealthInsights;

@doc("The body of the Patient Timeline request.")
model PatientTimelineData {
  ...Request;

  @doc("Configuration affecting the Patient Timeline model's inference.")
  configuration?: PatientTimelineModelConfiguration;
}

@doc("Configuration affecting the Patient Timeline model's inference.")
model PatientTimelineModelConfiguration {
  ...ModelConfiguration;
}

@resource("patient-timeline/jobs")
@doc("The response for the Patient Timeline request.")
model PatientTimelineResult
  is HealthInsightsOperationStatus<PatientTimelineInferenceResult>;

@doc("The inference results for the Patient Timeline request.")
model PatientTimelineInferenceResult {
  @doc("Results for the patients given in the request.")
  patientResults: PatientTimelinePatientResult[];

  @doc("The version of the model used for inference, expressed as the model date.")
  modelVersion: ModelVersion;
}

@doc("The results of the model's work for a single patient.")
model PatientTimelinePatientResult {
  @doc("The identifier given for the patient in the request.")
  patientId: string;

  @doc("The model's inferences for the given patient.")
  inferences: Array<PatientTimelineInference>;
}

@doc("An inference made by the Patient Timeline model regarding a patient.")
model PatientTimelineInference is Fhir.R4.Extendible {
  @doc("The type of the Patient Timeline inference.")
  type: PatientTimelineInferenceType;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
  @doc("""
  FHIR 4.0 representation of the piece of clinical info.
  additional dependent resources maybe contained (e.g. MedicationStatement may contain Medication)
  -- In the SDK we will have custom mapping to map this type to JsonObject
  """)
  resource?: Fhir.R4.DomainResource;

  @doc("Time range relevant to this Timeline inference.")
  period?: TimePeriod;
}

@doc("The type of the Patient Timeline inference.")
union PatientTimelineInferenceType {
  string,

  @doc("The inference is a timeline event.")
  TimelineEvent: "timelineEvent",

  @doc("The inference is a summary item.")
  SummaryItem: "summaryItem",
}
