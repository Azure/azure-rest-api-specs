import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./Configuration.tsp";
import "./Commons.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@armResourceOperations
interface NetworkConfigurations {
  get is ArmResourceRead<NetworkConfiguration>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<NetworkConfiguration>;
  update is ArmResourcePatchSync<
    NetworkConfiguration,
    NetworkConfigurationProperties
  >;
  delete is ArmResourceDeleteSync<NetworkConfiguration>;
  listByConfiguration is ArmResourceListByParent<NetworkConfiguration>;
}

@doc("NetworkConfiguration Resource")
@parentResource(Configuration)
model NetworkConfiguration is ProxyResource<LanNetworkConfigurationProperties> {
  ...ResourceNameParameter<
    NetworkConfiguration,
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Exposing various kinds of NetworkConfigurations via NetworkConfigurationKind"
  @doc("Specifies NetworkConfiguration kind")
  kind: NetworkConfigurationKind;
}

@doc("NetworkConfiguration Properties")
model NetworkConfigurationProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Scenario in which this configuration is used")
  scenario: Scenario;
}

@doc("NetworkConfigurationProperties for LAN")
model LanNetworkConfigurationProperties {
  ...NetworkConfigurationProperties;

  @doc("IP Assignment")
  ipAssignments: IpAssignment;
}

@doc("IP Assignment")
model IpAssignment {
  @doc("IpAssignment Type")
  ipAssignmentType: IpAssignmentType;

  @doc("IP V4")
  ipv4?: Ipv4;
}

@doc("Ip V4")
model Ipv4 {
  @doc("AddressRange for IPv4")
  addressRange?: Ipv4AddressRange;

  @doc("Subnet mask for IPv4")
  subnetMask?: ipV4Address;

  @doc("Default gateway for IPv4")
  defaultGateway?: ipV4Address;

  @doc("DNS Servers IPs for IPv4")
  dnsServers?: ipV4Address[];

  @doc("vLanId for the network interface")
  vLanId?: int32;
}

@doc("AddressRange for IP V4")
model Ipv4AddressRange {
  @doc("startIp of Address range")
  startIp: ipV4Address;

  @doc("endIp of Address range")
  endIp: ipV4Address;
}

@doc("IpAssignment Types")
union IpAssignmentType {
  @doc("Automatic IpAssignment") Automatic: "Automatic",
  @doc("Manual IpAssignment") Manual: "Manual",
  string,
}

@doc("kind for type of supported NetworkConfigurations")
union NetworkConfigurationKind {
  @doc("LAN type of NetworkConfigurations") LAN: "LAN",
  string,
}
