import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using OpenAPI;

@armProviderNamespace
@service(#{ title: "Microsoft.ResourceNotifications Management Service" })
@versioned(Versions)
namespace Microsoft.ResourceNotifications;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_08_01_preview: "2025-08-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

union NotificationSessionStatus {
  string,
  Active: "Active",
  Paused: "Paused",
  Completed: "Completed",
  Failed: "Failed",
}

@lroStatus
union ProvisioningState {
  Provisioning: "Provisioning",
  Updating: "Updating",
  Deleting: "Deleting",
  Accepted: "Accepted",
  Succeeded: "Succeeded",
  Failed: "Failed",
  Canceled: "Canceled",
  string,
}

model TenantLocationProperties {
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

model TenantLocationResource
  is Azure.ResourceManager.ProxyResource<TenantLocationProperties> {
  @key
  @path
  @segment("locations")
  @pattern("^[a-z0-9]+$")
  @visibility(Lifecycle.Read)
  locationName: string;
}

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

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  status?: NotificationSessionStatus;

  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

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

@parentResource(TenantLocationResource)
model NotificationSessionResource
  is Azure.ResourceManager.ProxyResource<NotificationSessionProperties> {
  @key
  @path
  @segment("notificationSessions")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @visibility(Lifecycle.Read)
  notificationSessionName: string;
}

model GetSessionDetailsRequest {
  @minValue(1)
  @maxValue(240)
  durationInMinutes?: int32;
}

model CreateNotificationSessionRequest {
  description?: string;

  @minValue(1)
  @maxValue(1440)
  maxDurationMinutes?: int32;

  configuration?: string;
}

model NotificationSessionConnectionDetails {
  connectionString?: string;
  endpoint?: string;
}

model GetSessionDetailsResponse {
  id?: string;
  encodedNotificationSession?: string;
  connectionDetails?: NotificationSessionConnectionDetails;
  validUntil?: utcDateTime;
}

model CloseSessionResponse {
  status: string;
  message?: string;
}

alias CreateNotificationSessionResponse = NotificationSessionResource;

@lroStatus
union OperationStatus {
  string,
  InProgress: "InProgress",
  Succeeded: "Succeeded",
  Failed: "Failed",
  Canceled: "Canceled",
}

interface NotificationsSessions {
  /** Create a notification session. */
  @put
  @extension("x-ms-long-running-operation", true)
  @route("/providers/Microsoft.ResourceNotifications/locations/{location}/notificationSessions/{notificationSessionName}")
  createNotificationSession(
    @path
    @pattern("^[a-z0-9]+$")
    location: string,

    @path
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
    notificationSessionName: string,

    @body body: CreateNotificationSessionRequest,
    ...ApiVersionParameter,
  ): {
    @statusCode _: 200;
    @body body: CreateNotificationSessionResponse;
  } | {
    @statusCode _: 201;
    @header("Retry-After") retryAfter?: int32;
    @body body: CreateNotificationSessionResponse;
  } | ErrorResponse;

  /** Get session details. */
  @post
  @route("/providers/Microsoft.ResourceNotifications/locations/{location}/notificationSessions/{notificationSessionId}:getSessionDetails")
  getSessionDetails(
    @path
    @pattern("^[a-z0-9]+$")
    location: string,

    @path
    @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
    notificationSessionId: string,

    @body body: GetSessionDetailsRequest,
    ...ApiVersionParameter,
  ): {
    @statusCode _: 200;
    @body body: GetSessionDetailsResponse;
  } | ErrorResponse;

  /** Delete a notification session and all its metadata. */
  @delete
  @route("/providers/Microsoft.ResourceNotifications/locations/{location}/notificationSessions/{notificationSessionId}")
  closeSession(
    @path
    @pattern("^[a-z0-9]+$")
    location: string,

    @path
    @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
    notificationSessionId: string,

    ...ApiVersionParameter,
  ): {
    @statusCode _: 204;
  } | {
    @statusCode _: 200;
    @body body: CloseSessionResponse;
  } | ErrorResponse;
}
