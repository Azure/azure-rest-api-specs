import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCIS;

@doc("environment properties")
model EnvironmentResourceProperties {
  @doc("Source environment/Cluster model")
  modelEnvironment?: string;

  @doc("Environment name")
  environmentName?: string;

  @doc("Cluster name")
  clusterName?: string;

  @doc("Basic or All Mode indicate clone customer config file or just basic file")
  @visibility("read")
  mode?: environmentMode;

  @doc("Indicate APGold or PFGold.")
  enlistmentType?: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: environmentProvisioningState;
}

@doc("Environment Resource")
model EnvironmentResource
  is ProxyResource<EnvironmentResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("resourceName")
  @segment("autopilotEnvironments") // start with lower case
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface Environment {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EnvironmentResource>;
  listBySubscription is ArmListBySubscription<EnvironmentResource>;
  listByResourceGroup is ArmResourceListByParent<EnvironmentResource>;
  get is ArmResourceRead<EnvironmentResource>;
}

@doc("Provisioning status of the resource.")
enum environmentProvisioningState {
  ...ResourceProvisioningState,

  @doc("Accepted State")
  Accepted,
}

@doc("Basic or All Mode indicate clone customer config file or just basic file")
enum environmentMode {
  @doc("Clone basic file")
  Basic,

  @doc("Clone customer config file")
  All,
}
