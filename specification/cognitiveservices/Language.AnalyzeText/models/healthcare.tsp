import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Versioning;
using Azure.Core;

namespace Language.Text;

/** Supported parameters for a Healthcare task. */
model HealthcareTaskParameters is PreBuiltTaskParameters {
  /** Specifies the method used to interpret string offsets. */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  /** The FHIR Spec version that the result will use to format the fhirBundle. For additional information see https://www.hl7.org/fhir/overview.html. */
  @added(Versions.v2024_11_01)
  fhirVersion?: fhirVersion;

  /** Document type that can be provided as input for Fhir Documents. Expect to have fhirVersion provided when used. Behavior of using None enum is the same as not using the documentType parameter. */
  @added(Versions.v2024_11_01)
  documentType?: healthcareDocumentType;
}

/** The FHIR Spec version. */
@added(Versions.v2024_11_01)
union fhirVersion {
  string,

  /** Version 4.0.1 */
  `4.0.1`: "4.0.1",
}

/** Document type. */
@added(Versions.v2024_11_01)
union healthcareDocumentType {
  string,

  /** None document type */
  None: "None",

  /** Clinical trial document type */
  ClinicalTrial: "ClinicalTrial",

  /** Discharge summary document type */
  DischargeSummary: "DischargeSummary",

  /** Progress note document type */
  ProgressNote: "ProgressNote",

  /** History and physical document type */
  HistoryAndPhysical: "HistoryAndPhysical",

  /** Consult document type */
  Consult: "Consult",

  /** Imaging document type */
  Imaging: "Imaging",

  /** Pathology document type */
  Pathology: "Pathology",

  /** Procedure note document type */
  ProcedureNote: "ProcedureNote",
}

/** The long running task to be performed by the service on the Healthcare input documents. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model HealthcareLROTask extends AnalyzeTextLROTask {
  /** Healthcare kind of the long running task. */
  kind: AnalyzeTextLROTaskKind.Healthcare;

  /** Parameters for the Healthcare task. */
  parameters?: HealthcareTaskParameters;
}

/** Result object for the processed Healthcare task. */
model HealthcareResult is PreBuiltResult {
  /** List of result objects for the processed Healthcare documents. */
  @typeChangedFrom(
    Versions.v2024_11_15_preview,
    Array<HealthcareEntitiesDocumentResult>
  )
  documents: Array<HealthcareEntitiesDocumentResultWithDocumentDetectedLanguage>;
}

/** Result object for the processed Healthcare document. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type"
model HealthcareEntitiesDocumentResult is DocumentResult {
  /** Healthcare entities. */
  entities: Array<HealthcareEntity>;

  /** Healthcare entity relations. */
  relations: Array<HealthcareRelation>;

  /** JSON bundle containing a FHIR compatible object for consumption in other Healthcare tools. For additional information see https://www.hl7.org/fhir/overview.html. */
  @added(Versions.v2024_11_01)
  fhirBundle?: FhirBundle;
}

/** JSON bundle containing a FHIR compatible object for consumption in other Healthcare tools. For additional information see https://www.hl7.org/fhir/overview.html. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type"
model FhirBundle is Record<unknown>;

/** Healthcare entity extracted from the document */
model HealthcareEntity {
  /** Entity text as appears in the request. */
  text: string;

  /** Healthcare Entity Category. */
  category: healthcareEntityCategory;

  /** (Optional) Entity sub type. */
  subcategory?: string;

  /** Start position for the entity text. Use of different 'stringIndexType' values can affect the offset returned. */
  offset: int32;

  /** Length for the entity text. Use of different 'stringIndexType' values can affect the length returned. */
  length: int32;

  /** Confidence score between 0 and 1 of the extracted entity. */
  confidenceScore: float64;

  /** Assertion of the entity. */
  assertion?: HealthcareAssertion;

  /** Preferred name for the entity. Example: 'histologically' would have a 'name' of 'histologic'. */
  name?: string;

  /** Entity references in known data sources. */
  links?: Array<HealthcareEntityLink>;
}

/** Healthcare Entity Category. */
union healthcareEntityCategory {
  string,

  /** Body structure */
  BodyStructure: "BodyStructure",

  /** Age */
  Age: "Age",

  /** Gender */
  Gender: "Gender",

  /** Examination name */
  ExaminationName: "ExaminationName",

  /** Date */
  Date: "Date",

  /** Direction */
  Direction: "Direction",

  /** Frequency */
  Frequency: "Frequency",

  /** Measurement value */
  MeasurementValue: "MeasurementValue",

  /** Measurement unit */
  MeasurementUnit: "MeasurementUnit",

