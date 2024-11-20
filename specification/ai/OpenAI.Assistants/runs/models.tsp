import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";
import "../common/models.tsp";
import "../threads/models.tsp";
import "../tools/models.tsp";

namespace Azure.AI.OpenAI.Assistants;

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

@doc("Data representing a single evaluation run of an assistant thread.")
@added(ServiceApiVersions.v2024_02_15_preview)
model ThreadRun {
  @doc("The identifier, which can be referenced in API endpoints.")
  id: string;

  @doc("The object type, which is always 'thread.run'.")
  object: "thread.run";

  @encodedName("application/json", "thread_id")
  @doc("The ID of the thread associated with this run.")
  threadId: string;

  @encodedName("application/json", "assistant_id")
  @doc("The ID of the assistant associated with the thread this run was performed against.")
  assistantId: string;

  @doc("The status of the assistant thread run.")
  status: RunStatus;

  // Internal note: API reference describes this as nullable and the spec explicitly defines it as required and
  //                nullable, but actual test traffic confirms that runs without tool calls do not present
  //                required_action on their responses. We split the difference to be optional and nullable.
  //                https://platform.openai.com/docs/api-reference/runs/object#runs/object-expires_at
  //                https://github.com/openai/openai-openapi/blob/master/openapi.yaml#L8245
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "required_action")
  @doc("The details of the action required for the assistant thread run to continue.")
  requiredAction?: RequiredAction | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "last_error")
  @doc("The last error, if any, encountered by this assistant thread run.")
  lastError: RunError | null;

  @doc("The ID of the model to use.")
  `model`: string;

  @doc("The overridden system instructions used for this assistant thread run.")
  instructions: string;

  @doc("The overridden enabled tools used for this assistant thread run.")
  tools: ToolDefinition[] = #[];

  @encodedName("application/json", "created_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this object was created.")
  createdAt: utcDateTime;

  // Internal note: API reference describes this as non-nullable, but retrieveThreadRun gets a null expiresAt
  //                for completed runs.
  //                https://platform.openai.com/docs/api-reference/runs/object#runs/object-expires_at
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "expires_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this item expires.")
  expiresAt: utcDateTime | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "started_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this item was started.")
  startedAt: utcDateTime | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "completed_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this completed.")
  completedAt: utcDateTime | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "cancelled_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this was cancelled.")
  cancelledAt: utcDateTime | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "failed_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this failed.")
  failedAt: utcDateTime | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "incomplete_details")
  @doc("Details on why the run is incomplete. Will be `null` if the run is not incomplete.")
  incompleteDetails: IncompleteRunDetails | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("Usage statistics related to the run. This value will be `null` if the run is not in a terminal state (i.e. `in_progress`, `queued`, etc.).")
  @added(ServiceApiVersions.v2024_02_15_preview)
  usage: RunCompletionUsage | null;

  /** The sampling temperature used for this run. If not set, defaults to 1. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @added(ServiceApiVersions.v2024_05_01_preview)
  temperature?: float32 | null;

  /** The nucleus sampling value used for this run. If not set, defaults to 1. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "top_p")
  @added(ServiceApiVersions.v2024_05_01_preview)
  topP?: float32 | null;

  /** The maximum number of prompt tokens specified to have been used over the course of the run. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "max_prompt_tokens")
  @added(ServiceApiVersions.v2024_05_01_preview)
  @minValue(256)
  maxPromptTokens: int32 | null;

  /** The maximum number of completion tokens specified to have been used over the course of the run. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "max_completion_tokens")
  @added(ServiceApiVersions.v2024_05_01_preview)
  @minValue(256)
  maxCompletionTokens: int32 | null;

  /** The strategy to use for dropping messages as the context windows moves forward. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "truncation_strategy")
  @added(ServiceApiVersions.v2024_05_01_preview)
  truncationStrategy: TruncationObject | null;

  /** Controls whether or not and which tool is called by the model. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "tool_choice")
  @added(ServiceApiVersions.v2024_05_01_preview)
  toolChoice: AssistantsApiToolChoiceOption | null;

  /**
   * Whether to enable parallel function calling during tool use.
   */
  @added(ServiceApiVersions.v2024_09_01_preview)
  @encodedName("application/json", "parallel_tool_calls")
  parallelToolCalls: boolean;

  /** The response format of the tool calls used in this run. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "response_format")
  @added(ServiceApiVersions.v2024_05_01_preview)
  responseFormat: AssistantsApiResponseFormatOption | null;

  ...RequiredNullableMetadata;
}

/** The reason why the run is incomplete. This will point to which specific token limit was reached over the course of the run. */
@added(ServiceApiVersions.v2024_02_15_preview)
union IncompleteRunDetails {
  string,

