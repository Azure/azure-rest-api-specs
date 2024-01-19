import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
@doc("An action group resource.")
model ActionGroupResource is TrackedResource<ActionGroup> {
  @doc("The name of the action group.")
  @path
  @key("actionGroupName")
  @segment("actionGroups")
  name: string;
}

@armResourceOperations
interface ActionGroupResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get an action group.")
  @operationId("ActionGroups_Get")
  get is ArmResourceRead<ActionGroupResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a new action group or update an existing one.")
  @operationId("ActionGroups_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ActionGroupResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates an existing action group's tags. To update other fields use the CreateOrUpdate method.")
  @operationId("ActionGroups_Update")
  update is ArmCustomPatchSync<ActionGroupResource, ActionGroupPatchBody>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete an action group.")
  @operationId("ActionGroups_Delete")
  delete is ArmResourceDeleteSync<ActionGroupResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a list of all action groups in a resource group.")
  @operationId("ActionGroups_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ActionGroupResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a list of all action groups in a subscription.")
  @operationId("ActionGroups_ListBySubscriptionId")
  listBySubscriptionId is ArmListBySubscription<ActionGroupResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Send test notifications to a set of provided receivers")
  @operationId("ActionGroups_CreateNotificationsAtActionGroupResourceLevel")
  createNotificationsAtActionGroupResourceLevel is ArmResourceActionAsync<
    ActionGroupResource,
    NotificationRequestBody,
    TestNotificationDetailsResponse,
    BaseParameters<ActionGroupResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Enable a receiver in an action group. This changes the receiver's status from Disabled to Enabled. This operation is only supported for Email or SMS receivers.")
  @operationId("ActionGroups_EnableReceiver")
  enableReceiver is ArmResourceActionSync<
    ActionGroupResource,
    EnableRequest,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ActionGroups_GetTestNotificationsAtActionGroupResourceLevel")
  @doc("Get the test notifications by the notification id")
  // FIXME: ActionGroups_GetTestNotificationsAtActionGroupResourceLevel could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/actionGroups/{actionGroupName}/notificationStatus/{notificationId}")
  @get
  getTestNotificationsAtActionGroupResourceLevel is Azure.Core.Foundations.Operation<
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

@@projectedName(ActionGroupResources.createOrUpdate::parameters.resource,
  "json",
  "actionGroup"
);
@@extension(ActionGroupResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "actionGroup"
);
@@doc(ActionGroupResources.createOrUpdate::parameters.resource,
  "The action group to create or use for the update."
);
@@projectedName(ActionGroupResources.update::parameters.properties,
  "json",
  "actionGroupPatch"
);
@@extension(ActionGroupResources.update::parameters.properties,
  "x-ms-client-name",
  "actionGroupPatch"
);
@@doc(ActionGroupResources.update::parameters.properties,
  "Parameters supplied to the operation."
);
@@projectedName(ActionGroupResources.createNotificationsAtActionGroupResourceLevel::parameters.body,
  "json",
  "notificationRequest"
);
@@extension(ActionGroupResources.createNotificationsAtActionGroupResourceLevel::parameters.body,
  "x-ms-client-name",
  "notificationRequest"
);
@@doc(ActionGroupResources.createNotificationsAtActionGroupResourceLevel::parameters.body,
  "The notification request body which includes the contact details"
);
@@projectedName(ActionGroupResources.enableReceiver::parameters.body,
  "json",
  "enableRequest"
);
@@extension(ActionGroupResources.enableReceiver::parameters.body,
  "x-ms-client-name",
  "enableRequest"
);
@@doc(ActionGroupResources.enableReceiver::parameters.body,
  "The receiver to re-enable."
);
