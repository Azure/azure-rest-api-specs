import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SBNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;
/**
 * Description of NetworkRuleSet resource.
 */
@singleton("default")
@parentResource(SBNamespace)
model NetworkRuleSet
  is Azure.ResourceManager.ProxyResource<NetworkRuleSetProperties> {
  ...ResourceNameParameter<
    Resource = NetworkRuleSet,
    KeyName = "networkRuleSet",
    SegmentName = "networkRuleSets",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "For backward compatibility"
@armResourceOperations
interface NetworkRuleSets {
  /**
   * Gets NetworkRuleSet for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_GetNetworkRuleSet")
  getNetworkRuleSet is ArmResourceRead<NetworkRuleSet>;

  /**
   * Create or update NetworkRuleSet for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Namespaces_CreateOrUpdateNetworkRuleSet")
  createOrUpdateNetworkRuleSet is ArmResourceCreateOrReplaceSync<
    NetworkRuleSet,
    Response = ArmResourceUpdatedResponse<NetworkRuleSet>
  >;

  /**
   * Gets list of NetworkRuleSet for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_ListNetworkRuleSets")
  listNetworkRuleSets is ArmResourceListByParent<NetworkRuleSet>;
}

@@doc(NetworkRuleSet.name, "");
@@doc(NetworkRuleSet.properties, "NetworkRuleSet properties");
@@doc(NetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "The Namespace IpFilterRule."
);
