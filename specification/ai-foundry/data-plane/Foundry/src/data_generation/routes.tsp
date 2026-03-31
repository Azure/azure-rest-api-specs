import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const DataGenerationJobsRequiredPreviews = #{
  conditional_previews: #[
    FoundryFeaturesOptInKeys.data_generation_jobs_v1_preview
  ],
};

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@tag("DataGenerationJobs")
interface DataGenerationJobs {
  /**
   * Gets the details of a data generation job by its ID.
   */
  @summary("Get info about a data generation job.")
  @route("data_generation/jobs/{data_generation_job_id}")
  @extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
  @get
  get is FoundryDataPlaneOperation<
    {
      @doc("The ID of the data generation job.")
      @path
      @maxLength(1024)
      data_generation_job_id: string;
    },
    DataGenerationJob
  >;

  /**
   * Returns a list of data generation jobs.
   */
  @summary("Returns a list of data generation jobs")
  @route("data_generation/jobs")
  @extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
  @get
  @list
  list is FoundryDataPlaneOperation<
    {
      ...CommonPageQueryParameters;

      @doc("Filter data generation jobs by their scenario.")
      @query
      scenario?: DataGenerationJobScenario;

      @doc("Filter data generation jobs by their type.")
      @query
      type?: DataGenerationJobType;
    },
    AgentsPagedResult<DataGenerationJob>
  >;

  /**
   * Creates a data generation job.
   */
  @summary("Creates a data generation job.")
  @extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
  @route("data_generation/jobs")
  @post
  create is FoundryDataPlaneOperation<
    {
      @doc("Data generation job create request body")
      @body
      dataGenerationJob: DataGenerationJob;
    },
    ResourceCreatedResponse<DataGenerationJob & {
      @doc("The URL to poll the created data generation job status and retrieve the job details.")
      @header("Location")
      location: string;
    }>
  >;

  /**
   * Cancels a data generation job by its ID.
   */
  @summary("Cancels a data generation job.")
  @extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
  @route("data_generation/jobs/{data_generation_job_id}/cancel")
  @post
  cancel is FoundryDataPlaneOperation<
    {
      @doc("The ID of the data generation job to cancel.")
      @path
      @maxLength(1024)
      data_generation_job_id: string;
    },
    DataGenerationJob
  >;

  /**
   * Deletes a data generation job by its ID.
   */
  @route("data_generation/jobs/{data_generation_job_id}")
  @extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
  @delete
  delete is FoundryDataPlaneOperation<
    {
      @doc("The ID of the data generation job to delete.")
      @path
      @maxLength(1024)
      data_generation_job_id: string;
    },
    NoContentResponse
  >;
}
