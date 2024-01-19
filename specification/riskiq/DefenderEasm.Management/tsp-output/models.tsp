import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Easm;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Resources provisioning states.")
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

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Workspace patch properties.")
model WorkspacePatchResource {
  @doc("resource tags.")
  tags?: Record<string>;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
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
