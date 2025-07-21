import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.Core.Traits;

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
  createdDateTime?: utcDateTime;

  /** The last modified timestamp of the notification. */
  lastModifiedDateTime?: utcDateTime;

  /** The current status of the notification. */
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

  /** List Resource Notifications by subscription. */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ResourceNotifications_ListBySubscription")
  listBySubscription is ArmListBySubscription<ResourceNotification>;
}

// Notification Session Resource Models

/** Properties of a Notification Session. */
model NotificationSessionProperties {
  /** The creation timestamp of the notification session. */
  creationTime?: utcDateTime;

  /** The last used timestamp of the notification session. */
  lastUsedTime?: utcDateTime;

  /** The provisioning state of the notification session. */
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

/** Standard error response. */
model ErrorResponse {
  error: ErrorDetail;
}

/** Error detail information. */
model ErrorDetail {
  code: string;
  message: string;
}

/** Accepted response for async operations. */
model AcceptedResponse {
  @statusCode _: 202;
}

/** OK response. */
model OkResponse {
  @statusCode _: 200;
}

/** Paged result for list operations. */
model PagedResult<T> {
  value: T[];
  nextLink?: string;
}

/** List result for Notification Sessions. */
model NotificationSessionListResult {
  value: NotificationSession[];
  nextLink?: string;
}

/** A Notification Session resource. */
model NotificationSession is Azure.ResourceManager.ProxyResource<NotificationSessionProperties> {
  /** The name of the Notification Session. */
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9\\-_]{0,62}[a-zA-Z0-9])?$")
  @key("notificationSessionName")
  @path
  @segment("notificationSessions")
  name: string;
}

interface NotificationSessions {
  /** Get a Notification Session by name. */
  @route("/providers/Microsoft.ResourceNotifications/locations/{location}/notificationSessions/{notificationSessionName}")
  @get
  get(
    @path location: string,
    @path notificationSessionName: string,
    @query("api-version") apiVersion: string
  ): NotificationSession | ErrorResponse;

  /** Create or update a Notification Session with async provisioning. */
  @route("/providers/Microsoft.ResourceNotifications/locations/{location}/notificationSessions/{notificationSessionName}")
  @put
  createOrUpdate(
    @path location: string,
    @path notificationSessionName: string,
    @query("api-version") apiVersion: string,
    @body resource: NotificationSessionProperties
  ): NotificationSession | AcceptedResponse | ErrorResponse;

  /** Delete a Notification Session. */
  @route("/providers/Microsoft.ResourceNotifications/locations/{location}/notificationSessions/{notificationSessionName}")
  @delete
  delete(
    @path location: string,
    @path notificationSessionName: string,
    @query("api-version") apiVersion: string
  ): OkResponse | ErrorResponse;

  /** List Notification Sessions by location. */
  @route("/providers/Microsoft.ResourceNotifications/locations/{location}/notificationSessions")
  @get
  listByLocation(
    @path location: string,
    @query("api-version") apiVersion: string
  ): NotificationSessionListResult | ErrorResponse;
}
