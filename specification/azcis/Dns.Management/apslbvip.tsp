import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("ApSlbVip properties")
@added(Versions.v2024_06_24_preview)
model ApSlbVipResourceProperties {
  @doc("Gets or sets the Ap Dns name. This is case-insensitive")
  apDnsName: string;

  @doc("Arm location")
  armLocation?: string; 

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ApSlbVipProvisioningState;
}

@doc("ApSlbVip Resource")
@added(Versions.v2024_06_24_preview)
model ApSlbVipResource is ProxyResource<ApSlbVipResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("apSlbVips") // start with lower case
  @visibility("read")
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
