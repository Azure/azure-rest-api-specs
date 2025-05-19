import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

@doc("The status of the current resource.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,

  @doc("Resource in progress")
  InProgress: "InProgress",

  @doc("Resource deletion in progress")
  Deleting: "Deleting",

  @doc("Resource deleted")
  Deleted: "Deleted",

  @doc("Resource completed.")
  Succeeded: "Succeeded",

  @doc("Resource failed.")
  Failed: "Failed",

  @doc("Resource canceling.")
  Canceling: "Canceling",

  @doc("Resource canceled.")
  Canceled: "Canceled",
}

@doc("The error object for the safe rollout.")
model Error {
  @doc("error code")
  code: string;

  @doc("error message")
  message: string;
}

@doc("Indicates internal status of the safe rollout or step resource.")
union Status {
  string,

  @doc("Resource is in running.")
  Running: "Running",

  @doc("Resource completed.")
  Succeeded: "Succeeded",

  @doc("Resource canceled.")
  Canceled: "Canceled",

  @doc("Resource canceling.")
  Canceling: "Canceling",

  @doc("Resource is paused.")
  Paused: "Paused",

  @doc("Resource is failed.")
  Failed: "Failed",

  @doc("Resource is initialized.")
  Initialized: "Initialized",
}
