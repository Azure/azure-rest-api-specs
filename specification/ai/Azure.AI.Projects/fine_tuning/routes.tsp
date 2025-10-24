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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get info about a fine-tuning job.")
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the fine-tuning job.")
      @path
      @maxLength(1024)
      fine_tuning_job_id: string;
    },
    FineTuningJob
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Returns a list of finetune jobs")
  @get
  @list
  list is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates a fine-tuning job.")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      @doc("fine-tuning job")
      @body
      fineTuningJob: JobCreateParams;
    },
    FineTuningJob
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Cancel a fine-tune job.")
  @post
  @route("/{fine_tuning_job_id}/cancel")
  cancel is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the fine-tuning job to cancel.")
      @path
      @maxLength(1024)
      fine_tuning_job_id: string;
    },
    FineTuningJob
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Pause a fine-tune job.")
  @post
  @route("/{fine_tuning_job_id}/pause")
  pause is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the fine-tuning job to pause.")
      @path
      @maxLength(1024)
      fine_tuning_job_id: string;
    },
    FineTuningJob
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Resume a fine-tune job.")
  @post
  @route("/{fine_tuning_job_id}/resume")
  resume is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the fine-tuning job to resume.")
      @path
      @maxLength(1024)
      fine_tuning_job_id: string;
    },
    FineTuningJob
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Delete a fine-tune job.")
  @delete
  @route("/{fine_tuning_job_id}")
  delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the fine-tuning job to delete.")
      @path
      @maxLength(1024)
      fine_tuning_job_id: string;
    },
    Http.NoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get status updates for a fine-tuning job.")
  @get
  @list
  @route("/{fine_tuning_job_id}/events")
  listEvents is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the fine-tuning job to get events for.")
      @path
      @maxLength(1024)
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List checkpoints for a fine-tuning job.")
  @get
  @list
  @route("/{fine_tuning_job_id}/checkpoints")
  listCheckpoints is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the fine-tuning job to get events for.")
      @path
      @maxLength(1024)
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
