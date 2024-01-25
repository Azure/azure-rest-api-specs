import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Relay;
/**
 * Single item in a List or Get AuthorizationRule operation
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(RelayNamespace)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(AuthorizationRuleProperties)
model AuthorizationRule extends ProxyResourceBase {
  /**
   * The authorization rule name.
   */
  @minLength(1)
  @path
  @key("authorizationRuleName")
  @segment("authorizationRules")
  @visibility("read")
  name: string;

  /**
   * Properties supplied to create or update AuthorizationRule
   */
  @extension("x-ms-client-flatten", true)
  properties?: AuthorizationRuleProperties;
}

@armResourceOperations
interface AuthorizationRules {
  /**
   * Authorization rule for a namespace by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_GetAuthorizationRule")
  getAuthorizationRule is ArmResourceRead<AuthorizationRule>;

  /**
   * Creates or updates an authorization rule for a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_CreateOrUpdateAuthorizationRule")
  createOrUpdateAuthorizationRule is ArmResourceCreateOrReplaceSync<AuthorizationRule>;

  /**
   * Deletes a namespace authorization rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_DeleteAuthorizationRule")
  deleteAuthorizationRule is ArmResourceDeleteSync<AuthorizationRule>;

  /**
   * Authorization rules for a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_ListAuthorizationRules")
  listAuthorizationRules is ArmResourceListByParent<AuthorizationRule>;

  /**
   * Primary and secondary connection strings to the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_ListKeys")
  listKeys is ArmResourceActionSync<AuthorizationRule, void, AccessKeys>;

  /**
   * Regenerates the primary or secondary connection strings to the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_RegenerateKeys")
  regenerateKeys is ArmResourceActionSync<
    AuthorizationRule,
    RegenerateAccessKeyParameters,
    AccessKeys
  >;
}

@@projectedName(AuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "json",
  "parameters"
);
@@extension(AuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(AuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "The authorization rule parameters."
);
@@projectedName(AuthorizationRules.regenerateKeys::parameters.body,
  "json",
  "parameters"
);
@@extension(AuthorizationRules.regenerateKeys::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(AuthorizationRules.regenerateKeys::parameters.body,
  "Parameters supplied to regenerate authorization rule."
);
