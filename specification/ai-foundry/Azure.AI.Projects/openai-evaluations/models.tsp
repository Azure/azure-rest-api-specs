import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "@typespec/openapi";
import "../.external-readonly/openai.external.typespec/evals/models.tsp";
import "azure-ai-decorators";
import "../red-teams/models.tsp";

using TypeSpec.OpenAPI;
using Azure.AI.Decorators;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/** A deleted evaluation Object */
model DeleteEvalResponse {
  @doc("The object type. Always 'eval.deleted'.")
  object: "eval.deleted";

  @doc("id of the eval.")
  eval_id: string;

  @doc("Whether the eval was successfully deleted.")
  deleted: boolean;
}

/** A deleted evaluation run Object. */
model DeleteEvalRunResponse {
  @doc("The object type. Always 'eval.deleted'.")
  object?: "eval.deleted";

  @doc("id of the eval.")
  run_id?: string;

  @doc("Whether the eval was successfully deleted.")
  deleted?: boolean;
}

/** Azure AI Evaluator definition for foundry evaluators. */
model AzureAIEvaluator {
  /** The object type, which is always `label_model`. */
  @extension("x-stainless-const", true)
  type: "azure_ai_evaluator";

  /** The name of the grader. */
  name: string;

  /** The name of the evaluator. */
  evaluator_name: string;

  /** The version of the evaluator. */
  evaluator_version?: string;

  /** The initialization parameters for the evaluation. Must support structured outputs. */
  initialization_parameters?: {};

  /** The model to use for the evaluation. Must support structured outputs. */
  data_mapping?: Record<string>;
}

model AzureAISource {
  /** The object type, which is always `label_model`. */
  @extension("x-stainless-const", true)
  type: "azure_ai_source";

  /** Data schema scenario. */
  scenario: "red_team" | "responses" | "traces";
}

/** Adding Azure AI Source type to data source for foundry extension. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
@@changePropertyType(OpenAI.Eval.data_source_config,

    | OpenAI.CreateEvalCustomDataSourceConfig
    | OpenAI.CreateEvalLogsDataSourceConfig
    | OpenAI.CreateEvalStoredCompletionsDataSourceConfig
    | AzureAISource
);

/** Adding Azure AI Evaluator type to testing criteria for foundry extension. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
@@changePropertyType(OpenAI.Eval.testing_criteria,
  (
    | OpenAI.EvalGraderLabelModel
    | OpenAI.EvalGraderStringCheck
    | OpenAI.EvalGraderTextSimilarity
    | OpenAI.EvalGraderPython
    | OpenAI.EvalGraderScoreModel
    | TaxonomyRedTeamItemGenerationParams
    | SeedPromptsRedTeamItemGenerationParams
    | RedTeamItemGenerationParams
    | AzureAIEvaluator)[]
);

model Eval is OpenAI.Eval {
  /** Unix timestamp (in seconds) when the evaluation run was last modified. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  modified_at?: integer;

  /** the name of the person who created the run. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  created_by?: string;

  /**
    Set of immutable 16 key-value pairs that can be attached to an object for storing additional information.
    Keys are strings with a maximum length of 64 characters. Values are strings with a maximum length of 512 characters.
  */
  properties?: Record<string>;
}

/** Adding Azure AI Source type to data source for foundry extension. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
@@changePropertyType(OpenAI.CreateEvalRequest.data_source_config,

    | OpenAI.CreateEvalCustomDataSourceConfig
    | OpenAI.CreateEvalLogsDataSourceConfig
    | OpenAI.CreateEvalStoredCompletionsDataSourceConfig
    | AzureAISource
);

/** Adding Azure AI Evaluator type to testing criteria for foundry extension. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
@@changePropertyType(OpenAI.CreateEvalRequest.testing_criteria,
  (
    | OpenAI.EvalGraderLabelModel
    | OpenAI.EvalGraderStringCheck
    | OpenAI.EvalGraderTextSimilarity
    | OpenAI.EvalGraderPython
    | OpenAI.EvalGraderScoreModel
    | TaxonomyRedTeamItemGenerationParams
    | SeedPromptsRedTeamItemGenerationParams
    | RedTeamItemGenerationParams
    | AzureAIEvaluator)[]
);
model CreateEvalRequest is OpenAI.CreateEvalRequest {
  /**
    Set of immutable 16 key-value pairs that can be attached to an object for storing additional information.
    Keys are strings with a maximum length of 64 characters. Values are strings with a maximum length of 512 characters.
  */
  properties?: Record<string>;
}

