/*
 * This file was automatically generated from an OpenAPI .yaml file.
 * Edits made directly to this file will be lost.
 */

import "../chat";
import "../common";
import "../responses";
import "./custom.tsp";

using TypeSpec.OpenAPI;

namespace OpenAI;

// Tool generated type. Extracts from EvalRunFileContentDataContentSource.content
alias EvalRunFileContentDataContentSourceContent = {
  item: Record<unknown>;
  sample?: Record<unknown>;
};

// Tool generated type. Extracts from EvalRun.per_model_usage
alias EvalRunPerModelUsage = {
  /** The name of the model. */
  model_name: string;

  /** The number of invocations. */
  invocation_count: int32;

  /** The number of prompt tokens used. */
  prompt_tokens: int32;

  /** The number of completion tokens generated. */
  completion_tokens: int32;

  /** The total number of tokens used. */
  total_tokens: int32;

  /** The number of tokens retrieved from cache. */
  cached_tokens: int32;
};

// Tool generated type. Extracts from EvalRun.per_testing_criteria_results
alias EvalRunPerTestingCriteriaResult = {
  /** A description of the testing criteria. */
  testing_criteria: string;

  /** Number of tests passed for this criteria. */
  passed: int32;

  /** Number of tests failed for this criteria. */
  failed: int32;
};

// Tool generated type. Extracts from EvalRunOutputItem.sample.input
alias EvalRunOutputItemSampleInput = {
  /** The role of the message sender (e.g., system, user, developer). */
  role: string;

  /** The content of the message. */
  content: string;
};

// Tool generated type. Extracts from EvalRunOutputItem.sample.output
alias EvalRunOutputItemSampleOutput = {
  /** The role of the message (e.g. "system", "assistant", "user"). */
  role?: string;

  /** The content of the message. */
  content?: string;
};

model CreateEvalRequest {
  /** The name of the evaluation. */
  name?: string;

  ...MetadataPropertyForRequest;

  // Tool customization: Use discriminated type
  /** The configuration for the data source used for the evaluation runs. Dictates the schema of the data used in the evaluation. */
  data_source_config: EvalDataSourceConfigParams;

  // Tool customization: Use discriminated type
  @doc("""
    A list of graders for all eval runs in this group. Graders can reference variables in the data source using double curly braces notation, like `{{item.variable_name}}`. To reference the model's output, use the `sample` namespace (ie, `{{sample.output_text}}`).
    """)
  testing_criteria: EvalGraderParams[];
}

/**
 * An Eval object with a data source config and testing criteria.
 * An Eval represents a task to be done for your LLM integration.
 * Like:
 *  - Improve the quality of my chatbot
 *  - See how well my chatbot handles customer support
 *  - Check if o4-mini is better at my usecase than gpt-4o
 */
model Eval {
  /** The object type. */
  object: "eval" = "eval";

  /** Unique identifier for the evaluation. */
  id: string;

  /** The name of the evaluation. */
  name: string;

  // Tool customization: Use discriminated type
  /** Configuration of data sources used in runs of the evaluation. */
  data_source_config: EvalDataSourceConfigResource;

  // Tool customization: Use discriminated type
  /** A list of testing criteria. */
  testing_criteria: EvalGraderResource[] | null = null;

  // Tool customization: 'created' and fields ending in '_at' are Unix encoded utcDateTime
  /** The Unix timestamp (in seconds) for when the eval was created. */
  @encode("unixTimestamp", int32)
  created_at: utcDateTime;

  ...MetadataPropertyForResponse;
}

// Tool customization (apply_discriminator): Apply discriminated type
/**
 * A CustomDataSourceConfig object that defines the schema for the data source used for the evaluation runs.
 * This schema is used to define the shape of the data that will be:
 * - Used to define your testing criteria and
 * - What data is required when creating a run
 */
model EvalCustomDataSourceConfigParams extends EvalDataSourceConfigParams {
  @doc("""
    The type of data source. Always `custom`.
    """)
  type: EvalDataSourceConfigType.custom;

  /** The json schema for each row in the data source. */
  item_schema: Record<unknown>;

  /** Whether the eval should expect you to populate the sample namespace (ie, by generating responses off of your data source) */
  include_sample_schema?: boolean = false;
}

