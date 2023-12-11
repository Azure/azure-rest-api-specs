import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ServiceBus;
@doc("Description of a namespace authorization rule.")
@parentResource(ServiceBusNamespace)
model ServiceBusNamespaceAuthorizationRule
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
interface ServiceBusNamespaceAuthorizationRules {
  @doc("Gets an authorization rule for a namespace by rule name.")
  get is ArmResourceRead<ServiceBusNamespaceAuthorizationRule>;
  @doc("Creates or updates an authorization rule for a namespace.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceBusNamespaceAuthorizationRule>;
  @doc("Deletes a namespace authorization rule.")
  delete is ArmResourceDeleteSync<ServiceBusNamespaceAuthorizationRule>;
  @doc("Gets the authorization rules for a namespace.")
  list is ArmResourceListByParent<ServiceBusNamespaceAuthorizationRule>;
  @doc("Gets the primary and secondary connection strings for the namespace.")
  listKeys is ArmResourceActionSync<
    ServiceBusNamespaceAuthorizationRule,
    {},
    ServiceBusAccessKeys
  >;
  @doc("Regenerates the primary or secondary connection strings for the namespace.")
  regenerateKeys is ArmResourceActionSync<
    ServiceBusNamespaceAuthorizationRule,
    ServiceBusRegenerateAccessKeyContent,
    ServiceBusAccessKeys
  >;
}
