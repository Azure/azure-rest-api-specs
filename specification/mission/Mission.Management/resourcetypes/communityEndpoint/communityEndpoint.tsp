import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../shared/resourceid.tsp";
import "../shared/endpointrulebase.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@doc("Community Endpoint Protocol Enum")
enum CommunityEndpointProtocol {
  @doc("CommunityEndpointProtocol Type ANY")
  ANY,

  @doc("CommunityEndpointProtocol Type TCP")
  TCP,

  @doc("CommunityEndpointProtocol Type UDP")
  UDP,

  @doc("CommunityEndpointProtocol Type ICMP")
  ICMP,

  @doc("CommunityEndpointProtocol Type ESP")
  ESP,

  @doc("CommunityEndpointProtocol Type AH")
  AH,

  @doc("CommunityEndpointProtocol Type HTTPS")
  HTTPS,

  @doc("CommunityEndpointProtocol Type HTTP")
  HTTP,
}

@doc("Destination Type Enum")
enum DestinationType {
  @doc("DestinationType Type FQDN")
  FQDN,

  @doc("DestinationType Type FQDNTag")
  FQDNTag,

  @doc("DestinationType Type IPAddress")
  IPAddress,

  @doc("DestinationType Type PrivateNetwork")
  PrivateNetwork,
}

@doc("Base type for destination rules.")
model CommunityEndpointDestinationRule extends EndpointRuleBase {
  @doc("Destination Type.")
  destinationType?: DestinationType;

  @doc("Protocol. Options specified by Endpoint Protocol Enum.")
  protocol?: CommunityEndpointProtocol[];

  @doc("Transit Hub Resource Id.")
  transitHubResourceId?: TransitHubResourceId;
}

@doc("Community Endpoint Resource properties")
model CommunityEndpointProperties {
  @extension("x-ms-identifiers", [])
  @doc("Community Endpoint Rule Collection.")
  ruleCollection: CommunityEndpointDestinationRule[];

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