@doc("""
  A chat message that makes up the prompt or context. May include variable references to the `item` namespace, ie {{item.name}}.
  """)
union CreateEvalItem {
  {
    /** The role of the message (e.g. "system", "assistant", "user"). */
    role: string,

    /** The content of the message. */
    content: string,
  },
  EvalItem,
}

// Tool customization (apply_discriminator): Apply discriminated type
/** A JsonlRunDataSource object with that specifies a JSONL file that matches the eval */
model EvalJsonlRunDataSourceParams extends EvalRunDataSourceParams {
  @doc("""
    The type of data source. Always `jsonl`.
    """)
  type: EvalRunDataSourceType.jsonl;

  // Tool customization: Use updated discriminated type union
  @doc("""
    Determines what populates the `item` namespace in the data source.
    """)
  source: EvalRunFileContentDataContentSource | EvalRunFileIdDataContentSource;
}

// Tool customization (apply_discriminator): Apply discriminated type
/** A CompletionsRunDataSource object describing a model sampling configuration. */
model EvalCompletionsRunDataSourceParams extends EvalRunDataSourceParams {
  @doc("""
    The type of run data source. Always `completions`.
    """)
  type: EvalRunDataSourceType.completions;

  @doc("""
    Used when sampling from a model. Dictates the structure of the messages passed into the model. Can either be a reference to a prebuilt trajectory (ie, `item.input_trajectory`), or a template with variable references to the `item` namespace.
    """)
  input_messages?: {
    @doc("""
      The type of input messages. Always `template`.
      """)
    type: "template";

    @doc("""
      A list of chat messages forming the prompt or context. May include variable references to the `item` namespace, ie {{item.name}}.
      """)
    template: (EasyInputMessage | EvalItem)[];
  } | {
    @doc("""
      The type of input messages. Always `item_reference`.
      """)
    type: "item_reference";

    @doc("""
      A reference to a variable in the `item` namespace. Ie, "item.input_trajectory"
      """)
    item_reference: string;
  };

  sampling_params?: {
    /** A higher temperature increases randomness in the outputs. */
    temperature?: float32 = 1;

    /** The maximum number of tokens in the generated output. */
    max_completion_tokens?: int32;

    /** An alternative to temperature for nucleus sampling; 1.0 includes all tokens. */
    top_p?: float32 = 1;

    /** A seed value to initialize the randomness, during sampling. */
    seed?: int32 = 42;

    // Tool customization: Employ discriminated type base
    @doc("""
      An object specifying the format that the model must output.
      
      Setting to `{ "type": "json_schema", "json_schema": {...} }` enables
      Structured Outputs which ensures the model will match your supplied JSON
      schema. Learn more in the [Structured Outputs
      guide](/docs/guides/structured-outputs).
      
      Setting to `{ "type": "json_object" }` enables the older JSON mode, which
      ensures the message the model generates is valid JSON. Using `json_schema`
      is preferred for models that support it.
      """)
    response_format?: ResponseTextFormatConfiguration;

    /** A list of tools the model may call. Currently, only functions are supported as a tool. Use this to provide a list of functions the model may generate JSON inputs for. A max of 128 functions are supported. */
    tools?: ChatCompletionTool[];
  };

  /** The name of the model to use for generating completions (e.g. "o3-mini"). */
  `model`?: string;

  // Tool customization: Use updated discriminated type union
  @doc("""
    Determines what populates the `item` namespace in this run's data source.
    """)
  source: EvalRunFileContentDataContentSource | EvalRunFileIdDataContentSource | EvalRunStoredCompletionsDataContentSource;
}

