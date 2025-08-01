import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias FineTuningServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias FineTuningOperations = Azure.Core.ResourceOperations<FineTuningServiceTraits>;

@route("fine_tuning")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
interface FineTuningJobs {
  @doc("Get info about a fine-tuning job.")
  get is FineTuningOperations.ResourceRead<FineTuningJob>;

  @doc("Creates a fine-tuning job.")
  @post
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  create is Azure.Core.Foundations.Operation<
    {
      @doc("fine-tuning job")
      @body
      fineTuningJob: FineTuningJobCreation;
    },
    ResourceCreatedResponse<FineTuningJob>
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
    ResourceCreatedResponse<FineTuningJob>
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
    ResourceCreatedResponse<FineTuningJob>
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
    ResourceCreatedResponse<FineTuningJob>
  >;
}
