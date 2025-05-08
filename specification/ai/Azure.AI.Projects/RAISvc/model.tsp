import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

enum SimulationType {
  Default,
  CustomPersona,
  HarmTurnGenerator,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Message")
model Message {
  @doc("The role.")
  Role?: string;

  @doc("The content.")
  Content?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Target Harm")
model TargetHarm {
  @doc("The risk type.")
  RiskType?: string;

  @doc("The risk sub type.")
  RiskSubType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Metadata")
model Metadata {
  @doc("List of target harms.")
  TargetHarms: Array<TargetHarm>;

  @doc("The language")
  Language: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Attack Objective")
model AttackObjective {
  @doc("The unique identifier.")
  Id: string;

  @doc("The metadata.")
  Metadata?: Metadata;

  @doc("List of sources.")
  Source: Array<string>;

  @doc("The modality.")
  Modality: string;

  @doc("The messages.")
  Messages: Array<Message>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Customization Parameters")
model CustomizationParameters {
  @doc("Application scenario.")
  ApplicationScenario?: string;

  @doc("List of harm categories.")
  HarmCategories: Array<string>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Customization Parameters")
model SimulationDTO {
  @doc("Additional headers.")
  Headers?: Record<string>;

  @doc("Parameters.")
  Params?: Record<string>;

  @doc("Template parameters.")
  TemplateParameters?: Record<string>;

  @doc("Customization parameters.")
  CustomizationParameters?: CustomizationParameters;

  @doc("Json.")
  Json?: string;

  @doc("Url.")
  Url?: string;

  @doc("Template key.")
  TemplateKey?: string;

  @doc("Type of Simulation.")
  SimulationType?: SimulationType;

  @doc("'True' if Microsoft internal tenant and 'False' otherwise.")
  IsMicrosoftTenant?: boolean;

  @doc("Azure subscription id.")
  SubscriptionId?: string;

  @doc("Resource group name.")
  ResourceGroupName?: string;

  @doc("Workspace name.")
  WorkspaceName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model SimulationResultDTO {
  @doc("Status Code.")
  StatusCode: int32;

  @doc("Content.")
  Content: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model Content {
  Messages: unknown[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model AnnotationDTO {
  AnnotationTask: string;
  ContentType: string;
  UserTextList: string[];
  Contents: Content[];
  MetricList: string[];
  PromptVersion: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model Data {
  assetId: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model ModelConfig {
  AzureEndpoint: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model SampleGenerator {
  ModelName: string;
  Type: string;
  SamplingParams: unknown;
  TrajectoryTemplate: unknown;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model StringCheckConfig extends GraderConfigBase {
  Type: string = "string-check-grader";
  Lhs: VRef;
  Rhs: VRef;
  CaseSensitive: boolean;
  Operation: string;
  TrueGrade: integer;
  FalseGrade: integer;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model StringValidityConfig extends GraderConfigBase {
  Type: string = "string-validity-grader";
  Operation: string;
  TrueGrade: integer;
  FalseGrade: integer;
  Reference: VRef;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model ChatCriteriaModelGraderConfig extends GraderConfigBase {
  Type: string = "chat-criteria-model-grader";
  ModelName?: string;
  TrueGrade: integer;
  FalseGrade: integer;
  Conversation?: VRef;
  Response: VRef;
  Criteria: JsonSchema;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model JsonSchemaConfig extends GraderConfigBase {
  Type: string = "json-schema-grader";
  JsonSchema: JsonSchema;
  Reference: VRef;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model SentimentClassificationConfig extends GraderConfigBase {
  Type: string = "sentiment-classification-model-grader";
  ModelName: string;
  NegativeGrade: integer;
  NeutralGrade: integer;
  PositiveGrade: integer;
  UnsureGrade: integer;
  Text: VRef;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model FactualityConfig extends GraderConfigBase {
  Type: string = "factuality-model-grader";
  ModelName: string;
  AgreementGrade: integer;
  DifferButFactualAgreementGrade: integer;
  DisagreementGrade: integer;
  SubsetGrade: integer;
  SupersetGrade: integer;
  Question: VRef;
  Reference: VRef;
  Submission: VRef;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model SemanticSimilarityConfig extends GraderConfigBase {
  Type: string = "discrete-classification-model-grader";
  ModelName: string;
  InvalidGrade: integer;
  Prompt: Prompt;
  Labels: Label[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model JsonSchema {
  Type: string;
  Value: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model VRef {
  Type: string;
  NamespaceName: string;
  VariableName: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model Prompt {
  Type: string;
  Template: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model Label {
  Text: string;
  Grade: integer;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model GraderConfigBase {
  Type: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model Grader {
  Name: string;
  Description: string;
  Config: GraderConfigBase;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model GradersDTO {
  Data: Data;
  ModelConfig: ModelConfig;
  SampleGenerators: SampleGenerator[];
  Graders: Grader[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model LongRunningResponse {
  Location: string;
  OperationResult: unknown;
}

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias ResourceCreatedOrOkResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<202> &
  T;
