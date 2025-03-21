import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("Autopilot software load balance VIP properties")
@added(Versions.v2024_06_24_preview)
model ApSlbVipResourceProperties {
  @doc("Gets or sets the auto pilot DNS name. This is case-insensitive")
  autoPilotDnsName: string;

  @doc("The Azure location")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ApSlbVipProvisioningState;

  @doc("IP address of an Ap Dns; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  assignedVip?: string;
}

@doc("Autopilot software load balance VIP Resource")
@added(Versions.v2024_06_24_preview)
model ApSlbVipResource is ProxyResource<ApSlbVipResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("autoPilotSoftwareLoadBalanceVirtualIps") // start with lower case
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@doc("Provisioning status of the resource.")
@added(Versions.v2024_06_24_preview)
union ApSlbVipProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
@added(Versions.v2024_06_24_preview)
interface ApSlbVip {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ApSlbVipResource>;
  listBySubscription is ArmListBySubscription<ApSlbVipResource>;
  listByResourceGroup is ArmResourceListByParent<ApSlbVipResource>;
  get is ArmResourceRead<ApSlbVipResource>;
}
