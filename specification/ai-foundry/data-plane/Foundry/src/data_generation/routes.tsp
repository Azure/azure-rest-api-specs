import "./models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@route("data_generation/jobs")
@tag("DataGenerationJobs")
interface DataGenerationJobs {
  /**
   * Gets the details of a data generation job by its ID.
   */
  @summary("Get info about a data generation job.")
  get is OpenAIOperation<
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
  @get
  @list
  list is OpenAIOperation<
    {
      @doc("Identifier for the last job from the previous pagination request.")
      @query
      after?: string;

      @doc("Number of data generation jobs to retrieve.")
      @query
      limit?: int32 = 20;

      @doc("Filter data generation jobs by their purpose.")
      @query
      purpose?: DataGenerationJobPurpose;

      @doc("Filter data generation jobs by their type.")
      @query
      type?: DataGenerationJobType;
    },
    Array<DataGenerationJob>
  >;

  /**
   * Creates a data generation job.
   */
  @summary("Creates a data generation job.")
  @post
  create is OpenAIOperation<
    {
      @doc("Data generation job create request body")
      @body
      dataGenerationJob: DataGenerationJob;
    },
    DataGenerationJob
  >;

  /**
   * Cancels a data generation job by its ID.
   */
  @summary("Cancels a data generation job.")
  @post
  cancel is OpenAIOperation<
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
  @delete
  delete is OpenAIOperation<
    {
      @doc("The ID of the data generation job to delete.")
      @path
      @maxLength(1024)
      data_generation_job_id: string;
    },
    NoContentResponse
  >;
}
