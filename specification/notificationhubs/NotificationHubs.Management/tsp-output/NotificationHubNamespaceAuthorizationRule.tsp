import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NotificationHubNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NotificationHubs;
@doc("Description of a Namespace AuthorizationRules.")
@parentResource(NotificationHubNamespace)
model NotificationHubNamespaceAuthorizationRule
  is TrackedResource<SharedAccessAuthorizationRuleProperties> {
  @doc("Authorization rule name.")
  @path
  @key("authorizationRuleName")
  @segment("AuthorizationRules")
  name: string;
}

@armResourceOperations
interface NotificationHubNamespaceAuthorizationRules {
  @doc("Gets an authorization rule for a namespace by name.")
  getAuthorizationRule is ArmResourceRead<NotificationHubNamespaceAuthorizationRule>;
  @doc("Creates an authorization rule for a namespace")
  createOrUpdateAuthorizationRule is ArmResourceCreateOrReplaceSync<NotificationHubNamespaceAuthorizationRule>;
  @doc("Deletes a namespace authorization rule")
  deleteAuthorizationRule is ArmResourceDeleteSync<NotificationHubNamespaceAuthorizationRule>;
  @doc("Gets the authorization rules for a namespace.")
  listAuthorizationRules is ArmResourceListByParent<NotificationHubNamespaceAuthorizationRule>;
  @doc("Gets the Primary and Secondary ConnectionStrings to the namespace ")
  listKeys is ArmResourceActionSync<
    NotificationHubNamespaceAuthorizationRule,
    {},
    ResourceListKeys
  >;
  @doc("Regenerates the Primary/Secondary Keys to the Namespace Authorization Rule")
  regenerateKeys is ArmResourceActionSync<
    NotificationHubNamespaceAuthorizationRule,
    PolicykeyResource,
    ResourceListKeys
  >;
}
