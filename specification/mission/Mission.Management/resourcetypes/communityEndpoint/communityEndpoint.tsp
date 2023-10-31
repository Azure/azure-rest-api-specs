import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../shared/resourceid.tsp";

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
model DestinationRule {
  @doc("Destination Rule Name.")
  name?: string;

  @doc("Destination Type.")
  destinationType?: DestinationType;

  @doc("Destination must follow the format for FQDNs if it is selected as the destination type (no IP/CIDR or full web URLs).")
  destination: string[];

  @doc("Port. Can include multiple ports separated by commas or a range indicated by a hyphen.")
  port?: string;

  @doc("Protocol. Options specified by Endpoint Protocol Enum.")
  protocol?: CommunityEndpointProtocol[];

  @doc("Transit Hub Resource Id.")
  transitHubResourceId?: TransitHubResourceId;
}

@doc("Community Endpoint Resource properties")
model CommunityEndpointProperties {
  @extension("x-ms-identifiers", ["name"])
  @doc("Destination Rule Collection.")
  destinationRuleCollection: DestinationRule[];

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
