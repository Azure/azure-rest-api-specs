using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace AzureHealthInsights;

@doc("Provides status details for long running operations.")
model HealthInsightsJobBase {
  @key("id")
  @doc("The unique ID of the job.")
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]+[a-zA-Z0-9]$")
  id: string;

  @doc("The status of the job.")
  @visibility(Lifecycle.Read)
  @lroStatus
  status: JobStatus;

  @doc("The date and time when the processing job was created.")
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  @doc("The date and time when the processing job is set to expire.")
  @visibility(Lifecycle.Read)
  expiresAt?: utcDateTime;

  @doc("The date and time when the processing job was last updated.")
  @visibility(Lifecycle.Read)
  updatedAt?: utcDateTime;

  @doc("Error object that describes the error when status is \"Failed\".")
  @visibility(Lifecycle.Read)
  error?: Foundations.Error;
}

@doc("ConditionStage")
model ConditionStage {
  @doc("""
      Simple summary (disease specific)
      see: https://www.hl7.org/fhir/valueset-condition-stage.html
    """)
  summary: Fhir.R4.CodeableConcept;

  @doc("""
    Kind of staging
    see: https://www.hl7.org/fhir/valueset-condition-stage-kind.html
    """)
  type?: Fhir.R4.CodeableConcept;
}

@doc("InterpretationType ")
union InterpretationType {
  string,

  @doc("Normal")
  Normal: "normal",

  @doc("Abnormal")
  Abnormal: "abnormal",

  @doc("Below normal")
  Low: "low",

  @doc("Above normal")
  High: "high",

  @doc("Better")
  Better: "better",

  @doc("Worse")
  Worse: "worse",

  @doc("Resistant")
  Resistant: "resistant",

  @doc("Susceptible")
  Susceptible: "susceptible",

  @doc("As Expected")
  Expected: "expected",

  @doc("Not as Expected")
  NotExpected: "notExpected",
}

@doc("""
  ObservationStatusType based on FHIR valueset observation-status
  see: https://www.hl7.org/fhir/codesystem-observation-status.html
  """)
union ObservationStatusType {
  string,

  @doc("The existence of the observation is registered, but there is no result yet available.")
  Registered: "registered",

  @doc("This is an initial or interim observation: data may be incomplete or unverified.")
  Preliminary: "preliminary",

  @doc("""
    The observation is complete and there are no further actions needed. Additional information such as 'released', 'signed', etc would be represented using [Provenance](provenance.html) which provides not only the act but also the actors and dates and other related data.
    These act states would be associated with an observation status of `preliminary` until they are all completed and then a status of `final` would be applied.
    """)
  Final: "final",

  @doc("Subsequent to being Final, the observation has been modified subsequent.  This includes updates/new information and corrections.")
  Amended: "amended",

  @doc("Subsequent to being Final, the observation has been modified to correct an error in the test result.")
  Corrected: "corrected",

  @doc("The observation is unavailable because the measurement was not started or not completed (also sometimes called \"aborted\").")
  Cancelled: "cancelled",

  @doc("The observation has been withdrawn following previous final release.  This electronic record should never have existed, though it is possible that real-world decisions were based on it. (If real-world activity has occurred, the status should be \"cancelled\" rather than \"entered-in-error\".)")
  EnteredInError: "enteredInError",

  @doc("The authoring/source system does not know which of the status values currently applies for this observation. Note: This concept is not to be used for \"other\" - one of the listed statuses is presumed to apply, but the authoring/source system does not know which.")
  Unknown: "unknown",
}

@doc("""
  ConditionDiagnosisSeverityType based on SNOMED CT International edition 31-July 2022
  see: http://snomed.info/sct
  """)
union ConditionDiagnosisSeverityType {
  string,

  @doc("Severe ( http://snomed.info/sct#24484000 ))")
  Severe: "severe",

  @doc("Moderate ( http://snomed.info/sct#6736007 ))")
  Moderate: "moderate",

  @doc("Mild ( http://snomed.info/sct#255604002 ))")
  Mild: "mild",
}

@doc("""
  ConditionCategoryType based on FHIR valueset condition-category
  """)
union ConditionCategoryType {
  string,

  @doc("An item on a problem list that can be managed over time and can be expressed by a practitioner (e.g. physician, nurse), patient or related person.")
  ProblemListItem: "problemListItem",

  @doc("A point in time diagnosis (e.g. from a physician or nurse) in context of an encounter.")
  EncounterDiagnosis: "encounterDiagnosis",
}

@doc("""
  VerificationStatusType based of FHIR valueset condition-ver-status.
  see: https://terminology.hl7.org/5.1.0/CodeSystem-condition-ver-status.html
  """)
union VerificationStatusType {
  string,

  @doc("There is not sufficient diagnostic and/or clinical evidence to treat this as a confirmed condition.")
  Unconfirmed: "unconfirmed",

  @doc("This is a tentative diagnosis - still a candidate that is under consideration.")
  Provisional: "provisional",

  @doc("One of a set of potential (and typically mutually exclusive) diagnoses asserted to further guide the diagnostic process and preliminary treatment.")
  Differential: "differential",

  @doc("There is sufficient diagnostic and/or clinical evidence to treat this as a confirmed condition.")
  Confirmed: "confirmed",

  @doc("This condition has been ruled out by diagnostic and clinical evidence.")
  Refuted: "refuted",

  @doc("The statement was entered in error and is not valid.")
  EnteredInError: "enteredInError",
}

@doc("""
  A location given as a combination of city, state and country/region. It could specify a city, a state or a country/region.
  In case a city is specified, either state +country/region or country/region (for countries/regions where there are no states) should be added.
  In case a state is specified (without a city), country/region should be added.
  """)
model GeographicLocation {
  @doc("City name.")
  city?: string;

  @doc("State name.")
  state?: string;

  @doc("Country/region name.")
  countryOrRegion: string;
}

@doc("A duration of time during which an event is happening")
model TimePeriod {
  @doc("Starting time with inclusive boundary")
  start?: utcDateTime;

  @doc("End time with inclusive boundary, if not ongoing")
  end?: utcDateTime;
}

@doc("Procedure information")
model OrderedProcedure {
  @doc("Procedure code")
  code?: Fhir.R4.CodeableConcept;

  @doc("Procedure description")
  description?: string;

  ...Fhir.R4.Extendible;
}

@doc("""
  A piece of clinical information, expressed as a code in a clinical coding system.
  """)
model ClinicalCodedElement {
  @doc("The clinical coding system, e.g. ICD-10, SNOMED-CT, UMLS.")
  system: string;

  @doc("The code within the given clinical coding system.")
  code: string;

  @doc("The name of this coded concept in the coding system.")
  name?: string;

  @doc("A value associated with the code within the given clinical coding system.")
  value?: string;
}

alias BodyParameter<
  T,
  TName extends valueof string = "body",
  TDoc extends valueof string = "Body parameter."
> = {
  #suppress "@azure-tools/typespec-azure-core/friendly-name" "Legacy"
  @doc(TDoc)
  @friendlyName(TName)
  @bodyRoot
  body: T;
};
