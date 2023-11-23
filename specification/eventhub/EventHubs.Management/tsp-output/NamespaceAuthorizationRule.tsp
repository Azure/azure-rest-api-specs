import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./EHNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.EventHub;
@doc("Single item in a List or Get AuthorizationRule operation")
@parentResource(EHNamespace)
model NamespaceAuthorizationRule is ProxyResource<AuthorizationRuleProperties> {
  @doc("The authorization rule name.")
  @minLength(1)
  @path
  @key("authorizationRuleName")
  @segment("authorizationRules")
  name: string;
}

@armResourceOperations
interface NamespaceAuthorizationRules {
  @doc("Gets an AuthorizationRule for a Namespace by rule name.")
  getAuthorizationRule is ArmResourceRead<NamespaceAuthorizationRule>;
  @doc("Creates or updates an AuthorizationRule for a Namespace.")
  createOrUpdateAuthorizationRule is ArmResourceCreateOrReplaceSync<NamespaceAuthorizationRule>;
  @doc("Deletes an AuthorizationRule for a Namespace.")
  deleteAuthorizationRule is ArmResourceDeleteSync<NamespaceAuthorizationRule>;
  @doc("Gets a list of authorization rules for a Namespace.")
  listAuthorizationRules is ArmResourceListByParent<NamespaceAuthorizationRule>;
  @doc("Gets the primary and secondary connection strings for the Namespace.")
  listKeys is ArmResourceActionSync<NamespaceAuthorizationRule, {}, AccessKeys>;
  @doc("Regenerates the primary or secondary connection strings for the specified Namespace.")
  regenerateKeys is ArmResourceActionSync<
    NamespaceAuthorizationRule,
    RegenerateAccessKeyParameters,
    AccessKeys
  >;
}
