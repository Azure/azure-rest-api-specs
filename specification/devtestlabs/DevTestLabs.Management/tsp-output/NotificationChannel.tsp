import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A notification.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Lab)
@includeInapplicableMetadataInPayload(false)
model NotificationChannel extends Resource {
  /**
   * The name of the notification channel.
   */
  @path
  @key("name")
  @segment("notificationchannels")
  @visibility("read")
  name: string;

  /**
   * The properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties: NotificationChannelProperties;
}

@armResourceOperations
interface NotificationChannels {
  /**
   * Get notification channel.
   */
  get is ArmResourceRead<
    NotificationChannel,
    {
      ...BaseParameters<NotificationChannel>;

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
  createOrUpdate is ArmResourceCreateOrReplaceSync<NotificationChannel>;

  /**
   * Allows modifying tags of notification channels. All other properties will be ignored.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    NotificationChannel,
    NotificationChannelFragment
  >;

  /**
   * Delete notification channel.
   */
  delete is ArmResourceDeleteSync<NotificationChannel>;

  /**
   * List notification channels in a given lab.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NotificationChannels_List")
  list is ArmResourceListByParent<
    NotificationChannel,
    {
      ...BaseParameters<NotificationChannel>;

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
    }
  >;

  /**
   * Send notification to provided channel.
   */
  notify is ArmResourceActionSync<NotificationChannel, NotifyParameters, void>;
}

@@projectedName(NotificationChannels.createOrUpdate::parameters.resource,
  "json",
  "notificationChannel"
);
@@extension(NotificationChannels.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "notificationChannel"
);
@@doc(NotificationChannels.createOrUpdate::parameters.resource,
  "A notification."
);
@@projectedName(NotificationChannels.update::parameters.properties,
  "json",
  "notificationChannel"
);
@@extension(NotificationChannels.update::parameters.properties,
  "x-ms-client-name",
  "notificationChannel"
);
@@doc(NotificationChannels.update::parameters.properties, "A notification.");
@@projectedName(NotificationChannels.notify::parameters.body,
  "json",
  "notifyParameters"
);
@@extension(NotificationChannels.notify::parameters.body,
  "x-ms-client-name",
  "notifyParameters"
);
@@doc(NotificationChannels.notify::parameters.body,
  "Properties for generating a Notification."
);
