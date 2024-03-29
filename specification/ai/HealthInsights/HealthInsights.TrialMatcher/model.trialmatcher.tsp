import "../HealthInsights.Common/model.common.request.tsp";
import "../HealthInsights.Common/model.common.response.tsp";
import "../HealthInsights.Common/model.common.shared.tsp";
import "../HealthInsights.Common/model.common.fhir.elements.tsp";

using TypeSpec.Rest;

namespace AzureHealthInsights;

@doc("The body of the Trial Matcher request.")
model TrialMatcherData {
  ...Request;

  @doc("Configuration affecting the Trial Matcher model's inference.")
  configuration?: TrialMatcherModelConfiguration;
}

@doc("Configuration affecting the Trial Matcher model's inference.")
model TrialMatcherModelConfiguration {
  ...ModelConfiguration;

  @doc("""
The clinical trials that the patient(s) should be matched to. <br />The trial
selection can be given as a list of custom clinical trials and/or a list of
filters to known clinical trial registries. In case both are given, the
resulting trial set is a union of the two sets.
""")
  clinicalTrials: ClinicalTrials;
}

@resource("trial-matcher/jobs")
@doc("The response for the Trial Matcher request.")
model TrialMatcherResult
  is HealthInsightsOperationStatus<TrialMatcherInferenceResult>;

@doc("The inference results for the Trial Matcher request.")
model TrialMatcherInferenceResult {
  @doc("Results for the patients given in the request.")
  patientResults: TrialMatcherPatientResult[];

  @doc("The version of the model used for inference, expressed as the model date.")
  modelVersion: ModelVersion;

  @doc("The date when the clinical trials knowledge graph was last updated.")
  knowledgeGraphLastUpdateDate?: plainDate;
}

@doc("Clinical information which is needed to provide better trial matching results for the patient.")
model NeededClinicalInfo is ExtendedClinicalCodedElement[];

@doc("""
A piece of clinical information, expressed as a code in a clinical coding system, extended by semantic information.
""")
model ExtendedClinicalCodedElement {
  ...ClinicalCodedElement;

  @doc("""
The [UMLS semantic type](https://www.nlm.nih.gov/research/umls/META3_current_semantic_types.html) associated with the coded concept.
""")
  semanticType?: string;

  @doc("""
The bio-medical category related to the coded concept, e.g. Diagnosis, Symptom, Medication, Examination.
""")
  category?: string;
}

@doc("The results of the model's work for a single patient.")
model TrialMatcherPatientResult {
  @doc("The identifier given for the patient in the request.")
  patientId: string;

  @doc("The inference results for the patient.")
  inferences: Array<TrialMatcherInference>;

  @doc("""
  Clinical information which is needed to provide better trial matching results for the patient.
  """)
  neededClinicalInfo?: NeededClinicalInfo;
}

@doc("A piece of evidence corresponding to a Trial Matcher inference.")
model TrialMatcherInferenceEvidence {
  @doc("A piece of evidence from the eligibility criteria text of a clinical trial.")
  eligibilityCriteriaEvidence?: string;

  ...InferenceEvidence;
}

@doc("An inference made by the Trial Matcher model regarding a patient.")
model TrialMatcherInference {
  @doc("The type of the Trial Matcher inference.")
  type: TrialMatcherInferenceType;

  ...Inference;

  @doc("The evidence corresponding to the inference value.")
  evidence?: TrialMatcherInferenceEvidence[];

  @doc("The identifier of the clinical trial.")
  @minLength(1)
  clinicalTrialId?: string;

  @doc("Possible sources of a clinical trial.")
  source?: ClinicalTrialSource;

  @doc("Trial data which is of interest to the potential participant.")
  metadata?: ClinicalTrialMetadata;
}

@doc("""
The clinical trials that the patient(s) should be matched to.
The trial selection can be given as a list of custom clinical trials and/or a list of filters to known clinical trial registries.
In case both are given, the resulting trial set is a union of the two sets.
""")
model ClinicalTrials {
  @doc("A list of clinical trials.")
  @minItems(1)
  customTrials?: Array<Fhir.R4.ResearchStudy>;

  @doc("""
  A list of filters, each one creating a selection of trials from a given
  clinical trial registry.
  """)
  @minItems(1)
  registryFilters?: ClinicalTrialRegistryFilter[];
}

@doc("""
A filter defining a subset of clinical trials from a given clinical trial registry (e.g. clinicaltrials.gov).
""")
model ClinicalTrialRegistryFilter {
  @doc("""
Trials with any of the given medical conditions will be included in the selection (provided that other limitations are satisfied).
Leaving this list empty will not limit the medical conditions.
""")
  conditions?: string[];

  @doc("""
Trials with any of the given study types will be included in the selection (provided that other limitations are satisfied).
Leaving this list empty will not limit the study types.
""")
  studyTypes?: ClinicalTrialStudyType[];

  @doc("""
Trials with any of the given recruitment statuses will be included in the selection (provided that other limitations are satisfied).
Leaving this list empty will not limit the recruitment statuses.
""")
  recruitmentStatuses?: ClinicalTrialRecruitmentStatus[];

  @doc("""
Trials with any of the given sponsors will be included in the selection (provided that other limitations are satisfied).
Leaving this list empty will not limit the sponsors.
""")
  sponsors?: string[];

  @doc("""
Trials with any of the given phases will be included in the selection (provided that other limitations are satisfied).
Leaving this list empty will not limit the phases.
""")
  phases?: ClinicalTrialPhase[];

  @doc("""
Trials with any of the given purposes will be included in the selection (provided that other limitations are satisfied).
Leaving this list empty will not limit the purposes.
""")
  purposes?: ClinicalTrialPurpose[];

  @doc("""
Trials with any of the given identifiers will be included in the selection (provided that other limitations are satisfied).
Leaving this list empty will not limit the trial identifiers.
""")
  ids?: string[];

  @doc("""
Trials with any of the given sources will be included in the selection (provided that other limitations are satisfied).
Leaving this list empty will not limit the sources.
""")
  sources?: ClinicalTrialSource[];

  @doc("""
Trials with any of the given facility names will be included in the selection (provided that other limitations are satisfied).
Leaving this list empty will not limit the trial facility names.
""")
  facilityNames?: string[];

  @doc("""
Trials with any of the given facility locations will be included in the selection (provided that other limitations are satisfied).
Leaving this list empty will not limit the trial facility locations.
""")
  facilityLocations?: GeographicLocation[];

  @doc("""
Trials with any of the given facility area boundaries will be included in the selection (provided that other limitations are satisfied).
Leaving this list empty will not limit the trial facility area boundaries.
""")
  facilityAreas?: GeographicArea[];
}

