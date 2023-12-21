import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Relay;
@doc("Description of topic resource.")
@singleton("default")
@parentResource(RelayNamespace)
model NetworkRuleSet is ProxyResource<NetworkRuleSetProperties> {
  @key("default")
  @segment("networkRuleSets")
  name: string;
}

@armResourceOperations
interface Namespaces {
  @doc("Gets NetworkRuleSet for a Namespace.")
  getNetworkRuleSet is ArmResourceRead<NetworkRuleSet>;
  @doc("Create or update NetworkRuleSet for a Namespace.")
  createOrUpdateNetworkRuleSet is ArmResourceCreateOrReplaceSync<NetworkRuleSet>;
}
