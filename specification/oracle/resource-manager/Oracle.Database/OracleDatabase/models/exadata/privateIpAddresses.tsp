import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;

namespace Oracle.Database;

@doc("Private Ip Addresses filter")
model PrivateIpAddressesFilter {
  @doc("Subnet OCID")
  subnetId: Ocid;

  @doc("VCN OCID")
  vnicId: Ocid;
}

@doc("PrivateIpAddress resource properties")
model PrivateIpAddressProperties {
  @doc("PrivateIpAddresses displayName")
  displayName: string;

  @doc("PrivateIpAddresses hostnameLabel")
  hostnameLabel: string;

  @doc("PrivateIpAddresses Id")
  ocid: Ocid;

  @doc("PrivateIpAddresses ipAddress")
  ipAddress: string;

  @doc("PrivateIpAddresses subnetId")
  subnetId: Ocid;
}
