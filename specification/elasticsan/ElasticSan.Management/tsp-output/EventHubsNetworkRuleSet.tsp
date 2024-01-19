import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EventHubsNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
interface EventHubsNetworkRuleSets {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets NetworkRuleSet for a Namespace.")
  @operationId("Namespaces_GetNetworkRuleSet")
  getNetworkRuleSet is ArmResourceRead<EventHubsNetworkRuleSet>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update NetworkRuleSet for a Namespace.")
  @operationId("Namespaces_CreateOrUpdateNetworkRuleSet")
  createOrUpdateNetworkRuleSet is ArmResourceCreateOrReplaceSync<EventHubsNetworkRuleSet>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets NetworkRuleSet for a Namespace.")
  @operationId("Namespaces_ListNetworkRuleSet")
  listNetworkRuleSet is ArmResourceListByParent<EventHubsNetworkRuleSet>;
}

@@projectedName(EventHubsNetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "json",
  "parameters"
);
@@extension(EventHubsNetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(EventHubsNetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "The Namespace IpFilterRule."
);
