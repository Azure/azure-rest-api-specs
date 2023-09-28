import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Language.AnalyzeText;

@doc("Supported parameters for a Healthcare task.")
model HealthcareTaskParameters extends PreBuiltTaskParameters{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  stringIndexType?: StringIndexType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model HealthcareLroTask extends AnalyzeTextLroTask{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroTaskKind.Healthcare;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: HealthcareTaskParameters;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model HealthcareResult extends AnalyzeTextPreBuiltResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  documents: Array<HealthcareEntitiesDocumentResult>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model HealthcareEntitiesDocumentResult extends DocumentResult {
  @doc("Healthcare entities.",)
  entities: Array<HealthcareEntity>;

  @doc("Healthcare entity relations.")
  relations: HealthcareRelation;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model HealthcareEntity {
  @doc("Entity text as appears in the request.")
  text: string;

  @doc("Healthcare Entity Category.")
  healthcareEntityCategory: HealthcareEntityCategory;

  @doc("(Optional) Entity sub type.")
  subcategory?: string;
  
  @doc("Start position for the entity text. Use of different 'stringIndexType' values can affect the offset returned.")
  offset: int32;

  @doc("Length for the entity text. Use of different 'stringIndexType' values can affect the length returned.")
  length: int32;

  @doc("Confidence score between 0 and 1 of the extracted entity.")
  confidenceScore: float64;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  assertion?: HealthcareAssertion;

  @doc("Preferred name for the entity. Example: 'histologically' would have a 'name' of 'histologic'.")
  name?: string;

  @doc("Entity references in known data sources.")
  links?: HealthcareEntityLink;
}

@doc("Healthcare Entity Category.")
enum HealthcareEntityCategory {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BodyStructure,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Age,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Gender,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ExaminationName,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Date,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Direction,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Frequency,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MeasurementValue,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MeasurementUnit,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  RelationalOperator,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Time,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  GeneOrProtein,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Variant,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AdministrativeEvent,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CareEnvironment,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HealthcareProfession,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Diagnosis,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SymptomOrSign,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ConditionQualifier,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MedicationClass,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MedicationName,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Dosage,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MedicationForm,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MedicationRoute,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FamilyRelation,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TreatmentName,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  Ethnicity,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  Course,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  Expression,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  MutationType,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  ConditionScale,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  Allergen,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  Employment,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  LivingStatus,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  SubstanceUse,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  SubstanceUseAmount,
}

@doc("Every relation is an entity graph of a certain relationType, where all entities are connected and have specific roles within the relation context.")
model HealthcareRelation {
  @doc("Type of relation. Examples include: `DosageOfMedication` or 'FrequencyOfMedication', etc.")
  relationType: HealthRelationType;

  @doc("The entities in the relation.")
  entities: Array<HealthcareRelationEntity>;

  @added(Versions.v2023_04_01)
  @doc("Confidence score between 0 and 1 of the extracted relation.")
  confidenceScore?: float64;
}

@doc("Type of relation. Examples include: `DosageOfMedication` or 'FrequencyOfMedication', etc.")
enum HealthRelationType {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Abbreviation,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DirectionOfBodyStructure,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DirectionOfCondition,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DirectionOfExamination,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DirectionOfTreatment,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DosageOfMedication,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FormOfMedication,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FrequencyOfMedication,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FrequencyOfTreatment,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  QualifierOfCondition,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  RelationOfExamination,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  RouteOfMedication,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TimeOfCondition,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TimeOfEvent,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TimeOfExamination,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TimeOfMedication,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TimeOfTreatment,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UnitOfCondition,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UnitOfExamination,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ValueOfCondition,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ValueOfExamination,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  BodySiteOfCondition,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  BodySiteOfTreatment,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  CourseOfCondition,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  CourseOfExamination,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  CourseOfMedication,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  CourseOfTreatment,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  ExaminationFindsCondition,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  ExpressionOfGene,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  ExpressionOfVariant,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  FrequencyOfCondition,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  MutationTypeOfGene,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  MutationTypeOfVariant,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  ScaleOfCondition,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  VariantOfGene, //14
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model HealthcareAssertion {
  @doc( "Describes any conditionality on the entity.")
  conditionality?: Conditionality;

  @doc("Describes the entities certainty and polarity.")
  certainty?: Certainty;
  
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  association?: Association;
}

@doc( "Describes any conditionality on the entity.")
enum Conditionality {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  hypothetical,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  conditional
}
@doc("Describes the entities certainty and polarity.")
enum Certainty {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  positive,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  positivePossible,
  
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  neutralPossible,
  
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  negativePossible,
  
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  negative
}

@doc("Describes if the entity is the subject of the text or if it describes someone else.")
enum Association {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  subject,
  
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  other
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model HealthcareRelationEntity {
  @doc("Reference link object, using a JSON pointer RFC 6901 (URI Fragment Identifier Representation), pointing to the entity .")
  ref: string;

  @doc("Role of entity in the relationship. For example: 'CD20-positive diffuse large B-cell lymphoma' has the following entities with their roles in parenthesis:  CD20 (GeneOrProtein), Positive (Expression), diffuse large B-cell lymphoma (Diagnosis).")
  role: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model HealthcareEntityLink {
  @doc("Entity Catalog. Examples include: UMLS, CHV, MSH, etc.")
  dataSource: string;

  @doc("Entity id in the given source catalog.")
  id: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model HealthcareLroResult extends AnalyzeTextLroResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroResultsKind.HealthcareLROResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: HealthcareResult;
}