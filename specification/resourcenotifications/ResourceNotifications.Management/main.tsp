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
@doc("Microsoft.ResourceNotifications Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.ResourceNotifications;

/** ResourceNotifications RP API Versions */
enum Versions {
  /** 2025-08-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_08_01_preview: "2025-08-01-preview",
}

/** The Azure Resource Manager Operations interface. */
interface Operations extends Azure.ResourceManager.Operations {}

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
 * Tenant Location Resource definition
 */

/** Properties for a tenant location resource. */
model TenantLocationProperties {
  /** The display name of the location. */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /** The regional display name of the location. */
  @visibility(Lifecycle.Read)
  regionalDisplayName?: string;

  /** Additional metadata for the location. */
  @visibility(Lifecycle.Read)
  additionalProperties?: string;

  /** The provisioning state of the location. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Tenant location resource that represents an Azure location at tenant scope. */
model TenantLocationResource
  is Azure.ResourceManager.ProxyResource<TenantLocationProperties> {
  /** The name of the location. */
  @key
  @path
  @segment("locations")
  @pattern("^[a-z0-9]+$")
  @visibility(Lifecycle.Read)
  locationName: string;
}

/*
 * Notification Sessions resource definition (Location-scoped within tenant)
 */

/** Properties for a notification session. */
model NotificationSessionProperties {
  /** Description of the notification session. */
  description?: string;

  /** The status of the notification session. */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  status?: NotificationSessionStatus;

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

/** A notification session resource that operates within a specific location at tenant scope. */
@parentResource(TenantLocationResource)
model NotificationSessionResource
  is Azure.ResourceManager.ProxyResource<NotificationSessionProperties> {
  /** Name of the notification session. */
  @key
  @path
  @segment("notificationSessions")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @visibility(Lifecycle.Read)
  notificationSessionName: string;
}

/*
 * Error Models
 */

 /** Inner error details for server errors. */
model DefaultErrorDetails {
  /** The specific error code. */
  code?: string;

  /** The error message. */
  message?: string;

  /** Stack trace information. */
  stackTrace?: string;
}

/** Inner error details for server errors. */
model InnerErrorDetails {
  /** The specific error code. */
  code?: string;

  /** The error message. */
  message?: string;

  /** Stack trace information. */
  stackTrace?: string;
}

/** Bad request error details. */
model BadRequestErrorDetails {
  /** Error code indicating the type of bad request. */
  code: string;

  /** Detailed error message. */
  message: string;

  /** The target of the error. */
  target?: string;

  /** Additional error details. */
  details?: string[];
}

/** Too many requests error details. */
model TooManyRequestsErrorDetails {
  /** Error code indicating the type of rate limiting error. */
  code: string;

  /** Detailed error message. */
  message: string;

  /** Additional error information. */
  innerError?: InnerErrorDetails;
}

/** Unauthorized error details. */
model UnauthorizedErrorDetails {
  /** Error code indicating the type of authorization error. */
  code: string;

  /** Detailed error message. */
  message: string;

  /** Additional error information. */
  innerError?: InnerErrorDetails;
}

/** Internal server error details. */
model InternalServerErrorDetails {
  /** Error code indicating the type of internal error. */
  code: string;

  /** Detailed error message. */
  message: string;

  /** Additional error information. */
  innerError?: InnerErrorDetails;
}

@error
@extension("x-ms-error-response", true)
@doc("Error response for bad request.")
model Default {
  /** Error details for bad request. */
  error: DefaultErrorDetails;
}

@error
@extension("x-ms-error-response", true)
@doc("Error response for bad request.")
model BadRequestError {
  /** Error details for bad request. */
  error: BadRequestErrorDetails;
}

@error
@extension("x-ms-error-response", true)
@doc("Error response for too many requests.")
model TooManyRequests {
  /** Error details for too many requests. */
  error: TooManyRequestsErrorDetails;
}

@error
@extension("x-ms-error-response", true)
@doc("Error response for unauthorized.")
model Unauthorized {
  /** Error details for unauthorized. */
  error: UnauthorizedErrorDetails;
}

@error
@extension("x-ms-error-response", true)
@doc("Error response for internal server error.")
model InternalServerError {
  /** Error details for internal server error. */
  error: InternalServerErrorDetails;
}

/*
 * Request/Response Models for Operations
 */

/** Request model for get session details operation. */
model GetSessionDetailsRequest {
  /** Duration in minutes for which the session details are valid. */
  durationInMinutes: int32;
}

/** Connection details for a notification session. */
model NotificationSessionConnectionDetails {
  /** Connection string for the session. */
  connectionString?: string;

  /** Endpoint to connect to. */
  endpoint?: string;
}

/** Response model for get session details operation. */
model GetSessionDetailsResponse {
  /** The resource ID. */
  id?: string;

  /** Encoded notification session containing signed session id with content. */
  encodedNotificationSession?: string;

  /** Connection details for the session. */
  connectionDetails?: NotificationSessionConnectionDetails;

  /** Timestamp until which the session is valid. */
  validUntil?: utcDateTime;
}

/** Response model for close session operation. */
model CloseSessionResponse {
  /** Success message for the close session operation. */
  message?: string;
}

/** Response model for create notification session operation. */
model CreateNotificationSessionResponse {
  @doc("The resource ID.")
  id?: string;

  @doc("The resource name.")
  name?: string;

  @doc("The resource type.")
  type?: string;

  @doc("The location of the resource.")
  location?: string;

  @doc("The properties of the notification session.")
  properties?: NotificationSessionProperties;

  @doc("The system metadata related to this resource.")
  systemData?: Azure.ResourceManager.CommonTypes.SystemData;
}

/*
 * Operations Interface - Custom Operations
 */

/** Operations for notification sessions. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "These are custom operations for notification sessions, not standard ARM resource operations"
@tag("NotificationsSessions")
interface NotificationsSessions {
  /** Create a notification session. */
  @post
  @route("/providers/Microsoft.ResourceNotifications/locations/{location}/notificationSessions/{notificationSessionName}")
  createNotificationSession(
    @doc("The location name.")
    @path
    @pattern("^[a-z0-9]+$")
    location: string,

    @doc("Name of the notification session.")
    @path
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
    notificationSessionName: string,

    ...ApiVersionParameter,
  ):
    | {
        @statusCode _: 200;
        @body body: CreateNotificationSessionResponse;
      }
    | {
        @statusCode _: 201;
        @body body: CreateNotificationSessionResponse;
      }
    | {
        @statusCode _: 202;
        @header location?: string;
        @header("Retry-After") retryAfter?: string;
      }
    | {
        @statusCode _: 400;
        @body body: BadRequestError;
      }
    | {
        @statusCode _: 401;
        @body body: Unauthorized;
      }
    | {
        @statusCode _: 429;
        @body body: TooManyRequests;
      }
    | {
        @statusCode _: 500;
        @body body: InternalServerError;
      }
    | {
        @statusCode _: "default";
        @body body: Default;
      };

  /** Get session details. */
  @post
  @route("/providers/Microsoft.ResourceNotifications/locations/{location}/notificationSessions/{notificationSessionId}/getSessionDetails")
  getSessionDetails(
    @doc("The location name.")
    @path
    @pattern("^[a-z0-9]+$")
    location: string,

    @doc("ID of the notification session.")
    @path
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
    notificationSessionId: string,

    @doc("Request body containing session details parameters.")
    @body
    body: GetSessionDetailsRequest,

    ...ApiVersionParameter,
  ):
    | {
        @statusCode _: 200;
        @body body: GetSessionDetailsResponse;
      }
    | {
        @statusCode _: 400;
        @body body: BadRequestError;
      }
    | {
        @statusCode _: 401;
        @body body: Unauthorized;
      }
    | {
        @statusCode _: 500;
        @body body: InternalServerError;
      }
    | {
        @statusCode _: "default";
        @body body: Default;
      };

  /** Close the session. */
  @post
  @route("/providers/Microsoft.ResourceNotifications/locations/{location}/notificationSessions/{notificationSessionId}/closeSession")
  closeSession(
    @doc("The location name.")
    @path
    @pattern("^[a-z0-9]+$")
    location: string,

    @doc("ID of the notification session.")
    @path
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
    notificationSessionId: string,

    ...ApiVersionParameter,
  ):
    | {
        @statusCode _: 200;
        @body body: CloseSessionResponse;
      }
    | {
        @statusCode _: 400;
        @body body: BadRequestError;
      }
    | {
        @statusCode _: 401;
        @body body: Unauthorized;
      }
    | {
        @statusCode _: 500;
        @body body: InternalServerError;
      }
    | {
        @statusCode _: "default";
        @body body: Default;
      };
}
