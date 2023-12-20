import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevTestLab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
@doc("A notification.")
@parentResource(DevTestLab)
model DevTestLabNotificationChannel
  is TrackedResource<NotificationChannelProperties> {
  @doc("The name of the notification channel.")
  @path
  @key("name")
  @segment("notificationchannels")
  name: string;
}

@armResourceOperations
interface DevTestLabNotificationChannels {
  @doc("Get notification channel.")
  get is ArmResourceRead<
    DevTestLabNotificationChannel,
    {
      ...BaseParameters<DevTestLabNotificationChannel>;

      @doc("Specify the $expand query. Example: 'properties($select=webHookUrl)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing notification channel.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DevTestLabNotificationChannel>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Allows modifying tags of notification channels. All other properties will be ignored.")
  update is ArmCustomPatchSync<
    DevTestLabNotificationChannel,
    NotificationChannelFragment
  >;
  @doc("Delete notification channel.")
  delete is ArmResourceDeleteSync<DevTestLabNotificationChannel>;
  @doc("List notification channels in a given lab.")
  list is ArmResourceListByParent<
    DevTestLabNotificationChannel,
    {
      ...BaseParameters<DevTestLabNotificationChannel>;

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
  notify is ArmResourceActionSync<
    DevTestLabNotificationChannel,
    NotifyParameters,
    void
  >;
}