/** Represents the parameters for red team item generation. */
model RedTeamItemGenerationParams {
  /** The type of item generation parameters, always `red_team`. */
  @extension("x-stainless-const", true)
  type: "red_team";

  /** The collection of attack strategies to be used. */
  attack_strategies: AttackStrategy[];

  /** The number of turns allowed in the game. */
  num_turns: int32;
}

/** Represents the parameters for red team item generation with seed prompts. */
model SeedPromptsRedTeamItemGenerationParams {
  /** The type of item generation parameters, always `red_team`. */
  @extension("x-stainless-const", true)
  type: "red_team_seed_prompts";

  /** The collection of attack strategies to be used. */
  attack_strategies: AttackStrategy[];

  /** The number of turns allowed in the game. */
  num_turns: int32;

  /** The collection of attack strategies to be used. */
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
  source: OpenAI.EvalJsonlFileContentSource | OpenAI.EvalJsonlFileIdSource;
}

/** Represents the parameters for red team item generation with seed prompts. */
model TaxonomyRedTeamItemGenerationParams {
  /** The type of item generation parameters, always `red_team`. */
  @extension("x-stainless-const", true)
  type: "red_team_taxonomy";

  /** The collection of attack strategies to be used. */
  attack_strategies: AttackStrategy[];

  /** The number of turns allowed in the game. */
  num_turns: int32;

  /** The collection of attack strategies to be used. */
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
  source: OpenAI.EvalJsonlFileContentSource | OpenAI.EvalJsonlFileIdSource;
}

/** Represents the set of parameters used to control item generation operations. */
@discriminator("type")
model ItemGenerationParams {
  /** The type of item generation parameters to use. */
  @extension("x-stainless-const", true)
  type: string;
}

/** Represents the parameters for continuous evaluation item generation. */
model ContinuousEvalItemGenerationParams extends ItemGenerationParams {
  /** The type of item generation parameters, always `ResponseRetrieval`. */
  @extension("x-stainless-const", true)
  type: "response_retrieval";

  /** The maximum number of turns of chat history to evaluate. */
  max_num_turns: int32;

  /** Mapping from source fields to response_id field, required for retrieving chat history. */
  data_mapping: Record<string>;

  /** The source from which JSONL content is read. */
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
  source: OpenAI.EvalJsonlFileContentSource | OpenAI.EvalJsonlFileIdSource;
}

/** Base class for targets with discriminator support. */
@discriminator("type")
model Target {
  /** The type of target. */
  @extension("x-stainless-const", true)
  type: string;
}

/** Represents a target specifying an Azure AI model for operations requiring model selection. */
model AzureAIModelTarget extends Target {
  /** The type of target, always `azure_ai_model`. */
  @extension("x-stainless-const", true)
  type: "azure_ai_model";

  /** The unique identifier of the Azure AI model. */
  `model`?: string;

  /** The parameters used to control the sampling behavior of the model during text generation. */
  sampling_params?: ModelSamplingParams;
}

/** Represents a target specifying an Azure AI agent. */
model AzureAIAgentTarget extends Target {
  /** The type of target, always `azure_ai_agent`. */
  @extension("x-stainless-const", true)
  type: "azure_ai_agent";

  /** The unique identifier of the Azure AI agent. */
  name: string;

  /** The version of the Azure AI agent. */
  version?: string;

  /** The parameters used to control the sampling behavior of the agent during text generation. */
  tool_descriptions?: ToolDescription[];
}

