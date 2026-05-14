import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.AI.Projects;

@tag("Memory Stores")
interface MemoryStores {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Create a memory store.")
  @operationId("createMemoryStore")
  @post
  @route("/memory_stores")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  createMemoryStore is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    CreateMemoryStoreRequest,
    MemoryStoreObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Update a memory store.")
  @operationId("updateMemoryStore")
  @post
  @route("/memory_stores/{name}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  updateMemoryStore is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    UpdateMemoryStoreRequest,
    MemoryStoreObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Retrieve a memory store.")
  @operationId("getMemoryStore")
  @get
  @route("/memory_stores/{name}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  getMemoryStore is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    GetMemoryStoreRequest,
    MemoryStoreObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List all memory stores.")
  @operationId("listMemoryStores")
  @get
  @list
  @route("/memory_stores")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  listMemoryStores is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    ListMemoryStoresRequest,
    AgentsPagedResult<MemoryStoreObject>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete a memory store.")
  @operationId("deleteMemoryStore")
  @delete
  @route("/memory_stores/{name}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  deleteMemoryStore is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    DeleteMemoryStoreRequest,
    DeleteMemoryStoreResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Search for relevant memories from a memory store based on conversation context.")
  @operationId("searchMemories")
  @post
  @route("/memory_stores/{name}:search_memories")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  searchMemories is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    MemoryStoreSearchRequest,
    MemoryStoreSearchResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Update memory store with conversation memories.")
  @operationId("updateMemories")
  @post
  @route("/memory_stores/{name}:update_memories")
  @pollingOperation(MemoryStores.getUpdateResult)
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  updateMemories is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    MemoryStoreUpdateRequest,
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
  getUpdateResult is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    MemoryStoreGetUpdateResultRequest,
    MemoryStoreUpdateResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete all memories associated with a specific scope from a memory store.")
  @operationId("deleteScopeMemories")
  @post
  @route("/memory_stores/{name}:delete_scope")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  deleteScope is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    MemoryStoreDeleteScopeRequest,
    MemoryStoreDeleteScopeResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Create a memory item in a memory store.")
  @operationId("createMemoryItem")
  @post
  @route("/memory_stores/{name}/memories")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  createMemoryItem is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    CreateMemoryItemRequest,
    MemoryItem
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Update a memory item in a memory store.")
  @operationId("updateMemoryItem")
  @post
  @route("/memory_stores/{name}/memories/{memory_id}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  updateMemoryItem is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    UpdateMemoryItemRequest,
    MemoryItem
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Retrieve a memory item from a memory store.")
  @operationId("getMemoryItem")
  @get
  @route("/memory_stores/{name}/memories/{memory_id}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  getMemoryItem is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    GetMemoryItemRequest,
    MemoryItem
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List all memory items in a memory store.")
  @operationId("listMemoryItems")
  @get
  @list
  @route("/memory_stores/{name}/memories")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  listMemoryItems is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    ListMemoryItemsRequest,
    AgentsPagedResult<MemoryItem>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete a memory item from a memory store.")
  @operationId("deleteMemoryItem")
  @delete
  @route("/memory_stores/{name}/memories/{memory_id}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  deleteMemoryItem is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    DeleteMemoryItemRequest,
    DeleteMemoryItemResponse
  >;
}
