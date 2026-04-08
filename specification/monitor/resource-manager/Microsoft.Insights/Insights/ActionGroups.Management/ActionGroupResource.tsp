import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * An action group resource.
 */
model ActionGroupResource
  is Azure.ResourceManager.TrackedResource<ActionGroup> {
  ...ResourceNameParameter<
    Resource = ActionGroupResource,
    KeyName = "actionGroupName",
    SegmentName = "actionGroups",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

alias ActionGroupResourcesOps = Azure.ResourceManager.Legacy.RoutedOperations<
  ActionGroupResourcesParentParameters,
  ActionGroupResourcesParameters,
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Insights/actionGroups/{actionGroupName}/notificationStatus/{notificationId}",
  }
>;

alias ActionGroupResourcesParentParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /**
   * The name of the action group.
   */
  @path
  @segment("actionGroups")
  @key
  actionGroupName: string;
};

alias ActionGroupResourcesParameters = {
  /**
   * The notification id
   */
  @path
  @key
  @segment("notificationStatus")
  notificationId: string;
};

@armResourceOperations(#{ omitTags: true, allowStaticRoutes: true })
interface ActionGroupResources {
  /**
   * Get an action group.
   */
  get is ArmResourceRead<ActionGroupResource, Error = ErrorResponse>;

  /**
   * Create a new action group or update an existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ActionGroupResource,
    Error = ErrorResponse
  >;

  /**
   * Updates an existing action group's tags. To update other fields use the CreateOrUpdate method.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ActionGroupResource,
    PatchModel = ActionGroupPatchBody,
    Error = ErrorResponse
  >;

  /**
   * Delete an action group.
   */
  delete is ArmResourceDeleteSync<ActionGroupResource, Error = ErrorResponse>;

  /**
   * Get a list of all action groups in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ActionGroupResource,
    Response = ArmResponse<ActionGroupList>,
    Error = ErrorResponse
  >;

  /**
   * Get a list of all action groups in a subscription.
   */
  listBySubscriptionId is ArmListBySubscription<
    ActionGroupResource,
    Response = ArmResponse<ActionGroupList>,
    Error = ErrorResponse
  >;

  /**
   * Send test notifications to a set of provided receivers
   */
  @action("createNotifications")
  createNotificationsAtActionGroupResourceLevel is ArmResourceActionAsync<
    ActionGroupResource,
    NotificationRequestBody,
    Response = TestNotificationDetailsResponse,
    Error = ErrorResponse
  >;

  /**
   * Get the test notifications by the notification id
   */
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/actionGroups/{actionGroupName}/notificationStatus/{notificationId}")
  getTestNotificationsAtActionGroupResourceLevel is ActionGroupResourcesOps.ActionSync<
    ActionGroupResource,
    void,
    Response = TestNotificationDetailsResponse,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Enable a receiver in an action group. This changes the receiver's status from Disabled to Enabled. This operation is only supported for Email or SMS receivers.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("subscribe")
  enableReceiver is ArmResourceActionSync<
    ActionGroupResource,
    EnableRequest,
    Response = OkResponse | ArmConflictErrorResponse,
    Error = ErrorResponse
  >;
}

@@doc(ActionGroupResource.name, "The name of the action group.");
@@doc(ActionGroupResource.properties,
  "The action groups properties of the resource."
);
@@doc(ActionGroupResources.createOrUpdate::parameters.resource,
  "The action group to create or use for the update."
);
@@doc(ActionGroupResources.update::parameters.properties,
  "Parameters supplied to the operation."
);
@@doc(ActionGroupResources.createNotificationsAtActionGroupResourceLevel::parameters.body,
  "The notification request body which includes the contact details"
);
@@doc(ActionGroupResources.enableReceiver::parameters.body,
  "The receiver to re-enable."
);