// Tool customization (apply_discriminator): Apply discriminated type
/** A ResponsesRunDataSource object describing a model sampling configuration. */
model EvalResponsesRunDataSourceParams extends EvalRunDataSourceParams {
  @doc("""
    The type of run data source. Always `responses`.
    """)
  type: EvalRunDataSourceType.responses;

  @doc("""
    Used when sampling from a model. Dictates the structure of the messages passed into the model. Can either be a reference to a prebuilt trajectory (ie, `item.input_trajectory`), or a template with variable references to the `item` namespace.
    """)
  input_messages?: {
    @doc("""
      The type of input messages. Always `template`.
      """)
    type: "template";

    @doc("""
      A list of chat messages forming the prompt or context. May include variable references to the `item` namespace, ie {{item.name}}.
      """)
    template: ({
      /** The role of the message (e.g. "system", "assistant", "user"). */
      role: string;

      /** The content of the message. */
      content: string;
    } | EvalItem)[];
  } | {
    @doc("""
      The type of input messages. Always `item_reference`.
      """)
    type: "item_reference";

    @doc("""
      A reference to a variable in the `item` namespace. Ie, "item.name"
      """)
    item_reference: string;
  };

  sampling_params?: {
    /** A higher temperature increases randomness in the outputs. */
    temperature?: float32 = 1;

    /** The maximum number of tokens in the generated output. */
    max_completion_tokens?: int32;

    /** An alternative to temperature for nucleus sampling; 1.0 includes all tokens. */
    top_p?: float32 = 1;

    /** A seed value to initialize the randomness, during sampling. */
    seed?: int32 = 42;

    @doc("""
      An array of tools the model may call while generating a response. You
      can specify which tool to use by setting the `tool_choice` parameter.
      
      The two categories of tools you can provide the model are:
      
      - **Built-in tools**: Tools that are provided by OpenAI that extend the
        model's capabilities, like [web search](/docs/guides/tools-web-search)
        or [file search](/docs/guides/tools-file-search). Learn more about
        [built-in tools](/docs/guides/tools).
      - **Function calls (custom tools)**: Functions that are defined by you,
        enabling the model to call your own code. Learn more about
        [function calling](/docs/guides/function-calling).
      """)
    tools?: Tool[];

    /**
     * Configuration options for a text response from the model. Can be plain
     * text or structured JSON data. Learn more:
     * - [Text inputs and outputs](/docs/guides/text)
     * - [Structured Outputs](/docs/guides/structured-outputs)
     */
    text?: {
      // Tool customization: Employ discriminated type base
      format?: ResponseTextFormatConfiguration;
    };
  };

  /** The name of the model to use for generating completions (e.g. "o3-mini"). */
  `model`?: string;

  // Tool customization: Use updated discriminated type union
  @doc("""
    Determines what populates the `item` namespace in this run's data source.
    """)
  source: EvalRunFileContentDataContentSource | EvalRunFileIdDataContentSource | EvalRunResponsesDataContentSource;
}

// Tool customization (apply_discriminator): Apply discriminated type
@doc("""
  A data source config which specifies the metadata property of your logs query.
  This is usually metadata like `usecase=chatbot` or `prompt-version=v2`, etc.
  """)
model EvalLogsDataSourceConfigParams extends EvalDataSourceConfigParams {
  @doc("""
    The type of data source. Always `logs`.
    """)
  type: EvalDataSourceConfigType.logs;

  ...MetadataPropertyForRequest;
}

model CreateEvalRunRequest {
  /** The name of the run. */
  name?: string;

  ...MetadataPropertyForRequest;

  // Tool customization: Use discriminated type
  /** Details about the run's data source. */
  data_source: EvalRunDataSourceParams;
}

/** An object representing an error response from the Eval API. */
model EvalApiError {
  /** The error code. */
  code: string;

  /** The error message. */
  message: string;
}

// Tool customization (apply_discriminator): Apply discriminated type
@doc("""
  A CustomDataSourceConfig which specifies the schema of your `item` and optionally `sample` namespaces.
  The response schema defines the shape of the data that will be:
  - Used to define your testing criteria and
  - What data is required when creating a run
  """)
model EvalCustomDataSourceConfigResource extends EvalDataSourceConfigResource {
  @doc("""
    The type of data source. Always `custom`.
    """)
  type: EvalDataSourceConfigType.custom;

  /**
   * The json schema for the run data source items.
   * Learn how to build JSON schemas [here](https://json-schema.org/).
   */
  schema: Record<unknown>;
}

