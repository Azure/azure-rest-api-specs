import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Relay;
@doc("Single item in a List or Get AuthorizationRule operation")
@parentResource(RelayNamespace)
model AuthorizationRule is ProxyResource<AuthorizationRuleProperties> {
  @doc("The authorization rule name.")
  @minLength(1)
  @key("authorizationRuleName")
  @segment("authorizationRules")
  name: string;
}

@armResourceOperations
@projectedName("client", "Namespaces")
interface AuthorizationRules_Namespaces {
  @doc("Authorization rule for a namespace by name.")
  getAuthorizationRule is ArmResourceRead<AuthorizationRule>;

  @doc("Creates or updates an authorization rule for a namespace.")
  createOrUpdateAuthorizationRule is ArmResourceCreateOrReplaceSync<AuthorizationRule>;

  @doc("Deletes a namespace authorization rule.")
  deleteAuthorizationRule is ArmResourceDeleteSync<AuthorizationRule>;

  @doc("Authorization rules for a namespace.")
  listAuthorizationRules is ArmResourceListByParent<AuthorizationRule>;

  @doc("Primary and secondary connection strings to the namespace.")
  listKeys is ArmResourceActionSync<AuthorizationRule, void, AccessKeys>;

  @doc("Regenerates the primary or secondary connection strings to the namespace.")
  regenerateKeys is ArmResourceActionSync<
    AuthorizationRule,
    RegenerateAccessKeyParameters,
    AccessKeys
  >;
}
