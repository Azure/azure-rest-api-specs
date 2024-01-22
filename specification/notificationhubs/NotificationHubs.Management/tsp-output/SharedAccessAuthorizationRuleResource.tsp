import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NamespaceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NotificationHubs;
/**
 * Description of a Namespace AuthorizationRules.
 */
@parentResource(NamespaceResource)
model SharedAccessAuthorizationRuleResource
  is TrackedResource<SharedAccessAuthorizationRuleProperties> {
  /**
   * Authorization rule name.
   */
  @path
  @key("authorizationRuleName")
  @segment("AuthorizationRules")
  name: string;
}

@armResourceOperations
interface SharedAccessAuthorizationRuleResources {
  /**
   * Gets an authorization rule for a namespace by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_GetAuthorizationRule")
  getAuthorizationRule is ArmResourceRead<SharedAccessAuthorizationRuleResource>;

  /**
   * Creates an authorization rule for a namespace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_CreateOrUpdateAuthorizationRule")
  createOrUpdateAuthorizationRule is ArmResourceCreateOrReplaceSync<SharedAccessAuthorizationRuleResource>;

  /**
   * Deletes a namespace authorization rule
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_DeleteAuthorizationRule")
  deleteAuthorizationRule is ArmResourceDeleteSync<SharedAccessAuthorizationRuleResource>;

  /**
   * Gets the authorization rules for a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_ListAuthorizationRules")
  listAuthorizationRules is ArmResourceListByParent<SharedAccessAuthorizationRuleResource>;

  /**
   * Gets the Primary and Secondary ConnectionStrings to the namespace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_ListKeys")
  listKeys is ArmResourceActionSync<
    SharedAccessAuthorizationRuleResource,
    void,
    ResourceListKeys
  >;

  /**
   * Regenerates the Primary/Secondary Keys to the Namespace Authorization Rule
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_RegenerateKeys")
  regenerateKeys is ArmResourceActionSync<
    SharedAccessAuthorizationRuleResource,
    PolicykeyResource,
    ResourceListKeys
  >;
}

@@projectedName(SharedAccessAuthorizationRuleResources.createOrUpdateAuthorizationRule::parameters.resource,
  "json",
  "parameters"
);
@@extension(SharedAccessAuthorizationRuleResources.createOrUpdateAuthorizationRule::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SharedAccessAuthorizationRuleResources.createOrUpdateAuthorizationRule::parameters.resource,
  "The shared access authorization rule."
);
@@projectedName(SharedAccessAuthorizationRuleResources.regenerateKeys::parameters.body,
  "json",
  "parameters"
);
@@extension(SharedAccessAuthorizationRuleResources.regenerateKeys::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(SharedAccessAuthorizationRuleResources.regenerateKeys::parameters.body,
  "Parameters supplied to regenerate the Namespace Authorization Rule Key."
);
