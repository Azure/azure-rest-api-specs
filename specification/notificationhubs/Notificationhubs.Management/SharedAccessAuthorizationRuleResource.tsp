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
  is Azure.ResourceManager.TrackedResource<SharedAccessAuthorizationRuleProperties> {
  ...ResourceNameParameter<
    Resource = SharedAccessAuthorizationRuleResource,
    KeyName = "authorizationRuleName",
    SegmentName = "authorizationRules",
    NamePattern = "^[a-zA-Z0-9!()*-._]+$"
  >;
}

@armResourceOperations
interface SharedAccessAuthorizationRuleResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = NamespaceResource,
          KeyName = "namespaceName",
          SegmentName = "namespaces",
          NamePattern = "^[a-zA-Z][a-zA-Z0-9-]*$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = NotificationHubResource,
          KeyName = "notificationHubName",
          SegmentName = "notificationHubs",
          NamePattern = "^[a-zA-Z][a-zA-Z0-9-./_]*$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = SharedAccessAuthorizationRuleResource,
        KeyName = "authorizationRuleName",
        SegmentName = "authorizationRules",
        NamePattern = "^[a-zA-Z0-9!()*-._]+$"
      >>
    > {}

@armResourceOperations
interface SharedAccessAuthorizationRuleResources {
  /**
   * Gets an authorization rule for a NotificationHub by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NotificationHubs_GetAuthorizationRule")
  getAuthorizationRule is SharedAccessAuthorizationRuleResourceOps.Read<SharedAccessAuthorizationRuleResource>;

  /**
   * Creates/Updates an authorization rule for a NotificationHub
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NotificationHubs_CreateOrUpdateAuthorizationRule")
  createOrUpdateAuthorizationRule is SharedAccessAuthorizationRuleResourceOps.CreateOrUpdateSync<SharedAccessAuthorizationRuleResource>;

  /**
   * Deletes a notificationHub authorization rule
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NotificationHubs_DeleteAuthorizationRule")
  deleteAuthorizationRule is SharedAccessAuthorizationRuleResourceOps.DeleteSync<SharedAccessAuthorizationRuleResource>;

  /**
   * Gets the authorization rules for a NotificationHub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NotificationHubs_ListAuthorizationRules")
  listAuthorizationRules is SharedAccessAuthorizationRuleResourceOps.List<SharedAccessAuthorizationRuleResource>;

  /**
   * Gets the Primary and Secondary ConnectionStrings to the NotificationHub
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NotificationHubs_ListKeys")
  listKeys is SharedAccessAuthorizationRuleResourceOps.ActionSync<
    SharedAccessAuthorizationRuleResource,
    void,
    ArmResponse<ResourceListKeys>
  >;

  /**
   * Regenerates the Primary/Secondary Keys to the NotificationHub Authorization Rule
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NotificationHubs_RegenerateKeys")
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
        ...KeysOf<ResourceNameParameter<
          Resource = NamespaceResource,
          KeyName = "namespaceName",
          SegmentName = "namespaces",
          NamePattern = "^[a-zA-Z][a-zA-Z0-9-]*$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = SharedAccessAuthorizationRuleResource,
        KeyName = "authorizationRuleName",
        SegmentName = "authorizationRules",
        NamePattern = "^[a-zA-Z0-9!()*-._]+$"
      >>
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
  listAuthorizationRules is NamespaceOps.List<SharedAccessAuthorizationRuleResource>;

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
