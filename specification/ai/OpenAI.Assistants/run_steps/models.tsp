import "@typespec/versioning";
import "../tools/models.tsp";

namespace Azure.AI.OpenAI.Assistants;

using TypeSpec.Versioning;

@doc("Detailed information about a single step of an assistant thread run.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStep {
  @doc("The identifier, which can be referenced in API endpoints.")
  id: string;

  @doc("The object type, which is always 'thread.run.step'.")
  object: "thread.run.step";

  @doc("The type of run step, which can be either message_creation or tool_calls.")
  type: RunStepType;

  @encodedName("application/json", "assistant_id")
  @doc("The ID of the assistant associated with the run step.")
  assistantId: string;

  @encodedName("application/json", "thread_id")
  @doc("The ID of the thread that was run.")
  threadId: string;

  @encodedName("application/json", "run_id")
  @doc("The ID of the run that this run step is a part of.")
  runId: string;

  @doc("The status of this run step.")
  status: RunStepStatus;

  @encodedName("application/json", "step_details")
  @doc("The details for this run step.")
  stepDetails: RunStepDetails;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "last_error")
  @doc("If applicable, information about the last error encountered by this run step.")
  lastError: RunStepError | null;

  @encodedName("application/json", "created_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this object was created.")
  createdAt: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "expired_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this item expired.")
  expiredAt: utcDateTime | null;

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
  @doc("Usage statistics related to the run step. This value will be `null` while the run step's status is `in_progress`.")
  @added(ServiceApiVersions.v2024_02_15_preview)
  usage?: RunStepCompletionUsage | null; // required in OpenAI, not present in AOpenAI

  ...RequiredNullableMetadata;
}

@doc("Usage statistics related to the run step.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepCompletionUsage {
  
  @doc("Number of completion tokens used over the course of the run step.")
  @encodedName("application/json", "completion_tokens")
  completionTokens: int64;

  @doc("Number of prompt tokens used over the course of the run step.")
  @encodedName("application/json", "prompt_tokens")
  promptTokens: int64;

  @doc("Total number of tokens used (prompt + completion).")
  @encodedName("application/json", "total_tokens")
  totalTokens: int64;
}

@doc("The possible types of run steps.")
@added(ServiceApiVersions.v2024_02_15_preview)
union RunStepType {
  string,

  @doc("Represents a run step to create a message.")
  messageCreation: "message_creation",

  @doc("Represents a run step that calls tools.")
  toolCalls: "tool_calls",
}

@discriminator("type")
@doc("An abstract representation of the details for a run step.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepDetails {
  @doc("The object type.")
  type: RunStepType;
}

@doc("The detailed information associated with a message creation run step.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepMessageCreationDetails extends RunStepDetails {
  @doc("The object type, which is always 'message_creation'.")
  type: RunStepType.messageCreation;

  @encodedName("application/json", "message_creation")
  @doc("Information about the message creation associated with this run step.")
  messageCreation: RunStepMessageCreationReference;
}

@doc("The detailed information associated with a run step calling tools.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepToolCallDetails extends RunStepDetails {
  @doc("The object type, which is always 'tool_calls'.")
  type: RunStepType.toolCalls;

  @encodedName("application/json", "tool_calls")
  @doc("A list of tool call details for this run step.")
  toolCalls: RunStepToolCall[];
}

@doc("The details of a message created as a part of a run step.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepMessageCreationReference {
  @encodedName("application/json", "message_id")
  @doc("The ID of the message created by this run step.")
  messageId: string;
}

@doc("Possible values for the status of a run step.")
@added(ServiceApiVersions.v2024_02_15_preview)
union RunStepStatus {
  string,

  @doc("Represents a run step still in progress.")
  inProgress: "in_progress",

  @doc("Represents a run step that was cancelled.")
  cancelled: "cancelled",

  @doc("Represents a run step that failed.")
  failed: "failed",

  @doc("Represents a run step that successfully completed.")
  completed: "completed",

  @doc("Represents a run step that expired before otherwise finishing.")
  expired: "expired",
}

@doc("Possible error code values attributable to a failed run step.")
@added(ServiceApiVersions.v2024_02_15_preview)
union RunStepErrorCode {
  string,

  @doc("Represents a server error.")
  serverError: "server_error",

  @doc("Represents an error indicating configured rate limits were exceeded.")
  rateLimitExceeded: "rate_limit_exceeded",
}

@doc("The error information associated with a failed run step.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepError {
  @doc("The error code for this error.")
  code: RunStepErrorCode;

  @doc("The human-readable text associated with this error.")
  message: string;
}

//
// The following types facilitate streaming use.
//

/** Represents a run step delta i.e. any changed fields on a run step during streaming. */
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepDeltaChunk {
  /** The identifier of the run step, which can be referenced in API endpoints. */
  id: string;

  /** The object type, which is always `thread.run.step.delta`. */
  object: "thread.run.step.delta";

  /** The delta containing the fields that have changed on the run step. */
  delta: RunStepDelta;
}

