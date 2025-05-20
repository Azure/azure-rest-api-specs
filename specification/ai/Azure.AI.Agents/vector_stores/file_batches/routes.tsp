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
   * A collection of file-batch operations under
   * `/vector_stores/{vectorStoreId}/file_batches`.
   */
  @route("/vector_stores/{vectorStoreId}/file_batches")
  @added(Versions.v2025_05_01)
  interface VectorStoreFileBatches {
    /**
     * Create a vector store file batch.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @post
    createVectorStoreFileBatch is AgentOperation<
      {
        /** The ID of the vector store for which to create a File Batch. */
        @doc("Identifier of the vector store.")
        @path
        vectorStoreId: string;

        /** A list of File IDs that the vector store should use. Useful for tools like `file_search` that can access files. */
        @minItems(1)
        @maxItems(500)
        @encodedName("application/json", "file_ids")
        @doc("List of file identifiers.")
        fileIds?: string[];

        /** The data sources to be used. This option is mutually exclusive with fileIds. */
        @minItems(1)
        @maxItems(500)
        @encodedName("application/json", "data_sources")
        @doc("List of Azure assets.")
        dataSources?: VectorStoreDataSource[];

        /** The chunking strategy used to chunk the file(s). If not set, will use the auto strategy. */
        @encodedName("application/json", "chunking_strategy")
        chunkingStrategy?: VectorStoreChunkingStrategyRequest;
      },
      VectorStoreFileBatch
    >;

    /**
     * Retrieve a vector store file batch.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @get
    @route("/{batchId}")
    getVectorStoreFileBatch is AgentOperation<
      {
        /** The ID of the vector store that the file batch belongs to. */
        @doc("Identifier of the vector store.")
        @path
        vectorStoreId: string;

        /** The ID of the file batch being retrieved. */
        @doc("Identifier of the file batch.")
        @path
        batchId: string;
      },
      VectorStoreFileBatch
    >;

    /**
     * Cancel a vector store file batch. This attempts to cancel the processing of files in this batch as soon as possible.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @post
    @route("/{batchId}/cancel")
    cancelVectorStoreFileBatch is AgentOperation<
      {
        /** The ID of the vector store that the file batch belongs to. */
        @doc("Identifier of the vector store.")
        @path
        vectorStoreId: string;

        /** The ID of the file batch to cancel. */
        @doc("Identifier of the file batch.")
        @path
        batchId: string;
      },
      VectorStoreFileBatch
    >;

    /**
     * Returns a list of vector store files in a batch.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
    @get
    @route("/{batchId}/files")
    @list
    listVectorStoreFileBatchFiles(
      /** The ID of the vector store that the file batch belongs to. */
      @doc("Identifier of the vector store.")
      @path
      vectorStoreId: string,

      /** The ID of the file batch that the files belong to. */
      @doc("Identifier of the file batch.")
      @path
      batchId: string,

      /** Filter by file status. */
      @query filter?: VectorStoreFileStatusFilter,

      ...ApiVersionParameter,
      ...AgentsListOptions,
    ): {
      ...AgentsPagedResult<VectorStoreFile>;
    } | AgentV1Error;
  }
}
