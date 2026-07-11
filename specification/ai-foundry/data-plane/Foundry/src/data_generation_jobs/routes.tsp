import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

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
  @extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
  get is queryJobStatusPreview<
    FoundryFeaturesOptInKeys.data_generation_jobs_v1_preview,
    DataGenerationJob
  >;

  /**
   * Returns a list of data generation jobs.
   */
  @summary("List data generation jobs")
  @route("data_generation_jobs")
  @extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
  list is listJobsPreview<
    FoundryFeaturesOptInKeys.data_generation_jobs_v1_preview,
    DataGenerationJob
  >;

  /**
   * Submits a new data generation job for asynchronous execution.
   */
  @summary("Create a data generation job")
  @route("data_generation_jobs")
  @extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
  @Azure.Core.pollingOperation(DataGenerationJobs.get)
  create is postJobPreview<
    FoundryFeaturesOptInKeys.data_generation_jobs_v1_preview,
    DataGenerationJob
  >;

  /**
   * Cancels the specified data generation job if it is still in progress.
   */
  @summary("Cancel a data generation job")
  @route("data_generation_jobs/{jobId}:cancel")
  @extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
  cancel is cancelJobPreview<
    FoundryFeaturesOptInKeys.data_generation_jobs_v1_preview,
    DataGenerationJob
  >;

  /**
   * Removes the specified data generation job and its associated output.
   */
  @summary("Delete a data generation job")
  @route("data_generation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
  delete is deleteJobPreview<FoundryFeaturesOptInKeys.data_generation_jobs_v1_preview>;
}