/** Represents a target specifying an Azure AI Assistant (Agent V1) endpoint, including its id. */
model AzureAIAssistantTarget extends Target {
  /** The type of target, always `azure_ai_assistant`. */
  @extension("x-stainless-const", true)
  type: "azure_ai_assistant";

  /** The unique identifier of the Azure AI Assistant. */
  id?: string;

  /** The descriptions of tools available to the assistant. */
  tool_descriptions: ToolDescription[];
}

/** Description of a tool that can be used by an agent. */
model ToolDescription {
  /** The name of the tool. */
  name?: string;

  /** A brief description of the tool's purpose. */
  description?: string;
}

/** Represents a set of parameters used to control the sampling behavior of a language model during text generation. */
model ModelSamplingParams {
  /** The temperature parameter for sampling. */
  temperature: float32;

  /** The top-p parameter for nucleus sampling. */
  top_p: float32;

  /** The random seed for reproducibility. */
  seed: int32;

  /** The maximum number of tokens allowed in the completion. */
  max_completion_tokens: int32;
}

/** Base class for run data sources with discriminator support. */
@discriminator("type")
model EvalRunDataSource {
  /** The data source type discriminator. */
  type: string;
}

/** Represents a data source for evaluation runs that operate over Agent traces stored in Application Insights. */
model TracesEvalRunDataSource extends EvalRunDataSource {
  /** The type of data source, always `azure_ai_traces`. */
  @extension("x-stainless-const", true)
  type: "azure_ai_traces";

  /** Collection of Agent trace identifiers that should be evaluated. */
  trace_ids: string[];

  /** Lookback window (in hours) applied when retrieving traces from Application Insights. */
  lookback_hours?: int32 = 168;
}

/** Represents a data source for evaluation runs that are specific to Continuous Evaluation scenarios. */
model AzureAIResponses extends EvalRunDataSource {
  /** The type of data source, always `AzureAIResponses`. */
  @extension("x-stainless-const", true)
  type: "azure_ai_responses";

  /** The parameters for item generation. */
  item_generation_params: ContinuousEvalItemGenerationParams;

  /** Maximum number of evaluation runs allowed per hour. */
  max_runs_hourly: int32;

  /** The event configuration name associated with this evaluation run. */
  event_configuration_id: string;
}

/** Represents a data source for target-based completion evaluation configuration. */
model TargetCompletions extends EvalRunDataSource {
  /** The type of data source, always `TargetCompletions`. */
  @extension("x-stainless-const", true)
  type: "azure_ai_target_completions";

  /** Input messages configuration. */
  input_messages?: OpenAI.CreateEvalCompletionsRunDataSourceInputMessagesItemReference;

  /** The source configuration for inline or file data. */
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
  source: OpenAI.EvalJsonlFileContentSource | OpenAI.EvalJsonlFileIdSource;

  /** The target configuration for the evaluation. */
  target: Target;
}

