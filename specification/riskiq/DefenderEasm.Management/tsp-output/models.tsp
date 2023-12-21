import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.DefenderEasm;

interface Operations extends Azure.ResourceManager.Operations {}

enum ResourceState {
  NotSpecified,
  Accepted,
  Creating,
  Succeeded,
  Failed,
  Canceled,
  ProvisioningResources,
  InstallingApplication,
  ConfiguringApplication,
  MigratingApplicationData,
  RunningValidations,
  CreatingArtifacts,
  DeletingArtifacts,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

@doc("Workspace properties.")
model WorkspaceResourceProperties extends ResourceBaseProperties {
  @doc("Data plane endpoint.")
  @visibility("read")
  dataPlaneEndpoint?: string;
}

@doc("Resource base properties.")
model ResourceBaseProperties {
  @doc("Resource provisioning state.")
  @visibility("read")
  provisioningState?: ResourceState;
}

@doc("Label properties.")
model LabelResourceProperties extends ResourceBaseProperties {
  @doc("Label display name.")
  displayName?: string;

  @doc("Label color.")
  color?: string;
}

@doc("Label patch properties")
model LabelPatchResource extends LabelResource {}

@doc("Task details")
model TaskResource extends ProxyResource {
  @doc("Task properties")
  properties?: TaskResourceProperties;
}

@doc("Task properties.")
model TaskResourceProperties extends ResourceBaseProperties {
  @doc("The time the task started")
  startedAt?: string;

  @doc("The time the task completed")
  completedAt?: string;

  @doc("The last time the task was polled")
  lastPolledAt?: string;

  @doc("the state the task is in")
  state?: string;

  @doc("the phase the task is in")
  phase?: string;

  @doc("The reason the task was moved into its current state, if the task wasn't completed.")
  reason?: string;

  @doc("The reason the task was moved into its current state, if the task wasn't completed.")
  metadata?: Record<unknown>;
}
