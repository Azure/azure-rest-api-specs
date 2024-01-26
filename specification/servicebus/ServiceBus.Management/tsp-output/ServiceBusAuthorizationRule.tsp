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
/**
 * Description of a namespace authorization rule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ServiceBusNamespace)
@includeInapplicableMetadataInPayload(false)
model ServiceBusAuthorizationRule extends ProxyResource {
  /**
   * The authorization rule name.
   */
  @maxLength(50)
  @minLength(1)
  @path
  @key("authorizationRuleName")
  @segment("AuthorizationRules")
  @visibility("read")
  name: string;

  /**
   * The system meta data relating to this resource.
   */
  @visibility("read")
  systemData?: SystemData;

  /**
   * AuthorizationRule properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SBAuthorizationRuleProperties;
}

@armResourceOperations
interface ServiceBusAuthorizationRules {
  /**
   * Gets an authorization rule for a namespace by rule name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NamespaceAuthorizationRules_Get")
  get is ArmResourceRead<ServiceBusAuthorizationRule>;

  /**
   * Creates or updates an authorization rule for a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NamespaceAuthorizationRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceBusAuthorizationRule>;

  /**
   * Deletes a namespace authorization rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NamespaceAuthorizationRules_Delete")
  delete is ArmResourceDeleteSync<ServiceBusAuthorizationRule>;

  /**
   * Gets the authorization rules for a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NamespaceAuthorizationRules_List")
  list is ArmResourceListByParent<ServiceBusAuthorizationRule>;

  /**
   * Gets the primary and secondary connection strings for the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NamespaceAuthorizationRules_ListKeys")
  listKeys is ArmResourceActionSync<
    ServiceBusAuthorizationRule,
    void,
    ServiceBusAccessKeys
  >;

  /**
   * Regenerates the primary or secondary connection strings for the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
