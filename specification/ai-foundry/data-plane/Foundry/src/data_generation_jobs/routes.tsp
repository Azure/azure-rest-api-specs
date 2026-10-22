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
   * Returns effective trace settings and preserves `type: conversations` for
   * conversation jobs. Reading an existing job does not require preview opt-in.
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
   * Each trace job includes its effective settings. Conversation jobs preserve
   * `type: conversations`. Listing existing jobs does not require preview opt-in.
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
   * Requests with `type` set to `conversations`, or trace requests with
   * `sample_level` set to `conversation`, require
   * `Foundry-Features: DataGenerationJobs=V1Preview`; the service rejects
   * conversation requests without this opt-in. Ordinary turn-level trace
   * requests do not require the header.
   * Conversation samples require `scenario` to be `evaluation`.
   * Jobs with `type: conversations` reconstruct existing traced conversations,
   * use sources of type `traces`, and do not support `sample_level`.
   * Generating test-case descriptions requires a nonempty `model_options.model`;
   * trace jobs also require `sample_level` to be `conversation`.
   * For `type: conversations`, `model_options` must be omitted when description
   * generation is false or omitted. Create, get, and list responses preserve
   * `type: conversations`.
   * Generating test-case rubrics with `generate_test_case_rubric_preview` also
   * requires a nonempty `model_options.model`.
   * The response includes the effective trace settings.
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
