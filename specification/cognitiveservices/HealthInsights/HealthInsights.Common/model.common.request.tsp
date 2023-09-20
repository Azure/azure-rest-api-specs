import "./model.common.shared.tsp";

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
  info?: PatientInfo;

  @doc("Patient unstructured clinical data, given as documents.")
  data?: PatientDocument[];
}

@doc("Patient structured information, including demographics and known structured clinical information.")
model PatientInfo {
  @doc("The patient's sex.")
  sex?: PatientInfoSex;

  @doc("The patient's date of birth.")
  birthDate?: plainDate;

  @doc("Known clinical information for the patient, structured.")
  clinicalInfo?: ClinicalCodedElement[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("The patient's sex.")
enum PatientInfoSex {
  Female: "female",
  Male: "male",
  Unspecified: "unspecified",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("The type of the patient document, such as 'note' (text document) or 'fhirBundle' (FHIR JSON document).")
enum DocumentType {
  Note: "note",
  FhirBundle: "fhirBundle",
  Dicom: "dicom",
  GenomicSequencing: "genomicSequencing",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("The type of the clinical document.")
enum ClinicalDocumentType {
  Consultation: "consultation",
  DischargeSummary: "dischargeSummary",
  HistoryAndPhysical: "historyAndPhysical",
  Procedure: "procedure",
  Progress: "progress",
  Imaging: "imaging",
  Laboratory: "laboratory",
  Pathology: "pathology",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("""
The type of the content's source. 
In case the source type is 'inline', the content is given as a string (for instance, text). 
In case the source type is 'reference', the content is given as a URI.
""")
enum DocumentContentSourceType {
  Inline: "inline",
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
  createdDateTime?: utcDateTime;

  @doc("The content of the patient document.")
  content: DocumentContent;
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
