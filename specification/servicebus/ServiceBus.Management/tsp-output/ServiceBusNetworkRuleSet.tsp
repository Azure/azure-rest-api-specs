import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ServiceBus;
@doc("Description of NetworkRuleSet resource.")
@parentResource(ServiceBusNamespace)
@singleton("default")
model ServiceBusNetworkRuleSet is ProxyResource<NetworkRuleSetProperties> {
  @key("default")
  @segment("networkRuleSets")
  name: string;
}

@armResourceOperations
interface ServiceBusNetworkRuleSets {
  @doc("Gets NetworkRuleSet for a Namespace.")
  getNetworkRuleSet is ArmResourceRead<ServiceBusNetworkRuleSet>;
  @doc("Create or update NetworkRuleSet for a Namespace.")
  createOrUpdateNetworkRuleSet is ArmResourceCreateOrReplaceSync<ServiceBusNetworkRuleSet>;
  @doc("Gets list of NetworkRuleSet for a Namespace.")
  listByServiceBusNamespace is ArmResourceListByParent<ServiceBusNetworkRuleSet>;
}
