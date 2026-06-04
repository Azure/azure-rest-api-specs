import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "../common/deviceTypes.tsp";
import "./deviceCapabilities.tsp";
import "./deviceAuthenticationProfiles.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.Core.Foundations;
using Azure.Core.Traits;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Device resource
// Shared types (DeviceEnabledStatus) are defined
// in specification/deviceregistry/common/deviceTypes.tsp.
// ──────────────────────────────────────────────

/** A device resource. */
@resource("devices")
@parentResource(Namespace)
model Device {
  ...DataPlaneResourceBase;

  /** The resource-specific properties for this device. */
  properties?: DeviceProperties;
}

@@key(Device.name, "deviceName");

/** Properties of a device resource. */
model DeviceProperties {
  ...OmitProperties<DevicePropertiesBase, "uuid">;

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/** Response model for device lookup POST actions (excludes deviceName key). */
model DeviceResponse {
  ...DataPlaneResourceBase;

  /** The resource-specific properties for this device. */
  properties?: DeviceProperties;
}

// ──────────────────────────────────────────────
// Device operation models
// ──────────────────────────────────────────────

/** Request for looking up a device by its UUID. */
model GetDeviceByUuidRequest {
  /** The unique identifier of the device. */
  @query
  deviceUuid: string;

  /** Whether to include extended device information in the response. */
  @query
  expandInfo?: boolean;
}

/** Request for looking up a device by its external identifier. */
model GetDeviceByExternalIdRequest {
  /** The external identifier of the device. */
  @query
  externalDeviceId: string;

  /** Whether to include extended device information in the response. */
  @query
  expandInfo?: boolean;
}

/** Request body for querying devices in a namespace. */
model QueryDevicesRequest {
  /** The query expression to evaluate against devices in the namespace. */
  query: string;

  /** Maximum number of results to return in this page. */
  top?: int32;

  /** Opaque continuation token returned by a previous query response. */
  continuationToken?: string;
}

/** Response body for a device query: a page of projected results. */
model QueryDevicesResponse {
  /** The page of query results. Each element is a projected JSON document whose shape is determined by the query. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Query projections can return arbitrary shapes."
  value: Record<unknown>[];

  /** Continuation token for retrieving the next page of results. Present only when more results exist. */
  continuationToken?: string;
}

/** Device twin desired properties. */
model TwinProperties {
  /** The desired properties to set on the device twin. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Device twin desired properties require Record<unknown> to support arbitrary value types."
  desired?: Record<unknown>;
}

/** Initial device twin configuration to apply during provisioning. */
model DeviceTwin {
  /** Device twin tags. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Device twin tags require Record<unknown> to support arbitrary value types."
  tags?: Record<unknown>;

  /** The device twin properties. */
  properties?: TwinProperties;
}

/** Request body for the provision device endpoint. */
model ProvisionDeviceRequest {
  /** The device identity in IoT Hub. */
  iotHubDeviceId: string;

  /** The service endpoint identifier as returned by the GetNamespace API. */
  targetEndpoint: IotHubEndpoint;

  /** Operational authentication configuration. */
  authentication: AuthenticationProfileProperties;

  /** Initial device twin configuration to apply during provisioning. */
  deviceTwin?: DeviceTwin;
}

/** Result of a successful device provisioning operation. */
model ProvisionDeviceResult {
  /** Unique device identifier assigned by the system. */
  deviceUuid: string;

  /** ARM resource ID of the provisioned device. */
  deviceResourceId: string;

  /** External device ID (IoT Hub device ID). */
  externalDeviceId: string;

  /** Name of the messaging endpoint the device is connected to. */
  messagingEndpointName: string;
}

// ──────────────────────────────────────────────
// Provision-device status monitor endpoint
// ──────────────────────────────────────────────

/**
 * Status monitor for the long-running `:provision` action on devices in a
 * namespace. Mirrors the shape of the central `Operation` resource but
 * exposes a typed `result` so SDK callers receive the strongly-typed
 * `ProvisionDeviceResult` payload directly.
 */
@parentResource(Namespace)
@resource("provisionDeviceOperations")
model ProvisionDeviceOperation {
  /** The unique identifier of the operation. */
  @key("operationId")
  @visibility(Lifecycle.Read)
  id: string;

  /** The current status of the operation. */
  @Azure.Core.lroStatus
  @visibility(Lifecycle.Read)
  status: Azure.Core.Foundations.OperationState;

  /** Error details when the operation failed. */
  @visibility(Lifecycle.Read)
  error?: Azure.Core.Foundations.Error;

  /** The time at which the operation was started (UTC). */
  @visibility(Lifecycle.Read)
  executedAt?: utcDateTime;

  /** The time at which the operation result expires (UTC). */
  @visibility(Lifecycle.Read)
  expiresAt?: utcDateTime;

  /** The result of the device-provisioning operation, available once `status` is `Succeeded`. */
  @visibility(Lifecycle.Read)
  result?: ProvisionDeviceResult;
}

// ──────────────────────────────────────────────
// Devices interface
// ──────────────────────────────────────────────

/** Operations on devices within a namespace. */
@tag("Devices")
interface Devices {
  /** Look up a device by its unique identifier. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  getDeviceByUuid is ResourceOperations.ResourceCollectionAction<
    Device,
    GetDeviceByUuidRequest,
    DeviceResponse
  >;

  /** Look up a device by its external identifier. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  getDeviceByExternalId is ResourceOperations.ResourceCollectionAction<
    Device,
    GetDeviceByExternalIdRequest,
    DeviceResponse
  >;

  /** Query devices in a namespace using a query expression. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  query is ResourceOperations.ResourceCollectionAction<
    Device,
    QueryDevicesRequest,
    QueryDevicesResponse
  >;

  /** Provision a device in a namespace. */
  @pollingOperation(ProvisionDeviceOperations.get)
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  provision is ResourceOperations.LongRunningResourceCollectionAction<
    Device,
    ProvisionDeviceRequest & OperationIdHeaderParameter,
    ProvisionDeviceResult,
    Azure.Core.Foundations.Error,
    ResponseHeadersTrait<
      Azure.Core.Foundations.RetryAfterHeader,
      TraitContext.Action
    >
  >;
}

/** Polling operations for the long-running `:provision` action on devices. */
@tag("Devices")
interface ProvisionDeviceOperations {
  /** Get the status of a device-provisioning operation. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Intentional: keep this GET grouped with Devices in generated SDK clients."
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  // Override the emitted operationId to surface this status monitor under
  // the `Devices` SDK client (matches the wire-side `Devices_Provision`
  // action that produces these operations) rather than as a top-level
  // `ProvisionDeviceOperations_Get` method.
  @operationId("Devices_GetProvisionDeviceOperation")
  get is ResourceOperations.ResourceRead<
    ProvisionDeviceOperation,
    ResponseHeadersTrait<
      Azure.Core.Foundations.RetryAfterHeader,
      TraitContext.Read
    >
  >;
}
