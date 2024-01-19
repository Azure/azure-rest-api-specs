import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EventHubsNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;
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
interface EventHubsAuthorizationRules {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets an AuthorizationRule for a Namespace by rule name.")
  @operationId("Namespaces_GetAuthorizationRule")
  getAuthorizationRule is ArmResourceRead<EventHubsAuthorizationRule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates an AuthorizationRule for a Namespace.")
  @operationId("Namespaces_CreateOrUpdateAuthorizationRule")
  createOrUpdateAuthorizationRule is ArmResourceCreateOrReplaceSync<EventHubsAuthorizationRule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an AuthorizationRule for a Namespace.")
  @operationId("Namespaces_DeleteAuthorizationRule")
  deleteAuthorizationRule is ArmResourceDeleteSync<EventHubsAuthorizationRule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of authorization rules for a Namespace.")
  @operationId("Namespaces_ListAuthorizationRules")
  listAuthorizationRules is ArmResourceListByParent<EventHubsAuthorizationRule>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the primary and secondary connection strings for the Namespace.")
  @operationId("Namespaces_ListKeys")
  listKeys is ArmResourceActionSync<
    EventHubsAuthorizationRule,
    void,
    EventHubsAccessKeys
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Regenerates the primary or secondary connection strings for the specified Namespace.")
  @operationId("Namespaces_RegenerateKeys")
  regenerateKeys is ArmResourceActionSync<
    EventHubsAuthorizationRule,
    EventHubsRegenerateAccessKeyContent,
    EventHubsAccessKeys
  >;
}

@@projectedName(EventHubsAuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "json",
  "parameters"
);
@@extension(EventHubsAuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(EventHubsAuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "The shared access AuthorizationRule."
);
@@projectedName(EventHubsAuthorizationRules.regenerateKeys::parameters.body,
  "json",
  "parameters"
);
@@extension(EventHubsAuthorizationRules.regenerateKeys::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(EventHubsAuthorizationRules.regenerateKeys::parameters.body,
  "Parameters required to regenerate the connection string."
);