model AzureAIRedTeam {
  /** The type of data source. Always `azure_ai_red_team`. */
  @extension("x-stainless-const", true)
  type: "azure_ai_red_team";

  /** The parameters for item generation. */
  item_generation_params: RedTeamItemGenerationParams;

  /** The target configuration for the evaluation. */
  target: Target;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
@@changePropertyType(OpenAI.EvalRun.data_source,

    | OpenAI.CreateEvalJsonlRunDataSource
    | OpenAI.CreateEvalCompletionsRunDataSource
    | OpenAI.CreateEvalResponsesRunDataSource
    | AzureAIRedTeam
    | TargetCompletions
    | AzureAIResponses
    | TracesEvalRunDataSource
);

model EvalRun is OpenAI.EvalRun {
  /** Unix timestamp (in seconds) when the evaluation run was last modified. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  modified_at?: integer;

  /** the name of the person who created the run. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  created_by?: string;

  /**
    Set of immutable 16 key-value pairs that can be attached to an object for storing additional information.
    Keys are strings with a maximum length of 64 characters. Values are strings with a maximum length of 512 characters.
  */
  properties?: Record<string>;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Imported from OpenAI spec."
@@changePropertyType(OpenAI.CreateEvalRunRequest.data_source,

    | OpenAI.CreateEvalJsonlRunDataSource
    | OpenAI.CreateEvalCompletionsRunDataSource
    | OpenAI.CreateEvalResponsesRunDataSource
    | AzureAIRedTeam
    | TargetCompletions
    | AzureAIResponses
    | TracesEvalRunDataSource
);

model CreateEvalRunRequest is OpenAI.CreateEvalRunRequest {
  /**
    Set of immutable 16 key-value pairs that can be attached to an object for storing additional information.
    Keys are strings with a maximum length of 64 characters. Values are strings with a maximum length of 512 characters.
  */
  properties?: Record<string>;
}

model UpdateEvalParametersBody is OpenAI.UpdateEvalParametersBody {
  /**
    Set of immutable 16 key-value pairs that can be attached to an object for storing additional information.
    Keys are strings with a maximum length of 64 characters. Values are strings with a maximum length of 512 characters.
  */
  properties?: Record<string>;
}

/** Represents the result of an evaluation run output item. */
@@extendModel(OpenAI.EvalRunOutputItemResult,
  {
    /** The name of the metric (e.g., "fluency", "f1_score"). */
    metric?: string,

    /** The label associated with the test criteria metric (e.g., "pass", "fail", "good", "bad"). */
    label?: string,

    /** The threshold used to determine pass/fail for this test criteria, if it is numerical. */
    threshold?: float32,

    /** The reason for the test criteria metric. */
    reason?: string,

    /** Additional details about the test criteria metric. */
    properties?: Record<string>,
  }
);

model EvalRunOutputItemResult is OpenAI.EvalRunOutputItemResult;

@@changePropertyType(OpenAI.EvalRunOutputItem.results,
  EvalRunOutputItemResult[]
);

model EvalRunOutputItem is OpenAI.EvalRunOutputItem;

/** Represents a sample from an evaluation run output item. */
model EvaluationRunOutputItemSample {
  /** An array of input messages. */
  input: EvaluationRunOutputItemMessage[];

  /** An array of output messages. */
  output: EvaluationRunOutputItemMessage[];

  /** The reason why the sample generation was finished. */
  finish_reason: string;

  /** The model used for generating the sample. */
  `model`: string;

  /** An object representing an error response from the Eval API. */
  error: OpenAI.EvalApiError;

  /** Token usage details for the sample. */
  usage?: SampleGenerationUsage;

  /** The seed used for generating the sample. */
  seed?: int32;

  /** The sampling temperature used. */
  temperature?: float32;

  /** The top_p value used for sampling. */
  top_p?: float32;

  /** The maximum number of tokens allowed for the entire completion. */
  max_completion_tokens?: int32;
}

/** Token usage details for an evaluation run sample. */
model SampleGenerationUsage {
  /** The number of tokens retrieved from cache. */
  cached_tokens: int32;

  /** The number of completion tokens generated. */
  completion_tokens: int32;

  /** The number of prompt tokens used. */
  prompt_tokens: int32;

  /** The total number of tokens used. */
  total_tokens: int32;
}

/** A message in the evaluation run. */
model EvaluationRunOutputItemMessage {
  /** Tool calls made within the message, if any. */
  tool_calls: CompletionMessageToolCallChunk[];
}

/** Tool call details within a message. */
model CompletionMessageToolCallChunk {
  /** The Id for the tool call. */
  id: string;

  /** The type of tool call, which is always "function". */
  type: "function";

  /** Details of the function tool call, if applicable. */
  function?: FunctionToolCall;
}

/** Details of a function tool call. */
model FunctionToolCall {
  /** The name of the function to call. */
  name: string;

  /** The arguments to call the function with, as generated by the model in JSON format. */
  arguments: string;
}
