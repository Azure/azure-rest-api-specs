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
  tools: ToolDefinition[] = [];

  @encodedName("application/json", "file_ids")
  @doc("A list of attached file IDs, ordered by creation date in ascending order.")
  fileIds: string[] = [];

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

  ...RequiredNullableMetadata;
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

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The overridden list of enabled tools that the assistant should use to run the thread.")
  tools?: ToolDefinition[] | null;

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

  @doc("The details used to create the new thread.")
  thread?: AssistantThreadCreationOptions;

  @doc("The overridden model that the assistant should use to run the thread.")
  @clientName("overrideModelName", "csharp")
  `model`?: string;

  @doc("The overridden system instructions the assistant should use to run the thread.")
  @clientName("overrideInstructions", "csharp")
  instructions?: string;

  @doc("The overridden list of enabled tools the assistant should use to run the thread.")
  @clientName("overrideTools", "csharp")
  tools?: ToolDefinition[];

  ...OptionalNullableMetadata;
}
