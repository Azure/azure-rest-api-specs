import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../main.tsp";
import "../../common/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@doc("Returns a list of vector store files.")
@get
@route("/vector_stores/{vectorStoreId}/files")
op listVectorStoreFiles(
  @doc("The ID of the vector store that the files belong to.")
  @path
  vectorStoreId: string,

  @doc("Filter by file status.")
  @query
  filter?: VectorStoreFileStatusFilter,

  ...OpenAIListRequestOptions,
): OpenAIPageableListOf<VectorStoreFile>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@doc("Create a vector store file by attaching a file to a vector store.")
@post
@route("/vector_stores/{vectorStoreId}/files")
op createVectorStoreFile(
  @doc("The ID of the vector store for which to create a File.")
  @path
  vectorStoreId: string,

  @doc("A File ID that the vector store should use. Useful for tools like `file_search` that can access files.")
  @encodedName("application/json", "file_id")
  fileId: string,

  @doc("The chunking strategy used to chunk the file(s). If not set, will use the auto strategy.")
  @encodedName("application/json", "chunking_strategy")
  chunkingStrategy?: VectorStoreChunkingStrategyRequest,
): VectorStoreFile;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@doc("Retrieves a vector store file.")
@get
@route("/vector_stores/{vectorStoreId}/files/{fileId}")
op getVectorStoreFile(
  @doc("The ID of the vector store that the file belongs to.")
  @path
  vectorStoreId: string,

  @doc("The ID of the file being retrieved.")
  @path
  fileId: string,
): VectorStoreFile;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@doc("Delete a vector store file. This will remove the file from the vector store but the file itself will not be deleted. To delete the file, use the delete file endpoint.")
@delete
@route("/vector_stores/{vectorStoreId}/files/{fileId}")
op deleteVectorStoreFile(
  @doc("The ID of the vector store that the file belongs to.")
  @path
  vectorStoreId: string,

  @doc("The ID of the file to delete its relationship to the vector store.")
  @path
  fileId: string,
): VectorStoreFileDeletionStatus;
