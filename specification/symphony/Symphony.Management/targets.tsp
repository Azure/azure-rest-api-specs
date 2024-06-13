import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ToolchainOrchestrator;

@doc("The properties of a Target resource.")
model TargetProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("A Target resource.")
model Target is TrackedResource<TargetProperties> {
  @doc("Name of target.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-z0-9]+(\\.[a-z0-9]+)*$")
  @path
  @key("targetName")
  @segment("targets")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Targets {
  @doc("Returns details of specified Target resource.")
  get is Azure.ResourceManager.ArmResourceRead<Target>;
  @doc("Creates new or updates existing Target resource.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceSync<Target>;
  @doc("Updates existing Target resource.")
  update is ArmCustomPatchSync<Target>;
  @doc("Deletes specified Target resource.")
  delete is ArmResourceDeleteSync<Target>;
  @doc("Returns a collection of Target resources within the resource group.")
  listByResourceGroup is Azure.ResourceManager.ArmResourceListByParent<Target>;
  @doc("Lists Targets resources within an Azure subscription.")
  listBySubscription is ArmListBySubscription<Target>;
}
