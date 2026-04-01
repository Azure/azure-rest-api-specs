import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const FoundryJobsRequiredPreviews = #{
  conditional_previews: #[FoundryFeaturesOptInKeys.jobs_v1_preview],
};

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@tag("Jobs")
interface FoundryJobs {
  /**
   * Gets the details of a job by its id.
   */
  @summary("Get the details of a Foundry job.")
  @route("jobs/{job_id}")
  @extension("x-ms-foundry-meta", FoundryJobsRequiredPreviews)
  @get
  get is FoundryDataPlaneOperation<
    {
      @doc("The ID of the foundry job.")
      @path
      @maxLength(1024)
      job_id: string;
    },
    FoundryJob
  >;

  /**
   * Returns a list of foundry jobs.
   */
  @summary("Returns a list of foundry jobs")
  @route("jobs")
  @extension("x-ms-foundry-meta", FoundryJobsRequiredPreviews)
  @get
  @list
  list is FoundryDataPlaneOperation<
    {
      ...CommonPageQueryParameters;

      @doc("Filter foundry jobs by their type.")
      @query
      type?: FoundryJobType;
    },
    AgentsPagedResult<FoundryJob>
  >;

  /**
   * Cancels a foundry job by its ID.
   */
  @summary("Cancels a foundry job.")
  @extension("x-ms-foundry-meta", FoundryJobsRequiredPreviews)
  @route("jobs/{job_id}:cancel")
  @post
  cancel is FoundryDataPlaneOperation<
    {
      @doc("The ID of the foundry job to cancel.")
      @path
      @maxLength(1024)
      job_id: string;
    },
    FoundryJob
  >;
}
