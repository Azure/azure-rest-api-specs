import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ConnectedVMwarevSphere;
@doc("Defines the vCenter.")
model VCenter is TrackedResource<VCenterProperties> {
  @doc("Name of the vCenter.")
  @path
  @key("vcenterName")
  @segment("vcenters")
  name: string;

  @doc("Gets or sets the extended location.")
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface VCenters {
  @doc("Implements vCenter GET method.")
  get is ArmResourceRead<VCenter>;
  @doc("Create Or Update vCenter.")
  create is ArmResourceCreateOrUpdateAsync<VCenter>;
  @doc("API to update certain properties of the vCenter resource.")
  update is ArmTagsPatchSync<VCenter>;
  @doc("Implements vCenter DELETE method.")
  delete is ArmResourceDeleteAsync<
    VCenter,
    {
      ...BaseParameters<VCenter>;

      @doc("Whether force delete was specified.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("List of vCenters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VCenter>;
  @doc("List of vCenters in a subscription.")
  list is ArmListBySubscription<VCenter>;
}
