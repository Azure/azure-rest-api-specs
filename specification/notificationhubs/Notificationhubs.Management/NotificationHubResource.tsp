import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NamespaceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NotificationHubs;
/**
 * Notification Hub Resource.
 */
@parentResource(NamespaceResource)
model NotificationHubResource
  is Azure.ResourceManager.TrackedResource<NotificationHubProperties> {
  ...ResourceNameParameter<
    Resource = NotificationHubResource,
    KeyName = "notificationHubName",
    SegmentName = "notificationHubs",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9-./_]*$"
  >;

  /**
   * The Sku description for a namespace
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

@armResourceOperations
interface NotificationHubResources {
  /**
   * Gets the notification hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NotificationHubs_Get")
  get is ArmResourceRead<NotificationHubResource>;

  /**
   * Creates/Update a NotificationHub in a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NotificationHubs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<NotificationHubResource>;

  /**
   * Patch a NotificationHub in a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("NotificationHubs_Update")
  update is ArmCustomPatchSync<
    NotificationHubResource,
    PatchModel = NotificationHubPatchParameters
  >;

  /**
   * Deletes a notification hub associated with a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NotificationHubs_Delete")
  delete is ArmResourceDeleteSync<NotificationHubResource>;

  /**
   * Lists the notification hubs associated with a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NotificationHubs_List")
  list is ArmResourceListByParent<
    NotificationHubResource,
    Parameters = {
      /**
       * Continuation token.
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Page size.
       */
      @query("$top")
      $top?: int32 = 100;
    }
  >;

  /**
   * Test send a push notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("debugsend")
  @operationId("NotificationHubs_DebugSend")
  debugSend is ArmResourceActionSync<
    NotificationHubResource,
    void,
    ArmResponse<DebugSendResponse>
  >;

  /**
   * Lists the PNS Credentials associated with a notification hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("pnsCredentials")
  @operationId("NotificationHubs_GetPnsCredentials")
  getPnsCredentials is ArmResourceActionSync<
    NotificationHubResource,
    void,
    ArmResponse<PnsCredentialsResource>
  >;
}

@@maxLength(NotificationHubResource.name, 265);
@@minLength(NotificationHubResource.name, 1);
@@doc(NotificationHubResource.name, "Notification Hub name");
@@doc(NotificationHubResource.properties, "NotificationHub properties.");
@@doc(NotificationHubResources.createOrUpdate::parameters.resource,
  "Request content."
);
@@doc(NotificationHubResources.update::parameters.properties,
  "Request content."
);
