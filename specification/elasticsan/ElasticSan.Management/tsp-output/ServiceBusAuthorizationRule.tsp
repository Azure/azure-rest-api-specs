import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;
@doc("Description of a namespace authorization rule.")
@parentResource(ServiceBusNamespace)
model ServiceBusAuthorizationRule
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
interface ServiceBusAuthorizationRules {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets an authorization rule for a namespace by rule name.")
  @operationId("NamespaceAuthorizationRules_Get")
  get is ArmResourceRead<ServiceBusAuthorizationRule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates an authorization rule for a namespace.")
  @operationId("NamespaceAuthorizationRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceBusAuthorizationRule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a namespace authorization rule.")
  @operationId("NamespaceAuthorizationRules_Delete")
  delete is ArmResourceDeleteSync<ServiceBusAuthorizationRule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the authorization rules for a namespace.")
  @operationId("NamespaceAuthorizationRules_List")
  list is ArmResourceListByParent<ServiceBusAuthorizationRule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the primary and secondary connection strings for the namespace.")
  @operationId("NamespaceAuthorizationRules_ListKeys")
  listKeys is ArmResourceActionSync<
    ServiceBusAuthorizationRule,
    void,
    ServiceBusAccessKeys
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Regenerates the primary or secondary connection strings for the namespace.")
  @operationId("NamespaceAuthorizationRules_RegenerateKeys")
  regenerateKeys is ArmResourceActionSync<
    ServiceBusAuthorizationRule,
    ServiceBusRegenerateAccessKeyContent,
    ServiceBusAccessKeys
  >;
}

@@projectedName(ServiceBusAuthorizationRules.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServiceBusAuthorizationRules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceBusAuthorizationRules.createOrUpdate::parameters.resource,
  "The shared access authorization rule."
);
@@projectedName(ServiceBusAuthorizationRules.regenerateKeys::parameters.body,
  "json",
  "parameters"
);
@@extension(ServiceBusAuthorizationRules.regenerateKeys::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceBusAuthorizationRules.regenerateKeys::parameters.body,
  "Parameters supplied to regenerate the authorization rule."
);
