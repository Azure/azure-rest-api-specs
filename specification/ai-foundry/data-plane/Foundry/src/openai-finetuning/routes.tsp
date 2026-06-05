import "../common/models.tsp";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/fine-tuning";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/fine_tuning")
@tag("Fine-tuning")
interface FineTuning {
  @tag("Fine-tuning")
  @list
  @route("checkpoints/{fine_tuned_model_checkpoint}/permissions")
  @get
  @summary("""
    **NOTE:** This endpoint requires an [admin API key](../admin-api-keys).
    
    Organization owners can use this endpoint to view all permissions for a fine-tuned model checkpoint.
    
    """)
  listFineTuningCheckpointPermissions is OpenAIOperation<
    {
      /** The ID of the fine-tuned model checkpoint to get permissions for. */
      @path
      fine_tuned_model_checkpoint: string;

      /** The ID of the project to get permissions for. */
      @query(#{ explode: true })
      project_id?: string;

      /** Identifier for the last permission ID from the previous pagination request. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** Number of permissions to retrieve. */
      @query(#{ explode: true })
      limit?: integer = 10;

      /** The order in which to retrieve permissions. */
      @query(#{ explode: true })
      order?: "ascending" | "descending" = "descending";
    },
    OpenAI.ListFineTuningCheckpointPermissionResponse
  >;

  @tag("Fine-tuning")
  @route("checkpoints/{fine_tuned_model_checkpoint}/permissions")
  @post
  @summary("""
    **NOTE:** Calling this endpoint requires an [admin API key](../admin-api-keys).
    
    This enables organization owners to share fine-tuned models with other projects in their organization.
    
    """)
  createFineTuningCheckpointPermission is OpenAIOperation<
    {
      /** The ID of the fine-tuned model checkpoint to create a permission for. */
      @path
      fine_tuned_model_checkpoint: string;

      @body
      body: OpenAI.CreateFineTuningCheckpointPermissionRequest;
    },
    OpenAI.ListFineTuningCheckpointPermissionResponse
  >;

  @tag("Fine-tuning")
  @route("checkpoints/{fine_tuned_model_checkpoint}/permissions/{permission_id}")
  @delete
  @summary("""
    **NOTE:** This endpoint requires an [admin API key](../admin-api-keys).
    
    Organization owners can use this endpoint to delete a permission for a fine-tuned model checkpoint.
    
    """)
  deleteFineTuningCheckpointPermission is OpenAIOperation<
    {
      /** The ID of the fine-tuned model checkpoint to delete a permission for. */
      @path
      fine_tuned_model_checkpoint: string;

      /** The ID of the fine-tuned model checkpoint permission to delete. */
      @path
      permission_id: string;
    },
    OpenAI.DeleteFineTuningCheckpointPermissionResponse
  >;

  @tag("Fine-tuning")
  @list
  @route("jobs")
  @get
  @summary("""
    List your organization's fine-tuning jobs
    
    """)
  listPaginatedFineTuningJobs is OpenAIOperation<
    {
      /** Identifier for the last job from the previous pagination request. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** Number of fine-tuning jobs to retrieve. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Optional metadata filter. To filter, use the syntax `metadata[k]=v`. Alternatively, set `metadata=null` to indicate no metadata. */
      @query(#{ explode: true })
      metadata?: Record<string> | null;
    },
    OpenAI.ListPaginatedFineTuningJobsResponse
  >;

  @tag("Fine-tuning")
  @route("jobs")
  @post
  @summary("""
    Creates a fine-tuning job which begins the process of creating a new model from a given dataset.
    
    Response includes details of the enqueued job including job status and the name of the fine-tuned models once complete.
    
    [Learn more about fine-tuning](/docs/guides/model-optimization)
    
    """)
  createFineTuningJob is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateFineTuningJobRequest;
    },
    OpenAI.FineTuningJob
  >;

  @tag("Fine-tuning")
  @route("jobs/{fine_tuning_job_id}")
  @get
  @summary("""
    Get info about a fine-tuning job.
    
    [Learn more about fine-tuning](/docs/guides/model-optimization)
    
    """)
  retrieveFineTuningJob is OpenAIOperation<
    {
      /** The ID of the fine-tuning job. */
      @path
      fine_tuning_job_id: string;
    },
    OpenAI.FineTuningJob
  >;

  @tag("Fine-tuning")
  @route("jobs/{fine_tuning_job_id}/cancel")
  @post
  @summary("""
    Immediately cancel a fine-tune job.
    
    """)
  cancelFineTuningJob is OpenAIOperation<
    {
      /** The ID of the fine-tuning job to cancel. */
      @path
      fine_tuning_job_id: string;
    },
    OpenAI.FineTuningJob
  >;

  @tag("Fine-tuning")
  @list
  @route("jobs/{fine_tuning_job_id}/checkpoints")
  @get
  @summary("""
    List checkpoints for a fine-tuning job.
    
    """)
  listFineTuningJobCheckpoints is OpenAIOperation<
    {
      /** The ID of the fine-tuning job to get checkpoints for. */
      @path
      fine_tuning_job_id: string;

      /** Identifier for the last checkpoint ID from the previous pagination request. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** Number of checkpoints to retrieve. */
      @query(#{ explode: true })
      limit?: integer = 10;
    },
    OpenAI.ListFineTuningJobCheckpointsResponse
  >;

  @tag("Fine-tuning")
  @list
  @route("jobs/{fine_tuning_job_id}/events")
  @get
  @summary("""
    Get status updates for a fine-tuning job.
    
    """)
  listFineTuningEvents is OpenAIOperation<
    {
      /** The ID of the fine-tuning job to get events for. */
      @path
      fine_tuning_job_id: string;

      /** Identifier for the last event from the previous pagination request. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** Number of events to retrieve. */
      @query(#{ explode: true })
      limit?: integer = 20;
    },
    OpenAI.ListFineTuningJobEventsResponse
  >;

  @tag("Fine-tuning")
  @route("jobs/{fine_tuning_job_id}/pause")
  @post
  @summary("""
    Pause a fine-tune job.
    
    """)
  pauseFineTuningJob is OpenAIOperation<
    {
      /** The ID of the fine-tuning job to pause. */
      @path
      fine_tuning_job_id: string;
    },
    OpenAI.FineTuningJob
  >;

  @tag("Fine-tuning")
  @route("jobs/{fine_tuning_job_id}/resume")
  @post
  @summary("""
    Resume a fine-tune job.
    
    """)
  resumeFineTuningJob is OpenAIOperation<
    {
      /** The ID of the fine-tuning job to resume. */
      @path
      fine_tuning_job_id: string;
    },
    OpenAI.FineTuningJob
  >;
}
