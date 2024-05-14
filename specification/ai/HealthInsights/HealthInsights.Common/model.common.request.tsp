import "./model.common.shared.tsp";
import "./model.common.fhir.elements.tsp";
import "./model.common.fhir.resources.tsp";

using TypeSpec.Rest;

namespace AzureHealthInsights;

alias Request = {
  @doc("The list of patients, including their clinical information and data.")
  patients: PatientRecord[];
};

alias ModelConfiguration = {
  @doc("An indication whether the model should produce verbose output.")
  verbose?: boolean = false;

  @doc("An indication whether the model's output should include evidence for the inferences.")
  includeEvidence?: boolean = true;
};

@doc("A patient record, including their clinical information and data.")
model PatientRecord {
  @doc("""
A given identifier for the patient. Has to be unique across all patients in a single request.
""")
  @minLength(1)
  id: string;

  @doc("""
Patient structured information, including demographics and known structured clinical information.
""")
  details?: PatientDetails;

  @doc("Patient encounters/visits.")
  encounters?: Array<PatientEncounter>;

  @doc("Patient unstructured clinical data, given as documents.")
  patientDocuments?: Array<PatientDocument>;
}

@doc("Patient structured information, including demographics and known structured clinical information.")
model PatientDetails {
  @doc("The patient's sex.")
  sex?: PatientSex;

  @doc("The patient's date of birth.")
  birthDate?: plainDate;

  @doc("Known clinical information for the patient, structured.")
  clinicalInfo?: Array<Fhir.R4.Resource>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("The patient's sex.")
union PatientSex {
  string,
  Female: "female",
  Male: "male",
  Unspecified: "unspecified",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("The type of the patient document, such as 'note' (text document) or 'fhirBundle' (FHIR JSON document).")
union DocumentType {
  string,
  Note: "note",
  FhirBundle: "fhirBundle",
  Dicom: "dicom",
  GenomicSequencing: "genomicSequencing",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("The type of the clinical document.")
union ClinicalDocumentType {
  string,
  Consultation: "consultation",
  DischargeSummary: "dischargeSummary",
  HistoryAndPhysical: "historyAndPhysical",
  RadiologyReport: "radiologyReport",
  Procedure: "procedure",
  Progress: "progress",
  Laboratory: "laboratory",
  PathologyReport: "pathologyReport",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("""
The type of the content's source.
In case the source type is 'inline', the content is given as a string (for instance, text).
In case the source type is 'reference', the content is given as a URI.
""")
union DocumentContentSourceType {
  string,

  @doc("The content is given as a string (for instance, text).")
  Inline: "inline",

  @doc("The content is given as a URI.")
  Reference: "reference",
}

@doc("A clinical document related to a patient. Document here is in the wide sense - not just a text document (note).")
model PatientDocument {
  @doc("The type of the patient document, such as 'note' (text document) or 'fhirBundle' (FHIR JSON document).")
  type: DocumentType;

  @doc("The type of the clinical document.")
  clinicalType?: ClinicalDocumentType;

  @doc("A given identifier for the document. Has to be unique across all documents for a single patient.")
  @minLength(1)
  id: string;

  @doc("A 2 letter ISO 639-1 representation of the language of the document.")
  language?: string;

  @doc("The date and time when the document was created.")
  createdAt?: utcDateTime;

  @doc("Document author(s)")
  @minItems(1)
  authors?: Array<DocumentAuthor>;

  @doc("specialty type the document")
  specialtyType?: SpecialtyType;

  @doc("Administrative metadata for the document.")
  administrativeMetadata?: DocumentAdministrativeMetadata;

  @doc("The content of the patient document.")
  content: DocumentContent;
}

@doc("Document administrative metadata")
model DocumentAdministrativeMetadata {
  @doc("List of procedure information associated with the document.")
  @minItems(1)
  orderedProcedures?: Array<OrderedProcedure>;

  @doc("Reference to the encounter associated with the document.")
  encounterId?: string;
}

@doc("visit/encounter information")
model PatientEncounter {
  @doc("The id of the visit.")
  @minLength(1)
  id: string;

  @doc("""
  Time period of the visit.
  In case of admission, use timePeriod.start to indicate the admission time and timePeriod.end to indicate the discharge time.
  """)
  period?: TimePeriod;

  @doc("The class of the encounter.")
  class?: EncounterClass;
}

@doc("Known values codes that can be used to indicate the class of encounter (TODO://Based on FHIR value set--http://....).")
union EncounterClass {
  string,

  @doc("""
  A patient encounter where a patient is admitted by a hospital or equivalent facility, assigned to a location where patients generally stay at least overnight and provided with room, board, and continuous nursing service.
  """)
  InPatient: "inpatient",

  @doc("""
  The term ambulatory usually implies that the patient has come to the location and is not assigned to a bed. Sometimes referred to as an outpatient encounter.
  """)
  Ambulatory: "ambulatory",

  @doc("""
  An encounter where the patient usually will start in different encounter, such as one in the emergency department but then transition to this type of encounter because they require a significant period of treatment and monitoring to determine whether or not their condition warrants an inpatient admission or discharge.
  """)
  Observation: "observation",

  @doc("""
  A patient encounter that takes place at a dedicated healthcare service delivery location where the patient receives immediate evaluation and treatment, provided until the patient can be discharged or responsibility for the patient's care is transferred elsewhere (for example, the patient could be admitted as an inpatient or transferred to another facility.
  """)
  Emergency: "emergency",

  @doc("""
  A patient encounter where the patient is not physically present for the encounter, such as in a telehealth encounter, phone call, or electronic communication.
  """)
  Virtual: "virtual",

  @doc("""
  Healthcare encounter that takes place in the residence of the patient or a designee
  """)
  HealthHome: "healthHome",
}

@doc("Known values codes that can be used to indicate the type of the Specialty.")
union SpecialtyType {
  string,

  @doc("pathology")
  Pathology: "pathology",

  @doc("radiology")
  Radiology: "radiology",
}

@doc("Document author")
model DocumentAuthor {
  @doc("author id")
  id?: string;

  @doc("Text representation of the full name")
  fullName?: string;
}

@doc("The content of the patient document.")
model DocumentContent {
  @doc("""
The type of the content's source.
In case the source type is 'inline', the content is given as a string (for instance, text).
In case the source type is 'reference', the content is given as a URI.
""")
  sourceType: DocumentContentSourceType;

  @doc("""
The content of the document, given either inline (as a string) or as a reference (URI).
""")
  value: string;
}
