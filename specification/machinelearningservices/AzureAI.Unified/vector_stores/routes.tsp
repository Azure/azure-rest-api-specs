import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../main.tsp";
import "../common/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

/**
 * Returns a list of vector stores.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/vector_stores")
op listVectorStores(
  ...OpenAIListRequestOptions,
): OpenAIPageableListOf<VectorStore>;

/**
 * Creates a vector store.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/vector_stores")
op createVectorStore(
  /**
   * Request object for creating a vector store.
   */
  @bodyRoot
  body: VectorStoreOptions,
): VectorStore;

/**
 * Returns the vector store object matching the specified ID.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/vector_stores/{vectorStoreId}")
op getVectorStore(
  /** The ID of the vector store to retrieve. */
  @path vectorStoreId: string,
): VectorStore;

/**
 * The ID of the vector store to modify.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/vector_stores/{vectorStoreId}")
op modifyVectorStore(
  /** The ID of the vector store to modify. */
  @path vectorStoreId: string,

  /**
   * Request object for updating a vector store.
   */
  @bodyRoot
  body: VectorStoreUpdateOptions,
): VectorStore;

/**
 * Deletes the vector store object matching the specified ID.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@delete
@route("/vector_stores/{vectorStoreId}")
op deleteVectorStore(
  /** The ID of the vector store to delete. */
  @path vectorStoreId: string,
): VectorStoreDeletionStatus;