@doc("""
  A message input to the model with a role indicating instruction following
  hierarchy. Instructions given with the `developer` or `system` role take
  precedence over instructions given with the `user` role. Messages with the
  `assistant` role are presumed to have been generated by the model in previous
  interactions.
  """)
model EvalItem {
  @doc("""
    The role of the message input. One of `user`, `assistant`, `system`, or
    `developer`.
    """)
  role: "user" | "assistant" | "system" | "developer";

  // Tool customization: Use distinct evals item content definitions
  /** Text inputs to the model - can contain template strings. */
  content: string | EvalItemContent;

  @doc("""
    The type of the message input. Always `message`.
    """)
  type?: "message";
}

// Tool customization (apply_discriminator): Apply discriminated type
model EvalRunFileContentDataContentSource extends EvalRunDataContentSource {
  @doc("""
    The type of jsonl source. Always `file_content`.
    """)
  type: EvalRunDataContentSourceType.file_content;

  /** The content of the jsonl file. */
  content: EvalRunFileContentDataContentSourceContent[];
}

// Tool customization (apply_discriminator): Apply discriminated type
model EvalRunFileIdDataContentSource extends EvalRunDataContentSource {
  @doc("""
    The type of jsonl source. Always `file_id`.
    """)
  type: EvalRunDataContentSourceType.file_id;

  /** The identifier of the file. */
  id: string;
}

// Tool customization: Conform to spread inherited base
model EvalGraderLabelModelResource extends EvalGraderResource {
  ...GraderLabelModel;
}

// Tool customization: Conform to spread inherited base
model EvalGraderStringCheckResource {
  ...GraderStringCheck;
}

// Tool customization: Conform to spread inherited base
model EvalGraderTextSimilarityResource extends EvalGraderResource {
  ...GraderTextSimilarity;

  /** The threshold for the score. */
  pass_threshold: float32;
}

/** An object representing a list of evals. */
model EvalList {
  /** The type of this object. It is always set to "list". */
  object: "list" = "list";

  /** An array of eval objects. */
  data: Eval[];

  /** The identifier of the first eval in the data array. */
  first_id: string;

  /** The identifier of the last eval in the data array. */
  last_id: string;

  /** Indicates whether there are more evals available. */
  has_more: boolean;
}

// Tool customization: Conform to spread inherited base
model EvalGraderPythonResource extends EvalGraderResource {
  ...GraderPython;

  /** The threshold for the score. */
  pass_threshold?: float32;
}

// Tool customization (apply_discriminator): Apply discriminated type
/** A EvalResponsesSource object describing a run data source configuration. */
model EvalRunResponsesDataContentSource extends EvalRunDataContentSource {
  @doc("""
    The type of run data source. Always `responses`.
    """)
  type: EvalRunDataContentSourceType.responses;

  ...MetadataPropertyForRequest;

  /** The name of the model to find responses for. This is a query parameter used to select responses. */
  `model`?: string | null;

  /** Optional string to search the 'instructions' field. This is a query parameter used to select responses. */
  instructions_search?: string | null;

  /** Only include items created after this timestamp (inclusive). This is a query parameter used to select responses. */
  @minValue(0)
  created_after?: int32 | null;

  /** Only include items created before this timestamp (inclusive). This is a query parameter used to select responses. */
  @minValue(0)
  created_before?: int32 | null;

  /** Optional reasoning effort parameter. This is a query parameter used to select responses. */
  reasoning_effort?: ReasoningEffort | null = "medium";

  /** Sampling temperature. This is a query parameter used to select responses. */
  temperature?: float32 | null;

  /** Nucleus sampling parameter. This is a query parameter used to select responses. */
  top_p?: float32 | null;

  /** List of user identifiers. This is a query parameter used to select responses. */
  users?: string[] | null;

  /** List of tool names. This is a query parameter used to select responses. */
  tools?: string[] | null;
}

