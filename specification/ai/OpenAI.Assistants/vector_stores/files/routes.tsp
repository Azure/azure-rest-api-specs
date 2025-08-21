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
 * Returns a list of vector store files.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/vector_stores/{vectorStoreId}/files")
@added(ServiceApiVersions.v2024_05_01_preview)
op listVectorStoreFiles(
  /** The ID of the vector store that the files belong to. */
  @path vectorStoreId: string,

  /** Filter by file status. */
  @query filter?: VectorStoreFileStatusFilter,

  ...OpenAIListRequestOptions,
): OpenAIPageableListOf<VectorStoreFile>;

/**
 * Create a vector store file by attaching a file to a vector store.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/vector_stores/{vectorStoreId}/files")
@added(ServiceApiVersions.v2024_05_01_preview)
op createVectorStoreFile(
  /** The ID of the vector store for which to create a File. */
  @path vectorStoreId: string,

  /** A File ID that the vector store should use. Useful for tools like `file_search` that can access files. */
  @encodedName("application/json", "file_id")
  fileId: string,

  /** The chunking strategy used to chunk the file(s). If not set, will use the auto strategy. */
  @encodedName("application/json", "chunking_strategy")
  @added(ServiceApiVersions.v2024_07_01_preview)
  chunkingStrategy?: VectorStoreChunkingStrategyRequest,
): VectorStoreFile;

/**
 * Retrieves a vector store file.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/vector_stores/{vectorStoreId}/files/{fileId}")
@added(ServiceApiVersions.v2024_05_01_preview)
op getVectorStoreFile(
  /** The ID of the vector store that the file belongs to. */
  @path vectorStoreId: string,

  /** The ID of the file being retrieved. */
  @path fileId: string,
): VectorStoreFile;

/**
 * Delete a vector store file. This will remove the file from the vector store but the file itself will not be deleted.
 * To delete the file, use the delete file endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@delete
@route("/vector_stores/{vectorStoreId}/files/{fileId}")
@added(ServiceApiVersions.v2024_05_01_preview)
op deleteVectorStoreFile(
  /** The ID of the vector store that the file belongs to. */
  @path vectorStoreId: string,

  /** The ID of the file to delete its relationship to the vector store. */
  @path fileId: string,
): VectorStoreFileDeletionStatus;
