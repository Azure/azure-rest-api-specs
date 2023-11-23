import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NamespaceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.NotificationHubs;
@doc("Description of a Namespace AuthorizationRules.")
@parentResource(NamespaceResource)
model NamespaceAuthorizationRule
  is TrackedResource<SharedAccessAuthorizationRuleProperties> {
  @doc("Authorization rule name.")
  @path
  @key("authorizationRuleName")
  @segment("AuthorizationRules")
  name: string;
}

@armResourceOperations
interface NamespaceAuthorizationRules {
  @doc("Gets an authorization rule for a namespace by name.")
  getAuthorizationRule is ArmResourceRead<NamespaceAuthorizationRule>;
  @doc("Creates an authorization rule for a namespace")
  createOrUpdateAuthorizationRule is ArmResourceCreateOrReplaceSync<NamespaceAuthorizationRule>;
  @doc("Deletes a namespace authorization rule")
  deleteAuthorizationRule is ArmResourceDeleteSync<NamespaceAuthorizationRule>;
  @doc("Gets the authorization rules for a namespace.")
  listAuthorizationRules is ArmResourceListByParent<NamespaceAuthorizationRule>;
  @doc("Gets the Primary and Secondary ConnectionStrings to the namespace ")
  listKeys is ArmResourceActionSync<
    NamespaceAuthorizationRule,
    {},
    ResourceListKeys
  >;
  @doc("Regenerates the Primary/Secondary Keys to the Namespace Authorization Rule")
  regenerateKeys is ArmResourceActionSync<
    NamespaceAuthorizationRule,
    PolicykeyResource,
    ResourceListKeys
  >;
}
