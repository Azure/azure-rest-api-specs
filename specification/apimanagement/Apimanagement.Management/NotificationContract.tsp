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

@armResourceOperations
interface NotificationContractOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ApiManagementServiceResource,
          KeyName = "serviceName",
          SegmentName = "service",
          NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = NotificationContract,
        KeyName = "notificationName",
        SegmentName = "notifications",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface NotificationContracts {
  /**
   * Gets the details of the Notification specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Notification_Get")
  get is NotificationContractOps.Read<NotificationContract>;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Create or Update API Management publisher notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Notification_CreateOrUpdate")
  createOrUpdate is NotificationContractOps.CreateOrUpdateSync<
    NotificationContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<NotificationContract>
  >;

  /**
   * Lists a collection of properties defined within a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Notification_ListByService")
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
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<NotificationCollection>
  >;

  /**
   * Gets the list of the Notification Recipient User subscribed to the notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("recipientUsers")
  @operationId("NotificationRecipientUser_ListByNotification")
  listByNotification is NotificationContractOps.ActionSync<
    NotificationContract,
    void,
    ArmResponse<RecipientUserCollection>
  >;

  /**
   * Determine if the Notification Recipient User is subscribed to the notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @head
  @action("{userId}")
  @operationId("NotificationRecipientUser_CheckEntityExists")
  checkEntityExists is NotificationContractOps.ActionSync<
    NotificationContract,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * User identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(80)
      @minLength(1)
      @path
      userId: string;
    }
  >;

  /**
   * Adds the API Management User to the list of Recipients for the Notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @put
  @action("{userId}")
  @operationId("NotificationRecipientUser_CreateOrUpdate")
  notificationRecipientUserCreateOrUpdate is NotificationContractOps.ActionSync<
    NotificationContract,
    void,
    ArmResponse<RecipientUserContract> | ArmResourceCreatedSyncResponse<RecipientUserContract>,
    Parameters = {
      /**
       * User identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(80)
      @minLength(1)
      @path
      userId: string;
    }
  >;

  /**
   * Removes the API Management user from the list of Notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @delete
  @action("{userId}")
  @operationId("NotificationRecipientUser_Delete")
  delete is NotificationContractOps.ActionSync<
    NotificationContract,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * User identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(80)
      @minLength(1)
      @path
      userId: string;
    }
  >;

  /**
   * Gets the list of the Notification Recipient Emails subscribed to a notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("recipientEmails")
  @operationId("NotificationRecipientEmail_ListByNotification")
  notificationRecipientEmailListByNotification is NotificationContractOps.ActionSync<
    NotificationContract,
    void,
    ArmResponse<RecipientEmailCollection>
  >;

  /**
   * Determine if Notification Recipient Email subscribed to the notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @head
  @action("{email}")
  @operationId("NotificationRecipientEmail_CheckEntityExists")
  notificationRecipientEmailCheckEntityExists is NotificationContractOps.ActionSync<
    NotificationContract,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * Email identifier.
       */
      @path
      email: string;
    }
  >;

  /**
   * Adds the Email address to the list of Recipients for the Notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @put
  @action("{email}")
  @operationId("NotificationRecipientEmail_CreateOrUpdate")
  notificationRecipientEmailCreateOrUpdate is NotificationContractOps.ActionSync<
    NotificationContract,
    void,
    ArmResponse<RecipientEmailContract> | ArmResourceCreatedSyncResponse<RecipientEmailContract>,
    Parameters = {
      /**
       * Email identifier.
       */
      @path
      email: string;
    }
  >;

  /**
   * Removes the email from the list of Notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @delete
  @action("{email}")
  @operationId("NotificationRecipientEmail_Delete")
  notificationRecipientEmailDelete is NotificationContractOps.ActionSync<
    NotificationContract,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * Email identifier.
       */
      @path
      email: string;
    }
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
        ...KeysOf<ResourceNameParameter<
          Resource = ApiManagementServiceResource,
          KeyName = "serviceName",
          SegmentName = "service",
          NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WorkspaceContract,
          KeyName = "workspaceId",
          SegmentName = "workspaces",
          NamePattern = "^[^*#&+:<>?]+$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = NotificationContract,
        KeyName = "notificationName",
        SegmentName = "notifications",
        NamePattern = ""
      >>
    > {}

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is WorkspaceNotificationOps.CreateOrUpdateSync<
    NotificationContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
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
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<NotificationCollection>
  >;

  /**
   * Gets the list of the Notification Recipient User subscribed to the notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("recipientUsers")
  @operationId("WorkspaceNotificationRecipientUser_ListByNotification")
  listByNotification is WorkspaceNotificationOps.ActionSync<
    NotificationContract,
    void,
    ArmResponse<RecipientUserCollection>
  >;

  /**
   * Determine if the Notification Recipient User is subscribed to the notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @head
  @action("{userId}")
  @operationId("WorkspaceNotificationRecipientUser_CheckEntityExists")
  checkEntityExists is WorkspaceNotificationOps.ActionSync<
    NotificationContract,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * User identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(80)
      @minLength(1)
      @path
      userId: string;
    }
  >;

  /**
   * Adds the API Management User to the list of Recipients for the Notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @put
  @action("{userId}")
  @operationId("WorkspaceNotificationRecipientUser_CreateOrUpdate")
  workspaceNotificationRecipientUserCreateOrUpdate is WorkspaceNotificationOps.ActionSync<
    NotificationContract,
    void,
    ArmResponse<RecipientUserContract> | ArmResourceCreatedSyncResponse<RecipientUserContract>,
    Parameters = {
      /**
       * User identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(80)
      @minLength(1)
      @path
      userId: string;
    }
  >;

  /**
   * Removes the API Management user from the list of Notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @delete
  @action("{userId}")
  @operationId("WorkspaceNotificationRecipientUser_Delete")
  delete is WorkspaceNotificationOps.ActionSync<
    NotificationContract,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * User identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(80)
      @minLength(1)
      @path
      userId: string;
    }
  >;

  /**
   * Gets the list of the Notification Recipient Emails subscribed to a notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("recipientEmails")
  @operationId("WorkspaceNotificationRecipientEmail_ListByNotification")
  workspaceNotificationRecipientEmailListByNotification is WorkspaceNotificationOps.ActionSync<
    NotificationContract,
    void,
    ArmResponse<RecipientEmailCollection>
  >;

  /**
   * Determine if Notification Recipient Email subscribed to the notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @head
  @action("{email}")
  @operationId("WorkspaceNotificationRecipientEmail_CheckEntityExists")
  workspaceNotificationRecipientEmailCheckEntityExists is WorkspaceNotificationOps.ActionSync<
    NotificationContract,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * Email identifier.
       */
      @path
      email: string;
    }
  >;

  /**
   * Adds the Email address to the list of Recipients for the Notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @put
  @action("{email}")
  @operationId("WorkspaceNotificationRecipientEmail_CreateOrUpdate")
  workspaceNotificationRecipientEmailCreateOrUpdate is WorkspaceNotificationOps.ActionSync<
    NotificationContract,
    void,
    ArmResponse<RecipientEmailContract> | ArmResourceCreatedSyncResponse<RecipientEmailContract>,
    Parameters = {
      /**
       * Email identifier.
       */
      @path
      email: string;
    }
  >;

  /**
   * Removes the email from the list of Notification.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @delete
  @action("{email}")
  @operationId("WorkspaceNotificationRecipientEmail_Delete")
  workspaceNotificationRecipientEmailDelete is WorkspaceNotificationOps.ActionSync<
    NotificationContract,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * Email identifier.
       */
      @path
      email: string;
    }
  >;
}

@@doc(NotificationContract.name, "Notification Name Identifier.");
@@doc(NotificationContract.properties,
  "Notification entity contract properties."
);
