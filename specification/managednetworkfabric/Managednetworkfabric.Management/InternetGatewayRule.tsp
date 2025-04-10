import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Internet Gateway Rule resource definition.
 */
model InternetGatewayRule
  is Azure.ResourceManager.TrackedResource<
    InternetGatewayRuleProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = InternetGatewayRule,
    KeyName = "internetGatewayRuleName",
    SegmentName = "internetGatewayRules",
    NamePattern = ""
  >;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    InternetGatewayRule,
    PatchModel = InternetGatewayRulePatch
  >;

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

@@doc(InternetGatewayRule.name, "Name of the Internet Gateway rule.");
@@doc(InternetGatewayRule.properties, "Resource properties.");
@@doc(InternetGatewayRules.create::parameters.resource, "Request payload.");
@@doc(InternetGatewayRules.update::parameters.properties,
  "Internet Gateway Rule properties to update."
);