/** A schema representing an evaluation run. */
model EvalRun {
  /** The type of the object. Always "eval.run". */
  object: "eval.run" = "eval.run";

  /** Unique identifier for the evaluation run. */
  id: string;

  /** The identifier of the associated evaluation. */
  eval_id: string;

  /** The status of the evaluation run. */
  status: string;

  /** The model that is evaluated, if applicable. */
  `model`: string;

  /** The name of the evaluation run. */
  name: string;

  // Tool customization: 'created' and fields ending in '_at' are Unix encoded utcDateTime
  /** Unix timestamp (in seconds) when the evaluation run was created. */
  @encode("unixTimestamp", int32)
  created_at: utcDateTime;

  /** The URL to the rendered evaluation run report on the UI dashboard. */
  report_url: string;

  /** Counters summarizing the outcomes of the evaluation run. */
  result_counts: {
    /** Total number of executed output items. */
    total: int32;

    /** Number of output items that resulted in an error. */
    errored: int32;

    /** Number of output items that failed to pass the evaluation. */
    failed: int32;

    /** Number of output items that passed the evaluation. */
    passed: int32;
  };

  /** Usage statistics for each model during the evaluation run. */
  per_model_usage: EvalRunPerModelUsage[];

  /** Results per testing criteria applied during the evaluation run. */
  per_testing_criteria_results: EvalRunPerTestingCriteriaResult[];

  // Tool customization: Use split output model with discriminated type
  /** Information about the run's data source. */
  data_source: EvalRunDataSourceResource;

  ...MetadataPropertyForResponse;
  error: EvalApiError;
}

/** An object representing a list of runs for an evaluation. */
model EvalRunList {
  /** The type of this object. It is always set to "list". */
  object: "list" = "list";

  /** An array of eval run objects. */
  data: EvalRun[];

  /** The identifier of the first eval run in the data array. */
  first_id: string;

  /** The identifier of the last eval run in the data array. */
  last_id: string;

  /** Indicates whether there are more evals available. */
  has_more: boolean;
}

/** A schema representing an evaluation run output item. */
model EvalRunOutputItem {
  /** The type of the object. Always "eval.run.output_item". */
  object: "eval.run.output_item" = "eval.run.output_item";

  /** Unique identifier for the evaluation run output item. */
  id: string;

  /** The identifier of the evaluation run associated with this output item. */
  run_id: string;

  /** The identifier of the evaluation group. */
  eval_id: string;

  // Tool customization: 'created' and fields ending in '_at' are Unix encoded utcDateTime
  /** Unix timestamp (in seconds) when the evaluation run was created. */
  @encode("unixTimestamp", int32)
  created_at: utcDateTime;

  /** The status of the evaluation run. */
  status: string;

  /** The identifier for the data source item. */
  datasource_item_id: int32;

  /** Details of the input data source item. */
  datasource_item: Record<unknown>;

  /** A list of results from the evaluation run. */
  results: Record<unknown>[];

  /** A sample containing the input and output of the evaluation run. */
  sample: {
    /** An array of input messages. */
    input: EvalRunOutputItemSampleInput[];

    /** An array of output messages. */
    output: EvalRunOutputItemSampleOutput[];

    /** The reason why the sample generation was finished. */
    finish_reason: string;

    /** The model used for generating the sample. */
    `model`: string;

    /** Token usage details for the sample. */
    usage: {
      /** The total number of tokens used. */
      total_tokens: int32;

      /** The number of completion tokens generated. */
      completion_tokens: int32;

      /** The number of prompt tokens used. */
      prompt_tokens: int32;

      /** The number of tokens retrieved from cache. */
      cached_tokens: int32;
    };

    error: EvalApiError;

    /** The sampling temperature used. */
    temperature: float32;

    /** The maximum number of tokens allowed for completion. */
    max_completion_tokens: int32;

    /** The top_p value used for sampling. */
    top_p: float32;

    /** The seed used for generating the sample. */
    seed: int32;
  };
}

