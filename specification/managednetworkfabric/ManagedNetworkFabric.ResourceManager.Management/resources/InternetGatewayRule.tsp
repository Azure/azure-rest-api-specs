import "../models/common.tsp";
import "../models/InternetGatewayRule.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Internet Gateway Rule resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@includeInapplicableMetadataInPayload(false)
model InternetGatewayRule
  extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Name of the Internet Gateway rule.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("internetGatewayRuleName")
  @segment("internetGatewayRules")
  @visibility("read")
  name: string;

  /** The Internet Gateway Rule properties */
  properties: InternetGatewayRuleProperties;
}

@armResourceOperations
interface InternetGatewayRules {
  /**
   * Gets an Internet Gateway Rule resource.
   */
  get is ArmResourceRead<InternetGatewayRule>;

  /**
   * Creates an Internet Gateway rule resource.
   */
  create is ArmResourceCreateOrReplaceAsync<InternetGatewayRule>;

  /**
   * API to update certain properties of the Internet Gateway Rule resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<InternetGatewayRule, InternetGatewayRulePatch>;

  /**
   * Implements Internet Gateway Rules DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<InternetGatewayRule>;

  /**
   * Implements Internet Gateway Rules list by resource group GET method.
   */
  listByResourceGroup is ArmResourceListByParent<InternetGatewayRule>;

  /**
   * List all Internet Gateway rules in the given subscription.
   */
  listBySubscription is ArmListBySubscription<InternetGatewayRule>;
}

@@doc(InternetGatewayRules.create::parameters.resource, "Request payload.");
@@doc(InternetGatewayRules.update::parameters.properties,
  "Internet Gateway Rule properties to update."
);
