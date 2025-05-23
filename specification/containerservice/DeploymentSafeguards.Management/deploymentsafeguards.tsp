import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;
using Azure.Core.Traits;

@armProviderNamespace
namespace Microsoft.ContainerService;

@doc("Deployment Safeguards")
@resource("deploymentSafeguards")
@singleton("default")
model DeploymentSafeguard
  is Azure.ResourceManager.ExtensionResource<DeploymentSafeguardsProperties> {
  @key("deploymentSafeguardName")
  @doc("Required default name")
  @segment("deploymentSafeguards")
  @visibility(Lifecycle.Read)
  @pattern("default")
  @path
  name: string;

  ...EntityTagProperty;
}

@doc("Specifies the level of Deployment Safeguards")
union DeploymentSafeguardsLevel {
  @doc("Best practice violations will only show warnings")
  Warn: "Warn",

  @doc("Best practice violations will be denied")
  Enforce: "Enforce",

  string,
}

@doc("DeploymentSafeguards Properties")
model DeploymentSafeguardsProperties {
  @doc("Provisioning State")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The deployment safeguards level. Possible values are Warn and Enforce")
  level: DeploymentSafeguardsLevel;

  @doc("User defined list of namespaces to exclude from Deployment Safeguards. Deployments in these namespaces will not be checked against any safeguards")
  excludedNamespaces?: Array<string>;

  @doc("System defined list of namespaces excluded from Deployment Safeguards. These are determined by the underlying provider (such as AKS), and cannot be changed. Deployments in these namespaces will not be checked")
  @visibility(Lifecycle.Read)
  systemExcludedNamespaces: Array<string>;
}

@lroStatus
@doc("The provisioning state of the last accepted operation.")
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The provisioning state of DeploymentSafeguards being created.")
  Creating: "Creating",

  @doc("The provisioning state of DeploymentSafeguards being updated.")
  Updating: "Updating",

  @doc("The provisioning state of DeploymentSafeguards being deleted.")
  Deleting: "Deleting",
}

@armResourceOperations
interface DeploymentSafeguards {
  @doc("Fetch a deployment safeguard by name")
  get is ArmResourceRead<DeploymentSafeguard>;

  @doc("Creates or updates a deploymentSafeguard")
  create is ArmResourceCreateOrUpdateAsync<DeploymentSafeguard>;

  @doc("Delete DeploymentSafeguards")
  delete is ArmResourceDeleteWithoutOkAsync<DeploymentSafeguard>;

  @doc("List DeploymentSafeguards by parent resource")
  list is ArmResourceListByParent<DeploymentSafeguard>;
}
