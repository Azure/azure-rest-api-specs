import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A notification.
 */
model NotificationChannel
  is Azure.ResourceManager.TrackedResource<NotificationChannelProperties> {
  ...ResourceNameParameter<
    Resource = NotificationChannel,
    KeyName = "name",
    SegmentName = "notificationchannels",
    NamePattern = ""
  >;
}

@armResourceOperations
interface NotificationChannels {
  /**
   * Get notification channel.
   */
  get is ArmResourceRead<
    NotificationChannel,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=webHookUrl)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing Notification Channel.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NotificationChannel>;

  /**
   * Allows modifying tags of notification channels. All other properties will be ignored.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    NotificationChannel,
    PatchModel = NotificationChannelFragment
  >;

  /**
   * Delete notification channel.
   */
  delete is ArmResourceDeleteSync<NotificationChannel>;

  /**
   * List notification channels in a given lab.
   */
  list is ArmResourceListByParent<
    NotificationChannel,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=webHookUrl)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')'
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<NotificationChannelList>
  >;

  /**
   * Send notification to provided channel.
   */
  notify is ArmResourceActionSync<
    NotificationChannel,
    NotifyParameters,
    OkResponse
  >;
}

@@doc(NotificationChannel.name, "The name of the notification channel.");
@@doc(NotificationChannel.properties, "The properties of the resource.");
@@doc(NotificationChannels.createOrUpdate::parameters.resource,
  "A notification."
);
@@doc(NotificationChannels.update::parameters.properties,
  "Allows modifying tags of notification channels. All other properties will be ignored."
);
@@doc(NotificationChannels.notify::parameters.body,
  "Properties for generating a Notification."
);
