import "@typespec/versioning";

import "../tools/tool_resources.tsp";
import "../common/models.tsp";
import "../messages/models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Agents;

@doc("Information about a single thread associated with an agent.")
@added(Versions.v2025_05_01)
model AgentThread {
  @doc("The identifier, which can be referenced in API endpoints.")
  id: string;

  @doc("The object type, which is always 'thread'.")
  object: "thread";

  @encodedName("application/json", "created_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this object was created.")
  createdAt: utcDateTime;

  /**
   * A set of resources that are made available to the agent's tools in this thread. The resources are specific to the type
   * of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list
   * of vector store IDs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "tool_resources")
  toolResources: ToolResources | null;

  ...RequiredNullableMetadata;
}

/** The details used to create a new agent thread. */
@added(Versions.v2025_05_01)
model AgentThreadCreationOptions {
  /** The initial messages to associate with the new thread. */
  messages?: ThreadMessageOptions[];

  /**
   * A set of resources that are made available to the agent's tools in this thread. The resources are specific to the
   * type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires
   * a list of vector store IDs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "tool_resources")
  toolResources?: ToolResources | null;

  ...OptionalNullableMetadata;
}

/** The details used to update an existing agent thread */
@added(Versions.v2025_05_01)
model UpdateAgentThreadOptions {
  /** The ID of the thread to modify. */
  @path threadId: string;

  /**
   * A set of resources that are made available to the agent's tools in this thread. The resources are specific to the
   * type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires
   * a list of vector store IDs
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "tool_resources")
  toolResources?: ToolResources | null;

  ...OptionalNullableMetadata;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "https://github.com/Azure/autorest.csharp/issues/4041"
@doc("The status of a thread deletion operation.")
@added(Versions.v2025_05_01)
model ThreadDeletionStatus {
  ...DeletionStatus;

  @doc("The object type, which is always 'thread.deleted'.")
  object: "thread.deleted";
}
