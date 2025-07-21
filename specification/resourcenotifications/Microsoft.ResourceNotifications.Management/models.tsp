import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ResourceNotifications;

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
model ResourceNotification is Azure.ResourceManager.TrackedResource<ResourceNotificationProperties> {
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
  update is ArmResourcePatchSync<ResourceNotification, ResourceNotificationProperties>;

  /** Delete a Resource Notification. */
  delete is ArmResourceDeleteSync<ResourceNotification>;

  /** List Resource Notifications by subscription and location. */
  listByLocation is ArmResourceListByParent<ResourceNotification>;

  /** List Resource Notifications by subscription. */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceNotifications_ListBySubscription")
  listBySubscription is ArmListBySubscription<ResourceNotification>;
}
