import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ResourceNotifications;

// Example model for a Resource Notification resource
// You can customize this based on your specific requirements

/** Properties of a Resource Notification. */
model ResourceNotificationProperties {
  /** The type of notification. */
  notificationType?: string;

  /** The target resource for the notification. */
  targetResource?: string;

  /** The notification message content. */
  @maxLength(1000)
  message?: string;

  /** The severity level of the notification. */
  severity?: NotificationSeverity;

  /** The creation timestamp of the notification. */
  @visibility("read")
  createdDateTime?: utcDateTime;

  /** The last modified timestamp of the notification. */
  @visibility("read")
  lastModifiedDateTime?: utcDateTime;

  /** The current status of the notification. */
  @visibility("read")
  status?: NotificationStatus;

  /** Additional properties for the notification. */
  additionalProperties?: Record<string>;
}

/** The severity level of a notification. */
union NotificationSeverity {
  string,

  /** Information level notification */
  Information: "Information",

  /** Warning level notification */
  Warning: "Warning",

  /** Error level notification */
  Error: "Error",

  /** Critical level notification */
  Critical: "Critical",
}

/** The status of a notification. */
union NotificationStatus {
  string,

  /** The notification is active */
  Active: "Active",

  /** The notification has been acknowledged */
  Acknowledged: "Acknowledged",

  /** The notification has been resolved */
  Resolved: "Resolved",

  /** The notification has expired */
  Expired: "Expired",
}

/** A Resource Notification resource. */
@parentResource(SubscriptionLocationResource)
model ResourceNotification
  is Azure.ResourceManager.TrackedResource<ResourceNotificationProperties> {
  /** The name of the Resource Notification. */
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9\\-_]{0,62}[a-zA-Z0-9])?$")
  @key("resourceNotificationName")
  @path
  @segment("resourceNotifications")
  name: string;
}

@armResourceOperations
interface ResourceNotifications {
  /** Get a Resource Notification by name. */
  get is ArmResourceRead<ResourceNotification>;

  /** Create or update a Resource Notification. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ResourceNotification>;

  /** Update a Resource Notification. */
  update is ArmResourcePatchSync<
    ResourceNotification,
    ResourceNotificationProperties
  >;

  /** Delete a Resource Notification. */
  delete is ArmResourceDeleteSync<ResourceNotification>;

  /** List Resource Notifications by subscription and location. */
  listByLocation is ArmResourceListByParent<ResourceNotification>;

  /** List Resource Notifications by subscription. */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceNotifications_ListBySubscription")
  listBySubscription is ArmListBySubscription<ResourceNotification>;
}

// Notification Session Resource Models

/** Properties of a Notification Session. */
model NotificationSessionProperties {
  /** The creation timestamp of the notification session. */
  @visibility("read")
  creationTime?: utcDateTime;

  /** The last used timestamp of the notification session. */
  @visibility("read")
  lastUsedTime?: utcDateTime;

  /** The provisioning state of the notification session. */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/** The provisioning state of a resource. */
union ProvisioningState {
  string,

  /** The resource is being created */
  Creating: "Creating",

  /** The resource creation succeeded */
  Succeeded: "Succeeded",

  /** The resource creation failed */
  Failed: "Failed",

  /** The resource is being updated */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource creation was accepted */
  Accepted: "Accepted",
}

/** A Notification Session resource. */
@parentResource(LocationResource)
model NotificationSession
  is Azure.ResourceManager.TrackedResource<NotificationSessionProperties> {
  /** The name of the Notification Session. */
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9\\-_]{0,62}[a-zA-Z0-9])?$")
  @key("notificationSessionName")
  @path
  @segment("notificationSessions")
  name: string;
}

@armResourceOperations
interface NotificationSessions {
  /** Get a Notification Session by name. */
  get is ArmResourceRead<NotificationSession>;

  /** Create or update a Notification Session with async provisioning. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NotificationSession>;

  /** Update a Notification Session. */
  update is ArmResourcePatchSync<
    NotificationSession,
    NotificationSessionProperties
  >;

  /** Delete a Notification Session. */
  delete is ArmResourceDeleteSync<NotificationSession>;

  /** List Notification Sessions by location. */
  listByLocation is ArmResourceListByParent<NotificationSession>;
}
