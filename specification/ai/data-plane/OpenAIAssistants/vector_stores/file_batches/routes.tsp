import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../../main.tsp";
import "../../common/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

/**
 * Create a vector store file batch.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/vector_stores/{vectorStoreId}/file_batches")
@added(ServiceApiVersions.v2024_05_01_preview)
op createVectorStoreFileBatch(
  /** The ID of the vector store for which to create a File Batch. */
  @path vectorStoreId: string,

  /** A list of File IDs that the vector store should use. Useful for tools like `file_search` that can access files. */
  @minItems(1)
  @maxItems(500)
  @encodedName("application/json", "file_ids")
  fileIds: string[],

  /** The chunking strategy used to chunk the file(s). If not set, will use the auto strategy. */
  @encodedName("application/json", "chunking_strategy")
  @added(ServiceApiVersions.v2024_07_01_preview)
  chunkingStrategy?: VectorStoreChunkingStrategyRequest,
): VectorStoreFileBatch;

/**
 * Retrieve a vector store file batch.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/vector_stores/{vectorStoreId}/file_batches/{batchId}")
@added(ServiceApiVersions.v2024_05_01_preview)
op getVectorStoreFileBatch(
  /** The ID of the vector store that the file batch belongs to. */
  @path vectorStoreId: string,

  /** The ID of the file batch being retrieved. */
  @path batchId: string,
): VectorStoreFileBatch;

/**
 * Cancel a vector store file batch. This attempts to cancel the processing of files in this batch as soon as possible.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/vector_stores/{vectorStoreId}/file_batches/{batchId}/cancel")
@added(ServiceApiVersions.v2024_05_01_preview)
op cancelVectorStoreFileBatch(
  /** The ID of the vector store that the file batch belongs to. */
  @path vectorStoreId: string,

  /** The ID of the file batch to cancel. */
  @path batchId: string,
): VectorStoreFileBatch;

/**
 * Returns a list of vector store files in a batch.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/vector_stores/{vectorStoreId}/file_batches/{batchId}/files")
@added(ServiceApiVersions.v2024_05_01_preview)
op listVectorStoreFileBatchFiles(
  /** The ID of the vector store that the file batch belongs to. */
  @path vectorStoreId: string,

  /** The ID of the file batch that the files belong to. */
  @path batchId: string,

  /** Filter by file status. */
  @query filter?: VectorStoreFileStatusFilter,

  ...OpenAIListRequestOptions,
): OpenAIPageableListOf<VectorStoreFile>;
