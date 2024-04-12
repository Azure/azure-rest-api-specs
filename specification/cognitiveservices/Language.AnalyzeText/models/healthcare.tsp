import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using Azure.Core;

namespace Language.AnalyzeText;

@doc("Supported parameters for a Healthcare task.")
@clientName("HealthcareTaskContent", "csharp")
model HealthcareTaskParameters is PreBuiltTaskParameters {
  @doc("Specifies the method used to interpret string offsets.")
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  `4.0.1`: "4.0.1",
}

@doc("Document type.")
@added(Versions.v2023_11_15_preview)
union healthcareDocumentType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ClinicalTrial: "ClinicalTrial",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DischargeSummary: "DischargeSummary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ProgressNote: "ProgressNote",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HistoryAndPhysical: "HistoryAndPhysical",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Consult: "Consult",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Imaging: "Imaging",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Pathology: "Pathology",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
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

@doc("Result object for the processed Healthcare document.")
model HealthcareEntitiesDocumentResult is DocumentResult {
  @doc("Healthcare entities.")
  entities: Array<HealthcareEntity>;

  @doc("Healthcare entity relations.")
  relations: Array<HealthcareRelation>;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type"
  @added(Versions.v2023_11_15_preview)
  @doc("JSON bundle containing a FHIR compatible object for consumption in other Healthcare tools. For additional information see https://www.hl7.org/fhir/overview.html.")
  fhirBundle?: Record<unknown>;
}

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
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BodyStructure: "BodyStructure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Age: "Age",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Gender: "Gender",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ExaminationName: "ExaminationName",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Date: "Date",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Direction: "Direction",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Frequency: "Frequency",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MeasurementValue: "MeasurementValue",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MeasurementUnit: "MeasurementUnit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  RelationalOperator: "RelationalOperator",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Time: "Time",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  GeneOrProtein: "GeneOrProtein",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Variant: "Variant",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AdministrativeEvent: "AdministrativeEvent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CareEnvironment: "CareEnvironment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HealthcareProfession: "HealthcareProfession",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Diagnosis: "Diagnosis",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SymptomOrSign: "SymptomOrSign",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ConditionQualifier: "ConditionQualifier",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MedicationClass: "MedicationClass",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MedicationName: "MedicationName",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Dosage: "Dosage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MedicationForm: "MedicationForm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MedicationRoute: "MedicationRoute",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FamilyRelation: "FamilyRelation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TreatmentName: "TreatmentName",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  Ethnicity: "Ethnicity",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  Course: "Course",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  Expression: "Expression",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  MutationType: "MutationType",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  ConditionScale: "ConditionScale",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  Allergen: "Allergen",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  Employment: "Employment",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  LivingStatus: "LivingStatus",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  SubstanceUse: "SubstanceUse",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Abbreviation: "Abbreviation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DirectionOfBodyStructure: "DirectionOfBodyStructure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DirectionOfCondition: "DirectionOfCondition",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DirectionOfExamination: "DirectionOfExamination",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DirectionOfTreatment: "DirectionOfTreatment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DosageOfMedication: "DosageOfMedication",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FormOfMedication: "FormOfMedication",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FrequencyOfMedication: "FrequencyOfMedication",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FrequencyOfTreatment: "FrequencyOfTreatment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  QualifierOfCondition: "QualifierOfCondition",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  RelationOfExamination: "RelationOfExamination",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  RouteOfMedication: "RouteOfMedication",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TimeOfCondition: "TimeOfCondition",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TimeOfEvent: "TimeOfEvent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TimeOfExamination: "TimeOfExamination",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TimeOfMedication: "TimeOfMedication",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TimeOfTreatment: "TimeOfTreatment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UnitOfCondition: "UnitOfCondition",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UnitOfExamination: "UnitOfExamination",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ValueOfCondition: "ValueOfCondition",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ValueOfExamination: "ValueOfExamination",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  BodySiteOfCondition: "BodySiteOfCondition",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  BodySiteOfTreatment: "BodySiteOfTreatment",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  CourseOfCondition: "CourseOfCondition",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  CourseOfExamination: "CourseOfExamination",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  CourseOfMedication: "CourseOfMedication",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  CourseOfTreatment: "CourseOfTreatment",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  ExaminationFindsCondition: "ExaminationFindsCondition",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  ExpressionOfGene: "ExpressionOfGene",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  ExpressionOfVariant: "ExpressionOfVariant",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  FrequencyOfCondition: "FrequencyOfCondition",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  MutationTypeOfGene: "MutationTypeOfGene",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  MutationTypeOfVariant: "MutationTypeOfVariant",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  ScaleOfCondition: "ScaleOfCondition",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
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
@clientName("HealthcareAssertionTemporality", "csharp")
@doc("Describes temporal information regarding the entity.")
union Temporality {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  current: "current",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  past: "past",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  future: "future",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
@doc("Describes any conditionality on the entity.")
@clientName("HealthcareAssertionConditionality", "csharp")
union Conditionality {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  hypothetical: "hypothetical",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  conditional: "conditional",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
@clientName("HealthcareAssertionCertainty", "csharp")
@doc("Describes the entities certainty and polarity.")
union Certainty {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  positive: "positive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  positivePossible: "positivePossible",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  neutralPossible: "neutralPossible",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  negativePossible: "negativePossible",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  negative: "negative",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
@clientName("HealthcareAssertionAssociation", "csharp")
@doc("Describes if the entity is the subject of the text or if it describes someone else.")
union Association {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  subject: "subject",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
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
