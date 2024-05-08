import "@typespec/versioning";
import "../common/models.tsp";
import "../tools/models.tsp";

namespace Azure.AI.OpenAI.Assistants;

using TypeSpec.Http;
using TypeSpec.Versioning;

@doc("Represents an assistant that can call the model and use tools.")
@added(ServiceApiVersions.v2024_02_15_preview)
model Assistant {
  @doc("The identifier, which can be referenced in API endpoints.")
  id: string;

  @doc("The object type, which is always assistant.")
  object: "assistant";

  @encodedName("application/json", "created_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this object was created.")
  createdAt: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The name of the assistant.")
  name: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The description of the assistant.")
  description: string | null;

  @doc("The ID of the model to use.")
  `model`: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The system instructions for the assistant to use.")
  instructions: string | null;

  @doc("The collection of tools enabled for the assistant.")
  tools: ToolDefinition[] = [];

  @encodedName("application/json", "file_ids")
  @doc("A list of attached file IDs, ordered by creation date in ascending order.")
  fileIds: string[] = [];

  ...RequiredNullableMetadata;
}

@doc("The request details to use when creating a new assistant.")
@added(ServiceApiVersions.v2024_02_15_preview)
model AssistantCreationOptions {
  @doc("The ID of the model to use.")
  `model`: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The name of the new assistant.")
  name?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The description of the new assistant.")
  description?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The system instructions for the new assistant to use.")
  instructions?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The collection of tools to enable for the new assistant.")
  tools?: ToolDefinition[] = [];

  @encodedName("application/json", "file_ids")
  @doc("A list of previously uploaded file IDs to attach to the assistant.")
  fileIds?: string[] = [];

  ...OptionalNullableMetadata;
}

@doc("The request details to use when modifying an existing assistant.")
@added(ServiceApiVersions.v2024_02_15_preview)
model UpdateAssistantOptions {
  @path
  @doc("The ID of the assistant to modify.")
  assistantId: string;

  @doc("The ID of the model to use.")
  `model`?: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The modified name for the assistant to use.")
  name?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The modified description for the assistant to use.")
  description?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The modified system instructions for the new assistant to use.")
  instructions?: string | null;

  @doc("The modified collection of tools to enable for the assistant.")
  tools?: ToolDefinition[] = [];

  @encodedName("application/json", "file_ids")
  @doc("The modified list of previously uploaded fileIDs to attach to the assistant.")
  fileIds?: string[] = [];

  ...OptionalNullableMetadata;
}

@doc("The status of an assistant deletion operation.")
@added(ServiceApiVersions.v2024_02_15_preview)
model AssistantDeletionStatus {
  ...DeletionStatus;

  @doc("The object type, which is always 'assistant.deleted'.")
  object: "assistant.deleted";
}

@doc("Information about a file attached to an assistant, as used by tools that can read files.")
@added(ServiceApiVersions.v2024_02_15_preview)
model AssistantFile {
  @doc("The identifier, which can be referenced in API endpoints.")
  id: string;

  @doc("The object type, which is always 'assistant.file'.")
  object: "assistant.file";

  @encodedName("application/json", "created_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this object was created.")
  createdAt: utcDateTime;

  @encodedName("application/json", "assistant_id")
  @doc("The assistant ID that the file is attached to.")
  assistantId: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "https://github.com/Azure/autorest.csharp/issues/4041"
@doc("The status of an assistant file deletion operation.")
@added(ServiceApiVersions.v2024_02_15_preview)
model AssistantFileDeletionStatus {
  ...DeletionStatus;

  @doc("The object type, which is always 'assistant.file.deleted'.")
  object: "assistant.file.deleted";
}
