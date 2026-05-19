import "@azure-tools/typespec-azure-core";
import "@typespec/rest";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

namespace FoundryLocal.AgenticRAG;

/** Operations for managing ingestion jobs. */
interface IngestionJobsOperationGroup {
  /**
   * Starts a long-running ingestion job that parses, chunks, embeds, and stores
   * documents into a collection. Returns an `operation-location` header to poll
   * for run status via `getIngestionRun`.
   */
  @summary("Create Ingestion Job")
  @route("/edgeai/ingestion/jobs/{jobId}")
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling is done via getIngestionRun but cannot use @pollingOperation due to different path parameters"
  @post
  createIngestionJob is Azure.Core.RpcOperation<
    {
      /** User-chosen name for the ingestion job. */
      @path
      jobId: string;

      /** The ingestion job configuration. */
      @bodyRoot
      body: CreateIngestionRequest;
    },
    IngestionCreateResponse & {
      /** URI to monitor the run. */
      @header("operation-location")
      operationLocation?: string;
    }
  >;

  /** List Ingestion Jobs */
  @summary("List Ingestion Jobs")
  @route("/edgeai/ingestion/jobs")
  @get
  listIngestionJobs is Azure.Core.RpcOperation<{}, IngestionJobList>;
}

/** Operations for managing ingestion runs. */
interface IngestionRunsOperationGroup {
  /** Get Ingestion Run */
  @summary("Get Ingestion Run")
  @route("/edgeai/ingestion/jobs/{jobId}/runs/{runId}")
  @get
  getIngestionRun is Azure.Core.RpcOperation<
    {
      /** The ingestion job identifier. */
      @path
      jobId: string;

      /** The run identifier. */
      @path
      runId: string;
    },
    IngestionRunDetail
  >;

  /** Delete Runs for Job */
  @summary("Delete Runs for Job")
  @route("/edgeai/ingestion/jobs/{jobId}/runs")
  @delete
  deleteIngestionRuns is Azure.Core.RpcOperation<
    {
      /** The ingestion job identifier. */
      @path
      jobId: string;
    },
    {
      @statusCode statusCode: 200;
    }
  >;
}
