import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./EHNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.EventHub;
@doc("Description of topic resource.")
@parentResource(EHNamespace)
@singleton("default")
model NetworkRuleSet is ProxyResource<NetworkRuleSetProperties> {
  @key("default")
  @segment("networkRuleSets")
  name: string;
}

@armResourceOperations
interface NetworkRuleSets {
  @doc("Gets NetworkRuleSet for a Namespace.")
  getNetworkRuleSet is ArmResourceRead<NetworkRuleSet>;
  @doc("Create or update NetworkRuleSet for a Namespace.")
  createOrUpdateNetworkRuleSet is ArmResourceCreateOrReplaceSync<NetworkRuleSet>;
  @doc("Gets NetworkRuleSet for a Namespace.")
  listByEHNamespace is ArmResourceListByParent<NetworkRuleSet>;
}
