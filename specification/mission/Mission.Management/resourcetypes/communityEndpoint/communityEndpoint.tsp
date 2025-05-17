import "@typespec/rest";
import "@typespec/versioning";
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

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Community Endpoint Protocol Enum")
union CommunityEndpointProtocolEnum {
  @doc("CommunityEndpointProtocolEnum Type ANY")
  ANY: "ANY",

  @doc("CommunityEndpointProtocolEnum Type TCP")
  TCP: "TCP",

  @doc("CommunityEndpointProtocolEnum Type UDP")
  UDP: "UDP",

  @doc("CommunityEndpointProtocolEnum Type ICMP")
  ICMP: "ICMP",

  @doc("CommunityEndpointProtocolEnum Type ESP")
  ESP: "ESP",

  @doc("CommunityEndpointProtocolEnum Type AH")
  AH: "AH",

  @doc("CommunityEndpointProtocolEnum Type HTTPS")
  HTTPS: "HTTPS",

  @doc("CommunityEndpointProtocolEnum Type HTTP")
  HTTP: "HTTP",

  string,
}

@doc("Destination Type Enum")
union DestinationType {
  @doc("DestinationType Type FQDN")
  FQDN: "FQDN",

  @doc("DestinationType Type FQDNTag")
  FQDNTag: "FQDNTag",

  @doc("DestinationType Type IPAddress")
  IPAddress: "IPAddress",

  @doc("DestinationType Type PrivateNetwork")
  PrivateNetwork: "PrivateNetwork",

  string,
}

@doc("Base type for destination rules.")
model CommunityEndpointDestinationRule is EndpointRuleBase {
  @doc("Destination Type.")
  destinationType?: DestinationType;

  @doc("Protocols. Options specified by Endpoint Protocol Enum.")
  protocols?: CommunityEndpointProtocolEnum[];

  @doc("Transit Hub Resource Id.")
  transitHubResourceId?: TransitHubResourceId;
}

@doc("Community Endpoint Resource properties")
model CommunityEndpointProperties {
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "Adding required property is a breaking change."
  @extension("x-ms-identifiers", #[])
  @doc("Community Endpoint Rule Collection.")
  ruleCollection: CommunityEndpointDestinationRule[];

  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @doc("List of resource ids created by community endpoint.")
  @visibility(Lifecycle.Read)
  resourceCollection?: string[];

  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningStateEnum;

  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @removed(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Whether approval is needed for the connection (True or False).")
  approvalRequired?: boolean;
}

@doc("Community Endpoint Patch properties")
model CommunityEndpointPatchProperties is CommunityEndpointProperties;

@doc("Community Endpoint Patch Resource")
model CommunityEndpointPatchModel {
  @doc("Community Endpoint Patch properties")
  properties?: Update<CommunityEndpointPatchProperties>;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
