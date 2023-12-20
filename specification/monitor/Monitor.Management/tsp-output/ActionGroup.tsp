import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Monitor;
@doc("An action group resource.")
model ActionGroup is TrackedResource<ActionGroup> {
  @doc("The name of the action group.")
  @path
  @key("actionGroupName")
  @segment("actionGroups")
  name: string;
}

@armResourceOperations
interface ActionGroups {
  @doc("Get an action group.")
  get is ArmResourceRead<ActionGroup>;
  @doc("Create a new action group or update an existing one.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ActionGroup>;
  @doc("Updates an existing action group's tags. To update other fields use the CreateOrUpdate method.")
  update is ArmResourcePatchSync<ActionGroup, ActionGroup>;
  @doc("Delete an action group.")
  delete is ArmResourceDeleteSync<ActionGroup>;
  @doc("Get a list of all action groups in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ActionGroup>;
  @doc("Get a list of all action groups in a subscription.")
  listBySubscriptionId is ArmListBySubscription<ActionGroup>;
  @doc("Send test notifications to a set of provided receivers")
  createNotificationsAtActionGroupResourceLevel is ArmResourceActionAsync<
    ActionGroup,
    NotificationRequestBody,
    TestNotificationDetailsResponse
  >;
  @doc("Enable a receiver in an action group. This changes the receiver's status from Disabled to Enabled. This operation is only supported for Email or SMS receivers.")
  enableReceiver is ArmResourceActionSync<ActionGroup, EnableRequest, void>;
  @doc("Get the test notifications by the notification id")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/actionGroups/{actionGroupName}/notificationStatus/{notificationId}")
  @get
  GetTestNotificationsAtActionGroupResourceLevel is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the action group.")
      @path
      actionGroupName: string;

      @doc("The notification id")
      @path
      notificationId: string;
    },
    TestNotificationDetailsResponse
  >;
}
