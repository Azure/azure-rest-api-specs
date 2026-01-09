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
/**
 * Single item in a List or Get AuthorizationRule operation
 */
@parentResource(EventHubsNamespace)
model EventHubsAuthorizationRule is ProxyResource<AuthorizationRuleProperties> {
  /**
   * The authorization rule name.
   */
  @minLength(1)
  @path
  @key("authorizationRuleName")
  @segment("authorizationRules")
  name: string;
}

@armResourceOperations
interface EventHubsAuthorizationRules {
  /**
   * Gets an AuthorizationRule for a Namespace by rule name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_GetAuthorizationRule")
  getAuthorizationRule is ArmResourceRead<EventHubsAuthorizationRule>;

  /**
   * Creates or updates an AuthorizationRule for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_CreateOrUpdateAuthorizationRule")
  createOrUpdateAuthorizationRule is ArmResourceCreateOrReplaceSync<EventHubsAuthorizationRule>;

  /**
   * Deletes an AuthorizationRule for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_DeleteAuthorizationRule")
  deleteAuthorizationRule is ArmResourceDeleteSync<EventHubsAuthorizationRule>;

  /**
   * Gets a list of authorization rules for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_ListAuthorizationRules")
  listAuthorizationRules is ArmResourceListByParent<EventHubsAuthorizationRule>;

  /**
   * Gets the primary and secondary connection strings for the Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_ListKeys")
  listKeys is ArmResourceActionSync<
    EventHubsAuthorizationRule,
    void,
    EventHubsAccessKeys
  >;

  /**
   * Regenerates the primary or secondary connection strings for the specified Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
