import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";
import "../models/batch.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

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
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@added(ServiceApiVersions.v2024_07_01_Preview)
@route("/batches")
op batchList(@query after?: string, @query @default(20) limit?: integer): ListBatchesResponse;

/**
 * Creates and executes a batch from an uploaded file of requests.
 * Response includes details of the enqueued job including job status.
 * The ID of the result file is added to the response once complete.
 *
 * @param batchCreateRequest The specification of the batch to create and execute.
 * @returns The requested list of files.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@added(ServiceApiVersions.v2024_07_01_Preview)
@route("/batches")
op batchCreate(@query batchCreateRequest: BatchCreateRequest): Batch;

/**
 * Creates and executes a batch from an uploaded file of requests.
 * Response includes details of the enqueued job including job status.
 * The ID of the result file is added to the response once complete.
 *
 * @returns The requested batch.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
@get
@route("/batches/{batchID}")
@doc("Gets details for a single batch specified by the given batchID.")
@added(ServiceApiVersions.v2024_07_01_Preview)
op batchGet(
  @doc("The identifier of the batch.")
  @path
  @encodedName("application/json", "batchID")
  batchID: string,
): Batch;

/**
 * Cancels the processing of the batch specified by the given batchID.
 *
 * @returns The Batch that was canceled.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API name parity"
@get
@route("/batches/{batchID}/cancel")
@doc("Gets details for a single batch specified by the given batchID.")
@added(ServiceApiVersions.v2024_07_01_Preview)
op batchCancel(
  @doc("The identifier of the batch.")
  @path
  @encodedName("application/json", "batchID")
  batchID: string,
): Batch;