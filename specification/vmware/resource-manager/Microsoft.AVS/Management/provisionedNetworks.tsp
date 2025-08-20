namespace Microsoft.AVS;

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface ProvisionedNetworks {
  @added(Versions.v2024_09_01)
  list is ArmResourceListByParent<ProvisionedNetwork>;

  @added(Versions.v2024_09_01)
  get is ArmResourceRead<ProvisionedNetwork>;
}

@doc("A provisioned network resource")
@parentResource(PrivateCloud)
model ProvisionedNetwork is ProxyResource<ProvisionedNetworkProperties> {
  @doc("Name of the cloud link.")
  @pattern("^[-\\w\\._]+$")
  @key("provisionedNetworkName")
  @path
  @segment("provisionedNetworks")
  name: string;
}

@doc("provisioned network provisioning state")
union ProvisionedNetworkProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("The properties of a provisioned network.")
model ProvisionedNetworkProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisionedNetworkProvisioningState;

  @doc("The address prefixes of the provisioned network in CIDR notation.")
  @visibility(Lifecycle.Read)
  addressPrefix?: string;

  @doc("The type of network provisioned.")
  @visibility(Lifecycle.Read)
  networkType?: ProvisionedNetworkTypes;
}

@doc("The type of network provisioned.")
union ProvisionedNetworkTypes {
  string,

  @doc("network for ESX management")
  esxManagement: "esxManagement",

  @doc("network for ESX replication")
  esxReplication: "esxReplication",

  @doc("network for HCX management")
  hcxManagement: "hcxManagement",

  @doc("network for HCX uplink")
  hcxUplink: "hcxUplink",

  @doc("network for vCenter management")
  vcenterManagement: "vcenterManagement",

  @doc("network for vmotion")
  vmotion: "vmotion",

  @doc("network for vsan")
  vsan: "vsan",
}
