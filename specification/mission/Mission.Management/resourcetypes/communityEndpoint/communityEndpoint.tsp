import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Community Endpoint Protocol Enum")
union CommunityEndpointProtocol {
  string,

  @doc("CommunityEndpointProtocol Type ANY")
  ANY: "ANY",

  @doc("CommunityEndpointProtocol Type TCP")
  TCP: "TCP",

  @doc("CommunityEndpointProtocol Type UDP")
  UDP: "UDP",

  @doc("CommunityEndpointProtocol Type ICMP")
  ICMP: "ICMP",

  @doc("CommunityEndpointProtocol Type ESP")
  ESP: "ESP",

  @doc("CommunityEndpointProtocol Type AH")
  AH: "AH",

  @doc("CommunityEndpointProtocol Type HTTPS")
  HTTPS: "HTTPS",

  @doc("CommunityEndpointProtocol Type HTTP")
  HTTP: "HTTP",
}

@doc("Destination Type Enum")
union DestinationType {
  string,

  @doc("DestinationType Type FQDN")
  FQDN: "FQDN",

  @doc("DestinationType Type FQDNTag")
  FQDNTag: "FQDNTag",

  @doc("DestinationType Type IPAddress")
  IPAddress: "IPAddress",

  @doc("DestinationType Type PrivateNetwork")
  PrivateNetwork: "PrivateNetwork",
}

@doc("Base type for destination rules.")
model CommunityEndpointDestinationRule {
  @doc("Destination Type.")
  destinationType?: DestinationType;

  @doc("Protocols. Options specified by Endpoint Protocol Enum.")
  protocols?: CommunityEndpointProtocol[];

  @doc("Transit Hub Resource Id.")
  transitHubResourceId?: TransitHubResourceId;

  ...EndpointRuleBase;
}

@doc("Community Endpoint Resource properties")
model CommunityEndpointProperties {
  @extension("x-ms-identifiers", #[])
  @doc("Community Endpoint Rule Collection.")
  ruleCollection: CommunityEndpointDestinationRule[];

  @doc("List of resource ids created by community endpoint.")
  @visibility(Lifecycle.Read)
  @typeChangedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, string[])
  resourceCollection?: armResourceIdentifier[];

  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @removed(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Whether approval is needed for the connection (True or False).")
  approvalRequired?: boolean;
}

@doc("Community Endpoint patchable Properties")
model CommunityEndpointPatchProperties
  is UpdateableProperties<OmitDefaults<CommunityEndpointProperties>>;

@doc("Community Endpoint Patch Resource")
model CommunityEndpointPatchModel {
  @doc("Community Endpoint Patch properties")
  properties?: CommunityEndpointPatchProperties;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
