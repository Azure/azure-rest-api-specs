import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NotificationHubResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NotificationHubs;
/**
 * Response for POST requests that return single SharedAccessAuthorizationRule.
 */
@parentResource(NotificationHubResource)
model SharedAccessAuthorizationRuleResource
  is Azure.ResourceManager.ProxyResource<SharedAccessAuthorizationRuleProperties> {
  ...ResourceNameParameter<
    Resource = SharedAccessAuthorizationRuleResource,
    KeyName = "authorizationRuleName",
    SegmentName = "authorizationRules",
    NamePattern = "^[a-zA-Z0-9!()*-._]+$"
  >;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations
interface SharedAccessAuthorizationRuleResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * Namespace name
         */
        @path
        @segment("namespaces")
        @pattern("^[a-zA-Z][a-zA-Z0-9-]*$")
        @minLength(1)
        @maxLength(50)
        namespaceName: string,

        /**
         * Notification Hub name
         */
        @path
        @segment("notificationHubs")
        @pattern("^[a-zA-Z][a-zA-Z0-9-./_]*$")
        @minLength(1)
        @maxLength(265)
        notificationHubName: string,
      },
      {
        /**
         * Authorization Rule Name
         */
        @path
        @segment("authorizationRules")
        @pattern("^[a-zA-Z0-9!()*-._]+$")
        @minLength(1)
        @maxLength(256)
        authorizationRuleName: string,
      }
    > {}

@armResourceOperations
interface SharedAccessAuthorizationRuleResources {
  /**
   * Gets an authorization rule for a NotificationHub by name.
   */
  getAuthorizationRule is SharedAccessAuthorizationRuleResourceOps.Read<SharedAccessAuthorizationRuleResource>;

  /**
   * Creates/Updates an authorization rule for a NotificationHub
   */
  createOrUpdateAuthorizationRule is SharedAccessAuthorizationRuleResourceOps.CreateOrUpdateSync<SharedAccessAuthorizationRuleResource>;

  /**
   * Deletes a notificationHub authorization rule
   */
  deleteAuthorizationRule is SharedAccessAuthorizationRuleResourceOps.DeleteSync<SharedAccessAuthorizationRuleResource>;

  /**
   * Gets the authorization rules for a NotificationHub.
   */
  listAuthorizationRules is SharedAccessAuthorizationRuleResourceOps.List<
    SharedAccessAuthorizationRuleResource,
    Response = SharedAccessAuthorizationRuleListResult
  >;

  /**
   * Gets the Primary and Secondary ConnectionStrings to the NotificationHub
   */
  listKeys is SharedAccessAuthorizationRuleResourceOps.ActionSync<
    SharedAccessAuthorizationRuleResource,
    void,
    ArmResponse<ResourceListKeys>
  >;

  /**
   * Regenerates the Primary/Secondary Keys to the NotificationHub Authorization Rule
   */
  regenerateKeys is SharedAccessAuthorizationRuleResourceOps.ActionSync<
    SharedAccessAuthorizationRuleResource,
    PolicyKeyResource,
    ArmResponse<ResourceListKeys>
  >;
}
@armResourceOperations
interface NamespaceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * Namespace name
         */
        @path
        @segment("namespaces")
        @pattern("^[a-zA-Z][a-zA-Z0-9-]*$")
        @minLength(1)
        @maxLength(50)
        namespaceName: string,
      },
      {
        /**
         * Authorization Rule Name
         */
        @path
        @segment("authorizationRules")
        @pattern("^[a-zA-Z0-9!()*-._]+$")
        @minLength(1)
        @maxLength(256)
        authorizationRuleName: string,
      }
    > {}

@armResourceOperations
interface Namespaces {
  /**
   * Gets an authorization rule for a namespace by name.
   */
  getAuthorizationRule is NamespaceOps.Read<SharedAccessAuthorizationRuleResource>;

  /**
   * Creates an authorization rule for a namespace
   */
  createOrUpdateAuthorizationRule is NamespaceOps.CreateOrUpdateSync<SharedAccessAuthorizationRuleResource>;

  /**
   * Deletes a namespace authorization rule
   */
  deleteAuthorizationRule is NamespaceOps.DeleteSync<SharedAccessAuthorizationRuleResource>;

  /**
   * Gets the authorization rules for a namespace.
   */
  listAuthorizationRules is NamespaceOps.List<
    SharedAccessAuthorizationRuleResource,
    Response = SharedAccessAuthorizationRuleListResult
  >;

  /**
   * Gets the Primary and Secondary ConnectionStrings to the namespace.
   */
  listKeys is NamespaceOps.ActionSync<
    SharedAccessAuthorizationRuleResource,
    void,
    ArmResponse<ResourceListKeys>
  >;

  /**
   * Regenerates the Primary/Secondary Keys to the Namespace Authorization Rule
   */
  regenerateKeys is NamespaceOps.ActionSync<
    SharedAccessAuthorizationRuleResource,
    PolicyKeyResource,
    ArmResponse<ResourceListKeys>
  >;
}

@@maxLength(SharedAccessAuthorizationRuleResource.name, 256);
@@minLength(SharedAccessAuthorizationRuleResource.name, 1);
@@doc(SharedAccessAuthorizationRuleResource.name, "Authorization Rule Name");
@@doc(SharedAccessAuthorizationRuleResource.properties,
  "SharedAccessAuthorizationRule properties."
);
@@doc(SharedAccessAuthorizationRuleResources.createOrUpdateAuthorizationRule::parameters.resource,
  "Request content."
);
@@doc(SharedAccessAuthorizationRuleResources.regenerateKeys::parameters.body,
  "Request content."
);
@@doc(Namespaces.createOrUpdateAuthorizationRule::parameters.resource,
  "Request content."
);
@@doc(Namespaces.regenerateKeys::parameters.body, "Request content.");
@@visibility(SharedAccessAuthorizationRuleResource.location,
  Lifecycle.Read,
  Lifecycle.Create
);
