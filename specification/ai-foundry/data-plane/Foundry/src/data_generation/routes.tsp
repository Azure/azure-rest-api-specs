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
#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client via Operation-Location"
@tag("DataGenerationJobs")
interface DataGenerationJobs {
  /**
   * Gets the details of a data generation job by its ID.
   */
  @summary("Get info about a data generation job.")
  @route("data_generation/jobs/{jobId}")
  @extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
  get is queryJobStatusPreview<
    FoundryFeaturesOptInKeys.data_generation_jobs_v1_preview,
    DataGenerationJob
  >;

  /**
   * Returns a list of data generation jobs.
   */
  @summary("Returns a list of data generation jobs")
  @route("data_generation/jobs")
  @extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
  list is listJobsPreview<
    FoundryFeaturesOptInKeys.data_generation_jobs_v1_preview,
    DataGenerationJob,
    {
      @doc("Filter data generation jobs by their scenario.")
      @query
      scenario?: DataGenerationJobScenario;

      @doc("Filter data generation jobs by their type.")
      @query
      type?: DataGenerationJobType;
    }
  >;

  /**
   * Creates a data generation job.
   */
  @summary("Creates a data generation job.")
  @route("data_generation/jobs")
  @extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
  create is postJobPreview<
    FoundryFeaturesOptInKeys.data_generation_jobs_v1_preview,
    DataGenerationJob
  >;

  /**
   * Cancels a data generation job by its ID.
   */
  @summary("Cancels a data generation job.")
  @route("data_generation/jobs/{jobId}:cancel")
  @extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
  cancel is cancelJobPreview<
    FoundryFeaturesOptInKeys.data_generation_jobs_v1_preview,
    DataGenerationJob
  >;

  /**
   * Deletes a data generation job by its ID.
   */
  @route("data_generation/jobs/{jobId}")
  @extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
  delete is deleteJobPreview<
    FoundryFeaturesOptInKeys.data_generation_jobs_v1_preview,
    DataGenerationJob
  >;
}
