import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiManagementServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Notification details.
 */
@parentResource(ApiManagementServiceResource)
model NotificationContract
  is Azure.ResourceManager.ProxyResource<NotificationContractProperties> {
  ...ResourceNameParameter<
    Resource = NotificationContract,
    KeyName = "notificationName",
    SegmentName = "notifications",
    NamePattern = "",
    Type = NotificationName
  >;
}

alias NotificationRecipientEmailParentParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /**
   *  The name of the API Management service.
   */
  @path
  @segment("service")
  @key
  @minLength(1)
  @maxLength(50)
  @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
  serviceName: string;

  /**
   * Notification Name Identifier.
   */
  @segment("notifications")
  notificationName: NotificationName;
};

alias NotificationRecipientEmailParameters = {
  /**
   * Email identifier.
   */
  @path
  @segment("recipientEmails")
  email: string;
};

alias NotificationRecipientEmailOps = Azure.ResourceManager.Legacy.RoutedOperations<
  NotificationRecipientEmailParentParameters,
  NotificationRecipientEmailParameters,
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/notifications/{notificationName}/recipientEmails/{email}",
  }
>;

alias NotificationRecipientUserParentParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /**
   *  The name of the API Management service.
   */
  @path
  @segment("service")
  @key
  @minLength(1)
  @maxLength(50)
  @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
  serviceName: string;

  /**
   * Notification Name Identifier.
   */
  @segment("notifications")
  notificationName: NotificationName;
};

alias NotificationRecipientUserParameters = {
  /**
   * User identifier. Must be unique in the current API Management service instance.
   */
  @maxLength(80)
  @minLength(1)
  @path
  @segment("recipientUsers")
  userId: string;
};

alias NotificationRecipientUserOps = Azure.ResourceManager.Legacy.RoutedOperations<
  NotificationRecipientUserParentParameters,
  NotificationRecipientUserParameters,
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/notifications/{notificationName}/recipientUsers",
  }
>;

alias WorkspaceNotificationRecipientUserParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
  ...Azure.ResourceManager.Legacy.Provider;

  /** The name of the API Management service. */
  @path
  @segment("service")
  @key
  @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
  @minLength(1)
  @maxLength(50)
  serviceName: string;

  /** Workspace identifier. Must be unique in the current API Management service instance. */
  @path
  @segment("workspaces")
  @key
  @pattern("^[^*#&+:<>?]+$")
  @minLength(1)
  @maxLength(80)
  workspaceId: string;

  /**
   * Workspace identifier. Must be unique in the current API Management service instance.
   */
  @path
  @segment("notifications")
  @key
  notificationName: NotificationName;

  /**
   * User identifier. Must be unique in the current API Management service instance.
   */
  @maxLength(80)
  @minLength(1)
  @path
  @segment("recipientUsers")
  userId: string;
};

alias WorkspaceNotificationRecipientEmailParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
  ...Azure.ResourceManager.Legacy.Provider;

  /** The name of the API Management service. */
  @path
  @segment("service")
  @key
  @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
  @minLength(1)
  @maxLength(50)
  serviceName: string;

  /** Workspace identifier. Must be unique in the current API Management service instance. */
  @path
  @segment("workspaces")
  @key
  @pattern("^[^*#&+:<>?]+$")
  @minLength(1)
  @maxLength(80)
  workspaceId: string;

  /**
   * Workspace identifier. Must be unique in the current API Management service instance.
   */
  @path
  @segment("notifications")
  @key
  notificationName: NotificationName;

  /**
   * Email identifier.
   */
  @path
  @segment("recipientEmails")
  email: string;
};

@armResourceOperations
interface NotificationContractOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,
      },
      {
        /** Notification Name Identifier. */
        @path
        @segment("notifications")
        @key
        notificationName: NotificationName,
      }
    > {}

