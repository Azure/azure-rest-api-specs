import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../main.tsp";
import "../common/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Assistants;

/**
 * Returns a list of vector stores.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/openai/vector_stores")
@added(ServiceApiVersions.v2024_05_01_preview)
op listVectorStores is Azure.Core.RpcOperation<
  {
    ...OpenAIListRequestOptions
  },
  OpenAIPageableListOf<VectorStore>
>;
/*
op listVectorStores(
  ...OpenAIListRequestOptions,
): OpenAIPageableListOf<VectorStore>;
*/

/**
 * Creates a vector store.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/openai/vector_stores")
@added(ServiceApiVersions.v2024_05_01_preview)
op createVectorStore is Azure.Core.RpcOperation<
  {
    /**
     * Request object for creating a vector store.
     */
    ...VectorStoreOptions
  },
  VectorStore
>;
/*
op createVectorStore(
  ...VectorStoreOptions
): VectorStore;
*/

/**
 * Returns the vector store object matching the specified ID.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/openai/vector_stores/{vectorStoreId}")
@added(ServiceApiVersions.v2024_05_01_preview)
op getVectorStore is Azure.Core.RpcOperation<
  {
    /** The ID of the vector store to retrieve. */
    @path vectorStoreId: string
  },
  VectorStore
>;
/*
op getVectorStore(
  @path vectorStoreId: string,
): VectorStore;
*/

/**
 * The ID of the vector store to modify.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/openai/vector_stores/{vectorStoreId}")
@added(ServiceApiVersions.v2024_05_01_preview)
op modifyVectorStore is Azure.Core.RpcOperation<
  {
    /** The ID of the vector store to modify. */
    @path vectorStoreId: string,

    /**
     * Request object for updating a vector store.
     */
    ...VectorStoreUpdateOptions
  },
  VectorStore
>;
/*
op modifyVectorStore(
  @path vectorStoreId: string,

  ...VectorStoreUpdateOptions
): VectorStore;
*/

/**
 * Deletes the vector store object matching the specified ID.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@delete
@route("/openai/vector_stores/{vectorStoreId}")
@added(ServiceApiVersions.v2024_05_01_preview)
op deleteVectorStore is Azure.Core.RpcOperation<
  {
    /** The ID of the vector store to delete. */
    @path vectorStoreId: string
  },
  VectorStoreDeletionStatus
>;
/*
op deleteVectorStore(
  @path vectorStoreId: string,
): VectorStoreDeletionStatus;
*/