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

#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
@removed(Microsoft.Mission.Versions.v2023_11_01_preview)
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

@doc("Base type for destination rules.")
model CommunityEndpointDestinationRule is EndpointRuleBase {
  @doc("Destination Type.")
  destinationType?: DestinationType;

  @doc("Protocols. Options specified by Endpoint Protocol Enum.")
  protocols?: CommunityEndpointProtocol[];

  @doc("Transit Hub Resource Id.")
  transitHubResourceId?: TransitHubResourceId;
}

@doc("Community Endpoint Resource properties")
model CommunityEndpointProperties {
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "Adding required property is a breaking change."
  @added(Microsoft.Mission.Versions.v2023_11_01_preview)
  @extension("x-ms-identifiers", [])
  @doc("Community Endpoint Rule Collection.")
  ruleCollection: CommunityEndpointDestinationRule[];

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @removed(Microsoft.Mission.Versions.v2023_11_01_preview)
  @extension("x-ms-identifiers", ["name"])
  @doc("Destination Rule Collection.")
  destinationRuleCollection: DestinationRule[];

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
