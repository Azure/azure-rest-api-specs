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
/**
 * An action group resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(ActionGroup)
@includeInapplicableMetadataInPayload(false)
model ActionGroupResource extends TrackedResourceBase {
  /**
   * The name of the action group.
   */
  @path
  @key("actionGroupName")
  @segment("actionGroups")
  name: string;

  /**
   * The action groups properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ActionGroup;
}

@armResourceOperations
interface ActionGroupResources {
  /**
   * Get an action group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ActionGroups_Get")
  get is ArmResourceRead<ActionGroupResource>;

  /**
   * Create a new action group or update an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ActionGroups_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ActionGroupResource>;

  /**
   * Updates an existing action group's tags. To update other fields use the CreateOrUpdate method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("ActionGroups_Update")
  update is ArmCustomPatchSync<ActionGroupResource, ActionGroupPatchBody>;

  /**
   * Delete an action group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ActionGroups_Delete")
  delete is ArmResourceDeleteSync<ActionGroupResource>;

  /**
   * Get a list of all action groups in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ActionGroups_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ActionGroupResource>;

  /**
   * Get a list of all action groups in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ActionGroups_ListBySubscriptionId")
  listBySubscriptionId is ArmListBySubscription<ActionGroupResource>;

  /**
   * Send test notifications to a set of provided receivers
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ActionGroups_CreateNotificationsAtActionGroupResourceLevel")
  createNotificationsAtActionGroupResourceLevel is ArmResourceActionAsync<
    ActionGroupResource,
    NotificationRequestBody,
    TestNotificationDetailsResponse,
    BaseParameters<ActionGroupResource>,
    ArmLroLocationHeader
  >;

  /**
   * Enable a receiver in an action group. This changes the receiver's status from Disabled to Enabled. This operation is only supported for Email or SMS receivers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ActionGroups_EnableReceiver")
  enableReceiver is ArmResourceActionSync<
    ActionGroupResource,
    EnableRequest,
    void
  >;

  /**
   * Get the test notifications by the notification id
   */
  // FIXME: ActionGroups_GetTestNotificationsAtActionGroupResourceLevel could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ActionGroups_GetTestNotificationsAtActionGroupResourceLevel")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/actionGroups/{actionGroupName}/notificationStatus/{notificationId}")
  @get
  getTestNotificationsAtActionGroupResourceLevel is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the action group.
       */
      @path
      actionGroupName: string;

      /**
       * The notification id
       */
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
