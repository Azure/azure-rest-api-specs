import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";

import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-core/experimental";
import "@azure-tools/openai-typespec/models/evals";

import "../common/models.tsp";
import "../red-teams/models.tsp";

using Azure.Core.Experimental;

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

/** Grader Azure AI Evaluator definition for foundry evaluators. */
model GraderAzureAIEvaluator {
  /** The object type, which is always `azure_ai_evaluator`. */
  type: "azure_ai_evaluator";

  /** The name of the grader. */
  name: string;

  /** The name of the evaluator. */
  evaluator_name: string;

  /** The version of the evaluator. Latest version if not specified. */
  evaluator_version?: string;

  /** The initialization parameters for the evaluation. Must support structured outputs. */
  initialization_parameters?: {};

  /** The model to use for the evaluation. Must support structured outputs. */
  data_mapping?: Record<string>;
}

@summary("AzureAIEvaluatorGrader")
model EvalGraderAzureAIEvaluator {
  ...GraderAzureAIEvaluator;
}

/** Base class for run data sources with discriminator support. */
@discriminator("type")
model DataSourceConfig {
  /** The data source type discriminator. */
  type: string;

  /** The overall object JSON schema for the run data source items. */
  schema: Record<unknown>;
}

model AzureAIDataSourceConfig extends DataSourceConfig {
  /** The object type, which is always `azure_ai_source`. */
  type: "azure_ai_source";

  /** Data schema scenario. */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  scenario:
    | "red_team"
    | "responses"
    | "traces_preview"
    | "synthetic_data_gen_preview";
}

/** Adding Azure AI Source type to data source for foundry extension. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
#suppress "deprecated" "Deprecated status inherited from source OpenAI specification"
@@changePropertyType(OpenAI.Eval.data_source_config,

    | OpenAI.CreateEvalCustomDataSourceConfig
    | OpenAI.CreateEvalLogsDataSourceConfig
    | OpenAI.CreateEvalStoredCompletionsDataSourceConfig
    | AzureAIDataSourceConfig
);

/** Adding Azure AI Evaluator type to testing criteria for foundry extension. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
@@changePropertyType(OpenAI.Eval.testing_criteria,
  (
    | OpenAI.EvalGraderLabelModel
    | OpenAI.EvalGraderStringCheck
    | OpenAI.EvalGraderTextSimilarity
    | OpenAI.EvalGraderPython
    | OpenAI.EvalGraderScoreModel
    | EvalGraderAzureAIEvaluator)[]
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
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
#suppress "deprecated" "Deprecated status inherited from source OpenAI specification"
@@changePropertyType(OpenAI.CreateEvalRequest.data_source_config,

    | OpenAI.CreateEvalCustomDataSourceConfig
    | OpenAI.CreateEvalLogsDataSourceConfig
    | OpenAI.CreateEvalStoredCompletionsDataSourceConfig
    | AzureAIDataSourceConfig
);

/** Adding Azure AI Evaluator type to testing criteria for foundry extension. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
@@changePropertyType(OpenAI.CreateEvalRequest.testing_criteria,
  (
    | OpenAI.EvalGraderLabelModel
    | OpenAI.EvalGraderStringCheck
    | OpenAI.EvalGraderTextSimilarity
    | OpenAI.EvalGraderPython
    | OpenAI.EvalGraderScoreModel
    | EvalGraderAzureAIEvaluator)[]
);
model CreateEvalRequest is OpenAI.CreateEvalRequest {
  /**
    Set of immutable 16 key-value pairs that can be attached to an object for storing additional information.
    Keys are strings with a maximum length of 64 characters. Values are strings with a maximum length of 512 characters.
  */
  properties?: Record<string>;
}

/** The types of parameters for red team item generation. */
union ItemGenerationParamsType {
  string,

  /** Parameters for red team. */
  redTeam: "red_team",

  /** The ResponseRetrieval item generation parameters. */
  responseRetrieval: "response_retrieval",

  /** Parameters for red team seed prompts. */
  redTeamSeedPrompts: "red_team_seed_prompts",

  /** Parameters for red team taxonomy item generation. */
  redTeamTaxonomy: "red_team_taxonomy",

  /** Parameters for synthetic data item generation. */
  syntheticData: "synthetic_data_gen_preview",
}

/** Represents the set of parameters used to control item generation operations. */
@discriminator("type")
model ItemGenerationParams {
  /** The type of item generation parameters to use. */
  type: ItemGenerationParamsType;
}

