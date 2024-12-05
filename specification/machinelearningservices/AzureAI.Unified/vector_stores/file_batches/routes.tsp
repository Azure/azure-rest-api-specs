import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../../main.tsp";
import "../../common/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@doc("Create a vector store file batch.")
@post
@route("/vector_stores/{vectorStoreId}/file_batches")
op createVectorStoreFileBatch(
  @doc("The ID of the vector store for which to create a File Batch.")
  @path
  vectorStoreId: string,

  @doc("A list of File IDs that the vector store should use. Useful for tools like `file_search` that can access files.")
  @minItems(1)
  @maxItems(500)
  @encodedName("application/json", "file_ids")
  fileIds: string[],

  @doc("The chunking strategy used to chunk the file(s). If not set, will use the auto strategy.")
  @encodedName("application/json", "chunking_strategy")
  chunkingStrategy?: VectorStoreChunkingStrategyRequest,
): VectorStoreFileBatch;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@doc("Retrieve a vector store file batch.")
@get
@route("/vector_stores/{vectorStoreId}/file_batches/{batchId}")
op getVectorStoreFileBatch(
  @doc("The ID of the vector store that the file batch belongs to.")
  @path
  vectorStoreId: string,

  @doc("The ID of the file batch being retrieved.")
  @path
  batchId: string,
): VectorStoreFileBatch;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@doc("Cancel a vector store file batch. This attempts to cancel the processing of files in this batch as soon as possible.")
@post
@route("/vector_stores/{vectorStoreId}/file_batches/{batchId}/cancel")
op cancelVectorStoreFileBatch(
  @doc("The ID of the vector store that the file batch belongs to.")
  @path
  vectorStoreId: string,

  @doc("The ID of the file batch to cancel.")
  @path
  batchId: string,
): VectorStoreFileBatch;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@doc("Returns a list of vector store files in a batch.")
@get
@route("/vector_stores/{vectorStoreId}/file_batches/{batchId}/files")
op listVectorStoreFileBatchFiles(
  @doc("The ID of the vector store that the file batch belongs to.")
  @path
  vectorStoreId: string,

  @doc("The ID of the file batch that the files belong to.")
  @path
  batchId: string,

  @doc("Filter by file status.")
  @query
  filter?: VectorStoreFileStatusFilter,

  ...OpenAIListRequestOptions,
): OpenAIPageableListOf<VectorStoreFile>;
