import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./models.tsp";
import "../common/models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core.Foundations;

namespace Azure.AI.Agents {
  /**
   * A collection of vector-store operations under `/vector_stores`.
   */
  @route("/vector_stores")
  interface VectorStores {
    /**
     * Returns a list of vector stores.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @get
    @list
    listVectorStores(...ApiVersionParameter, ...AgentsListOptions): {
      ...AgentsPagedResult<VectorStore>;
    } | AgentV1Error;

    /**
     * Creates a vector store.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @post
    createVectorStore is AgentOperation<
      {
        /**
         * Request object for creating a vector store.
         */
        ...VectorStoreOptions;
      },
      VectorStore
    >;

    /**
     * Returns the vector store object matching the specified ID.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @get
    @route("/{vectorStoreId}")
    getVectorStore is AgentOperation<
      {
        /** The ID of the vector store to retrieve. */
        @doc("Identifier of the vector store.")
        @path
        vectorStoreId: string;
      },
      VectorStore
    >;

    /**
     * Modifies an existing vector store.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @post
    @route("/{vectorStoreId}")
    modifyVectorStore is AgentOperation<
      {
        /** The ID of the vector store to modify. */
        @doc("Identifier of the vector store.")
        @path
        vectorStoreId: string;

        /**
         * Request object for updating a vector store.
         */
        ...VectorStoreUpdateOptions;
      },
      VectorStore
    >;

    /**
     * Deletes the vector store object matching the specified ID.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @delete
    @route("/{vectorStoreId}")
    deleteVectorStore is AgentOperation<
      {
        /** The ID of the vector store to delete. */
        @doc("Identifier of the vector store.")
        @path
        vectorStoreId: string;
      },
      VectorStoreDeletionStatus
    >;
  }
}