model RedTeamItemGenerationParams extends ItemGenerationParams {
  /** The type of item generation parameters. */
  type: ItemGenerationParamsType.redTeam;

  /** The collection of attack strategies to be used. */
  attack_strategies: AttackStrategy[];

  /** The number of turns allowed in the game. */
  num_turns: int32 = 20;
}

/** Represents the parameters for red team seed prompts item generation. */
model RedTeamSeedPromptsItemGenerationParams extends ItemGenerationParams {
  /** The type of item generation parameters, always `red_team_seed_prompts`. */
  type: ItemGenerationParamsType.redTeamSeedPrompts;

  /** The collection of attack strategies to be used. */
  attack_strategies: AttackStrategy[];

  /** The number of turns allowed in the game. */
  num_turns: int32 = 20;

  /** The source of JSONL content to be processed. */
  source: OpenAI.EvalJsonlFileContentSource;
}

/** Represents the parameters for red team taxonomy item generation. */
model RedTeamTaxonomyItemGenerationParams extends ItemGenerationParams {
  /** The type of item generation parameters, always `red_team_taxonomy`. */
  type: ItemGenerationParamsType.redTeamTaxonomy;

  /** The collection of attack strategies to be used. */
  attack_strategies: AttackStrategy[];

  /** The number of turns allowed in the game. */
  num_turns: int32 = 20;

  /** The source from which JSONL content is read. */
  source: OpenAI.EvalJsonlFileContentSource;
}

/** Represents the parameters for response retrieval item generation. */
model ResponseRetrievalItemGenerationParams extends ItemGenerationParams {
  /** The type of item generation parameters, always `response_retrieval`. */
  type: ItemGenerationParamsType.responseRetrieval;

  /** The maximum number of turns of chat history to evaluate. */
  max_num_turns: int32;

  /** Mapping from source fields to response_id field, required for retrieving chat history. */
  data_mapping: Record<string>;

  /** The source from which JSONL content is read. */
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  source: OpenAI.EvalJsonlFileContentSource | OpenAI.EvalJsonlFileIdSource;
}

/** Base class for targets with discriminator support. */
@discriminator("type")
model Target {
  /** The type of target. */
  type: string;
}

/** Represents a target specifying an Azure AI model for operations requiring model selection. */
model AzureAIModelTarget extends Target {
  /** The type of target, always `azure_ai_model`. */
  type: "azure_ai_model";

  /** The unique identifier of the Azure AI model. */
  `model`?: string;

  /** The parameters used to control the sampling behavior of the model during text generation. */
  sampling_params?: ModelSamplingParams;
}

