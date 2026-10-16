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
   * Returns effective trace settings, including `turn` and false for omitted
   * settings or older stored jobs. Reading an existing job does not require
   * preview opt-in.
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
   * Each trace job includes its effective settings, including `turn` and false
   * for omitted settings or older stored jobs. Listing existing jobs does not
   * require preview opt-in.
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
   * Trace requests with `sample_level` set to `conversation` require
   * `Foundry-Features: DataGenerationJobs=V1Preview`; the service rejects
   * conversation requests without this opt-in. Ordinary turn-level trace
   * requests do not require the header.
   * Conversation samples require `scenario` to be `evaluation`.
   * Generating test-case descriptions also requires `sample_level` to be
   * `conversation` and a nonempty `model_options.model`.
   * The response includes the effective trace settings, defaulting to
   * `sample_level: turn` and `generate_test_case_description: false`.
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
