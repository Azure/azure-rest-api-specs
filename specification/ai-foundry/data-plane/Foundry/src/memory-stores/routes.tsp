import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.AI.Projects;

@tag("Memory Stores")
interface MemoryStores {
  /** Creates a memory store resource with the provided configuration. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Create a memory store")
  @operationId("createMemoryStore")
  @post
  @route("/memory_stores")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  createMemoryStore is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    CreateMemoryStoreRequest,
    MemoryStoreObject
  >;

  /** Updates the specified memory store with the supplied configuration changes. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Update a memory store")
  @operationId("updateMemoryStore")
  @post
  @route("/memory_stores/{name}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  updateMemoryStore is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    UpdateMemoryStoreRequest,
    MemoryStoreObject
  >;

  /** Retrieves the specified memory store and its current configuration. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Get a memory store")
  @operationId("getMemoryStore")
  @get
  @route("/memory_stores/{name}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  getMemoryStore is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    GetMemoryStoreRequest,
    MemoryStoreObject
  >;

  /** Returns the memory stores available to the caller. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("List memory stores")
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

  /** Deletes the specified memory store. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Delete a memory store")
  @operationId("deleteMemoryStore")
  @delete
  @route("/memory_stores/{name}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  deleteMemoryStore is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    DeleteMemoryStoreRequest,
    DeleteMemoryStoreResponse
  >;

  /** Searches the specified memory store for memories relevant to the provided conversation context. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Search memories")
  @operationId("searchMemories")
  @post
  @route("/memory_stores/{name}:search_memories")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  searchMemories is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    MemoryStoreSearchRequest,
    MemoryStoreSearchResponse
  >;

  /**
   * Starts an update that writes conversation memories into the specified memory store.
   * The operation returns a long-running status location for polling the update result.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Update memories")
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

  /** Retrieves the status and result of a memory store update operation. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Get an update result")
  @operationId("getUpdateResult")
  @get
  @route("/memory_stores/{name}/updates/{update_id}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  getUpdateResult is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    MemoryStoreGetUpdateResultRequest,
    MemoryStoreUpdateResponse
  >;

  /** Deletes all memories in the specified memory store that are associated with the provided scope. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Delete memories by scope")
  @operationId("deleteScopeMemories")
  @post
  @route("/memory_stores/{name}:delete_scope")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  deleteScope is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    MemoryStoreDeleteScopeRequest,
    MemoryStoreDeleteScopeResponse
  >;

  /** Creates a memory item in the specified memory store. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Create a memory item")
  @operationId("createMemory")
  @post
  @route("/memory_stores/{name}/items")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  createMemory is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    CreateMemoryRequest,
    MemoryItem
  >;

  /** Updates the specified memory item in the memory store. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Update a memory item")
  @operationId("updateMemory")
  @post
  @route("/memory_stores/{name}/items/{memory_id}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  updateMemory is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    UpdateMemoryRequest,
    MemoryItem
  >;

  /** Retrieves the specified memory item from the memory store. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Get a memory item")
  @operationId("getMemory")
  @get
  @route("/memory_stores/{name}/items/{memory_id}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  getMemory is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.memory_stores_v1_preview,
    GetMemoryRequest,
    MemoryItem
  >;

  /** Returns memory items from the specified memory store. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("List memory items")
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

  /** Deletes the specified memory item from the memory store. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Delete a memory item")
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
