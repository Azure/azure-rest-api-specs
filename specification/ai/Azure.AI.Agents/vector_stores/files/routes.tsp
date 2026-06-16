import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./models.tsp";
import "../../common/models.tsp";
import "../../servicepatterns.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core.Foundations;

namespace Azure.AI.Agents {
  /**
   * A collection of vector-store file operations under
   * `/vector_stores/{vectorStoreId}/files`.
   */
  @route("/vector_stores/{vectorStoreId}/files")
  @added(Versions.v2025_05_01)
  interface VectorStoreFiles {
    /**
     * Returns a list of vector store files.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @get
    @list
    listVectorStoreFiles(
      /** The ID of the vector store that the files belong to. */
      @doc("Identifier of the vector store.")
      @path
      vectorStoreId: string,

      /** Filter by file status. */
      @query
      filter?: VectorStoreFileStatusFilter,

      ...ApiVersionParameter,
      ...AgentsListOptions,
    ): {
      ...AgentsPagedResult<VectorStoreFile>;
    } | AgentV1Error;

    /**
     * Create a vector store file by attaching a file to a vector store.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @post
    createVectorStoreFile is AgentOperation<
      {
        /** The ID of the vector store for which to create a File. */
        @doc("Identifier of the vector store.")
        @path
        vectorStoreId: string;

        /** A File ID that the vector store should use. Useful for tools like `file_search`. */
        @doc("Identifier of the file.")
        @encodedName("application/json", "file_id")
        fileId?: string;

        /** The data source to be used. Mutually exclusive with fileId. */
        @doc("Azure asset ID.")
        @encodedName("application/json", "data_source")
        dataSource?: VectorStoreDataSource;

        /** The chunking strategy used to chunk the file. If not set, uses the auto strategy. */
        @encodedName("application/json", "chunking_strategy")
        chunkingStrategy?: VectorStoreChunkingStrategyRequest;
      },
      VectorStoreFile
    >;

    /**
     * Retrieves a vector store file.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @get
    @route("/{fileId}")
    getVectorStoreFile is AgentOperation<
      {
        /** The ID of the vector store that the file belongs to. */
        @doc("Identifier of the vector store.")
        @path
        vectorStoreId: string;

        /** The ID of the file being retrieved. */
        @doc("Identifier of the file.")
        @path
        fileId: string;
      },
      VectorStoreFile
    >;

    /**
     * Deletes a vector store file. This removes the file‐to‐store link (does not delete the file itself).
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @delete
    @route("/{fileId}")
    deleteVectorStoreFile is AgentOperation<
      {
        /** The ID of the vector store that the file belongs to. */
        @doc("Identifier of the vector store.")
        @path
        vectorStoreId: string;

        /** The ID of the file to delete its relationship to the vector store. */
        @doc("Identifier of the file.")
        @path
        fileId: string;
      },
      VectorStoreFileDeletionStatus
    >;
  }
}
