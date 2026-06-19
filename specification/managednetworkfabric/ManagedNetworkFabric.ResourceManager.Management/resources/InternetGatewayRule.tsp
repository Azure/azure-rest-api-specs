import "../models/common.tsp";
import "../models/InternetGatewayRule.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
@doc("The Internet Gateway Rule resource definition.")
model InternetGatewayRule
  is Azure.ResourceManager.TrackedResource<
    InternetGatewayRuleProperties,
    false
  > {
  @doc("Name of the Internet Gateway rule.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("internetGatewayRuleName")
  @segment("internetGatewayRules")
  @visibility(Lifecycle.Read)
  name: string;
}

@@doc(InternetGatewayRule.properties, "The Internet Gateway Rule properties");

@armResourceOperations
interface InternetGatewayRules {
  @doc("Gets an Internet Gateway Rule resource.")
  get is ArmResourceRead<InternetGatewayRule>;

  @doc("Creates an Internet Gateway rule resource.")
  create is ArmResourceCreateOrReplaceAsync<InternetGatewayRule>;

  @doc("API to update certain properties of the Internet Gateway Rule resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<InternetGatewayRule, InternetGatewayRulePatch>;

  @doc("Implements Internet Gateway Rules DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<InternetGatewayRule>;

  @doc("Implements Internet Gateway Rules list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<
    InternetGatewayRule,
    Response = InternetGatewayRulesListResult
  >;

  @doc("List all Internet Gateway rules in the given subscription.")
  listBySubscription is ArmListBySubscription<
    InternetGatewayRule,
    Response = InternetGatewayRulesListResult
  >;
}

@@doc(InternetGatewayRules.create::parameters.resource, "Request payload.");
@@doc(
  InternetGatewayRules.update::parameters.properties,
  "Internet Gateway Rule properties to update."
);