/** Represents the delta payload in a streaming run step delta chunk. */
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepDelta {
  /** The details of the run step. */
  @encodedName("application/json", "step_details")
  stepDetails?: RunStepDeltaDetail;
}

/** Represents a single run step detail item in a streaming run step's delta payload. */
@discriminator("type")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepDeltaDetail {
  /** The object type for the run step detail object. */
  type: string;
}

/** Represents a message creation within a streaming run step delta. */
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepDeltaMessageCreation extends RunStepDeltaDetail {
  /** The object type, which is always "message_creation." */
  type: "message_creation";

  /** The message creation data. */
  @encodedName("application/json", "message_creation")
  messageCreation?: RunStepDeltaMessageCreationObject;
}

/** Represents the data within a streaming run step message creation response object. */
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepDeltaMessageCreationObject {
  /** The ID of the newly-created message. */
  @encodedName("application/json", "message_id")
  messageId?: string;
}

/** Represents an invocation of tool calls as part of a streaming run step. */
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepDeltaToolCallObject extends RunStepDeltaDetail {
  /** The object type, which is always "tool_calls." */
  type: "tool_calls";

  /** The collection of tool calls for the tool call detail item. */
  @encodedName("application/json", "tool_calls")
  toolCalls?: RunStepDeltaToolCall[];
}

/** The abstract base representation of a single tool call within a streaming run step's delta tool call details. */
@discriminator("type")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepDeltaToolCall {
  /** The index of the tool call detail in the run step's tool_calls array. */
  index: int32;

  /** The ID of the tool call, used when submitting outputs to the run. */
  id: string;

  /** The type of the tool call detail item in a streaming run step's details. */
  type: string;
}

/** Represents a function tool call within a streaming run step's tool call details. */
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepDeltaFunctionToolCall extends RunStepDeltaToolCall {
  /** The object type, which is always "function." */
  type: "function";

  /** The function data for the tool call. */
  function?: RunStepDeltaFunction;
}

/** Represents a retrieval tool call within a streaming run step's tool call details. */
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepDeltaRetrievalToolCall extends RunStepDeltaToolCall {
  /** The object type, which is always "retrieval." */
  type: "retrieval";

  /** Reserved for future use. */
  @encodedName("application/json", "file_search")
  fileSearch?: Record<string>;
}

/** Represents a Code Interpreter tool call within a streaming run step's tool call details. */
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepDeltaCodeInterpreterToolCall extends RunStepDeltaToolCall {
  /** The object type, which is always "code_interpreter." */
  type: "code_interpreter";

  /** The Code Interpreter data for the tool call. */
  @encodedName("application/json", "code_interpreter")
  codeInterpreter?: RunStepDeltaCodeInterpreterDetailItemObject;
}

/** Represents the function data in a streaming run step delta's function tool call. */
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepDeltaFunction {
  /** The name of the function. */
  name?: string;

  /** The arguments passed to the function as input. */
  arguments?: string;

  /** The output of the function, null if outputs have not yet been submitted. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  output?: string | null;
}

/** Represents the Code Interpreter tool call data in a streaming run step's tool calls. */
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepDeltaCodeInterpreterDetailItemObject {
  /** The input into the Code Interpreter tool call. */
  input?: string;

  /**
   * The outputs from the Code Interpreter tool call. Code Interpreter can output one or more
   * items, including text (`logs`) or images (`image`). Each of these are represented by a
   * different object type.
   */
  outputs?: RunStepDeltaCodeInterpreterOutput[];
}

/** The abstract base representation of a streaming run step tool call's Code Interpreter tool output. */
@added(ServiceApiVersions.v2024_02_15_preview)
@discriminator("type")
model RunStepDeltaCodeInterpreterOutput {
  /** The index of the output in the streaming run step tool call's Code Interpreter outputs array. */
  index: int32;

  /** The type of the streaming run step tool call's Code Interpreter output. */
  type: string;
}

/** Represents a log output as produced by the Code Interpreter tool and as represented in a streaming run step's delta tool calls collection. */
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepDeltaCodeInterpreterLogOutput
  extends RunStepDeltaCodeInterpreterOutput {
  /** The type of the object, which is always "logs." */
  type: "logs";

  /** The text output from the Code Interpreter tool call. */
  logs?: string;
}

/** Represents an image output as produced the Code interpreter tool and as represented in a streaming run step's delta tool calls collection. */
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepDeltaCodeInterpreterImageOutput
  extends RunStepDeltaCodeInterpreterOutput {
  /** The object type, which is always "image." */
  type: "image";

  /** The image data for the Code Interpreter tool call output. */
  image?: RunStepDeltaCodeInterpreterImageOutputObject;
}

/** Represents the data for a streaming run step's Code Interpreter tool call image output. */
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepDeltaCodeInterpreterImageOutputObject {
  /** The file ID for the image. */
  @encodedName("application/json", "file_id")
  fileId?: string;
}
