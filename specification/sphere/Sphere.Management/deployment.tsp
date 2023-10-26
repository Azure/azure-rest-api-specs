import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.AzureSphere;

// Deployment
@doc("An deployment resource belonging to a device group resource.")
@parentResource(DeviceGroup)
model Deployment is ProxyResource<DeploymentProperties> {
  @doc("Deployment name. Use .default for deployment creation and to get the current deployment for the associated device group.")
  @key("deploymentName")
  @path
  @segment("deployments")
  name: string;
}

interface ProxyResourceOperationsDeployments<
  TResource extends ArmResource,
  TListParameters extends {} = {}
> {
  @doc("Get a Deployment. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.")
  get is ArmResourceRead<Deployment>;
  @doc("List Deployment resources by DeviceGroup. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.")
  list is ArmResourceListByParent<
    TResource,
    ListQueryParameters & BaseParameters<TResource>
  >;
  @doc("Create a Deployment. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Deployment>;
  @doc("Delete a Deployment. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.")
  delete is ArmResourceDeleteAsync<Deployment>;
}

@armResourceOperations
interface Deployments extends ProxyResourceOperationsDeployments<Deployment> {}

@doc("The properties of deployment")
model DeploymentProperties {
  @visibility("create", "read")
  @doc("Deployment ID")
  deploymentId?: string;

  @doc("Images deployed")
  @visibility("create", "read")
  deployedImages?: Image[];

  @doc("Deployment date UTC")
  @visibility("read")
  deploymentDateUtc?: utcDateTime;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}
