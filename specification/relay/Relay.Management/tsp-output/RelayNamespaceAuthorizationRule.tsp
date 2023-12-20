import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Relay;
@doc("Single item in a List or Get AuthorizationRule operation")
@parentResource(RelayNamespace)
model RelayNamespaceAuthorizationRule
  is ProxyResource<AuthorizationRuleProperties> {
  @doc("The authorization rule name.")
  @minLength(1)
  @path
  @key("authorizationRuleName")
  @segment("authorizationRules")
  name: string;
}

@armResourceOperations
interface RelayNamespaceAuthorizationRules {
  @doc("Authorization rule for a namespace by name.")
  getAuthorizationRule is ArmResourceRead<RelayNamespaceAuthorizationRule>;
  @doc("Creates or updates an authorization rule for a namespace.")
  createOrUpdateAuthorizationRule is ArmResourceCreateOrReplaceSync<RelayNamespaceAuthorizationRule>;
  @doc("Deletes a namespace authorization rule.")
  deleteAuthorizationRule is ArmResourceDeleteSync<RelayNamespaceAuthorizationRule>;
  @doc("Authorization rules for a namespace.")
  listAuthorizationRules is ArmResourceListByParent<RelayNamespaceAuthorizationRule>;
  @doc("Primary and secondary connection strings to the namespace.")
  listKeys is ArmResourceActionSync<
    RelayNamespaceAuthorizationRule,
    void,
    AccessKeys
  >;
  @doc("Regenerates the primary or secondary connection strings to the namespace.")
  regenerateKeys is ArmResourceActionSync<
    RelayNamespaceAuthorizationRule,
    RegenerateAccessKeyParameters,
    AccessKeys
  >;
}
