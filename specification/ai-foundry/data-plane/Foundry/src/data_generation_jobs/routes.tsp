import "./models.tsp";

using TypeSpec.Http;
using Azure.Core;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@tag("DataGenerationJobs")
interface DataGenerationJobs {
  /**
   * Retrieves the specified data generation job and its current status.
   */
  @summary("Get a data generation job")
  @route("data_generation_jobs/{jobId}")
  get is queryJobStatus<DataGenerationJob>;

  /**
   * Returns a list of data generation jobs.
   */
  @summary("List data generation jobs")
  @route("data_generation_jobs")
  list is listJobs<DataGenerationJob>;

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
  cancel is cancelJob<DataGenerationJob>;

  /**
   * Removes the specified data generation job and its associated output.
   */
  @summary("Delete a data generation job")
  @route("data_generation_jobs/{jobId}")
  delete is deleteJob<DataGenerationJob>;
}
