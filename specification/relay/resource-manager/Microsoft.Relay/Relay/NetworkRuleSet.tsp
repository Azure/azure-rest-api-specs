import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Relay;
/**
 * Description of topic resource.
 */
@singleton("default")
@parentResource(RelayNamespace)
model NetworkRuleSet
  is Azure.ResourceManager.ProxyResource<NetworkRuleSetProperties> {
  ...ResourceNameParameter<
    Resource = NetworkRuleSet,
    KeyName = "networkRuleSet",
    SegmentName = "networkRuleSets",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface NetworkRuleSets {
  /**
   * Gets NetworkRuleSet for a Namespace.
   */
  getNetworkRuleSet is ArmResourceRead<NetworkRuleSet>;

  /**
   * Create or update NetworkRuleSet for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdateNetworkRuleSet is ArmResourceCreateOrReplaceSync<
    NetworkRuleSet,
    Response = ArmResourceUpdatedResponse<NetworkRuleSet>
  >;
}

@@doc(NetworkRuleSet.name, "");
@@doc(NetworkRuleSet.properties, "NetworkRuleSet properties");
@@doc(NetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "The Namespace IpFilterRule."
);
