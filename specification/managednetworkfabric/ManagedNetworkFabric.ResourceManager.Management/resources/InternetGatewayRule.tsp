import "../models/common.tsp";
import "../models/InternetGatewayRule.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The Internet Gateway Rule resource definition.")
@Http.Private.includeInapplicableMetadataInPayload(false)
model InternetGatewayRule
  extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Internet Gateway rule.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("internetGatewayRuleName")
  @segment("internetGatewayRules")
  @visibility(Lifecycle.Read)
  name: string;

  /** The Internet Gateway Rule properties */
  properties: InternetGatewayRuleProperties;
}

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
  listByResourceGroup is ArmResourceListByParent<InternetGatewayRule>;

  @doc("List all Internet Gateway rules in the given subscription.")
  listBySubscription is ArmListBySubscription<InternetGatewayRule>;
}

@@doc(InternetGatewayRules.create::parameters.resource, "Request payload.");
@@doc(InternetGatewayRules.update::parameters.properties,
  "Internet Gateway Rule properties to update."
);