  /** Maximum completion tokens exceeded */
  maxCompletionTokens: "max_completion_tokens",

  /** Maximum prompt tokens exceeded */
  maxPromptTokens: "max_prompt_tokens",
}

/**
 * Usage statistics related to the run. This value will be `null` if the run is not in a terminal state (i.e. `in_progress`, `queued`, etc.).
 */
@added(ServiceApiVersions.v2024_02_15_preview)
model RunCompletionUsage {
  @doc("Number of completion tokens used over the course of the run.")
  @encodedName("application/json", "completion_tokens")
  completionTokens: int64;

  @doc("Number of prompt tokens used over the course of the run.")
  @encodedName("application/json", "prompt_tokens")
  promptTokens: int64;

  @doc("Total number of tokens used (prompt + completion).")
  @encodedName("application/json", "total_tokens")
  totalTokens: int64;
}

@doc("The details used when creating a new run of an assistant thread.")
@added(ServiceApiVersions.v2024_02_15_preview)
model CreateRunOptions {
  @doc("The ID of the assistant that should run the thread.")
  @encodedName("application/json", "assistant_id")
  assistantId: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The overridden model name that the assistant should use to run the thread.")
  `model`?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The overridden system instructions that the assistant should use to run the thread.")
  instructions?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "additional_instructions")
  @doc("""
    Additional instructions to append at the end of the instructions for the run. This is useful for modifying the behavior
    on a per-run basis without overriding other instructions.
    """)
  additionalInstructions?: string | null;

  /** Adds additional messages to the thread before creating the run. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "additional_messages")
  @added(ServiceApiVersions.v2024_05_01_preview)
  additionalMessages?: ThreadMessage[] | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The overridden list of enabled tools that the assistant should use to run the thread.")
  tools?: ToolDefinition[] | null;

  /**
   * Whether to enable parallel function calling during tool use.
   */
  @added(ServiceApiVersions.v2024_09_01_preview)
  @encodedName("application/json", "parallel_tool_calls")
  parallelToolCalls?: boolean = true;

  /**
   * If `true`, returns a stream of events that happen during the Run as server-sent events,
   * terminating when the Run enters a terminal state with a `data: [DONE]` message.
   */
  @added(ServiceApiVersions.v2024_02_15_preview)
  stream?: boolean;

  /**
   * What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output
   * more random, while lower values like 0.2 will make it more focused and deterministic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @minValue(0)
  @maxValue(2)
  @added(ServiceApiVersions.v2024_05_01_preview)
  temperature?: float32 | null = 1;

  /**
   * An alternative to sampling with temperature, called nucleus sampling, where the model
   * considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens
   * comprising the top 10% probability mass are considered.
   *
   * We generally recommend altering this or temperature but not both.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @minValue(0)
  @maxValue(1)
  @encodedName("application/json", "top_p")
  @added(ServiceApiVersions.v2024_05_01_preview)
  topP?: float32 | null = 1;

  /**
   * The maximum number of prompt tokens that may be used over the course of the run. The run will make a best effort to use only
   * the number of prompt tokens specified, across multiple turns of the run. If the run exceeds the number of prompt tokens specified,
   * the run will end with status `incomplete`. See `incomplete_details` for more info.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @minValue(256)
  @encodedName("application/json", "max_prompt_tokens")
  @added(ServiceApiVersions.v2024_05_01_preview)
  maxPromptTokens?: int32 | null;

  /**
   * The maximum number of completion tokens that may be used over the course of the run. The run will make a best effort
   * to use only the number of completion tokens specified, across multiple turns of the run. If the run exceeds the number of
   * completion tokens specified, the run will end with status `incomplete`. See `incomplete_details` for more info.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @minValue(256)
  @encodedName("application/json", "max_completion_tokens")
  @added(ServiceApiVersions.v2024_05_01_preview)
  maxCompletionTokens?: int32 | null;

  /** The strategy to use for dropping messages as the context windows moves forward. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "truncation_strategy")
  @added(ServiceApiVersions.v2024_05_01_preview)
  truncationStrategy?: TruncationObject | null;

  /** Controls whether or not and which tool is called by the model. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "tool_choice")
  @added(ServiceApiVersions.v2024_05_01_preview)
  toolChoice?: AssistantsApiToolChoiceOption | null;

  /** Specifies the format that the model must output. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "response_format")
  @added(ServiceApiVersions.v2024_05_01_preview)
  responseFormat?: AssistantsApiResponseFormatOption | null;

  ...OptionalNullableMetadata;
}

@doc("The details of an error as encountered by an assistant thread run.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunError {
  @doc("The status for the error.")
  code: string;

  @doc("The human-readable text associated with the error.")
  message: string;
}

@doc("Possible values for the status of an assistant thread run.")
@added(ServiceApiVersions.v2024_02_15_preview)
union RunStatus {
  string,

  @doc("Represents a run that is queued to start.")
  queued: "queued",

  @doc("Represents a run that is in progress.")
  inProgress: "in_progress",

  @doc("Represents a run that needs another operation, such as tool output submission, to continue.")
  requiresAction: "requires_action",

  @doc("Represents a run that is in the process of cancellation.")
  cancelling: "cancelling",

  @doc("Represents a run that has been cancelled.")
  cancelled: "cancelled",

  @doc("Represents a run that failed.")
  failed: "failed",

  @doc("Represents a run that successfully completed.")
  completed: "completed",

  @doc("Represents a run that expired before it could otherwise finish.")
  expired: "expired",
}

@discriminator("type")
@doc("An abstract representation of a required action for an assistant thread run to continue.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RequiredAction {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The object type.")
  type: string;
}

@doc("The details for required tool calls that must be submitted for an assistant thread run to continue.")
@added(ServiceApiVersions.v2024_02_15_preview)
model SubmitToolOutputsAction extends RequiredAction {
  @doc("The object type, which is always 'submit_tool_outputs'.")
  type: "submit_tool_outputs";

  @encodedName("application/json", "submit_tool_outputs")
  @doc("The details describing tools that should be called to submit tool outputs.")
  submitToolOutputs: SubmitToolOutputsDetails;
}

@doc("The details describing tools that should be called to submit tool outputs.")
@added(ServiceApiVersions.v2024_02_15_preview)
model SubmitToolOutputsDetails {
  @encodedName("application/json", "tool_calls")
  @doc("The list of tool calls that must be resolved for the assistant thread run to continue.")
  toolCalls: RequiredToolCall[];
}

@doc("The details used when creating and immediately running a new assistant thread.")
@added(ServiceApiVersions.v2024_02_15_preview)
model CreateAndRunThreadOptions {
  @encodedName("application/json", "assistant_id")
  @doc("The ID of the assistant for which the thread should be created.")
  assistantId: string;

  @doc("The details used to create the new thread. If no thread is provided, an empty one will be created.")
  thread?: AssistantThreadCreationOptions;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The overridden model that the assistant should use to run the thread.")
  @clientName("overrideModelName", "csharp")
  `model`?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The overridden system instructions the assistant should use to run the thread.")
  @clientName("overrideInstructions", "csharp")
  instructions?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The overridden list of enabled tools the assistant should use to run the thread.")
  @clientName("overrideTools", "csharp")
  tools?: ToolDefinition[] | null;

  /**
   * Whether to enable parallel function calling during tool use.
   */
  @added(ServiceApiVersions.v2024_09_01_preview)
  @encodedName("application/json", "parallel_tool_calls")
  parallelToolCalls?: boolean = true;

  /** Override the tools the assistant can use for this run. This is useful for modifying the behavior on a per-run basis. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "tool_resources")
  @added(ServiceApiVersions.v2024_05_01_preview)
  toolResources?: UpdateToolResourcesOptions | null;

  /**
   * If `true`, returns a stream of events that happen during the Run as server-sent events,
   * terminating when the Run enters a terminal state with a `data: [DONE]` message.
   */
  @added(ServiceApiVersions.v2024_02_15_preview)
  stream?: boolean;

  /**
   * What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output
   * more random, while lower values like 0.2 will make it more focused and deterministic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @minValue(0)
  @maxValue(2)
  @added(ServiceApiVersions.v2024_05_01_preview)
  temperature?: float32 | null = 1;

  /**
   * An alternative to sampling with temperature, called nucleus sampling, where the model
   * considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens
   * comprising the top 10% probability mass are considered.
   *
   * We generally recommend altering this or temperature but not both.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @minValue(0)
  @maxValue(1)
  @encodedName("application/json", "top_p")
  @added(ServiceApiVersions.v2024_05_01_preview)
  topP?: float32 | null = 1;

  /**
   * The maximum number of prompt tokens that may be used over the course of the run. The run will make a best effort to use only
   * the number of prompt tokens specified, across multiple turns of the run. If the run exceeds the number of prompt tokens specified,
   * the run will end with status `incomplete`. See `incomplete_details` for more info.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @minValue(256)
  @encodedName("application/json", "max_prompt_tokens")
  @added(ServiceApiVersions.v2024_05_01_preview)
  maxPromptTokens?: int32 | null;

  /**
   * The maximum number of completion tokens that may be used over the course of the run. The run will make a best effort to use only
   * the number of completion tokens specified, across multiple turns of the run. If the run exceeds the number of completion tokens
   * specified, the run will end with status `incomplete`. See `incomplete_details` for more info.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @minValue(256)
  @encodedName("application/json", "max_completion_tokens")
  @added(ServiceApiVersions.v2024_05_01_preview)
  maxCompletionTokens?: int32 | null;

  /** The strategy to use for dropping messages as the context windows moves forward. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "truncation_strategy")
  @added(ServiceApiVersions.v2024_05_01_preview)
  truncationStrategy?: TruncationObject | null;

  /** Controls whether or not and which tool is called by the model. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "tool_choice")
  @added(ServiceApiVersions.v2024_05_01_preview)
  toolChoice?: AssistantsApiToolChoiceOption | null;

  /** Specifies the format that the model must output. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "response_format")
  @added(ServiceApiVersions.v2024_05_01_preview)
  responseFormat?: AssistantsApiResponseFormatOption | null;

  ...OptionalNullableMetadata;
}

/**
 * Controls for how a thread will be truncated prior to the run. Use this to control the initial
 * context window of the run.
 */
@added(ServiceApiVersions.v2024_05_01_preview)
model TruncationObject {
  /**
   * The truncation strategy to use for the thread. The default is `auto`. If set to `last_messages`, the thread will
   * be truncated to the `lastMessages` count most recent messages in the thread. When set to `auto`, messages in the middle of the thread
   * will be dropped to fit the context length of the model, `max_prompt_tokens`.
   */
  type: TruncationStrategy = TruncationStrategy.auto;

  /**
   * The number of most recent messages from the thread when constructing the context for the run.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @minValue(1)
  @added(ServiceApiVersions.v2024_05_01_preview)
  @encodedName("application/json", "last_messages")
  lastMessages?: int32 | null;
}

/**
 * Possible truncation strategies for the thread.
 */
@added(ServiceApiVersions.v2024_05_01_preview)
union TruncationStrategy {
  string,

  /** Default value. Messages in the middle of the thread will be dropped to fit the context length of the model. */
  auto: "auto",

  /** The thread will truncate to the `lastMessages` count of recent messages. */
  lastMessages: "last_messages",
}