/** An object representing a list of output items for an evaluation run. */
model EvalRunOutputItemList {
  /** The type of this object. It is always set to "list". */
  object: "list" = "list";

  /** An array of eval run output item objects. */
  data: EvalRunOutputItem[];

  /** The identifier of the first eval run output item in the data array. */
  first_id: string;

  /** The identifier of the last eval run output item in the data array. */
  last_id: string;

  /** Indicates whether there are more eval run output items available. */
  has_more: boolean;
}

// Tool customization (apply_discriminator): Apply common discriminated base
/**
 * A LabelModelGrader object which uses a model to assign labels to each item
 * in the evaluation.
 */
model EvalGraderLabelModelParams extends EvalGraderParams {
  @doc("""
    The object type, which is always `label_model`.
    """)
  type: GraderType.label_model;

  /** The name of the grader. */
  name: string;

  /** The model to use for the evaluation. Must support structured outputs. */
  `model`: string;

  @doc("""
    A list of chat messages forming the prompt or context. May include variable references to the `item` namespace, ie {{item.name}}.
    """)
  input: CreateEvalItem[];

  /** The labels to classify to each item in the evaluation. */
  labels: string[];

  /** The labels that indicate a passing result. Must be a subset of labels. */
  passing_labels: string[];
}

// Tool customization: Conform to spread inherited base
model EvalGraderScoreModelResource extends EvalGraderResource {
  ...GraderScoreModel;

  /** The threshold for the score. */
  pass_threshold?: float32;
}

// Tool customization (apply_discriminator): Apply discriminated type
/** Deprecated in favor of LogsDataSourceConfig. */
#suppress "deprecated" "Warning unnecessary for spec description of deprecation"
#deprecated "This field is marked as deprecated."
model EvalStoredCompletionsDataSourceConfigParams
  extends EvalDataSourceConfigParams {
  @doc("""
    The type of data source. Always `stored_completions`.
    """)
  type: EvalDataSourceConfigType.stored_completions;

  /** Metadata filters for the stored completions data source. */
  metadata?: Record<unknown>;
}

// Tool customization (apply_discriminator): Apply discriminated type
/** Deprecated in favor of LogsDataSourceConfig. */
#suppress "deprecated" "Warning unnecessary for spec description of deprecation"
#deprecated "This field is marked as deprecated."
model EvalStoredCompletionsDataSourceConfigResource
  extends EvalDataSourceConfigResource {
  @doc("""
    The type of data source. Always `stored_completions`.
    """)
  type: EvalDataSourceConfigType.stored_completions;

  ...MetadataPropertyForResponse;

  /**
   * The json schema for the run data source items.
   * Learn how to build JSON schemas [here](https://json-schema.org/).
   */
  schema: Record<unknown>;
}

// Tool customization (apply_discriminator): Apply discriminated type
/** A StoredCompletionsRunDataSource configuration describing a set of filters */
model EvalRunStoredCompletionsDataContentSource
  extends EvalRunDataContentSource {
  @doc("""
    The type of source. Always `stored_completions`.
    """)
  type: EvalRunDataContentSourceType.stored_completions;

  ...MetadataPropertyForResponse;

  /** An optional model to filter by (e.g., 'gpt-4o'). */
  `model`?: string | null;

  /** An optional Unix timestamp to filter items created after this time. */
  created_after?: int32 | null;

  /** An optional Unix timestamp to filter items created before this time. */
  created_before?: int32 | null;

  /** An optional maximum number of items to return. */
  limit?: int32 | null;
}

// Tool customization (apply_discriminator): Apply discriminated type
@doc("""
  A LogsDataSourceConfig which specifies the metadata property of your logs query.
  This is usually metadata like `usecase=chatbot` or `prompt-version=v2`, etc.
  The schema returned by this data source config is used to defined what variables are available in your evals.
  `item` and `sample` are both defined when using this data source config.
  """)
model EvalLogsDataSourceConfigResource extends EvalDataSourceConfigResource {
  @doc("""
    The type of data source. Always `logs`.
    """)
  type: EvalDataSourceConfigType.logs;

  ...MetadataPropertyForResponse;

  /**
   * The json schema for the run data source items.
   * Learn how to build JSON schemas [here](https://json-schema.org/).
   */
  schema: Record<unknown>;
}