  /** Relational operator */
  RelationalOperator: "RelationalOperator",

  /** Time */
  Time: "Time",

  /** Gene or protein */
  GeneOrProtein: "GeneOrProtein",

  /** Variant */
  Variant: "Variant",

  /** Administrative event */
  AdministrativeEvent: "AdministrativeEvent",

  /** Care environment */
  CareEnvironment: "CareEnvironment",

  /** Healthcare profession */
  HealthcareProfession: "HealthcareProfession",

  /** Diagnosis */
  Diagnosis: "Diagnosis",

  /** Symptom or sign */
  SymptomOrSign: "SymptomOrSign",

  /** Condition qualifier */
  ConditionQualifier: "ConditionQualifier",

  /** Medication class */
  MedicationClass: "MedicationClass",

  /** Medication name */
  MedicationName: "MedicationName",

  /** Dosage */
  Dosage: "Dosage",

  /** Medication form */
  MedicationForm: "MedicationForm",

  /** Medication route */
  MedicationRoute: "MedicationRoute",

  /** Family relation */
  FamilyRelation: "FamilyRelation",

  /** Treatment name */
  TreatmentName: "TreatmentName",

  /** Ethnicity */
  @added(Versions.v2023_04_01)
  Ethnicity: "Ethnicity",

  /** Course */
  @added(Versions.v2023_04_01)
  Course: "Course",

  /** Expression */
  @added(Versions.v2023_04_01)
  Expression: "Expression",

  /** Mutation type */
  @added(Versions.v2023_04_01)
  MutationType: "MutationType",

  /** Condition scale */
  @added(Versions.v2023_04_01)
  ConditionScale: "ConditionScale",

  /** Allergen */
  @added(Versions.v2023_04_01)
  Allergen: "Allergen",

  /** Employment */
  @added(Versions.v2023_04_01)
  Employment: "Employment",

  /** Living status */
  @added(Versions.v2023_04_01)
  LivingStatus: "LivingStatus",

  /** Substance use */
  @added(Versions.v2023_04_01)
  SubstanceUse: "SubstanceUse",

  /** Substance use amount */
  @added(Versions.v2023_04_01)
  SubstanceUseAmount: "SubstanceUseAmount",
}

/** Every relation is an entity graph of a certain relationType, where all entities are connected and have specific roles within the relation context. */
model HealthcareRelation {
  /** Type of relation. Examples include: `DosageOfMedication` or 'FrequencyOfMedication', etc. */
  relationType: relationType;

  /** The entities in the relation. */
  entities: Array<HealthcareRelationEntity>;

  /** Confidence score between 0 and 1 of the extracted relation. */
  @added(Versions.v2023_04_01)
  confidenceScore?: float64;
}

/** Type of relation. Examples include: `DosageOfMedication` or 'FrequencyOfMedication', etc. */
union relationType {
  string,

  /** Abbreviation */
  Abbreviation: "Abbreviation",

  /** Direction of body structure */
  DirectionOfBodyStructure: "DirectionOfBodyStructure",

  /** Direction of condition */
  DirectionOfCondition: "DirectionOfCondition",

  /** Direction of examination */
  DirectionOfExamination: "DirectionOfExamination",

  /** Direction of treatment */
  DirectionOfTreatment: "DirectionOfTreatment",

  /** Dosage of medication */
  DosageOfMedication: "DosageOfMedication",

  /** Form of medication */
  FormOfMedication: "FormOfMedication",

  /** Frequency of medication */
  FrequencyOfMedication: "FrequencyOfMedication",

  /** Frequency of treatment */
  FrequencyOfTreatment: "FrequencyOfTreatment",

  /** Qualifier of condition */
  QualifierOfCondition: "QualifierOfCondition",

  /** Relation of examination */
  RelationOfExamination: "RelationOfExamination",

  /** Route of medication */
  RouteOfMedication: "RouteOfMedication",

  /** Time of condition */
  TimeOfCondition: "TimeOfCondition",

  /** Time of event */
  TimeOfEvent: "TimeOfEvent",

  /** Time of examination */
  TimeOfExamination: "TimeOfExamination",

  /** Time of medication */
  TimeOfMedication: "TimeOfMedication",

  /** Time of treatment */
  TimeOfTreatment: "TimeOfTreatment",

  /** Unit of condition */
  UnitOfCondition: "UnitOfCondition",

  /** Unit of examination */
  UnitOfExamination: "UnitOfExamination",

  /** Value of condition */
  ValueOfCondition: "ValueOfCondition",

  /** Value of examination */
  ValueOfExamination: "ValueOfExamination",

