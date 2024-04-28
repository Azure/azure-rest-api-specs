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

  ...RequiredNullableMetadata;
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
