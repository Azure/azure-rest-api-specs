import "@typespec/openapi";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Edge Virtual Network Properties")
model EdgeVirtualNetworkPropertiesFormat {
  @doc("The provisioning state of the Edge Virtual Network resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("A list of edge subnets in a Virtual Network.")
  @minItems(1)
  @extension("x-ms-identifiers", ["name"])
  subnets?: EdgeSubnet[];

  @doc("Default interface to which traffic is routed from this Virtual Network")
  defaultRouteInterface?: EdgeNetworkInterface;
}

@doc("Edge Subnet Properties")
model EdgeSubnet {
  @doc("The name of the subnet.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  name: string;

  @doc("List of address prefixes for the subnet.")
  @minItems(1)
  @extension("x-ms-identifiers", [])
  addressPrefixes: EdgeSubnetPrefix[];

  @doc("The reference to the NetworkSecurityGroup resource.")
  networkSecurityGroup?: EdgeNetworkSecurityGroupResourceId;
}

@doc("Edge Subnet IP Prefix")
model EdgeSubnetPrefix {
  @doc("IPv4 address prefix.")
  ipv4Prefix?: Ipv4AddrMask;
}
