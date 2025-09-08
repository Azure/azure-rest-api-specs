import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Evaluator Configuration")
@added(Versions.v2025_05_15_preview)
model EvaluatorConfiguration {
  @doc("Identifier of the evaluator.")
  id: string;

  @doc("Initialization parameters of the evaluator.")
  initParams?: Record<unknown>;

  @doc("Data parameters of the evaluator.")
  dataMapping?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
@doc("Abstract data class.")
@discriminator("type")
@added(Versions.v2025_05_15_preview)
model InputData {
  @doc("Type of the data")
  type: string;
}

@doc("Dataset as source for evaluation.")
@added(Versions.v2025_05_15_preview)
model InputDataset extends InputData {
  type: "dataset";

  @doc("Evaluation input data")
  id: string;
}

@doc("Evaluation Definition")
@resource("runs")
@added(Versions.v2025_05_15_preview)
model Evaluation {
  @doc("Identifier of the evaluation.")
  @key("name")
  @encodedName("application/json", "id")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Data for evaluation.")
  data: InputData;

  @doc("Display Name for evaluation. It helps to find the evaluation easily in AI Foundry. It does not need to be unique.")
  displayName?: string;

  @doc("Description of the evaluation. It can be used to store additional information about the evaluation and is mutable.")
  description?: string;

  @doc("Status of the evaluation. It is set by service and is read-only.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("Evaluation's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Evaluation's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;

  @doc("Evaluators to be used for the evaluation.")
  evaluators: Record<EvaluatorConfiguration>;

  @doc("Specifies the type and configuration of the entity used for this evaluation.")
  target?: EvaluationTarget;
}

@doc("Definition for sampling strategy.")
@added(Versions.v2025_05_15_preview)
model AgentEvaluationSamplingConfiguration {
  @doc("Name of the sampling strategy.")
  name: string;

  @doc("Percentage of sampling per hour (0-100).")
  samplingPercent: float32;

  @doc("Maximum request rate per hour (0 to 1000).")
  maxRequestRate: float32;
}

@doc("The redaction configuration will allow the user to control what is redacted.")
@added(Versions.v2025_05_15_preview)
model AgentEvaluationRedactionConfiguration {
  @doc("Redact score properties. If not specified, the default is to redact in production.")
  redactScoreProperties?: boolean;
}

@doc("Evaluation request for agent run.")
@added(Versions.v2025_05_15_preview)
model AgentEvaluationRequest {
  @doc("Identifier of the agent run.")
  runId: string;

  @doc("Identifier of the agent thread. This field is mandatory currently, but it will be optional in the future.")
  threadId?: string;

  @doc("Evaluators to be used for the evaluation.")
  evaluators: Record<EvaluatorConfiguration>;

  @doc("Sampling configuration for the evaluation.")
  samplingConfiguration?: AgentEvaluationSamplingConfiguration;

  @doc("Redaction configuration for the evaluation.")
  redactionConfiguration?: AgentEvaluationRedactionConfiguration;

  @doc("Pass the AppInsights connection string to the agent evaluation for the evaluation results and the errors logs.")
  appInsightsConnectionString: string;
}

@doc("Result for the agent evaluation evaluator run.")
@added(Versions.v2025_05_15_preview)
model AgentEvaluationResult {
  @doc("Evaluator's name. This is the name of the evaluator that was used to evaluate the agent's completion.")
  evaluator: string;

  @doc("Identifier of the evaluator.")
  evaluatorId: string;

  @doc("Score of the given evaluator. No restriction on range.")
  score: float32;

  @doc("Status of the evaluator result. Options: Running, Completed, Failed, NotApplicable.")
  status: string;

  @doc("Reasoning for the evaluation result.")
  reason?: string;

  @doc("Version of the evaluator that was used to evaluate the agent's completion.")
  version?: string;

  @doc("The unique identifier of the thread.")
  threadId?: string;

  @doc("The unique identifier of the run.")
  runId: string;

  @doc("A string explaining why there was an error, if applicable.")
  error?: string;

  @doc("Additional properties relevant to the evaluator. These will differ between evaluators.")
  additionalDetails?: Record<string>;
}

@doc("Evaluation response for agent evaluation run.")
@added(Versions.v2025_05_15_preview)
model AgentEvaluation {
  @doc("Identifier of the agent evaluation run.")
  id: string;

  @doc("Status of the agent evaluation. Options: Running, Completed, Failed.")
  status: string;

  @doc("The reason of the request failure for the long running process, if applicable.")
  error?: string;

  @doc("The agent evaluation result.")
  result?: Array<AgentEvaluationResult>;
}

@doc("Abstract base model representing a single message in a conversation.")
@discriminator("role")
@added(Versions.v2025_05_15_preview)
model Message {
  @doc("The role of the message author. Known values: 'system', 'assistant', 'developer', 'user'.")
  role: "system" | "assistant" | "developer" | "user" | string;
}

@doc("A message authored by the system to guide model behavior.")
@added(Versions.v2025_05_15_preview)
model SystemMessage extends Message {
  @doc("Indicates this is a system message.")
  role: "system";

  @doc("Plain text instructions provided by the system to steer model behavior.")
  content: string;
}

@doc("A message authored by a developer to guide the model during evaluation.")
@added(Versions.v2025_05_15_preview)
model DeveloperMessage extends Message {
  @doc("Indicates this is a developer message.")
  role: "developer";

  @doc("Content provided by a developer to guide model behavior in an evaluation context.")
  content: string;
}

@doc("A message authored by the end user as input to the model.")
@added(Versions.v2025_05_15_preview)
model UserMessage extends Message {
  @doc("Indicates this is a user message.")
  role: "user";

  @doc("Input content or question provided by the end user.")
  content: string;
}

@doc("A message generated by the assistant in response to previous messages.")
@added(Versions.v2025_05_15_preview)
model AssistantMessage extends Message {
  @doc("Indicates this is an assistant message.")
  role: "assistant";

  @doc("Response content generated by the assistant.")
  content: string;
}

@doc("Allowed types of evaluation targets.")
@added(Versions.v2025_05_15_preview)
union EvaluationTargetType {
  @doc("Evaluation target that uses a model for response generation.")
  modelResponseGeneration: "modelResponseGeneration",

  string,
}

@doc("Abstract base model for defining evaluation targets.")
@discriminator("type")
@added(Versions.v2025_05_15_preview)
model EvaluationTarget {
  @doc("Discriminator that defines the type of the evaluation target.")
  type: EvaluationTargetType;
}

@doc("Evaluation target for generating responses using a given model and dataset.")
@added(Versions.v2025_05_15_preview)
model modelResponseGenerationTarget extends EvaluationTarget {
  @doc("The type of evaluation target. Always 'modelResponseGeneration'.")
  type: EvaluationTargetType.modelResponseGeneration;

  @doc("A list of messages comprising the conversation so far.")
  baseMessages: Message[];

  @doc("The model deployment to be evaluated. Accepts either the deployment name alone or with the connection name as '{connectionName}/modelDeploymentName'.")
  modelDeploymentName: string;

  @doc("Optional parameters passed to the model for evaluation.")
  modelParams: Record<unknown>;
}

@doc("Human Evaluation Template for defining the structure of human evaluation feedback questions.")
@added(Versions.v2025_05_15_preview)
model HumanEvaluationTemplate {
  @doc("Title of the human evaluation template.")
  @minLength(1)
  title: string;

  @doc("A list of feedback questions comprising the human evaluation template.")
  @minItems(1)
  feedbackQuestions: FeedbackQuestion[];
}
/** Five-point Likert scale option labels. */
alias FivePointLikert = [string, string, string, string, string];

/** Ten-point Likert scale option labels. */
alias TenPointLikert = [
  string,
  string,
  string,
  string,
  string,
  string,
  string,
  string,
  string,
  string
];

@doc("Base feedback question.")
@discriminator("type")
@added(Versions.v2025_05_15_preview)
model FeedbackQuestionBase {
  @doc("Discriminator defining the feedback question kind.")
  type: string;

  @doc("The question to present to the reviewer.")
  @minLength(1)
  question: string;

  @doc("Optional tooltip/help text for the reviewer.")
  info?: string;

  @doc("Whether answering this question is required. Defaults to false.")
  required?: boolean;
}

@doc("A free-form text feedback question.")
@added(Versions.v2025_05_15_preview)
model TextFeedbackQuestion extends FeedbackQuestionBase {
  @doc("Discriminator value for a text question.")
  type: "text";
}

@doc("A single-select choice feedback question.")
@added(Versions.v2025_05_15_preview)
model ChoiceFeedbackQuestion extends FeedbackQuestionBase {
  @doc("Discriminator value for a single-select choice question.")
  type: "choice";

  @doc("List of answer choices presented to the reviewer.")
  @minItems(1)
  choices: string[];
}

@doc("A multi-select choice feedback question.")
@added(Versions.v2025_05_15_preview)
model MultiChoiceFeedbackQuestion extends FeedbackQuestionBase {
  @doc("Discriminator value for a multi-select choice question.")
  type: "multi";

  @doc("List of answer choices presented to the reviewer.")
  @minItems(2)
  choices: string[];
}

@doc("A Likert scale feedback question (exactly 5 or 10 ordered labels).")
@added(Versions.v2025_05_15_preview)
model LikertScaleFeedbackQuestion extends FeedbackQuestionBase {
  @doc("Discriminator value for a Likert scale question.")
  type: "likert_scale";

  @doc("Ordered labels for the Likert scale (must be exactly 5 or 10).")
  choices: FivePointLikert | TenPointLikert;
}

@doc("A feedback question that a reviewer can be asked.")
@added(Versions.v2025_05_15_preview)
union FeedbackQuestion {
  @doc("Free-form text response question.")
  TextFeedbackQuestion,

  @doc("Single-select choice question.")
  ChoiceFeedbackQuestion,

  @doc("Multi-select choice question.")
  MultiChoiceFeedbackQuestion,

  @doc("Likert scale rating question (5 or 10 points).")
  LikertScaleFeedbackQuestion,
}

@doc("List of human evaluation templates associated with an agent.")
model AssociatedTemplates {
  @doc("Templates associated with this agent.")
  templates: AssociatedTemplate[];
}

@doc("An existing human evaluation template association.")
model AssociatedTemplate {
  @doc("Whether the current human evaluation template for this agent is enabled.")
  active: boolean;

  @doc("The associated human evaluation template (for convenience).")
  template: HumanEvaluationTemplate;
}

@doc("Request body to update an existing human evaluation template association.")
model UpdateAssociatedTemplate {
  @doc("Whether the current human evaluation template for this agent is enabled. If omitted the existing value is preserved.")
  active?: boolean;
}

@doc("Error payload returned when a request fails.")
model RequestError {
  ...Record<unknown>;
}

@doc("Identifier of a saved asset.")
<<<<<<< HEAD
scalar AssetId extends string;
=======
scalar AssetId extends string;
>>>>>>> 726c9748b5 (Adding proposal for HET APIs)
