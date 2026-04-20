import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ServiceBus;
@doc("Description of a namespace authorization rule.")
@parentResource(ServiceBusNamespace)
model ServiceBusAuthorizationRule
  is ProxyResource<SBAuthorizationRuleProperties> {
  @doc("The authorization rule name.")
  @maxLength(50)
  @minLength(1)
  @key("authorizationRuleName")
  @segment("AuthorizationRules")
  name: string;
}

@armResourceOperations
interface NamespaceAuthorizationRules {
  // @doc("Gets an authorization rule for a namespace by rule name.")
  // get is ArmResourceRead<ServiceBusAuthorizationRule>;
  // @doc("Creates or updates an authorization rule for a namespace.")
  // createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceBusAuthorizationRule>;
  // @doc("Deletes a namespace authorization rule.")
  // delete is ArmResourceDeleteSync<ServiceBusAuthorizationRule>;
  @doc("Gets the authorization rules for a namespace.")
  list is ArmResourceListByParent<ServiceBusAuthorizationRule>;
  @doc("Gets the primary and secondary connection strings for the namespace.")
  listKeys is ArmResourceActionSync<
    ServiceBusAuthorizationRule,
    void,
    ServiceBusAccessKeys
  >;
  @doc("Regenerates the primary or secondary connection strings for the namespace.")
  regenerateKeys is ArmResourceActionSync<
    ServiceBusAuthorizationRule,
    ServiceBusRegenerateAccessKeyContent,
    ServiceBusAccessKeys
  >;
}