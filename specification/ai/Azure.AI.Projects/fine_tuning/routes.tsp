import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;
using Azure.Core.Foundations;

namespace Azure.AI.Projects;

@route("fine_tuning/jobs")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
interface FineTuningJobs {
  @doc("Get info about a fine-tuning job.")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  get is Azure.Core.Foundations.Operation<
      {
        @doc("The ID of the fine-tuning job.")
        @path
        fine_tuning_job_id: string
      },
      FineTuningJob
  >;

  @doc("Returns a list of finetune jobs")
  @get
  @list
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  listFineTuningJobs is Azure.Core.Foundations.Operation<
    {
        @doc("Identifier for the last job from the previous pagination request.")
        @query
        after?: string;

        @doc("Number of fine-tuning jobs to retrieve.")
        @query
        limit?: int32 = 20;

        @doc("Optional metadata filter. To filter, use the syntax metadata[k]=v. Alternatively, set metadata=null to indicate no metadata.")
        @query
        metadata?: string;
    },
    FineTuningPaginatedResponse<FineTuningJob>
  >;

  @doc("Creates a fine-tuning job.")
  @post
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  create is Azure.Core.Foundations.Operation<
    {
      @doc("fine-tuning job")
      @body
      fineTuningJob: FineTuningJobCreation;
    },
    FineTuningJob
  >;

  @doc("Cancel a fine-tune job.")
  @post
  @route("/{fine_tuning_job_id}/cancel")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  cancel is Azure.Core.Foundations.Operation<
    {
        @doc("The ID of the fine-tuning job to cancel.")
        @path
        fine_tuning_job_id: string;
    },
    FineTuningJob
  >;

  @doc("Pause a fine-tune job.")
  @post
  @route("/{fine_tuning_job_id}/pause")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  pause is Azure.Core.Foundations.Operation<
    {
        @doc("The ID of the fine-tuning job to pause.")
        @path
        fine_tuning_job_id: string;
    },
    FineTuningJob
  >;

  @doc("Resume a fine-tune job.")
  @post
  @route("/{fine_tuning_job_id}/resume")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  resume is Azure.Core.Foundations.Operation<
    {
        @doc("The ID of the fine-tuning job to resume.")
        @path
        fine_tuning_job_id: string;
    },
    FineTuningJob
  >;

  @doc("Delete a fine-tune job.")
  @delete
  @route("/{fine_tuning_job_id}")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  delete is Azure.Core.Foundations.Operation<
    {
        @doc("The ID of the fine-tuning job to delete.")
        @path
        fine_tuning_job_id: string;
    },
    Http.NoContentResponse
  >;

  @doc("Get status updates for a fine-tuning job.")
  @get
  @route("/{fine_tuning_job_id}/events")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  listFineTuningJobEvents is Azure.Core.Foundations.Operation<
    {
        @doc("The ID of the fine-tuning job to get events for.")
        @path
        fine_tuning_job_id: string;

        @doc("Identifier for the last event from the previous pagination request.")
        @query
        after?: string;

        @doc("Number of events to retrieve.")
        @query
        limit?: int32 = 20;
    },
    FineTuningPaginatedResponse<FineTuningJobEvent>
  >;

  @doc("List checkpoints for a fine-tuning job.")
  @get
  @route("/{fine_tuning_job_id}/checkpoints")
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  listFineTuningJobCheckpoints is Azure.Core.Foundations.Operation<
    {
        @doc("The ID of the fine-tuning job to get events for.")
        @path
        fine_tuning_job_id: string;

        @doc("Identifier for the last checkpoint from the previous pagination request.")
        @query
        after?: string;

        @doc("Number of checkpoints to retrieve.")
        @query
        limit?: int32 = 10;
    },
    FineTuningPaginatedResponse<FineTuningJobCheckpoint>
  >;
}
