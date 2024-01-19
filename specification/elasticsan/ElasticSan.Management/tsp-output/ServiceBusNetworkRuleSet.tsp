import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
interface ServiceBusNetworkRuleSets {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets NetworkRuleSet for a Namespace.")
  @operationId("Namespaces_GetNetworkRuleSet")
  getNetworkRuleSet is ArmResourceRead<ServiceBusNetworkRuleSet>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update NetworkRuleSet for a Namespace.")
  @operationId("Namespaces_CreateOrUpdateNetworkRuleSet")
  createOrUpdateNetworkRuleSet is ArmResourceCreateOrReplaceSync<ServiceBusNetworkRuleSet>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets list of NetworkRuleSet for a Namespace.")
  @operationId("Namespaces_ListNetworkRuleSets")
  listNetworkRuleSets is ArmResourceListByParent<ServiceBusNetworkRuleSet>;
}

@@projectedName(ServiceBusNetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServiceBusNetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceBusNetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "The Namespace IpFilterRule."
);
