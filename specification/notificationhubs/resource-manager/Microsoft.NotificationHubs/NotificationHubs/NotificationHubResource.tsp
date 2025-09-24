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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;
}

@armResourceOperations
interface NotificationHubResources {
  /**
   * Gets the notification hub.
   */
  get is ArmResourceRead<NotificationHubResource>;

  /**
   * Creates/Update a NotificationHub in a namespace.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NotificationHubResource>;

  /**
   * Patch a NotificationHub in a namespace.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    NotificationHubResource,
    PatchModel = NotificationHubPatchParameters
  >;

  /**
   * Deletes a notification hub associated with a namespace.
   */
  delete is ArmResourceDeleteSync<NotificationHubResource>;

  /**
   * Lists the notification hubs associated with a namespace.
   */
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
    },
    Response = NotificationHubListResult
  >;

  /**
   * Test send a push notification.
   */
  @action("debugsend")
  debugSend is ArmResourceActionSync<
    NotificationHubResource,
    void,
    ArmResponse<DebugSendResponse>
  >;

  /**
   * Lists the PNS Credentials associated with a notification hub.
   */
  @action("pnsCredentials")
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
