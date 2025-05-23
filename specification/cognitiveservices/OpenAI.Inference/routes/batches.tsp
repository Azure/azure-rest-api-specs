import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "../models/batch.tsp";
import "../models/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.OpenAI;

/**
 * Gets a list of all batches owned by the Azure OpenAI resource.
 *
 * @param after Identifier for the last event from the previous pagination request.
 * @param limit The number of batches to retrieve. The default is 20.
 * @returns The requested list of batches.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@added(ServiceApiVersions.v2024_07_01_Preview)
@route("/batches")
op listBatches(
  /** Identifier for the last event from the previous pagination request. */
  @query after?: string,

  /** Number of batches to retrieve. Defaults to 20. */
  @query limit?: int32,
): OpenAIPageableListOf<Batch>;

/**
 * Creates and executes a batch from an uploaded file of requests.
 * Response includes details of the enqueued job including job status.
 * The ID of the result file is added to the response once complete.
 *
 * @param batchCreateRequest The specification of the batch to create and execute.
 * @returns The requested new batch job.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@added(ServiceApiVersions.v2024_07_01_Preview)
@route("/batches")
op createBatch(
  /** The specification of the batch to create and execute. */
  @body
  createBatchRequest: BatchCreateRequest,
): BatchCreateResponse;

/**
 * Retrieves an existing batch job by its ID.
 *
 * @param batchId The ID of the batch job to retrieve.
 * @returns The requested existing batch job.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
@get
@route("/batches/{batchId}")
@doc("Gets details for a single batch specified by the given batchID.")
@added(ServiceApiVersions.v2024_07_01_Preview)
op getBatch(
  @doc("The identifier of the batch.")
  @path
  batchId: string,
): Batch;

/**
 * Cancels the processing of the batch specified by the given ID.
 *
 * @param batchId The ID of the batch job to cancel.
 * @returns The updated batch job that was canceled.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
@post
@route("/batches/{batchId}/cancel")
@doc("Gets details for a single batch specified by the given batchID.")
@added(ServiceApiVersions.v2024_07_01_Preview)
op cancelBatch(
  @doc("The identifier of the batch.")
  @path
  batchId: string,
): Batch;
