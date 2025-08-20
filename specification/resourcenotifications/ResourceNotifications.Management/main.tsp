import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.ResourceNotifications Management Service" })
@doc("Microsoft.ResourceNotifications Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.ResourceNotifications;

/** ResourceNotifications RP API Versions */
enum Versions {
  /** 2025-08-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2025-08-01-preview`,
}

/*
 * Common enums and unions
 */

/** The status of a notification session. */
union NotificationSessionStatus {
  string,

  /** The session is active and processing notifications */
  Active: "Active",

  /** The session is paused and not processing notifications */
  Paused: "Paused",

  /** The session has completed */
  Completed: "Completed",

  /** The session has failed */
  Failed: "Failed",
}

/** The provisioning state of the resource. */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned. */
  Provisioning: "Provisioning",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The resource provisioning request has been accepted. */
  Accepted: "Accepted",

  string,
}

/*
 * Notification Sessions resource definition (Tenant-scoped location-based)
 */

/** Properties for a notification session. */
model NotificationSessionProperties {
  /** Description of the notification session. */
  description?: string;

  /** The status of the notification session. */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  status?: NotificationSessionStatus = NotificationSessionStatus.Active;

  /** The maximum duration for the session in minutes. */
  maxDurationMinutes?: int32;

  /** The start time of the session. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  startTime?: utcDateTime;

  /** The end time of the session. */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /** Configuration settings as key-value pairs. */
  configuration?: string;

  /** Statistics about notifications processed in this session. */
  @visibility(Lifecycle.Read)
  statistics?: NotificationSessionStatistics;

  /** The provisioning state of the notification session. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The date and time when the session was created. */
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  /** The date and time when the session was last updated. */
  @visibility(Lifecycle.Read)
  updatedAt?: utcDateTime;
}

/** Statistics for a notification session. */
model NotificationSessionStatistics {
  /** Total number of notifications processed. */
  @visibility(Lifecycle.Read)
  totalNotificationsProcessed?: int32;

  /** Number of notifications that were successfully delivered. */
  @visibility(Lifecycle.Read)
  successfulDeliveries?: int32;

  /** Number of notifications that failed to be delivered. */
  @visibility(Lifecycle.Read)
  failedDeliveries?: int32;

  /** Average processing time per notification in milliseconds. */
  @visibility(Lifecycle.Read)
  averageProcessingTimeMs?: int32;
}

/** A notification session resource that operates at tenant scope within a specific location. */
model NotificationSessionResource is ProxyResource<NotificationSessionProperties> {
  /** Name of the notification session. */
  @key("sessionName")
  @segment("notificationsSessions")
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @visibility(Lifecycle.Read)
  name: string;
}

/*
 * Microsoft.ResourceNotifications RP interface definitions
 */

interface Operations extends Azure.ResourceManager.Operations {}

/** Operations for notification sessions at tenant scope with location. */
interface NotificationsSessions {
  /** Create or update a notification session. */
  @put
  @route("/providers/Microsoft.ResourceNotifications/locations/{locationName}/notificationsSessions/{sessionName}")
  createOrUpdate(
    @doc("The location name.")
    @path
    @pattern("^[a-z0-9]+$")
    locationName: string,
    
    @doc("Name of the notification session.")
    @path
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
    sessionName: string,
    
    @doc("The notification session resource.")
    @body 
    resource: NotificationSessionResource,
    
    ...ApiVersionParameter,
  ): ArmResponse<NotificationSessionResource> | ArmCreatedResponse<NotificationSessionResource> | ErrorResponse;
  
  /** Get a notification session. */
  @get
  @route("/providers/Microsoft.ResourceNotifications/locations/{locationName}/notificationsSessions/{sessionName}")
  get(
    @doc("The location name.")
    @path
    @pattern("^[a-z0-9]+$")
    locationName: string,
    
    @doc("Name of the notification session.")
    @path
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
    sessionName: string,
    
    ...ApiVersionParameter,
  ): ArmResponse<NotificationSessionResource> | ErrorResponse;
  
  /** Delete a notification session. */
  @delete
  @route("/providers/Microsoft.ResourceNotifications/locations/{locationName}/notificationsSessions/{sessionName}")
  delete(
    @doc("The location name.")
    @path
    @pattern("^[a-z0-9]+$")
    locationName: string,
    
    @doc("Name of the notification session.")
    @path
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
    sessionName: string,
    
    ...ApiVersionParameter,
  ): ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse | ErrorResponse;
  
  /** List all notification sessions in a location. */
  @get
  @route("/providers/Microsoft.ResourceNotifications/locations/{locationName}/notificationsSessions")
  listByLocation(
    @doc("The location name.")
    @path
    @pattern("^[a-z0-9]+$")
    locationName: string,
    
    ...ApiVersionParameter,
  ): ArmResponse<ResourceListResult<NotificationSessionResource>> | ErrorResponse;
}