import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./EventHubsNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.EventHubs;
@doc("Single item in a List or Get AuthorizationRule operation")
@parentResource(EventHubsNamespace)
model EventHubsAuthorizationRule is ProxyResource<AuthorizationRuleProperties> {
  @doc("The authorization rule name.")
  @minLength(1)
  @path
  @key("authorizationRuleName")
  @segment("authorizationRules")
  name: string;
}

@armResourceOperations
interface Namespaces {
  @doc("Gets an AuthorizationRule for a Namespace by rule name.")
  getAuthorizationRule is ArmResourceRead<EventHubsAuthorizationRule>;
  @doc("Creates or updates an AuthorizationRule for a Namespace.")
  createOrUpdateAuthorizationRule is ArmResourceCreateOrReplaceSync<EventHubsAuthorizationRule>;
  @doc("Deletes an AuthorizationRule for a Namespace.")
  deleteAuthorizationRule is ArmResourceDeleteSync<EventHubsAuthorizationRule>;
  @doc("Gets a list of authorization rules for a Namespace.")
  listAuthorizationRules is ArmResourceListByParent<EventHubsAuthorizationRule>;
  @doc("Gets the primary and secondary connection strings for the Namespace.")
  listKeys is ArmResourceActionSync<
    EventHubsAuthorizationRule,
    void,
    EventHubsAccessKeys
  >;
  @doc("Regenerates the primary or secondary connection strings for the specified Namespace.")
  regenerateKeys is ArmResourceActionSync<
    EventHubsAuthorizationRule,
    EventHubsRegenerateAccessKeyContent,
    EventHubsAccessKeys
  >;
}
