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
  @operationId("createMemory")
  @post
  @route("/memory_stores/{name}/items")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  createMemory is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    CreateMemoryRequest,
    MemoryItem
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Update a memory item in a memory store.")
  @operationId("updateMemory")
  @post
  @route("/memory_stores/{name}/items/{memory_id}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  updateMemory is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    UpdateMemoryRequest,
    MemoryItem
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Retrieve a memory item from a memory store.")
  @operationId("getMemory")
  @get
  @route("/memory_stores/{name}/items/{memory_id}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  getMemory is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    GetMemoryRequest,
    MemoryItem
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List all memory items in a memory store.")
  @operationId("listMemories")
  @post
  @list
  @route("/memory_stores/{name}/items:list")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  listMemories is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    ListMemoriesRequest,
    AgentsPagedResult<MemoryItem>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete a memory item from a memory store.")
  @operationId("deleteMemory")
  @delete
  @route("/memory_stores/{name}/items/{memory_id}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  deleteMemory is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    DeleteMemoryRequest,
    DeleteMemoryResponse
  >;
}
