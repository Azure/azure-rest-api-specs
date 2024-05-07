import "@typespec/openapi";
import "@typespec/versioning";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

@removed(Versions.v2024_06_01)
@doc("Network protocol this rule applies to.")
union SecurityRuleProtocol {
  @doc("Transmission control protocol.")
  TCP: "TCP",

  @doc("User datagram protocol.")
  UDP: "UDP",

  @doc("Internet control message protocol.")
  ICMP: "ICMP",

  @doc("Encapsulating security payload.")
  ESP: "ESP",

  @doc("Wildcard character, representing any protocol.")
  Asterisk: "*",

  @doc("Authentication header.")
  AH: "AH",

  string,
}

@removed(Versions.v2024_06_01)
@doc("Whether network traffic is allowed or denied.")
union EdgeSecurityRuleAccess {
  @doc("Allow network traffic.")
  Allow: "Allow",

  @doc("Deny network traffic.")
  Deny: "Deny",

  string,
}

@removed(Versions.v2024_06_01)
@doc("The direction of the rule. The direction specifies if rule will be evaluated on incoming or outgoing traffic. Direction is based on device attached to the edge network, Inbound means towards the device attached, and outbound means away from the device attached.")
union EdgeSecurityRuleDirection {
  @doc("Traffic towards the device attached.")
  Inbound: "Inbound",

  @doc("Traffic away from the device attached.")
  Outbound: "Outbound",

  string,
}

@removed(Versions.v2024_06_01)
@doc("Edge Network Security Group properties.")
model EdgeNetworkSecurityGroupPropertiesFormat {
  @doc("The provisioning state of the Edge Network Security Group resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("An optional description for this Edge Network Security Group.")
  description?: string;

  @doc("A collection of security rules of the network security group.")
  @extension("x-ms-identifiers", ["ruleName"])
  securityRules?: EdgeSecurityRule[];

  @doc("The default security rules of network security group.")
  @visibility("read")
  @extension("x-ms-identifiers", ["ruleName"])
  defaultSecurityRules?: EdgeSecurityRule[];
}

@removed(Versions.v2024_06_01)
@doc("Security rule resource.")
model EdgeSecurityRule {
  @doc("The name of the rule.")
  ruleName: string;

  @doc("A description for this rule. Restricted to 140 chars.")
  description?: string;

  @doc("Network protocol this rule applies to.")
  protocol: SecurityRuleProtocol;

  @doc("The list of source address prefixes. Matches to the source IP address of the packet being processed. Can be an IPv4 address prefix, using CIDR notation (e.g. 10.1.1.0/24) or a single IPv4 address.")
  @minItems(1)
  sourceAddressPrefixes?: string[];

  @doc("The list of destination address prefixes. Matches to the destination IP address of the packet being processed. Can be an IPv4 address prefix, using CIDR notation (e.g. 10.1.1.0/24) or a single IPv4 address.")
  @minItems(1)
  destinationAddressPrefixes?: string[];

  @doc("The list of source port ranges. Matches to the source port in the packet being processed. Integer or range between 0 and 65535. When specifying a range, both the lower and upper bounds must be specified. Asterisk '*' can also be used to match all ports.")
  @minItems(1)
  sourcePortRanges?: string[];

  @doc("The list of destination port ranges. Matches to the destination port in the packet being processed. Integer or range between 0 and 65535. When specifying a range, both the lower and upper bounds must be specified. Asterisk '*' can also be used to match all ports.")
  @minItems(1)
  destinationPortRanges?: string[];

  @doc("The network traffic is allowed or denied.")
  access: EdgeSecurityRuleAccess;

  @doc("The priority of the rule. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.")
  @maxValue(65500)
  @minValue(100)
  priority: int32;

  @doc("The direction of the rule. The direction specifies if rule will be evaluated on incoming or outgoing traffic.")
  direction: EdgeSecurityRuleDirection;
}
