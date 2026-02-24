import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ResourceNotifications;

/** Notification session status */
union NotificationSessionStatus {
  string,

  /** Active session */
  Active: "Active",

  /** Paused session */
  Paused: "Paused",

  /** Completed session */
  Completed: "Completed",

  /** Failed session */
  Failed: "Failed",
}

model NotificationSessionParentProperties {
  /** The provisioning state */
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;
}

@subscriptionResource
model NotificationSessionResourceParent
  is ProxyResource<NotificationSessionParentProperties> {
  /** The location name */
  @key("locationName")
  @segment("locations")
  @path
  @pattern("^[a-z0-9]+$")
  @visibility(Lifecycle.Read)
  locationName: string;
}

/** Properties of a notification session */
model NotificationSessionProperties {
  /** Arbitrary configuration payload (string encoded). */
  configuration?: string;

  /** Description of the notification session. */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  description?: string;

  /** Maximum duration in minutes. */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minValue(1)
  @maxValue(1440)
  maxDurationMinutes?: int32;

  /** Start time of the session. */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /** The status of the notification session */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  status?: NotificationSessionStatus;

  /** The provisioning state of the resource */
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

  /** Creation timestamp. */
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  /** Last update timestamp. */
  @visibility(Lifecycle.Read)
  updatedAt?: utcDateTime;

  /** Unique identifier of the notification session. */
  @visibility(Lifecycle.Read)
  notificationSessionId?: string;
}

/** Notification session resource for Azure Resource Notifications */
@parentResource(NotificationSessionResourceParent)
model NotificationSessionResource
  is Azure.ResourceManager.ProxyResource<NotificationSessionProperties> {
  /** The name of the notification session */
  @key("notificationSessionName")
  @segment("notificationSessions")
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  name: string;
}

/** Request body for getting session details */
model GetSessionDetailsRequest {
  /** Duration in minutes for session validity */
  @minValue(1)
  @maxValue(240)
  durationInMinutes?: int32;
}

/** Connection details for a notification session */
model NotificationSessionConnectionDetails {
  /** Connection string for the session */
  @secret
  connectionString?: string;

  /** Endpoint URL for the session */
  endpoint?: string;
}

/** Session details for connecting to a notification session */
model GetNotificationSessionDetails {
  /** The resource ID of the session */
  id?: string;

  /** Encoded notification session data */
  @secret
  encodedNotificationSession?: string;

  /** Connection details for the session */
  connectionDetails?: NotificationSessionConnectionDetails;

  /** Timestamp until which the session details are valid */
  validUntil?: utcDateTime;
}

/** Operations for Notification Sessions */
@armResourceOperations
interface NotificationsSessions {
  /** Gets a notification session */
  get is ArmResourceRead<NotificationSessionResource>;

  /** Lists notification sessions in a location */
  listByLocation is ArmResourceListByParent<NotificationSessionResource>;

  /** Creates or updates a notification session */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "This is a valid final state for a PUT operation"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NotificationSessionResource>;

  /** Deletes a notification session */
  delete is ArmResourceDeleteSync<NotificationSessionResource>;

  /** Gets session details for connecting to a notification session */
  getSessionDetails is ArmResourceActionSync<
    NotificationSessionResource,
    GetSessionDetailsRequest,
    GetNotificationSessionDetails
  >;
}
