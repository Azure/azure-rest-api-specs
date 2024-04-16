import "@typespec/openapi";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Network protocol this rule applies to.")
enum SecurityRuleProtocol {
  @doc("Transmission control protocol.")
  TCP,

  @doc("User datagram protocol.")
  UDP,

  @doc("Internet control message protocol.")
  ICMP,

  @doc("Encapsulating security payload.")
  ESP,

  @doc("Wildcard character, representing any protocol.")
  Asterisk: "*",

  @doc("Authentication header.")
  AH,
}

@doc("Whether network traffic is allowed or denied.")
enum EdgeSecurityRuleAccess {
  @doc("Allow network traffic.")
  Allow,

  @doc("Deny network traffic.")
  Deny,
}

@doc("The direction of the rule. The direction specifies if rule will be evaluated on incoming or outgoing traffic. Direction is based on device attached to the edge network, Inbound means towards the device attached, and outbound means away from the device attached.")
enum EdgeSecurityRuleDirection {
  @doc("Traffic towards the device attached.")
  Inbound,

  @doc("Traffic away from the device attached.")
  Outbound,
}

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
