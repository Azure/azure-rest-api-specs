import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Versioning;
using Azure.Core;

namespace Language.AnalyzeText;

@doc("Supported parameters for a Healthcare task.")
model HealthcareTaskParameters is PreBuiltTaskParameters {
  @doc("Specifies the method used to interpret string offsets.")
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  @added(Versions.v2023_11_15_preview)
  @doc("The FHIR Spec version that the result will use to format the fhirBundle. For additional information see https://www.hl7.org/fhir/overview.html.")
  fhirVersion?: fhirVersion;

  @added(Versions.v2023_11_15_preview)
  @doc("Document type that can be provided as input for Fhir Documents. Expect to have fhirVersion provided when used. Behavior of using None enum is the same as not using the documentType parameter.")
  documentType?: healthcareDocumentType;
}

@doc("The FHIR Spec version.")
@added(Versions.v2023_11_15_preview)
union fhirVersion {
  string,

  @doc("Version 4.0.1")
  `4.0.1`: "4.0.1",
}

@doc("Document type.")
@added(Versions.v2023_11_15_preview)
union healthcareDocumentType {
  string,

  @doc("None document type")
  None: "None",

  @doc("Clinical trial document type")
  ClinicalTrial: "ClinicalTrial",

  @doc("Discharge summary document type")
  DischargeSummary: "DischargeSummary",

  @doc("Progress note document type")
  ProgressNote: "ProgressNote",

  @doc("History and physical document type")
  HistoryAndPhysical: "HistoryAndPhysical",

  @doc("Consult document type")
  Consult: "Consult",

  @doc("Imaging document type")
  Imaging: "Imaging",

  @doc("Pathology document type")
  Pathology: "Pathology",

