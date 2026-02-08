import "../common/models.tsp";
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
  createMemoryStore is FoundryDataPlaneOperation<
    CreateMemoryStoreRequest &
      WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.memory_stores_v1_preview>,
    MemoryStoreObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Update a memory store.")
  @operationId("updateMemoryStore")
  @post
  @route("/memory_stores/{name}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  updateMemoryStore is FoundryDataPlaneOperation<
    UpdateMemoryStoreRequest &
      WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.memory_stores_v1_preview>,
    MemoryStoreObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Retrieve a memory store.")
  @operationId("getMemoryStore")
  @get
  @route("/memory_stores/{name}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  getMemoryStore is FoundryDataPlaneOperation<
    GetMemoryStoreRequest &
      WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.memory_stores_v1_preview>,
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
    ListMemoryStoresRequest &
      WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.memory_stores_v1_preview>,
    AgentsPagedResult<MemoryStoreObject>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete a memory store.")
  @operationId("deleteMemoryStore")
  @delete
  @route("/memory_stores/{name}")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  deleteMemoryStore is FoundryDataPlaneOperation<
    DeleteMemoryStoreRequest &
      WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.memory_stores_v1_preview>,
    DeleteMemoryStoreResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Search for relevant memories from a memory store based on conversation context.")
  @operationId("searchMemories")
  @post
  @route("/memory_stores/{name}:search_memories")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  searchMemories is FoundryDataPlaneOperation<
    MemoryStoreSearchRequest &
      WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.memory_stores_v1_preview>,
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
    MemoryStoreUpdateRequest &
      WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.memory_stores_v1_preview>,
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
    MemoryStoreGetUpdateResultRequest &
      WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.memory_stores_v1_preview>,
    MemoryStoreUpdateResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete all memories associated with a specific scope from a memory store.")
  @operationId("deleteScopeMemories")
  @post
  @route("/memory_stores/{name}:delete_scope")
  @extension("x-ms-foundry-meta", MemoryStoreRequiredPreviews)
  deleteScope is FoundryDataPlaneOperation<
    MemoryStoreDeleteScopeRequest &
      WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.memory_stores_v1_preview>,
    MemoryStoreDeleteScopeResponse
  >;
}
