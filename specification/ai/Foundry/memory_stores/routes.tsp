import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.AI.Projects;

@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
@tag("Memory stores")
interface MemoryStores {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Create a memory store.")
  @operationId("createMemoryStore")
  @post
  @route("/memory_stores")
  createMemoryStore is AgentOperation<
    CreateMemoryStoreRequest,
    MemoryStoreObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Update a memory store.")
  @operationId("updateMemoryStore")
  @post
  @route("/memory_stores/{name}")
  updateMemoryStore is AgentOperation<
    UpdateMemoryStoreRequest,
    MemoryStoreObject
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Retrieve a memory store.")
  @operationId("getMemoryStore")
  @get
  @route("/memory_stores/{name}")
  getMemoryStore is AgentOperation<GetMemoryStoreRequest, MemoryStoreObject>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List all memory stores.")
  @operationId("listMemoryStores")
  @list
  @route("/memory_stores")
  listMemoryStores is AgentOperation<
    ListMemoryStoresRequest,
    AgentsPagedResult<MemoryStoreObject>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete a memory store.")
  @operationId("deleteMemoryStore")
  @delete
  @route("/memory_stores/{name}")
  deleteMemoryStore is AgentOperation<
    DeleteMemoryStoreRequest,
    DeleteMemoryStoreResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Create a memory item in a memory store.")
  @operationId("createMemoryItem")
  @post
  @route("/memory_stores/{name}/items")
  createMemoryItem is AgentOperation<CreateMemoryItemRequest, MemoryItem>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Retrieve a memory item from a memory store.")
  @operationId("getMemoryItem")
  @get
  @route("/memory_stores/{name}/items/{memory_id}")
  getMemoryItem is AgentOperation<GetMemoryItemRequest, MemoryItem>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Update the content of an existing memory item in a memory store.")
  @operationId("updateMemoryItem")
  @post
  @route("/memory_stores/{name}/items/{memory_id}")
  updateMemoryItem is AgentOperation<UpdateMemoryItemRequest, MemoryItem>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete an existing memory item from a memory store.")
  @operationId("deleteMemoryItem")
  @delete
  @route("/memory_stores/{name}/items/{memory_id}")
  deleteMemoryItem is AgentOperation<
    DeleteMemoryItemRequest,
    DeleteMemoryItemResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List memory items for a specific scope in a memory store.")
  @operationId("listMemoryItems")
  @post
  @route("/memory_stores/{name}/items:list")
  listMemoryItems is AgentOperation<
    ListMemoryItemsRequest,
    AgentsPagedResult<MemoryItem>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Search for relevant memories from a memory store based on conversation context.")
  @operationId("searchMemories")
  @post
  @route("/memory_stores/{name}:search_memories")
  searchMemories is AgentOperation<
    MemoryStoreSearchRequest,
    MemoryStoreSearchResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Update memory store with conversation memories.")
  @operationId("updateMemories")
  @post
  @route("/memory_stores/{name}:update_memories")
  @pollingOperation(MemoryStores.getUpdateResult)
  updateMemories is AgentOperation<
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
  getUpdateResult is AgentOperation<
    MemoryStoreGetUpdateResultRequest,
    MemoryStoreUpdateResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete all memories associated with a specific scope from a memory store.")
  @operationId("deleteScopeMemories")
  @post
  @route("/memory_stores/{name}:delete_scope")
  deleteScope is AgentOperation<
    MemoryStoreDeleteScopeRequest,
    MemoryStoreDeleteScopeResponse
  >;
}