@armResourceOperations(#{ allowStaticRoutes: true })
interface NotificationContracts {
  /**
   * Gets the details of the Notification specified by its identifier.
   */
  get is NotificationContractOps.Read<NotificationContract>;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Create or Update API Management publisher notification.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is NotificationContractOps.CreateOrUpdateSync<
    NotificationContract,
    Request = void,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<NotificationContract>
  >;

  /**
   * Lists a collection of properties defined within a service instance.
   */
  listByService is NotificationContractOps.List<
    NotificationContract,
    Parameters = {
      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<NotificationCollection>
  >;

  /**
   * Gets the list of the Notification Recipient User subscribed to the notification.
   */
  @get
  @action("recipientUsers")
  listByNotification is NotificationContractOps.ActionSync<
    NotificationContract,
    void,
    ArmResponse<RecipientUserCollection>
  >;

  /**
   * Determine if the Notification Recipient User is subscribed to the notification.
   */
  @head
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/notifications/{notificationName}/recipientUsers/{userId}")
  checkEntityExists is NotificationRecipientUserOps.ActionSync<
    NotificationContract,
    void,
    Response = NoContentResponse | NotFoundResponse
  >;

  /**
   * Adds the API Management User to the list of Recipients for the Notification.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/notifications/{notificationName}/recipientUsers/{userId}")
  notificationRecipientUserCreateOrUpdate is NotificationRecipientUserOps.ActionSync<
    NotificationContract,
    void,
    Response = ArmResponse<RecipientUserContract> | ArmResourceCreatedSyncResponse<RecipientUserContract>
  >;

  /**
   * Removes the API Management user from the list of Notification.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/notifications/{notificationName}/recipientUsers/{userId}")
  delete is NotificationRecipientUserOps.ActionSync<
    NotificationContract,
    void,
    Response = OkResponse | NoContentResponse | ErrorResponse
  >;

  /**
   * Gets the list of the Notification Recipient Emails subscribed to a notification.
   */
  @get
  @action("recipientEmails")
  notificationRecipientEmailListByNotification is NotificationContractOps.ActionSync<
    NotificationContract,
    void,
    ArmResponse<RecipientEmailCollection>
  >;

  /**
   * Determine if Notification Recipient Email subscribed to the notification.
   */
  @head
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/notifications/{notificationName}/recipientEmails/{email}")
  notificationRecipientEmailCheckEntityExists is NotificationRecipientEmailOps.ActionSync<
    NotificationContract,
    void,
    Response = NoContentResponse | NotFoundResponse
  >;

  /**
   * Adds the Email address to the list of Recipients for the Notification.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/notifications/{notificationName}/recipientEmails/{email}")
  notificationRecipientEmailCreateOrUpdate is NotificationRecipientEmailOps.ActionSync<
    NotificationContract,
    void,
    Response = ArmResponse<RecipientEmailContract> | ArmResourceCreatedSyncResponse<RecipientEmailContract>
  >;

  /**
   * Removes the email from the list of Notification.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/notifications/{notificationName}/recipientEmails/{email}")
  notificationRecipientEmailDelete is NotificationRecipientEmailOps.ActionSync<
    NotificationContract,
    void,
    Response = OkResponse | NoContentResponse
  >;
}
@armResourceOperations
interface WorkspaceNotificationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        workspaceId: string,
      },
      {
        /** Notification Name Identifier. */
        @path
        @segment("notifications")
        @key
        notificationName: NotificationName,
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface WorkspaceNotification {
  /**
   * Gets the details of the Notification specified by its identifier.
   */
  get is WorkspaceNotificationOps.Read<NotificationContract>;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Create or Update API Management publisher notification for the workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is WorkspaceNotificationOps.CreateOrUpdateSync<
    NotificationContract,
    Request = void,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<NotificationContract>
  >;

  /**
   * Lists a collection of properties defined within a service instance.
   */
  listByService is WorkspaceNotificationOps.List<
    NotificationContract,
    Parameters = {
      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<NotificationCollection>
  >;

  /**
   * Gets the list of the Notification Recipient User subscribed to the notification.
   */
  @get
  @action("recipientUsers")
  listByNotification is WorkspaceNotificationOps.ActionSync<
    NotificationContract,
    void,
    ArmResponse<RecipientUserCollection>
  >;

  /**
   * Determine if the Notification Recipient User is subscribed to the notification.
   */
  @head
  checkEntityExists(
    ...WorkspaceNotificationRecipientUserParameters,
  ): NoContentResponse | NotFoundResponse | ErrorResponse;

  /**
   * Adds the API Management User to the list of Recipients for the Notification.
   */
  @put
  workspaceNotificationRecipientUserCreateOrUpdate is WorkspaceNotificationOps.CreateOrUpdateSync<
    NotificationContract,
    Request = void,
    Response = ArmResponse<RecipientUserContract> | ArmResourceCreatedSyncResponse<RecipientUserContract>,
    Parameters = {
      /**
       * User identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(80)
      @minLength(1)
      @path
      @segment("recipientUsers")
      userId: string;
    }
  >;

  /**
   * Removes the API Management user from the list of Notification.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @delete
  delete(
    ...WorkspaceNotificationRecipientUserParameters,
  ): OkResponse | NoContentResponse | ErrorResponse;

  /**
   * Gets the list of the Notification Recipient Emails subscribed to a notification.
   */
  @get
  @action("recipientEmails")
  workspaceNotificationRecipientEmailListByNotification is WorkspaceNotificationOps.ActionSync<
    NotificationContract,
    void,
    ArmResponse<RecipientEmailCollection>
  >;

  /**
   * Determine if Notification Recipient Email subscribed to the notification.
   */
  @head
  workspaceNotificationRecipientEmailCheckEntityExists(
    ...WorkspaceNotificationRecipientEmailParameters,
  ): NoContentResponse | NotFoundResponse | ErrorResponse;

  /**
   * Adds the Email address to the list of Recipients for the Notification.
   */
  @put
  workspaceNotificationRecipientEmailCreateOrUpdate is WorkspaceNotificationOps.CreateOrUpdateSync<
    NotificationContract,
    Request = void,
    Response = ArmResponse<RecipientEmailContract> | ArmResourceCreatedSyncResponse<RecipientEmailContract>,
    Parameters = {
      /**
       * Email identifier.
       */
      @path
      @segment("recipientEmails")
      email: string;
    }
  >;

  /**
   * Removes the email from the list of Notification.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @delete
  workspaceNotificationRecipientEmailDelete(
    ...WorkspaceNotificationRecipientEmailParameters,
  ): OkResponse | NoContentResponse | ErrorResponse;
}

@@doc(NotificationContract.name, "Notification Name Identifier.");
@@doc(NotificationContract.properties,
  "Notification entity contract properties."
);
