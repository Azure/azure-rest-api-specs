import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SBNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ServiceBus;
@doc("Description of a namespace authorization rule.")
@parentResource(SBNamespace)
model NamespaceAuthorizationRule
  is ProxyResource<SBAuthorizationRuleProperties> {
  @doc("The authorization rule name.")
  @maxLength(50)
  @minLength(1)
  @path
  @key("authorizationRuleName")
  @segment("AuthorizationRules")
  name: string;
}

@armResourceOperations
interface NamespaceAuthorizationRules {
  @doc("Gets an authorization rule for a namespace by rule name.")
  getAuthorizationRule is ArmResourceRead<NamespaceAuthorizationRule>;
  @doc("Creates or updates an authorization rule for a namespace.")
  createOrUpdateAuthorizationRule is ArmResourceCreateOrReplaceSync<NamespaceAuthorizationRule>;
  @doc("Deletes a namespace authorization rule.")
  deleteAuthorizationRule is ArmResourceDeleteSync<NamespaceAuthorizationRule>;
  @doc("Gets the authorization rules for a namespace.")
  listAuthorizationRules is ArmResourceListByParent<NamespaceAuthorizationRule>;
  @doc("Gets the primary and secondary connection strings for the namespace.")
  listKeys is ArmResourceActionSync<NamespaceAuthorizationRule, {}, AccessKeys>;
  @doc("Regenerates the primary or secondary connection strings for the namespace.")
  regenerateKeys is ArmResourceActionSync<
    NamespaceAuthorizationRule,
    RegenerateAccessKeyParameters,
    AccessKeys
  >;
}
