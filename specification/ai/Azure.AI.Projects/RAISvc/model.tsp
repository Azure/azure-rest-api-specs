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
@doc("The Evaluation Metric")
model EvaluationMetric {
  @doc("The metric name.")
  name: string;

  @doc("The metric label.")
  label?: string;

  @doc("The metric label's reason")
  reason: string;

  @doc("Additional metric properties.")
  properties?: Record<string>;
}

@doc("Safety Evaluation Type")
enum SafetyEvaluationType {
  ContentSafety: "content safety",
  Groundedness: "groundedness",
  XPIA: "xpia",
  ECI: "eci",
  ProtectedMaterial: "protected material",
  CodeVulnerability: "code vulnerability",
  UngroundedAttributes: "ungrounded attributes"
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Safety Evaluation")
model SafetyEvaluation {
  @doc("Identifier of the evaluation.")
  @key("name")
  @visibility("read")
  id: string;

  @doc("The safety evaluation type.")
  type: SafetyEvaluationType;

  @doc("The metrics to evaluate.")
  metrics?: Array<string>;

  @doc("The safety evaluation version (aka prompt version).")
  version: string;

  @doc("The collection of context messages associated with this chat completions that need to be evaluated.")
  @minItems(1)
  inputs: ChatCompletions[];

  @doc("The evaluated metrics for the inputs.")
  @visibility("read")
  outputs: EvaluationMetric[][];
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

model ChatCompletions {
  @doc("The collection of context messages associated with this chat completions that need to be evaluated.")
  @minItems(1)
  messages: ChatRequestMessage[];
}


@doc("A description of the intended purpose of a message within a chat completions interaction.")
union ChatRole {
  string,

  @doc("The role that instructs or sets the behavior of the assistant.")
  system: "system",

  @doc("The role that provides input for chat completions.")
  user: "user",

  @doc("The role that provides responses to system-instructed, user-prompted input.")
  assistant: "assistant",
}

@doc("An abstract representation of a structured content item within a chat message.")
model ChatMessageContentItem {
  @doc("The discriminated object type.")
  type: string;
}

@doc("A structured chat content item containing plain text.")
model ChatMessageTextContentItem extends ChatMessageContentItem {
  @doc("The discriminated object type: always 'text' for this type.")
  type: "text";

  @doc("The content of the message.")
  text: string;
}

@doc("A structured chat content item containing an image reference.")
model ChatMessageImageContentItem extends ChatMessageContentItem {
  @doc("The discriminated object type: always 'image_url' for this type.")
  type: "image_url";

  @doc("An internet location, which must be accessible to the model,from which the image may be retrieved.")
  @encodedName("application/json", "image_url")
  imageUrl: ChatMessageImageUrl;
}

@doc("An internet location from which the model may retrieve an image.")
model ChatMessageImageUrl {
  @doc("The URL of the image.")
  url: string;

  @doc("""
    The evaluation quality setting to use, which controls relative prioritization of speed, token consumption, and
    accuracy.
    """)
  detail?: ChatMessageImageDetailLevel;
}

@doc("A representation of the possible image detail levels for image-based chat completions message content.")
union ChatMessageImageDetailLevel {
  string,

  @doc("Specifies that the model should determine which detail level to apply using heuristics like image size.")
  auto: "auto",

  @doc("""
    Specifies that image evaluation should be constrained to the 'low-res' model that may be faster and consume fewer
    tokens but may also be less accurate for highly detailed images.
    """)
  low: "low",

  @doc("""
    Specifies that image evaluation should enable the 'high-res' model that may be more accurate for highly detailed
    images but may also be slower and consume more tokens.
    """)
  high: "high",
}

@doc("An abstract representation of a chat message as provided in a request.")
model ChatRequestMessage {
  @doc("The chat role associated with this message.")
  role: ChatRole;
}

@doc("""
  A request chat message containing system instructions that influence how the model will generate a chat completions
  response.
  """)
model ChatRequestSystemMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'system' for system messages.")
  role: ChatRole.system;

  @doc("The contents of the system message.")
  content: string;
}

@doc("A request chat message representing user input to the assistant.")
model ChatRequestUserMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'user' for user messages.")
  role: ChatRole.user;

  #suppress "@azure-tools/typespec-autorest/union-unsupported" "External API shape is defined in OpenAPI 3.0 as oneOf."
  @doc("The contents of the user message, with available input types varying by selected model.")
  content: string | ChatMessageContentItem[];
}

@doc("A request chat message representing response or action from the assistant.")
model ChatRequestAssistantMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'assistant' for assistant messages.")
  role: ChatRole.assistant;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  @doc("The content of the message.")
  content?: string | ChatMessageContentItem[];
}
