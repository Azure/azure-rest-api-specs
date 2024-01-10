import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ServiceBus;
@doc("Description of NetworkRuleSet resource.")
@singleton("default")
@parentResource(ServiceBusNamespace)
model ServiceBusNetworkRuleSet is ProxyResource<NetworkRuleSetProperties> {
  @key("networkRuleSet")
  @segment("networkRuleSets")
  name: string;
}

@armResourceOperations
@projectedName("client", "Namespaces")
interface ServiceBusNetworkRuleSets_Namespaces {
  @doc("Gets NetworkRuleSet for a Namespace.")
  getNetworkRuleSet is ArmResourceRead<ServiceBusNetworkRuleSet>;

  @doc("Create or update NetworkRuleSet for a Namespace.")
  createOrUpdateNetworkRuleSet is ArmResourceCreateOrReplaceSync<ServiceBusNetworkRuleSet>;

  @doc("Gets list of NetworkRuleSet for a Namespace.")
  listNetworkRuleSets is ArmResourceListByParent<ServiceBusNetworkRuleSet>;
}
