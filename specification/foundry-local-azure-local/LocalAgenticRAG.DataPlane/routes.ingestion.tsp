import "@azure-tools/typespec-azure-core";
import "@typespec/rest";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace FoundryLocal.AgenticRAG;

/** Operations for managing ingestion jobs. */
interface IngestionJobsOperationGroup {
  /**
   * Starts an ingestion job that parses, chunks, embeds, and stores documents into
   * a collection.
   */
  @summary("Create Ingestion Job")
  @route("/edgeai/ingestion/jobs/{jobId}")
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
    IngestionCreateResponse
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
