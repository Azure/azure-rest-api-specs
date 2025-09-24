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
@removed(Versions.v1)
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
@removed(Versions.v1)
model InputData {
  @doc("Type of the data")
  type: string;
}

@doc("Dataset as source for evaluation.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model InputDataset extends InputData {
  type: "dataset";

  @doc("Evaluation input data")
  id: string;
}

@doc("Evaluation Definition")
@resource("runs")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
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
@removed(Versions.v1)
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
@removed(Versions.v1)
model AgentEvaluationRedactionConfiguration {
  @doc("Redact score properties. If not specified, the default is to redact in production.")
  redactScoreProperties?: boolean;
}

@doc("Evaluation request for agent run.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
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
@removed(Versions.v1)
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
@removed(Versions.v1)
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
@removed(Versions.v1)
@added(Versions.v2025_05_15_preview)
model Message {
  @doc("The role of the message author. Known values: 'system', 'assistant', 'developer', 'user'.")
  role: "system" | "assistant" | "developer" | "user" | string;
}

@doc("A message authored by the system to guide model behavior.")
@removed(Versions.v1)
@added(Versions.v2025_05_15_preview)
model SystemMessage extends Message {
  @doc("Indicates this is a system message.")
  role: "system";

  @doc("Plain text instructions provided by the system to steer model behavior.")
  content: string;
}

@doc("A message authored by a developer to guide the model during evaluation.")
@removed(Versions.v1)
@added(Versions.v2025_05_15_preview)
model DeveloperMessage extends Message {
  @doc("Indicates this is a developer message.")
  role: "developer";

  @doc("Content provided by a developer to guide model behavior in an evaluation context.")
  content: string;
}

@doc("A message authored by the end user as input to the model.")
@removed(Versions.v1)
@added(Versions.v2025_05_15_preview)
model UserMessage extends Message {
  @doc("Indicates this is a user message.")
  role: "user";

  @doc("Input content or question provided by the end user.")
  content: string;
}

@doc("A message generated by the assistant in response to previous messages.")
@removed(Versions.v1)
@added(Versions.v2025_05_15_preview)
model AssistantMessage extends Message {
  @doc("Indicates this is an assistant message.")
  role: "assistant";

  @doc("Response content generated by the assistant.")
  content: string;
}

@doc("Allowed types of evaluation targets.")
@removed(Versions.v1)
@added(Versions.v2025_05_15_preview)
union EvaluationTargetType {
  @doc("Evaluation target that uses a model for response generation.")
  modelResponseGeneration: "modelResponseGeneration",

  string,
}

@doc("Abstract base model for defining evaluation targets.")
@discriminator("type")
@removed(Versions.v1)
@added(Versions.v2025_05_15_preview)
model EvaluationTarget {
  @doc("Discriminator that defines the type of the evaluation target.")
  type: EvaluationTargetType;
}

@doc("Evaluation target for generating responses using a given model and dataset.")
@removed(Versions.v1)
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
