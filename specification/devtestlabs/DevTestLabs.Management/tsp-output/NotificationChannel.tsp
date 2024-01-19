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
@doc("A notification.")
@parentResource(Lab)
model NotificationChannel is TrackedResource<NotificationChannelProperties> {
  @doc("The name of the notification channel.")
  @path
  @key("name")
  @segment("notificationchannels")
  name: string;
}

@armResourceOperations
interface NotificationChannels {
  @doc("Get notification channel.")
  get is ArmResourceRead<
    NotificationChannel,
    {
      ...BaseParameters<NotificationChannel>;

      @doc("Specify the $expand query. Example: 'properties($select=webHookUrl)'")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Create or replace an existing notification channel.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<NotificationChannel>;

  @doc("Allows modifying tags of notification channels. All other properties will be ignored.")
  update is ArmCustomPatchSync<
    NotificationChannel,
    NotificationChannelFragment
  >;

  @doc("Delete notification channel.")
  delete is ArmResourceDeleteSync<NotificationChannel>;

  @doc("List notification channels in a given lab.")
  list is ArmResourceListByParent<
    NotificationChannel,
    {
      ...BaseParameters<NotificationChannel>;

      @doc("Specify the $expand query. Example: 'properties($select=webHookUrl)'")
      @query("$expand")
      $expand?: string;

      @doc("The filter to apply to the operation. Example: '$filter=contains(name,'myName')")
      @query("$filter")
      $filter?: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'")
      @query("$top")
      $top?: int32;

      @doc("The ordering expression for the results, using OData notation. Example: '$orderby=name desc'")
      @query("$orderby")
      $orderby?: string;
    }
  >;

  @doc("Send notification to provided channel.")
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
