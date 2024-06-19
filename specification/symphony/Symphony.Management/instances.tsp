import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ToolchainOrchestrator;

@doc("The properties of an Instance resource.")
model InstanceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("An Instance resource.")
model Instance is TrackedResource<InstanceProperties> {
  @doc("Name of Instance.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-z0-9]+(\\.[a-z0-9]+)*$")
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
  @doc("Returns details of specified Instance resource.")
  get is ArmResourceRead<Instance>;
  @doc("Creates new or updates existing Instance resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Instance>;
  @doc("Updates existing Instance resource.")
  update is ArmCustomPatchSync<Instance>;
  @doc("Deletes specified Instance resource.")
  delete is ArmResourceDeleteSync<Instance>;
  @doc("Returns a collection of Instances resources within the resource group.")
  listByResourceGroup is Azure.ResourceManager.ArmResourceListByParent<Instance>;
  @doc("Lists Instances resources within an Azure subscription.")
  listBySubscription is ArmListBySubscription<Instance>;
}
