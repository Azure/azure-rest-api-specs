import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Fine-Tuning Job")
@resource("jobs")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJob {
  @doc("The job identifier.")
  @key("id")
  @encodedName("application/json", "id")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The current status of the fine-tuning job, which can be either validating_files, queued, running, succeeded, failed, or cancelled.")
  status: string;

  @doc("The file ID used for training. You can retrieve the training data with the Files API.")
  training_file: string;

  @doc("The file ID used for validation. You can retrieve the validation results with the Files API.")
  validation_file: string;

  @doc("The Unix timestamp (in seconds) for when the fine-tuning job was created.")
  created_at: int32;

  @doc("The Unix timestamp (in seconds) for when the fine-tuning job is estimated to finish. The value will be null if the fine-tuning job is not running.")
  estimated_finish?: int32;

  @doc("The Unix timestamp (in seconds) for when the fine-tuning job was finished. The value will be null if the fine-tuning job is still running.")
  finished_at?: int32;

  @doc("The name of the fine-tuned model that is being created. The value will be null if the fine-tuning job is still running.")
  fine_tuned_model?: string;

  @doc("The base model that is being fine-tuned.")
  `model`: string;

  @doc("The seed used for the fine-tuning job.")
  seed: int32;

  @doc("The total number of billable tokens processed by this fine-tuning job. The value will be null if the fine-tuning job is still running.")
  trained_tokens?: int32;

  @doc("The object type, which is always 'fine_tuning.job'. Parity with OAI SDK")
  object: string;

  @doc("The organization that owns the fine-tuning job. Unused in AOAI API. It is maintained for parity with OAI SDK")
  organization_id?: string;
}