  @doc("Procedure note document type")
  ProcedureNote: "ProcedureNote",
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("The long running task to be performed by the service on the Healthcare input documents.")
model HealthcareLROTask extends AnalyzeTextLROTask {
  @doc("Healthcare kind of the long running task.")
  kind: AnalyzeTextLROTaskKind.Healthcare;

  @doc("Parameters for the Healthcare task.")
  parameters?: HealthcareTaskParameters;
}

@doc("Result object for the processed Healthcare task.")
model HealthcareResult is PreBuiltResult {
  @typeChangedFrom(
    Versions.v2023_11_15_preview,
    Array<HealthcareEntitiesDocumentResult>
  )
  @doc("List of result objects for the processed Healthcare documents.")
  documents: Array<HealthcareEntitiesDocumentResultWithDocumentDetectedLanguage>;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type"
@doc("Result object for the processed Healthcare document.")
model HealthcareEntitiesDocumentResult is DocumentResult {
  @doc("Healthcare entities.")
  entities: Array<HealthcareEntity>;

  @doc("Healthcare entity relations.")
  relations: Array<HealthcareRelation>;

  @added(Versions.v2023_11_15_preview)
  @doc("JSON bundle containing a FHIR compatible object for consumption in other Healthcare tools. For additional information see https://www.hl7.org/fhir/overview.html.")
  fhirBundle?: FhirBundle;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type"
@doc("JSON bundle containing a FHIR compatible object for consumption in other Healthcare tools. For additional information see https://www.hl7.org/fhir/overview.html.")
model FhirBundle is Record<unknown>;

@doc("Healthcare entity extracted from the document")
model HealthcareEntity {
  @doc("Entity text as appears in the request.")
  text: string;

  @doc("Healthcare Entity Category.")
  category: healthcareEntityCategory;

  @doc("(Optional) Entity sub type.")
  subcategory?: string;

  @doc("Start position for the entity text. Use of different 'stringIndexType' values can affect the offset returned.")
  offset: int32;

  @doc("Length for the entity text. Use of different 'stringIndexType' values can affect the length returned.")
  length: int32;

  @doc("Confidence score between 0 and 1 of the extracted entity.")
  confidenceScore: float64;

  @doc("Assertion of the entity.")
  assertion?: HealthcareAssertion;

  @doc("Preferred name for the entity. Example: 'histologically' would have a 'name' of 'histologic'.")
  name?: string;

  @doc("Entity references in known data sources.")
  links?: Array<HealthcareEntityLink>;
}

@doc("Healthcare Entity Category.")
union healthcareEntityCategory {
  string,

  @doc("Body structure")
  BodyStructure: "BodyStructure",

  @doc("Age")
  Age: "Age",

  @doc("Gender")
  Gender: "Gender",

  @doc("Examination name")
  ExaminationName: "ExaminationName",

  @doc("Date")
  Date: "Date",

  @doc("Direction")
  Direction: "Direction",

  @doc("Frequency")
  Frequency: "Frequency",

  @doc("Measurement value")
  MeasurementValue: "MeasurementValue",

  @doc("Measurement unit")
  MeasurementUnit: "MeasurementUnit",

  @doc("Relational operator")
  RelationalOperator: "RelationalOperator",

  @doc("Time")
  Time: "Time",

  @doc("Gene or protein")
  GeneOrProtein: "GeneOrProtein",

  @doc("Variant")
  Variant: "Variant",

  @doc("Administrative event")
  AdministrativeEvent: "AdministrativeEvent",

  @doc("Care environment")
  CareEnvironment: "CareEnvironment",

  @doc("Healthcare profession")
  HealthcareProfession: "HealthcareProfession",

  @doc("Diagnosis")
  Diagnosis: "Diagnosis",

  @doc("Symptom or sign")
  SymptomOrSign: "SymptomOrSign",

  @doc("Condition qualifier")
  ConditionQualifier: "ConditionQualifier",

  @doc("Medication class")
  MedicationClass: "MedicationClass",

  @doc("Medication name")
  MedicationName: "MedicationName",

  @doc("Dosage")
  Dosage: "Dosage",

  @doc("Medication form")
  MedicationForm: "MedicationForm",

  @doc("Medication route")
  MedicationRoute: "MedicationRoute",

  @doc("Family relation")
  FamilyRelation: "FamilyRelation",

  @doc("Treatment name")
  TreatmentName: "TreatmentName",

  @doc("Ethnicity")
  @added(Versions.v2023_04_01)
  Ethnicity: "Ethnicity",

  @doc("Course")
  @added(Versions.v2023_04_01)
  Course: "Course",

  @doc("Expression")
  @added(Versions.v2023_04_01)
  Expression: "Expression",

  @doc("Mutation type")
  @added(Versions.v2023_04_01)
  MutationType: "MutationType",

  @doc("Condition scale")
  @added(Versions.v2023_04_01)
  ConditionScale: "ConditionScale",

  @doc("Allergen")
  @added(Versions.v2023_04_01)
  Allergen: "Allergen",

  @doc("Employment")
  @added(Versions.v2023_04_01)
  Employment: "Employment",

  @doc("Living status")
  @added(Versions.v2023_04_01)
  LivingStatus: "LivingStatus",

  @doc("Substance use")
  @added(Versions.v2023_04_01)
  SubstanceUse: "SubstanceUse",

  @doc("Substance use amount")
  @added(Versions.v2023_04_01)
  SubstanceUseAmount: "SubstanceUseAmount",
}

@doc("Every relation is an entity graph of a certain relationType, where all entities are connected and have specific roles within the relation context.")
model HealthcareRelation {
  @doc("Type of relation. Examples include: `DosageOfMedication` or 'FrequencyOfMedication', etc.")
  relationType: relationType;

  @doc("The entities in the relation.")
  entities: Array<HealthcareRelationEntity>;

  @added(Versions.v2023_04_01)
  @doc("Confidence score between 0 and 1 of the extracted relation.")
  confidenceScore?: float64;
}

@doc("Type of relation. Examples include: `DosageOfMedication` or 'FrequencyOfMedication', etc.")
union relationType {
  string,

  @doc("Abbreviation")
  Abbreviation: "Abbreviation",

  @doc("Direction of body structure")
  DirectionOfBodyStructure: "DirectionOfBodyStructure",

  @doc("Direction of condition")
  DirectionOfCondition: "DirectionOfCondition",

  @doc("Direction of examination")
  DirectionOfExamination: "DirectionOfExamination",

  @doc("Direction of treatment")
  DirectionOfTreatment: "DirectionOfTreatment",

  @doc("Dosage of medication")
  DosageOfMedication: "DosageOfMedication",

  @doc("Form of medication")
  FormOfMedication: "FormOfMedication",

  @doc("Frequency of medication")
  FrequencyOfMedication: "FrequencyOfMedication",

  @doc("Frequency of treatment")
  FrequencyOfTreatment: "FrequencyOfTreatment",

  @doc("Qualifier of condition")
  QualifierOfCondition: "QualifierOfCondition",

  @doc("Relation of examination")
  RelationOfExamination: "RelationOfExamination",

  @doc("Route of medication")
  RouteOfMedication: "RouteOfMedication",

  @doc("Time of condition")
  TimeOfCondition: "TimeOfCondition",

  @doc("Time of event")
  TimeOfEvent: "TimeOfEvent",

  @doc("Time of examination")
  TimeOfExamination: "TimeOfExamination",

  @doc("Time of medication")
  TimeOfMedication: "TimeOfMedication",

  @doc("Time of treatment")
  TimeOfTreatment: "TimeOfTreatment",

  @doc("Unit of condition")
  UnitOfCondition: "UnitOfCondition",

  @doc("Unit of examination")
  UnitOfExamination: "UnitOfExamination",

  @doc("Value of condition")
  ValueOfCondition: "ValueOfCondition",

  @doc("Value of examination")
  ValueOfExamination: "ValueOfExamination",

  @doc("Body site of condition")
  @added(Versions.v2023_04_01)
  BodySiteOfCondition: "BodySiteOfCondition",

  @doc("Body site of treatment")
  @added(Versions.v2023_04_01)
  BodySiteOfTreatment: "BodySiteOfTreatment",

  @doc("Course of condition")
  @added(Versions.v2023_04_01)
  CourseOfCondition: "CourseOfCondition",

  @doc("Course of examination")
  @added(Versions.v2023_04_01)
  CourseOfExamination: "CourseOfExamination",

  @doc("Course of medication")
  @added(Versions.v2023_04_01)
  CourseOfMedication: "CourseOfMedication",

  @doc("Course of treatment")
  @added(Versions.v2023_04_01)
  CourseOfTreatment: "CourseOfTreatment",

  @doc("Examination finds condition")
  @added(Versions.v2023_04_01)
  ExaminationFindsCondition: "ExaminationFindsCondition",

  @doc("Expression of gene")
  @added(Versions.v2023_04_01)
  ExpressionOfGene: "ExpressionOfGene",

  @doc("Expression of variant")
  @added(Versions.v2023_04_01)
  ExpressionOfVariant: "ExpressionOfVariant",

  @doc("Frequency of condition")
  @added(Versions.v2023_04_01)
  FrequencyOfCondition: "FrequencyOfCondition",

  @doc("Mutation type of gene")
  @added(Versions.v2023_04_01)
  MutationTypeOfGene: "MutationTypeOfGene",

  @doc("Mutation type of variant")
  @added(Versions.v2023_04_01)
  MutationTypeOfVariant: "MutationTypeOfVariant",

  @doc("Scale of condition")
  @added(Versions.v2023_04_01)
  ScaleOfCondition: "ScaleOfCondition",

  @doc("Variant of gene")
  @added(Versions.v2023_04_01)
  VariantOfGene: "VariantOfGene",
}

@doc("Assertion of the entity.")
model HealthcareAssertion {
  @doc("Describes any conditionality on the entity.")
  conditionality?: Conditionality;

  @doc("Describes the entities certainty and polarity.")
  certainty?: Certainty;

  @doc("Describes if the entity is the subject of the text or if it describes someone else.")
  association?: Association;

  @added(Versions.v2023_11_15_preview)
  @doc("Describes temporal information regarding the entity.")
  temporality?: Temporality;
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
@added(Versions.v2023_11_15_preview)
@doc("Describes temporal information regarding the entity.")
union Temporality {
  @doc("Current temporality")
  current: "current",

  @doc("Past temporality")
  past: "past",

  @doc("Future temporality")
  future: "future",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
@doc("Describes any conditionality on the entity.")
union Conditionality {
  @doc("Hypothetical conditionality")
  hypothetical: "hypothetical",

  @doc("Conditional conditionality")
  conditional: "conditional",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
@doc("Describes the entities certainty and polarity.")
union Certainty {
  @doc("Positive certainty")
  positive: "positive",

  @doc("Possibly positive certainty")
  positivePossible: "positivePossible",

  @doc("Possibly neutral certainty")
  neutralPossible: "neutralPossible",

  @doc("Possibly negative certainty")
  negativePossible: "negativePossible",

  @doc("Negative certainty")
  negative: "negative",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
@doc("Describes if the entity is the subject of the text or if it describes someone else.")
union Association {
  @doc("Subject association")
  subject: "subject",

  @doc("Other association")
  other: "other",
}

@doc("Entity in the relation.")
model HealthcareRelationEntity {
  @doc("Reference link object, using a JSON pointer RFC 6901 (URI Fragment Identifier Representation), pointing to the entity .")
  ref: string;

  @doc("Role of entity in the relationship. For example: 'CD20-positive diffuse large B-cell lymphoma' has the following entities with their roles in parenthesis:  CD20 (GeneOrProtein), Positive (Expression), diffuse large B-cell lymphoma (Diagnosis).")
  role: string;
}

@doc("Reference to an entity in known data sources.")
model HealthcareEntityLink {
  @doc("Entity Catalog. Examples include: UMLS, CHV, MSH, etc.")
  dataSource: string;

  @doc("Entity id in the given source catalog.")
  id: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Healthcare Analyze Text long tunning operation result object.")
model HealthcareLROResult extends AnalyzeTextLROResult {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROResultsKind.HealthcareLROResults;

  @doc("Results of the task.")
  results: HealthcareResult;
}

@added(Versions.v2023_11_15_preview)
@doc("Result object for the processed Healthcare document with detected language.")
model HealthcareEntitiesDocumentResultWithDocumentDetectedLanguage
  is HealthcareEntitiesDocumentResult {
  ...DocumentDetectedLanguage;
}
