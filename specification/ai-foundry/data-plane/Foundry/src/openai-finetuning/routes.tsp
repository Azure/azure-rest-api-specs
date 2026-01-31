import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

// import "../.external-readonly/openai.external.typespec/finetuning/custom.tsp";
import "@azure-tools/openai-typespec/views/client-emitters/models/fine-tuning";

import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@route("openai/v1/fine_tuning")
@tag("Fine-tuning")
interface FineTuning {
  /**
   * Creates a fine-tuning job which begins the process of creating a new model from a given dataset.
   *
   * Response includes details of the enqueued job including job status and the name of the fine-tuned models once complete.
   *
   * [Learn more about fine-tuning](https://platform.openai.com/docs/guides/fine-tuning)
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @route("jobs")
  @post
  @operationId("createFineTuningJob")
  createFineTuningJob is FoundryDataPlaneOperation<
    OpenAI.CreateFineTuningJobRequest,
    OpenAI.FineTuningJob
  >;

  /**
   * List your organization's fine-tuning jobs
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @route("jobs")
  @get
  @operationId("listPaginatedFineTuningJobs")
  listPaginatedFineTuningJobs is FoundryDataPlaneOperation<
    {
      /** Identifier for the last job from the previous pagination request. */
      @query after?: string;

      /** Number of fine-tuning jobs to retrieve. */
      @query limit?: int32 = 20;
    },
    OpenAI.ListPaginatedFineTuningJobsResponse
  >;

  /**
   * Get info about a fine-tuning job.
   *
   * [Learn more about fine-tuning](https://platform.openai.com/docs/guides/fine-tuning)
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @route("jobs/{fine_tuning_job_id}")
  @get
  @operationId("retrieveFineTuningJob")
  retrieveFineTuningJob is FoundryDataPlaneOperation<
    {
      /** The ID of the fine-tuning job. */
      @path fine_tuning_job_id: string;
    },
    OpenAI.FineTuningJob
  >;

  /**
   * Immediately cancel a fine-tune job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @route("jobs/{fine_tuning_job_id}/cancel")
  @post
  @operationId("cancelFineTuningJob")
  cancelFineTuningJob is FoundryDataPlaneOperation<
    {
      /** The ID of the fine-tuning job to cancel. */
      @path fine_tuning_job_id: string;
    },
    OpenAI.FineTuningJob
  >;

  /**
   * Pause a running fine-tune job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @route("jobs/{fine_tuning_job_id}/pause")
  @post
  @operationId("pauseFineTuningJob")
  pauseFineTuningJob is FoundryDataPlaneOperation<
    {
      /** The ID of the fine-tuning job to pause. */
      @path fine_tuning_job_id: string;
    },
    OpenAI.FineTuningJob
  >;

  /**
   * Resume a paused fine-tune job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @route("jobs/{fine_tuning_job_id}/resume")
  @post
  @operationId("resumeFineTuningJob")
  resumeFineTuningJob is FoundryDataPlaneOperation<
    {
      /** The ID of the fine-tuning job to resume. */
      @path fine_tuning_job_id: string;
    },
    OpenAI.FineTuningJob
  >;

  /**
   * List checkpoints for a fine-tuning job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @route("jobs/{fine_tuning_job_id}/checkpoints")
  @get
  @operationId("listFineTuningJobCheckpoints")
  listFineTuningJobCheckpoints is FoundryDataPlaneOperation<
    {
      /** The ID of the fine-tuning job to get checkpoints for. */
      @path fine_tuning_job_id: string;

      /** Identifier for the last checkpoint ID from the previous pagination request. */
      @query after?: string;

      /** Number of checkpoints to retrieve. */
      @query limit?: int32 = 10;
    },
    OpenAI.ListFineTuningJobCheckpointsResponse
  >;

  /**
   * Get fine-grained status updates for a fine-tuning job.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @route("jobs/{fine_tuning_job_id}/events")
  @get
  @operationId("listFineTuningJobEvents")
  listFineTuningJobEvents is FoundryDataPlaneOperation<
    {
      /** The ID of the fine-tuning job to get events for. */
      @path fine_tuning_job_id: string;

      /** Identifier for the last event from the previous pagination request. */
      @query after?: string;

      /** Number of events to retrieve. */
      @query limit?: int32 = 20;
    },
    OpenAI.ListFineTuningJobEventsResponse
  >;
}
