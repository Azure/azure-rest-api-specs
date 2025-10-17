import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.DevTestLab;
/**
 * A notification.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model NotificationChannel extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("notificationchannels")
  name: string;

  properties: NotificationChannelProperties;
}

@armResourceOperations
interface NotificationChannelOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = NotificationChannel,
        KeyName = "name",
        SegmentName = "notificationchannels",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface NotificationChannels {
  /**
   * Get notification channel.
   */
  get is NotificationChannelOps.Read<
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
   * Create or replace an existing notification channel.
   */
  createOrUpdate is NotificationChannelOps.CreateOrUpdateSync<NotificationChannel>;

  /**
   * Allows modifying tags of notification channels. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is NotificationChannelOps.CustomPatchSync<
    NotificationChannel,
    PatchModel = NotificationChannelFragment
  >;

  /**
   * Delete notification channel.
   */
  delete is NotificationChannelOps.DeleteSync<NotificationChannel>;

  /**
   * List notification channels in a given lab.
   */
  list is NotificationChannelOps.List<
    NotificationChannel,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=webHookUrl)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
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
  notify is NotificationChannelOps.ActionSync<
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
@@doc(NotificationChannels.update::parameters.properties, "A notification.");
@@doc(NotificationChannels.notify::parameters.body,
  "Properties for generating a Notification."
);
