import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";
import "./chat_messages.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/** Azure AI Evaluator class definition. */
@added(Versions.v2025_11_15_preview)
model AzureAIEvaluator {
  /** The object type, which is always `azure_ai_evaluator`. */
  type: "azure_ai_evaluator";

  /** User provided name of the Azure AI Evaluator object instance. */
  name: string;

  /** The reference name of the evaluator. */
  evaluator_name: string;

  /** The optional reference version of the evaluator. */
  evaluator_version?: string;

  /** The initialization parameters for the evaluation. */
  initialization_parameters?: {};

  /** The model to use for the evaluation. */
  data_mapping?: Record<string>;
}

/** Expect format of the results list of the evaluation run output items. */
@added(Versions.v2025_11_15_preview)
model EvaluationRunOutputItemResult {
  /** The result type (e.g., "string_check", "azure_ai_evaluator"). */
  type: string;

  /** The name of the test criteria (e.g., "my_string_check_grader", "my_fluency"). */
  name: string;

  /** Whether the test criteria passed or failed. */
  passed: boolean;

  /** The numeric score for this test criteria metric. */
  score: float64;

  /** The name of the metric (e.g., "fluency", "f1_score"). Most evaluators only have a single metric with the same name as the evaluator. */
  metric: string;

  /** The label associated with the test criteria metric (e.g., "pass", "fail", "good", "bad", etc.). */
  label?: string;

  /** The threshold used to determine pass/fail for this test criteria, if it is numerical. */
  threshold?: float64;

  /** The reason for the test criteria metric. */
  reason?: string;

  /** A sample from the evaluation run output item, if available. */
  sample?: {};

  /** Additional details about the test criteria metric. */
  properties: Record<unknown>;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
@doc("Eval jsonl file content class.")
@added(Versions.v2025_11_15_preview)
model EvalJsonlFileContent {
  /** Expected schema: QueryResponseInlineMessage */
  @doc("The eval jsonl file content item.")
  item: EvalJsonlFileContentItem;

  /** optional sample. */
  sample?: {};
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
@doc("Abstract eval jsonl file content item class.")
@discriminator("type")
@added(Versions.v2025_11_15_preview)
model EvalJsonlFileContentItem {
  @doc("Type of the eval jsonl file content item.")
  type: string;
}

/** Query and response excepted input messsage defintion. */
@added(Versions.v2025_11_15_preview)
model QueryResponseInlineMessage extends EvalJsonlFileContentItem {
  /** The object type, which is always query_response_inline_message. */
  type: "azure_ai_query_response_inline_message";

  /** The input query string provided by the user or system. Can be image url. */
  query: string;

  /** The generated response corresponding to the input query. Can be image url. */
  response?: string;

  /** Optional contextual information that may provide additional details or background relevant to the query-response pair. */
  context?: string;

  /** Optional list of tools or resources utilized during the evaluation or generation of the response. */
  tools?: {}[];

  /** Additional properties for the query response inline message. */
  properties?: Record<string>;
}

/** Custom inference model endpoint for evaluation. */
@added(Versions.v2025_11_15_preview)
model CustomInference {
  /** The endpoint URL to be used for inferencing. */
  endpointUrl: string;

  /** The deployment id to be used for inferencing. */
  DeploymentId: string;
}

/** Query and response excepted input messsage defintion. */
@added(Versions.v2025_11_15_preview)
model EvaluatorMessage extends EvalJsonlFileContentItem {
  /** The object type, which is always query_response_inline_message. */
  type: "azure_ai_evaluator_messages";

  /** The input query string provided by the user or system. Can be image url. */
  query: Message[];

  /** The generated response corresponding to the input query. Can be image url. */
  response?: Message[];

  /** Optional list of tools or resources utilized during the evaluation or generation of the response. */
  tools?: {}[];

  /** Additional properties for the query response inline message. */
  properties?: Record<string>;
}

/** OpenAI definition: Eval output results. */
@added(Versions.v2025_11_15_preview)
model EvalRunOutputItem {
  /** The type of the object. Always eval.run.output_item */
  object: "eval.run.output_item" = "eval.run.output_item";

  /** Unique identifier for the evaluation run output item. */
  id?: string;

  /** The identifier of the evaluation run associated with this output item. */
  run_id?: string;

  /** The identifier of the evaluation group. */
  eval_id?: string;

  /** Unix timestamp (in seconds) when the evaluation run was created. */
  created_at: int64;

  /** The status of the evaluation run. */
  status: string;

  /** The identifier for the data source item. */
  datasource_item_id?: int64;

  /** Details of the input data source item. */
  datasource_item: {};

  /** A list of results from the evaluation run. Expected Object: EvaluationRunOutputItemResult. */
  results: {}[];

  /** A sample containing the input and output of the evaluation run. */
  sample?: {};
}

/** OpenAI definition: Eval inline file content or jsonl input data. */
@added(Versions.v2025_11_15_preview)
model EvalJsonlFileContentSource {
  /** The type of jsonl source. Always `file_content`. */
  type: "file_content" = "file_content";

  /** The content of the jsonl file. */
  content: EvalJsonlFileContent;
}

/** Eval jsonl input data. */
@added(Versions.v2025_11_15_preview)
model CreateEvalJsonlRunDataSource {
  /** The type of data source. Always jsonl. */
  type: "jsonl" = "jsonl";

  /** Determines what populates the `item` namespace in the data source. */
  source: EvalJsonlFileContentSource;
}

/** OpenAI Input data source definition for eval. */
@added(Versions.v2025_11_15_preview)
model SyncEvalInput {
  /** Identifier of the evaluator. */
  data_source: CreateEvalJsonlRunDataSource;

  /** Evaluators to be used for the evaluation. */
  testing_criteria: AzureAIEvaluator[];

  /** Evaluation's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed. */
  properties?: Record<string>;

  /** Custom inference configuration. */
  customInference?: CustomInference;
}

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
  id: string;

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

@doc("Message content.")
@added(Versions.v2025_05_15_preview)
model Content {
  @doc("The type of content.")
  Messages: unknown[];
}

@doc("Represents the data transfer object for an annotation.")
@added(Versions.v2025_05_15_preview)
model AnnotationDTO {
  @doc("The task associated with the annotation.")
  AnnotationTask: string;

  @doc("The type of content being annotated.")
  ContentType: string;

  @doc("A list of user-provided text inputs.")
  UserTextList: string[];

  @doc("A collection of content objects related to the annotation.")
  Contents: Content[];

  @doc("A list of metrics associated with the annotation.")
  MetricList: string[];

  @doc("The version of the prompt used for the annotation.")
  PromptVersion: string;

  @doc("The user agent information.")
  UserAgent: string;

  @doc("The partner identifier.")
  PartnerId: string;

  @doc("The model identifier.")
  ModelId: string;

  @doc("The type of inference performed.")
  InferenceType: string;

  @doc("The client request identifier.")
  ClientRequestId: string;
}

@doc("Upload a local SDK evaluation run. Currently update supports status, outputs, properties, and tags updates.")
@resource("runs")
@added(Versions.v2025_05_15_preview)
model EvaluationUpload {
  @doc("Identifier of the evaluation.")
  @key("name")
  @encodedName("application/json", "id")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Data for evaluation.")
  data?: InputData;

  @doc("Evaluation target specifying the model config and parameters")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  target?: EvaluationTarget;

  @doc("Display Name for evaluation. It helps to find the evaluation easily in AI Foundry. It does not need to be unique.")
  displayName?: string;

  @doc("Description of the evaluation. It can be used to store additional information about the evaluation and is mutable.")
  description?: string;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  @doc("Status of the evaluation. For upload: Failed or Completed.")
  status?: string;

  @doc("Evaluation's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Evaluation's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;

  @doc("Evaluators to be used for the evaluation.")
  evaluators?: Record<EvaluatorConfiguration>;

  @doc("Outputs of the evaluation as a dictionary of IDs. Example: { 'evaluationResultId': 'azureai://accounts/{AccountName}/projects/{myproject}/evaluationresults/{name}/versions/{version}'}")
  outputs?: Record<string>;
}
