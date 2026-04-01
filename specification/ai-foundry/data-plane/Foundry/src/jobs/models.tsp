import "../common/models.tsp";
using Azure.Core.Foundations;
namespace Azure.AI.Projects;

@doc("Foundry job result")
@discriminator("type")
model FoundryJob {
  @doc("The unique identifier of the job.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The display name of the job.")
  name: string;

  @doc("The type of the job.")
  type: FoundryJobType;

  @doc("The status of the job.")
  @visibility(Lifecycle.Read)
  status: OperationState;

  @doc("The user who created the job.")
  @visibility(Lifecycle.Read)
  created_by: string;

  @doc("The user who last updated the job.")
  @visibility(Lifecycle.Read)
  last_updated_by: string;

  @doc("The timestamp when the job is created.")
  @visibility(Lifecycle.Read)
  created_time: utcDateTime;

  @doc("The timestamp when the job is completed.")
  @visibility(Lifecycle.Read)
  completed_time?: utcDateTime;

  @doc("Error information set only when status is 'failed'.")
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

@doc("The types of Foundry jobs.")
union FoundryJobType {
  string,

  @doc("Data generation job type for generating data which can be used for fine-tuning or evaluation.")
  DataGeneration: "DataGeneration",
}
