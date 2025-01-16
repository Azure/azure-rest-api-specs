import "@typespec/versioning";

import "../tools/tool_resources.tsp";
import "../common/models.tsp";
import "../messages/models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

@doc("Information about a single thread associated with an assistant.")
model AssistantThread {
  @doc("The identifier, which can be referenced in API endpoints.")
  id: string;

  @doc("The object type, which is always 'thread'.")
  object: "thread";

  @encodedName("application/json", "created_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this object was created.")
  createdAt: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("A set of resources that are made available to the assistant's tools in this thread. The resources are specific to the type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs.")
  @encodedName("application/json", "tool_resources")
  toolResources: ToolResources | null;

  ...RequiredNullableMetadata;
}

@doc("The details used to create a new assistant thread.")
model AssistantThreadCreationOptions {
  @doc("The initial messages to associate with the new thread.")
  messages?: ThreadMessageOptions[];

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("A set of resources that are made available to the assistant's tools in this thread. The resources are specific to the type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs.")
  @encodedName("application/json", "tool_resources")
  toolResources?: CreateToolResourcesOptions | null;

  ...OptionalNullableMetadata;
}

@doc("The details used to update an existing assistant thread")
model UpdateAssistantThreadOptions {
  @doc("The ID of the thread to modify.")
  @path
  threadId: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("A set of resources that are made available to the assistant's tools in this thread. The resources are specific to the type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs.")
  @encodedName("application/json", "tool_resources")
  toolResources?: UpdateToolResourcesOptions | null;

  ...OptionalNullableMetadata;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "https://github.com/Azure/autorest.csharp/issues/4041"
@doc("The status of a thread deletion operation.")
model ThreadDeletionStatus {
  ...DeletionStatus;

  @doc("The object type, which is always 'thread.deleted'.")
  object: "thread.deleted";
}
