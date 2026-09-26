import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.AI.Projects;

alias DataGenerationJobsOptionalPreviewHeader = WithConditionalFoundryPreviewHeader<FoundryFeaturesOptInKeys.data_generation_jobs_v1_preview>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@tag("DataGenerationJobs")
interface DataGenerationJobs {
  /**
   * Retrieves the specified data generation job and its current status.
   */
  @summary("Get a data generation job")
  @route("data_generation_jobs/{jobId}")
  @get
  get is FoundryDataPlaneOperation<
    {
      ...DataGenerationJobsOptionalPreviewHeader;

      /** The ID of the job. */
      @path jobId: string;
    },
    JobStatusResponse<DataGenerationJob>
  >;

  /**
   * Returns a list of data generation jobs.
   */
  @summary("List data generation jobs")
  @route("data_generation_jobs")
  @get
  @list
  list is FoundryDataPlaneOperation<
    {
      ...DataGenerationJobsOptionalPreviewHeader;
      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<DataGenerationJob>
  >;

  /**
   * Submits a new data generation job for asynchronous execution.
   */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client via Operation-Location"
  @summary("Create a data generation job")
  @route("data_generation_jobs")
  @pollingOperation(DataGenerationJobs.get)
  @post
  create is FoundryDataPlaneOperation<
    {
      ...DataGenerationJobsOptionalPreviewHeader;
      ...WithOperationId;

      /** The data generation job inputs to create. */
      @body job: DataGenerationJobInputs;
    },
    JobCreatedResponse<DataGenerationJob>
  >;

  /**
   * Cancels the specified data generation job if it is still in progress.
   */
  @summary("Cancel a data generation job")
  @route("data_generation_jobs/{jobId}:cancel")
  @post
  cancel is FoundryDataPlaneOperation<
    {
      ...DataGenerationJobsOptionalPreviewHeader;

      /** The ID of the job to cancel. */
      @path jobId: string;
    },
    OkResponse & DataGenerationJob
  >;

  /**
   * Removes the specified data generation job and its associated output.
   */
  @summary("Delete a data generation job")
  @route("data_generation_jobs/{jobId}")
  @delete
  delete is FoundryDataPlaneOperation<
    {
      ...DataGenerationJobsOptionalPreviewHeader;

      /** The ID of the job to delete. */
      @path jobId: string;
    },
    NoContentResponse
  >;
}