  /** Body site of condition */
  @added(Versions.v2023_04_01)
  BodySiteOfCondition: "BodySiteOfCondition",

  /** Body site of treatment */
  @added(Versions.v2023_04_01)
  BodySiteOfTreatment: "BodySiteOfTreatment",

  /** Course of condition */
  @added(Versions.v2023_04_01)
  CourseOfCondition: "CourseOfCondition",

  /** Course of examination */
  @added(Versions.v2023_04_01)
  CourseOfExamination: "CourseOfExamination",

  /** Course of medication */
  @added(Versions.v2023_04_01)
  CourseOfMedication: "CourseOfMedication",

  /** Course of treatment */
  @added(Versions.v2023_04_01)
  CourseOfTreatment: "CourseOfTreatment",

  /** Examination finds condition */
  @added(Versions.v2023_04_01)
  ExaminationFindsCondition: "ExaminationFindsCondition",

  /** Expression of gene */
  @added(Versions.v2023_04_01)
  ExpressionOfGene: "ExpressionOfGene",

  /** Expression of variant */
  @added(Versions.v2023_04_01)
  ExpressionOfVariant: "ExpressionOfVariant",

  /** Frequency of condition */
  @added(Versions.v2023_04_01)
  FrequencyOfCondition: "FrequencyOfCondition",

  /** Mutation type of gene */
  @added(Versions.v2023_04_01)
  MutationTypeOfGene: "MutationTypeOfGene",

  /** Mutation type of variant */
  @added(Versions.v2023_04_01)
  MutationTypeOfVariant: "MutationTypeOfVariant",

  /** Scale of condition */
  @added(Versions.v2023_04_01)
  ScaleOfCondition: "ScaleOfCondition",

  /** Variant of gene */
  @added(Versions.v2023_04_01)
  VariantOfGene: "VariantOfGene",
}

/** Assertion of the entity. */
model HealthcareAssertion {
  /** Describes any conditionality on the entity. */
  conditionality?: Conditionality;

  /** Describes the entities certainty and polarity. */
  certainty?: Certainty;

  /** Describes if the entity is the subject of the text or if it describes someone else. */
  association?: Association;

  /** Describes temporal information regarding the entity. */
  @added(Versions.v2024_11_01)
  temporality?: Temporality;
}

/** Describes temporal information regarding the entity. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
@added(Versions.v2024_11_01)
union Temporality {
  /** Current temporality */
  current: "current",

  /** Past temporality */
  past: "past",

  /** Future temporality */
  future: "future",
}

/** Describes any conditionality on the entity. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
union Conditionality {
  /** Hypothetical conditionality */
  hypothetical: "hypothetical",

  /** Conditional conditionality */
  conditional: "conditional",
}

/** Describes the entities certainty and polarity. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
union Certainty {
  /** Positive certainty */
  positive: "positive",

  /** Possibly positive certainty */
  positivePossible: "positivePossible",

  /** Possibly neutral certainty */
  neutralPossible: "neutralPossible",

  /** Possibly negative certainty */
  negativePossible: "negativePossible",

  /** Negative certainty */
  negative: "negative",
}

/** Describes if the entity is the subject of the text or if it describes someone else. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
union Association {
  /** Subject association */
  subject: "subject",

  /** Other association */
  other: "other",
}

/** Entity in the relation. */
model HealthcareRelationEntity {
  /** Reference link object, using a JSON pointer RFC 6901 (URI Fragment Identifier Representation), pointing to the entity . */
  ref: string;

  /** Role of entity in the relationship. For example: 'CD20-positive diffuse large B-cell lymphoma' has the following entities with their roles in parenthesis:  CD20 (GeneOrProtein), Positive (Expression), diffuse large B-cell lymphoma (Diagnosis). */
  role: string;
}

/** Reference to an entity in known data sources. */
model HealthcareEntityLink {
  /** Entity Catalog. Examples include: UMLS, CHV, MSH, etc. */
  dataSource: string;

  /** Entity id in the given source catalog. */
  id: string;
}

/** Healthcare Analyze Text long tunning operation result object. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model HealthcareLROResult extends AnalyzeTextLROResult {
  /** Kind of the task. */
  kind: AnalyzeTextLROResultsKind.HealthcareLROResults;

  /** Results of the task. */
  results: HealthcareResult;
}

/** Result object for the processed Healthcare document with detected language. */
@added(Versions.v2024_11_15_preview)
model HealthcareEntitiesDocumentResultWithDocumentDetectedLanguage
  is HealthcareEntitiesDocumentResult {
  ...DocumentDetectedLanguage;
}