/** Represents a target specifying an Azure AI agent. */
model AzureAIAgentTarget extends Target {
  /** The type of target, always `azure_ai_agent`. */
  type: "azure_ai_agent";

  /** The unique identifier of the Azure AI agent. */
  name: string;

  /** The version of the Azure AI agent. */
  version?: string;

  /** The parameters used to control the sampling behavior of the agent during text generation. */
  tool_descriptions?: ToolDescription[];
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
model TracesPreviewEvalRunDataSource extends EvalRunDataSource {
  /** The type of data source, always `azure_ai_traces_preview`. */
  type: "azure_ai_traces_preview";

  /** Collection of Agent trace identifiers that should be evaluated. */
  trace_ids?: string[];

  /** The agent ID used to filter traces for evaluation. */
  agent_id?: string;

  /** The agent name used to filter traces for evaluation. */
  agent_name?: string;

  /**
    Lookback window (in hours) applied when retrieving traces from Application Insights.
    For scheduled evaluations this is inferred from the recurrence interval.
  */
  lookback_hours?: int32 = 168;

  /** Unix timestamp (in seconds) marking the end of the trace query window. Defaults to the current time. */
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  end_time?: utcDateTime;

  /** Sampling limit applied to traces retrieved for evaluation. */
  max_traces?: int32 = 1000;

  /**
   * The delay to apply for ingestion when querying traces.
   */
  @encode(DurationKnownEncoding.seconds, int32)
  ingestion_delay_seconds?: duration = duration.fromISO("PT5M");
}

/** Represents a data source for evaluation runs that evaluates based on generated synthetic data for testing purposes. */
model SyntheticDataGenerationPreviewEvalRunDataSource
  extends EvalRunDataSource {
  /** The type of data source, always `azure_ai_synthetic_data_gen_preview`. */
  type: "azure_ai_synthetic_data_gen_preview";

  /** The parameters for item generation. */
  item_generation_params: SyntheticDataGenerationPreviewItemGenerationParams;

  /** The target configuration for the evaluation. */
  target: Target;

  /** Input messages template configuration applicable only if target is of type 'azure_ai_model' */
  input_messages?: OpenAI.CreateEvalResponsesRunDataSourceInputMessagesTemplate;
}

model SyntheticDataGenerationPreviewItemGenerationParams
  extends ItemGenerationParams {
  /** The type of item generation parameters. */
  type: ItemGenerationParamsType.syntheticData;

  /** The maximum number of data samples to generate. */
  samples_count: int32;

  /** The prompt used for generating synthetic data. This is option if target is of type 'azure_ai_agent' with instructions configured in agent. */
  prompt?: string;

  /** The name of the model deployment to use for generating synthetic data. */
  model_deployment_name: string;

  /** The name of the output dataset where generated synthetic data will be stored. If not provided, service generates dataset name automatically. */
  output_dataset_name?: string;

  /** The identifier of the output dataset where generated synthetic data is stored. The generated data is a jsonl file with columns id, query and test_description. */
  @visibility(Lifecycle.Read)
  output_dataset_id?: string;

  /** The optional seed data content source files for data generation. */
  sources: OpenAI.EvalJsonlFileIdSource[];
}

/** Represents a data source for evaluation runs that are specific to Continuous Evaluation scenarios. */
model AzureAIResponsesEvalRunDataSource extends EvalRunDataSource {
  /** The type of data source, always `azure_ai_responses`. */
  type: "azure_ai_responses";

  /** The parameters for item generation. */
  item_generation_params: ResponseRetrievalItemGenerationParams;

  /** Maximum number of evaluation runs allowed per hour. */
  max_runs_hourly: int32;

  /** The event configuration name associated with this evaluation run. */
  event_configuration_id: string;
}

/** Represents a data source for target-based completion evaluation configuration. */
model TargetCompletionEvalRunDataSource extends EvalRunDataSource {
  /** The type of data source, always `azure_ai_target_completions`. */
  type: "azure_ai_target_completions";

  /** Input messages configuration. */
  input_messages?: OpenAI.CreateEvalCompletionsRunDataSourceInputMessagesItemReference;

  /** The source configuration for inline or file data. */
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  source: OpenAI.EvalJsonlFileContentSource | OpenAI.EvalJsonlFileIdSource;

  /** The target configuration for the evaluation. */
  target: Target;
}

model RedTeamEvalRunDataSource extends EvalRunDataSource {
  /** The type of data source. Always `azure_ai_red_team`. */
  type: "azure_ai_red_team";

  /** The parameters for item generation. */
  item_generation_params: ItemGenerationParams;

  /** The target configuration for the evaluation. */
  target: Target;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
@@changePropertyType(OpenAI.EvalRun.data_source,

    | OpenAI.CreateEvalJsonlRunDataSource
    | OpenAI.CreateEvalCompletionsRunDataSource
    | OpenAI.CreateEvalResponsesRunDataSource
    | EvalRunDataSource /* RedTeamEvalRunDataSource | TargetCompletionsEvalRunDataSource | AzureAIResponsesEvalRunDataSource | TracesPreviewEvalRunDataSource */
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
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
@@changePropertyType(OpenAI.CreateEvalRunRequest.data_source,

    | OpenAI.CreateEvalJsonlRunDataSource
    | OpenAI.CreateEvalCompletionsRunDataSource
    | OpenAI.CreateEvalResponsesRunDataSource
    | EvalRunDataSource /* RedTeamEvalRunDataSource | TargetCompletionsEvalRunDataSource | AzureAIResponsesEvalRunDataSource | TracesPreviewEvalRunDataSource */
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
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyProperties(OpenAI.EvalRunOutputItemResult,
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

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@changePropertyType(OpenAI.EvalRunOutputItem.results,
  EvalRunOutputItemResult[]
);

model EvalRunOutputItem is OpenAI.EvalRunOutputItem;

/** A message in the evaluation run. */
model EvalRunOutputItemSampleOutput is OpenAI.EvalRunOutputItemSampleOutput {
  /** Tool calls made within the message, if any. */
  tool_calls: CompletionMessageToolCallChunk[];
}

/** A message in the evaluation run. */
model EvalRunOutputItemSampleInput is OpenAI.EvalRunOutputItemSampleInput {
  /** Tool calls made within the message, if any. */
  tool_calls: CompletionMessageToolCallChunk[];
}

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@changePropertyType(OpenAI.EvalRunOutputItemSample.input,
  EvalRunOutputItemSampleInput[]
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@changePropertyType(OpenAI.EvalRunOutputItemSample.output,
  EvalRunOutputItemSampleOutput[]
);

model EvalRunOutputItemSample is OpenAI.EvalRunOutputItemSample;

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
