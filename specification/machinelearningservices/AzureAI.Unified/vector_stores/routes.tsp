import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../main.tsp";
import "../common/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@doc("Returns a list of vector stores.")
@get
@route("/vector_stores")
op listVectorStores(
  ...OpenAIListRequestOptions,
): OpenAIPageableListOf<VectorStore>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@doc("Creates a vector store.")
@post
@route("/vector_stores")
op createVectorStore(
  @doc("Request object for creating a vector store.")
  @bodyRoot
  body: VectorStoreOptions,
): VectorStore;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@doc("Returns the vector store object matching the specified ID.")
@get
@route("/vector_stores/{vectorStoreId}")
op getVectorStore(
  @doc("The ID of the vector store to retrieve.")
  @path
  vectorStoreId: string,
): VectorStore;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@doc("The ID of the vector store to modify.")
@post
@route("/vector_stores/{vectorStoreId}")
op modifyVectorStore(
  @doc("The ID of the vector store to modify.")
  @path
  vectorStoreId: string,

  @doc("Request object for updating a vector store.")
  @bodyRoot
  body: VectorStoreUpdateOptions,
): VectorStore;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@doc("Deletes the vector store object matching the specified ID.")
@delete
@route("/vector_stores/{vectorStoreId}")
op deleteVectorStore(
  @doc("The ID of the vector store to delete.")
  @path
  vectorStoreId: string,
): VectorStoreDeletionStatus;
