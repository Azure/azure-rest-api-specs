
import "@typespec/rest";
import "@typespec/http";
import "./main.tsp";
import "../Language/common.tsp";

namespace Language.AnalyzeText;

@doc("Supported parameters for a Healthcare task.")
model HealthcareTaskParameters extends PreBuiltTaskParameters{
  stringIndexType?: StringIndexType;
}

model HealthcareLROTask extends AnalyzeTextLROTask{
  kind: AnalyzeTextLROTaskKind.Healthcare;

  parameters?: HealthcareTaskParameters;
}

model HealthcareResult extends PreBuiltResult {
  documents: Array<HealthcareEntitiesDocumentResult>;
}

model HealthcareEntitiesDocumentResult extends DocumentResult {
  @doc("Healthcare entities.",)
  entities: Array<HealthcareEntity>;

  @doc("Healthcare entity relations.")
  relations: HealthcareRelation;
}

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

  assertion?: HealthcareAssertion;

  @doc("Preferred name for the entity. Example: 'histologically' would have a 'name' of 'histologic'.")
  name?: string;

  @doc("Entity references in known data sources.")
  links?: HealthcareEntityLink;
}

@doc("Healthcare Entity Category.")
enum HealthcareEntityCategory {
  BodyStructure,
  Age,
  Gender,
  ExaminationName,
  Date,
  Direction,
  Frequency,
  MeasurementValue,
  MeasurementUnit,
  RelationalOperator,
  Time,
  GeneOrProtein,
  Variant,
  AdministrativeEvent,
  CareEnvironment,
  HealthcareProfession,
  Diagnosis,
  SymptomOrSign,
  ConditionQualifier,
  MedicationClass,
  MedicationName,
  Dosage,
  MedicationForm,
  MedicationRoute,
  FamilyRelation,
  TreatmentName
}

@doc("Every relation is an entity graph of a certain relationType, where all entities are connected and have specific roles within the relation context.")
model HealthcareRelation {
  @doc("Type of relation. Examples include: `DosageOfMedication` or 'FrequencyOfMedication', etc.")
  relationType: RelationType;

  @doc("The entities in the relation.")
  entities: Array<HealthcareRelationEntity>;
}

@doc("Type of relation. Examples include: `DosageOfMedication` or 'FrequencyOfMedication', etc.")
enum RelationType {
  Abbreviation,
  DirectionOfBodyStructure,
  DirectionOfCondition,
  DirectionOfExamination,
  DirectionOfTreatment,
  DosageOfMedication,
  FormOfMedication,
  FrequencyOfMedication,
  FrequencyOfTreatment,
  QualifierOfCondition,
  RelationOfExamination,
  RouteOfMedication,
  TimeOfCondition,
  TimeOfEvent,
  TimeOfExamination,
  TimeOfMedication,
  TimeOfTreatment,
  UnitOfCondition,
  UnitOfExamination,
  ValueOfCondition,
  ValueOfExamination
}

model HealthcareAssertion {
  @doc( "Describes any conditionality on the entity.")
  conditionality?: Conditionality;

  @doc("Describes the entities certainty and polarity.")
  certainty?: Certainty;
  
  association?: Association;
}

@doc( "Describes any conditionality on the entity.")
enum Conditionality {
  hypothetical,
  conditional
}
@doc("Describes the entities certainty and polarity.")
enum Certainty {
  positive,
  positivePossible,
  neutralPossible,
  negativePossible,
  negative
}

@doc("Describes if the entity is the subject of the text or if it describes someone else.")
enum Association {
  subject,
  other
}

model HealthcareRelationEntity {
  @doc("Reference link object, using a JSON pointer RFC 6901 (URI Fragment Identifier Representation), pointing to the entity .")
  ref: string;

  @doc("Role of entity in the relationship. For example: 'CD20-positive diffuse large B-cell lymphoma' has the following entities with their roles in parenthesis:  CD20 (GeneOrProtein), Positive (Expression), diffuse large B-cell lymphoma (Diagnosis).")
  role: string;
}

model HealthcareEntityLink {
  @doc("Entity Catalog. Examples include: UMLS, CHV, MSH, etc.")
  dataSource: string;

  @doc("Entity id in the given source catalog.")
  id: string;
}