import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Symphony;

@doc("The properties of the service.")
model InstanceProperties {
  @doc("Provisioning state of the service.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The service entity.")
model Instance is TrackedResource<InstanceProperties> {
  @doc("The name of Azure API Center service.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]{3,90}$")
  @path
  @key("instanceName")
  @segment("instances")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Instances {
  @doc("Returns details of the service.")
  get is ArmResourceRead<Instance>;
  @doc("Creates new or updates existing API.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Instance>;
  @doc("Updates existing service.")
  update is ArmCustomPatchSync<Instance>;
  @doc("Deletes specified service.")
  delete is ArmResourceDeleteSync<Instance>;
  @doc("Returns a collection of services within the resource group.")
  listByResourceGroup is Azure.ResourceManager.ArmResourceListByParent<Instance>;
  @doc("Lists services within an Azure subscription.")
  listBySubscription is ArmListBySubscription<Instance>;
}