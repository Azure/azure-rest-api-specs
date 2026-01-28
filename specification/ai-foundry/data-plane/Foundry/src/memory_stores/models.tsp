import "@typespec/http";
import "@typespec/openapi";

import "../common/service.tsp";
import "../openai-responses/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const MemoryStoreRequiredPreviews = #{
  conditional_previews: #[FoundryPreviewOptInKeys.memory_stores_v1],
};

@doc("A memory store that can store and retrieve user memories.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
model MemoryStoreObject {
  @doc("The object type, which is always 'memory_store'.")
  object: "memory_store";

  @doc("The unique identifier of the memory store.")
  id: string;

  @doc("The Unix timestamp (seconds) when the memory store was created.")
  @encode("unixTimestamp", int32)
  created_at: utcDateTime;

  @doc("The Unix timestamp (seconds) when the memory store was last updated.")
  @encode("unixTimestamp", int32)
  updated_at: utcDateTime;

  @doc("The name of the memory store.")
  @maxLength(256)
  name: string;

  @doc("A human-readable description of the memory store.")
  @maxLength(512)
  description?: string;

  @doc("Arbitrary key-value metadata to associate with the memory store.")
  metadata?: Record<string>;

  @doc("The definition of the memory store.")
  definition: MemoryStoreDefinition;
}

@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
model DeleteMemoryStoreResponse {
  @doc("The object type. Always 'memory_store.deleted'.")
  object: "memory_store.deleted";

  @doc("The name of the memory store.")
  name: string;

  @doc("Whether the memory store was successfully deleted.")
  deleted: boolean;
}

@doc("The type of memory store implementation to use.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
union MemoryStoreKind {
  string,

  @doc("The default memory store implementation.")
  default: "default",
}

@doc("Base definition for memory store configurations.")
@discriminator("kind")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
model MemoryStoreDefinition {
  @doc("The kind of the memory store.")
  kind: MemoryStoreKind;
}

@doc("Default memory store implementation.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
model MemoryStoreDefaultDefinition extends MemoryStoreDefinition {
  @doc("The kind of the memory store.")
  kind: MemoryStoreKind.default;

  @doc("The name or identifier of the chat completion model deployment used for memory processing.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  chat_model: string;

  @doc("The name or identifier of the embedding model deployment used for memory processing.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  embedding_model: string;

  @doc("Default memory store options.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  options?: MemoryStoreDefaultOptions;
}

@doc("Default memory store configurations.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
model MemoryStoreDefaultOptions {
  @doc("Whether to enable user profile extraction and storage. Default is true.")
  user_profile_enabled: boolean = true;

  @doc("Specific categories or types of user profile information to extract and store.")
  user_profile_details?: string;

  @doc("Whether to enable chat summary extraction and storage. Default is true.")
  chat_summary_enabled: boolean = true;
}

@doc("Usage statistics of a memory store operation.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
model MemoryStoreOperationUsage {
  @doc("The number of embedding tokens.")
  embedding_tokens: int32;

  ...OpenAI.ResponseUsage;
}

@doc("Status of a memory store update operation.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
union MemoryStoreUpdateStatus {
  queued: "queued",
  in_progress: "in_progress",

  @Azure.Core.lroSucceeded
  completed: "completed",

  @Azure.Core.lroFailed
  failed: "failed",

  @Azure.Core.lroCanceled
  superseded: "superseded",
}

@doc("Provides the status of a memory store update operation.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
model MemoryStoreUpdateResponse {
  @doc("The unique ID of this update request. Use this value as previous_update_id in subsequent requests to perform incremental updates.")
  update_id: string;

  @doc("""
    The status of the memory update operation. One of "queued", "in_progress", "completed", "failed", or "superseded".
    """)
  @Azure.Core.lroStatus
  status: MemoryStoreUpdateStatus;

  @doc("The update_id the operation was superseded by when status is \"superseded\".")
  superseded_by?: string;

  @doc("The result of memory store update operation when status is \"completed\".")
  @Azure.Core.lroResult
  result?: MemoryStoreUpdateCompletedResult;

  @doc("Error object that describes the error when status is \"failed\".")
  @Azure.Core.lroErrorResult
  error?: ApiError;
}

@doc("Memory update result.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
model MemoryStoreUpdateCompletedResult {
  @doc("A list of individual memory operations that were performed during the update.")
  memory_operations: MemoryOperation[];

  @doc("Usage statistics associated with the memory update operation.")
  usage: MemoryStoreOperationUsage;
}

@doc("Represents a single memory operation (create, update, or delete) performed on a memory item.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
model MemoryOperation {
  @doc("The type of memory operation being performed.")
  kind: MemoryOperationKind;

  @doc("The memory item to create, update, or delete.")
  memory_item: MemoryItem;
}

@doc("Memory operation kind.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
union MemoryOperationKind {
  string,

  @doc("Create a new memory item.")
  create: "create",

  @doc("Update an existing memory item.")
  update: "update",

  @doc("Delete an existing memory item.")
  delete: "delete",
}

@doc("Memory search options.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
model MemorySearchOptions {
  @doc("Maximum number of memory items to return.")
  max_memories?: int32;
}

@doc("Memory search response.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
model MemoryStoreSearchResponse {
  @doc("The unique ID of this search request. Use this value as previous_search_id in subsequent requests to perform incremental searches.")
  search_id: string;

  @doc("Related memory items found during the search operation.")
  memories: MemorySearchItem[];

  @doc("Usage statistics associated with the memory search operation.")
  usage: MemoryStoreOperationUsage;
}

@doc("A retrieved memory item from memory search.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
model MemorySearchItem {
  @doc("Retrieved memory item.")
  memory_item: MemoryItem;
}

@doc("Memory item kind.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
union MemoryItemKind {
  string,

  @doc("User profile information extracted from conversations.")
  user_profile: "user_profile",

  @doc("Summary of chat conversations.")
  chat_summary: "chat_summary",
}

@doc("A single memory item stored in the memory store, containing content and metadata.")
@discriminator("kind")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
model MemoryItem {
  @doc("The unique ID of the memory item.")
  memory_id: string;

  @doc("The last update time of the memory item.")
  @encode("unixTimestamp", int32)
  updated_at: utcDateTime;

  @doc("The namespace that logically groups and isolates memories, such as a user ID.")
  scope: string;

  @doc("The content of the memory.")
  content: string;

  @doc("The kind of the memory item.")
  kind: MemoryItemKind;
}

@doc("A memory item specifically containing user profile information extracted from conversations, such as preferences, interests, and personal details.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
model UserProfileMemoryItem extends MemoryItem {
  @doc("The kind of the memory item.")
  kind: MemoryItemKind.user_profile;
}

@doc("A memory item containing a summary extracted from conversations.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
model ChatSummaryMemoryItem extends MemoryItem {
  @doc("The kind of the memory item.")
  kind: MemoryItemKind.chat_summary;
}

@doc("Response for deleting memories from a scope.")
@extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
model MemoryStoreDeleteScopeResponse {
  @doc("The object type. Always 'memory_store.scope.deleted'.")
  object: "memory_store.scope.deleted";

  @doc("The name of the memory store.")
  name: string;

  @doc("The scope from which memories were deleted.")
  scope: string;

  @doc("Whether the deletion operation was successful.")
  deleted: boolean;
}

alias CreateMemoryStoreRequest = {
  @doc("The name of the memory store.")
  @maxLength(256)
  name: string;

  @doc("A human-readable description of the memory store.")
  @maxLength(512)
  description?: string;

  @doc("Arbitrary key-value metadata to associate with the memory store.")
  metadata?: Record<string>;

  @doc("The memory store definition.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  definition: MemoryStoreDefinition;
};

alias UpdateMemoryStoreRequest = {
  @doc("The name of the memory store to update.")
  @path
  name: string;

  @doc("A human-readable description of the memory store.")
  @maxLength(512)
  description?: string;

  @doc("Arbitrary key-value metadata to associate with the memory store.")
  metadata?: Record<string>;
};

alias GetMemoryStoreRequest = {
  @doc("The name of the memory store to retrieve.")
  @path
  name: string;
};

alias ListMemoryStoresRequest = {
  ...CommonPageQueryParameters;
};

alias DeleteMemoryStoreRequest = {
  @doc("The name of the memory store to delete.")
  @path
  name: string;
};

alias MemoryStoreSearchRequest = {
  @doc("The name of the memory store to search.")
  @path
  name: string;

  @doc("The namespace that logically groups and isolates memories, such as a user ID.")
  scope: string;

  @doc("Items for which to search for relevant memories.")
  items?: OpenAI.InputItem[];

  @doc("The unique ID of the previous search request, enabling incremental memory search from where the last operation left off.")
  previous_search_id?: string;

  @doc("Memory search options.")
  options?: MemorySearchOptions;
};

alias MemoryStoreUpdateRequest = {
  @doc("The name of the memory store to update.")
  @path
  name: string;

  @doc("The namespace that logically groups and isolates memories, such as a user ID.")
  scope: string;

  @doc("Conversation items from which to extract memories.")
  items?: OpenAI.InputItem[];

  @doc("The unique ID of the previous update request, enabling incremental memory updates from where the last operation left off.")
  previous_update_id?: string;

  @doc("""
    Timeout period before processing the memory update in seconds.
    If a new update request is received during this period, it will cancel the current request and reset the timeout.
    Set to 0 to immediately trigger the update without delay.
    Defaults to 300 (5 minutes).
    """)
  update_delay?: int32 = 300;
};

alias MemoryStoreGetUpdateResultRequest = {
  @doc("The name of the memory store.")
  @path
  name: string;

  @doc("The ID of the memory update operation.")
  @path
  update_id: string;
};

alias MemoryStoreDeleteScopeRequest = {
  @doc("The name of the memory store.")
  @path
  name: string;

  @doc("The namespace that logically groups and isolates memories to delete, such as a user ID.")
  scope: string;
};
