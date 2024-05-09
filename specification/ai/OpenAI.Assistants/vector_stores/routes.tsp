import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../main.tsp";
import "../common/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

/**
 * Returns a list of vector stores.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/vector_stores")
@added(ServiceApiVersions.v2024_05_01_preview)
op listVectorStores(
    ...OpenAIListRequestOptions
): OpenAIPageableListOf<VectorStore>;

/**
 * Creates a vector store.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/vector_stores")
@added(ServiceApiVersions.v2024_05_01_preview)
op createVectorStore(...VectorStoreOptions): VectorStore;

/**
 * Returns the vector store object matching the specified ID.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/vector_stores/{vectorStoreId}")
@added(ServiceApiVersions.v2024_05_01_preview)
op getVectorStore(
    /** The ID of the vector store to retrieve. */
    @path vectorStoreId: string
): VectorStore;

/**
 * The ID of the vector store to modify.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/vector_stores/{vectorStoreId}")
@added(ServiceApiVersions.v2024_05_01_preview)
op modifyVectorStore(
    /** The ID of the vector store to modify. */
    @path vectorStoreId: string,
    ...VectorStoreUpdateOptions
): VectorStore;

/**
 * Deletes the vector store object matching the specified ID.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@delete
@route("/vector_stores/{vectorStoreId}")
@added(ServiceApiVersions.v2024_05_01_preview)
op deleteVectorStore(
    /** The ID of the vector store to retrieve. */
    @path vectorStoreId: string
): VectorStoreDeletionStatus;


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
    /** The ID of the vector store to retrieve. */
    @path vectorStoreId: string,
    /** Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`. */
    @query filter?: VectorStoreFileStatusFilter,
    ...OpenAIListRequestOptions
): OpenAIPageableListOf<VectorStoreFile>;
