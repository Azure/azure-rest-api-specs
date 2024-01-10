import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./EventHubsNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.EventHub;
@doc("Description of topic resource.")
@singleton("default")
@parentResource(EventHubsNamespace)
model EventHubsNetworkRuleSet is ProxyResource<NetworkRuleSetProperties> {
  @key("networkRuleSet")
  @segment("networkRuleSets")
  name: string;
}

@armResourceOperations
@projectedName("client", "Namespaces")
interface EventHubsNetworkRuleSets_Namespaces {
  @doc("Gets NetworkRuleSet for a Namespace.")
  getNetworkRuleSet is ArmResourceRead<EventHubsNetworkRuleSet>;

  @doc("Create or update NetworkRuleSet for a Namespace.")
  createOrUpdateNetworkRuleSet is ArmResourceCreateOrReplaceSync<EventHubsNetworkRuleSet>;

  @doc("Gets NetworkRuleSet for a Namespace.")
  listNetworkRuleSet is ArmResourceListByParent<EventHubsNetworkRuleSet>;
}
