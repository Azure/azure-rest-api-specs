import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Relay;
@doc("Description of topic resource.")
@singleton("default")
@parentResource(RelayNamespace)
model NetworkRuleSet is ProxyResource<NetworkRuleSetProperties> {
  @key("networkRuleSet")
  @segment("networkRuleSets")
  name: string;
}

@armResourceOperations
interface NetworkRuleSets {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets NetworkRuleSet for a Namespace.")
  @operationId("Namespaces_GetNetworkRuleSet")
  getNetworkRuleSet is ArmResourceRead<NetworkRuleSet>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update NetworkRuleSet for a Namespace.")
  @operationId("Namespaces_CreateOrUpdateNetworkRuleSet")
  createOrUpdateNetworkRuleSet is ArmResourceCreateOrReplaceSync<NetworkRuleSet>;
}

@@projectedName(NetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "json",
  "parameters"
);
@@extension(NetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "The Namespace IpFilterRule."
);
