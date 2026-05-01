import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.AI.Projects;

alias MemoryStorePreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.memory_stores_v1_preview>;

@tag("Memory Stores")
interface MemoryStores {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Create a memory store.")
  @operationId("createMemoryStore")
  @post
  @route("/memory_stores")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  createMemoryStore is FoundryDataPlaneOperation<
    CreateMemoryStoreRequest & MemoryStorePreviewHeader,
    MemoryStoreObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Update a memory store.")
  @operationId("updateMemoryStore")
  @post
  @route("/memory_stores/{name}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  updateMemoryStore is FoundryDataPlaneOperation<
    UpdateMemoryStoreRequest & MemoryStorePreviewHeader,
    MemoryStoreObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Retrieve a memory store.")
  @operationId("getMemoryStore")
  @get
  @route("/memory_stores/{name}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  getMemoryStore is FoundryDataPlaneOperation<
    GetMemoryStoreRequest & MemoryStorePreviewHeader,
    MemoryStoreObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List all memory stores.")
  @operationId("listMemoryStores")
  @get
  @list
  @route("/memory_stores")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  listMemoryStores is FoundryDataPlaneOperation<
    ListMemoryStoresRequest & MemoryStorePreviewHeader,
    AgentsPagedResult<MemoryStoreObject>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete a memory store.")
  @operationId("deleteMemoryStore")
  @delete
  @route("/memory_stores/{name}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  deleteMemoryStore is FoundryDataPlaneOperation<
    DeleteMemoryStoreRequest & MemoryStorePreviewHeader,
    DeleteMemoryStoreResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Search for relevant memories from a memory store based on conversation context.")
  @operationId("searchMemories")
  @post
  @route("/memory_stores/{name}:search_memories")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  searchMemories is FoundryDataPlaneOperation<
    MemoryStoreSearchRequest & MemoryStorePreviewHeader,
    MemoryStoreSearchResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Update memory store with conversation memories.")
  @operationId("updateMemories")
  @post
  @route("/memory_stores/{name}:update_memories")
  @pollingOperation(MemoryStores.getUpdateResult)
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  updateMemories is FoundryDataPlaneOperation<
    MemoryStoreUpdateRequest & MemoryStorePreviewHeader,
    Foundations.AcceptedResponse &
      MemoryStoreUpdateResponse &
      Foundations.LongRunningStatusLocation<MemoryStoreUpdateCompletedResult>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Get memory store update result.")
  @operationId("getUpdateResult")
  @get
  @route("/memory_stores/{name}/updates/{update_id}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  getUpdateResult is FoundryDataPlaneOperation<
    MemoryStoreGetUpdateResultRequest & MemoryStorePreviewHeader,
    MemoryStoreUpdateResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete all memories associated with a specific scope from a memory store.")
  @operationId("deleteScopeMemories")
  @post
  @route("/memory_stores/{name}:delete_scope")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  deleteScope is FoundryDataPlaneOperation<
    MemoryStoreDeleteScopeRequest & MemoryStorePreviewHeader,
    MemoryStoreDeleteScopeResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Create a memory item in a memory store.")
  @operationId("createMemoryItem")
  @post
  @route("/memory_stores/{name}/memories")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  createMemoryItem is FoundryDataPlaneOperation<
    CreateMemoryItemRequest & MemoryStorePreviewHeader,
    MemoryItem
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Update a memory item in a memory store.")
  @operationId("updateMemoryItem")
  @post
  @route("/memory_stores/{name}/memories/{memory_id}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  updateMemoryItem is FoundryDataPlaneOperation<
    UpdateMemoryItemRequest & MemoryStorePreviewHeader,
    MemoryItem
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Retrieve a memory item from a memory store.")
  @operationId("getMemoryItem")
  @get
  @route("/memory_stores/{name}/memories/{memory_id}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  getMemoryItem is FoundryDataPlaneOperation<
    GetMemoryItemRequest & MemoryStorePreviewHeader,
    MemoryItem
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List all memory items in a memory store.")
  @operationId("listMemoryItems")
  @get
  @list
  @route("/memory_stores/{name}/memories")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  listMemoryItems is FoundryDataPlaneOperation<
    ListMemoryItemsRequest & MemoryStorePreviewHeader,
    AgentsPagedResult<MemoryItem>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete a memory item from a memory store.")
  @operationId("deleteMemoryItem")
  @delete
  @route("/memory_stores/{name}/memories/{memory_id}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  deleteMemoryItem is FoundryDataPlaneOperation<
    DeleteMemoryItemRequest & MemoryStorePreviewHeader,
    DeleteMemoryItemResponse
  >;
}