@doc("""
A geographic area, expressed as a `Circle` geometry represented using a `GeoJSON Feature` (see [GeoJSON spec](https://tools.ietf.org/html/rfc7946)).
""")
model GeographicArea {
  @doc("`GeoJSON` type.")
  type: GeoJsonType;

  @doc("`GeoJSON` geometry, representing the area circle's center.")
  geometry: AreaGeometry;

  @doc("`GeoJSON` object properties.")
  properties: AreaProperties;
}

@doc("`GeoJSON` geometry, representing the area circle's center.")
model AreaGeometry {
  @doc("`GeoJSON` geometry type.")
  type: GeoJsonGeometryType;

  @doc("""
Coordinates of the area circle's center, represented according to the `GeoJSON` standard.
This is an array of 2 decimal numbers, longitude and latitude (precisely in this order).
""")
  @minItems(2)
  @maxItems(2)
  coordinates: float32[];
}

@doc("`GeoJSON` object properties.")
model AreaProperties {
  @doc("`GeoJSON` object sub-type.")
  subType: GeoJsonPropertiesSubType;

  @doc("The radius of the area's circle, in meters.")
  @minValueExclusive(0.0)
  radius: float64;
}

@doc("Trial data which is of interest to the potential participant.")
model ClinicalTrialMetadata {
  @doc("""
Phases which are relevant for the clinical trial.
Each clinical trial can be in a certain phase or in multiple phases.
""")
  phases?: ClinicalTrialPhase[];

  @doc("Possible study types of a clinical trial.")
  studyType?: ClinicalTrialStudyType;

  @doc("Possible recruitment status of a clinical trial.")
  recruitmentStatus?: ClinicalTrialRecruitmentStatus;

  @doc("""
Medical conditions and their synonyms which are relevant for the clinical trial, given as strings.
""")
  @minItems(1)
  conditions: string[];

  @doc("Sponsors/collaborators involved with the trial.")
  sponsors?: string[];

  @doc("""
Contact details of the trial administrators, for patients that want to participate in the trial.
""")
  contacts?: ContactDetails[];

  @doc("Research facilities where the clinical trial is conducted.")
  facilities?: ClinicalTrialResearchFacility[];
}

@doc("A person's contact details.")
model ContactDetails {
  @doc("The person's name.")
  name?: string;

  @doc("The person's email.")
  email?: string;

  @doc("A person's phone number.")
  phone?: string;
}

@doc("Details of a research facility where a clinical trial is conducted.")
model ClinicalTrialResearchFacility {
  @doc("The facility's name.")
  name: string;

  ...GeographicLocation;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("Possible phases of a clinical trial.")
union ClinicalTrialPhase {
  string,
  NotApplicable: "notApplicable",
  EarlyPhase1: "earlyPhase1",
  Phase1: "phase1",
  Phase2: "phase2",
  Phase3: "phase3",
  Phase4: "phase4",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("Possible study types of a clinical trial.")
union ClinicalTrialStudyType {
  string,
  Interventional: "interventional",
  Observational: "observational",
  ExpandedAccess: "expandedAccess",
  PatientRegistries: "patientRegistries",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("Possible recruitment status of a clinical trial.")
union ClinicalTrialRecruitmentStatus {
  string,
  UnknownStatus: "unknownStatus",
  NotYetRecruiting: "notYetRecruiting",
  Recruiting: "recruiting",
  EnrollingByInvitation: "enrollingByInvitation",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("Possible purposes of a clinical trial.")
union ClinicalTrialPurpose {
  string,
  NotApplicable: "notApplicable",
  Screening: "screening",
  Diagnostic: "diagnostic",
  Prevention: "prevention",
  HealthServicesResearch: "healthServicesResearch",
  Treatment: "treatment",
  DeviceFeasibility: "deviceFeasibility",
  SupportiveCare: "supportiveCare",
  BasicScience: "basicScience",
  Other: "other",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("Possible sources of a clinical trial.")
union ClinicalTrialSource {
  string,
  Custom: "custom",
  ClinicaltrialsGov: "clinicaltrials.gov",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("`GeoJSON` type.")
union GeoJsonType {
  string,
  Feature: "Feature",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("`GeoJSON` geometry type.")
union GeoJsonGeometryType {
  string,
  Point: "Point",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("`GeoJSON` object sub-type.")
union GeoJsonPropertiesSubType {
  string,
  Circle: "Circle",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("The type of the Trial Matcher inference.")
union TrialMatcherInferenceType {
  string,
  TrialEligibility: "trialEligibility",
}
