import "../Common/StandardizedContracts/AssessedWorkloadProperties.tsp";
import "../Common/StandardizedContracts/CostComponent.tsp";
import "../Common/CommonModels.tsp";
import "./AssessedNetworkSecurityGroup.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Assessed network security group rule web model class.")
@parentResource(AssessedNetworkSecurityGroup)
model AssessedNsgRule is ProxyResource<AssessedNsgRuleProperties> {
  @doc("Network assessment assessed network security group rule ARM name.")
  @key("assessedNsgRuleName")
  @segment("assessedNsgRules")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AssessedNsgRule doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Assessed network security group rule properties web model.")
model AssessedNsgRuleProperties
  is AssessedWorkloadProperties<Linkages, NetworkEntityRecommendations> {
  @doc("The resource name.")
  @visibility(Lifecycle.Read)
  resourceName?: string;

  @doc("The network security group rule extended details.")
  @visibility(Lifecycle.Read)
  extendedDetails?: NsgRuleExtendedDetails;

  @doc("When was assessed network security group rule first created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("When was assessed network security group rule last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

@doc("Network security group rule extended details.")
model NsgRuleExtendedDetails {
  @doc("A description for this rule.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("Network protocol this rule applies to.")
  @visibility(Lifecycle.Read)
  protocol?: NsgSecurityRuleProtocol;

  @doc("The source port ranges. Asterisk '*' can be used to match all ports.")
  @visibility(Lifecycle.Read)
  sourcePortRanges?: string[];

  @doc("The destination port ranges. Asterisk '*' can be used to match all ports.")
  @visibility(Lifecycle.Read)
  destinationPortRanges?: string[];

  @doc("The source address prefixes. CIDR, IP ranges, or default tags such as 'VirtualNetwork', 'AzureLoadBalancer', 'Internet'. Asterisk '*' matches all.")
  @visibility(Lifecycle.Read)
  sourceAddressPrefixes?: string[];

  @doc("The destination address prefixes. CIDR, IP ranges, or default tags such as 'VirtualNetwork', 'AzureLoadBalancer', 'Internet'. Asterisk '*' matches all.")
  @visibility(Lifecycle.Read)
  destinationAddressPrefixes?: string[];

  @doc("Whether network traffic is allowed or denied.")
  @visibility(Lifecycle.Read)
  action?: NsgSecurityRuleAccess;

  @doc("The priority of the rule. The value can be between 100 and 4096. The lower the priority number, the higher the priority of the rule.")
  @visibility(Lifecycle.Read)
  priority?: int32;

  @doc("The direction of the rule. Specifies if rule will be evaluated on incoming or outgoing traffic.")
  @visibility(Lifecycle.Read)
  direction?: NsgSecurityRuleDirection;

  @doc("Whether this is a default security rule or a custom security rule.")
  @visibility(Lifecycle.Read)
  isDefaultRule?: boolean;
}
