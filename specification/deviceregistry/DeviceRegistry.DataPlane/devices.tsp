import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "../common/deviceTypes.tsp";
import "./common/provisionedRefs.tsp";
import "./common/longRunningOperation.tsp";
import "./deviceCapabilities.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.Core;

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
  provisioningState?: ProvisioningState;
}

// ──────────────────────────────────────────────
// Device operation models
// ──────────────────────────────────────────────

/** Request for looking up a device by its UUID. */
model GetDeviceByUuidRequest {
  /** The unique identifier of the device. */
  @query
  deviceUuid: string;
}

/** Request for looking up a device by its external identifier. */
model GetDeviceByExternalIdRequest {
  /** The external identifier of the device. */
  @query
  externalDeviceId: string;
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

/** Request body for counting devices in a namespace. */
@added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
model QueryCountRequest {
  /** Optional filter clause applied to the count (e.g. `WHERE properties.deviceClassId = 'dc-1'`). When omitted, all devices in the namespace are counted. */
  query?: string;
}

/** Response body for a device count: a single aggregate scalar. */
@added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
model QueryCountResponse {
  /** The number of devices in the namespace that match the supplied filter. */
  count: int64;
}

/** Request body for enumerating the distinct values of a single device field within a namespace. */
@added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
model QueryDistinctValuesRequest {
  /** The device field to project distinct values of (e.g. `properties.deviceClassId`). */
  field: string;

  /** Optional filter clause applied before the distinct projection (e.g. `WHERE groupMemberships.Contains('g-1')`). When omitted, distinct values across all devices in the namespace are returned. */
  query?: string;

  /** Maximum number of distinct values to return in this page. */
  top?: int32;

  /** Opaque continuation token returned by a previous distinct response. */
  continuationToken?: string;
}

/** Response body for a distinct device-field query: a page of scalar values. */
@added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
model QueryDistinctValuesResponse {
  /** The page of distinct scalar values for the requested field. */
  value: string[];

  /** Continuation token for retrieving the next page of distinct values. Present only when more results exist. */
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
@added(Versions.v2026_11_02_preview)
model ProvisionDeviceRequest {
  /** Controls which operations ADR performs. Defaults to full when omitted. */
  @query
  mode?: ProvisionMode;

  /** The Device ID provided by the customer. Also used by IoT Hub to hold the IoT Hub device ID. */
  iotHubDeviceId: string;

  /** The service endpoint identifier as returned by the GetNamespace API. */
  targetEndpoint: IotHubEndpoint;

  /** Operational authentication configuration. */
  authentication: AuthenticationProfileProperties;

  /** Initial device twin configuration to apply during provisioning. */
  deviceTwin?: DeviceTwin;
}

// ──────────────────────────────────────────────
// Provision mode
// ──────────────────────────────────────────────

/** Controls which operations ADR performs during provisioning. */
@added(Versions.v2026_11_02_preview)
union ProvisionMode {
  string,

  /** Full provisioning: ADR creates the device in IoT Hub and sets twin data. */
  Full: "Full",

  /** Registry-only provisioning: ADR creates registry resources but skips IoT Hub operations. Used when the device already exists in Hub. */
  RegistryOnly: "RegistryOnly",
}

/** Result of a successful device provisioning operation. Returns nested references to the Device, Capability, and AuthenticationProfile resources written by the orchestration, plus the messaging endpoint the device was provisioned against. */
@added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
model ProvisionDeviceResult {
  /** Reference to the provisioned Device resource. */
  device: ProvisionedDeviceRef;

  /** Reference to the provisioned Capability child resource. */
  capability: ProvisionedResourceRef;

  /** Reference to the provisioned AuthenticationProfile child resource. */
  authProfile: ProvisionedAuthProfileRef;

  /** Reference to the messaging endpoint the device was provisioned against. */
  endpoint: IotHubEndpoint;
}

// ──────────────────────────────────────────────
// Provision-device status monitor endpoint
// ──────────────────────────────────────────────

/** Status monitor for the long-running `:provision` action on devices in a namespace. */
@added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
@parentResource(Namespace)
@resource("provisionDeviceResults")
model ProvisionDeviceResultStatusMonitor
  is LongRunningOperationStatus<ProvisionDeviceResult>;

// ──────────────────────────────────────────────
// Reprovision device models
// ──────────────────────────────────────────────

/** The mode controlling how the device twin is populated on the new IoT Hub during reprovisioning. */
@added(Versions.v2026_11_02_preview)
union DeviceTwinMode {
  string,

  /** Copy tags and desired properties from the old hub to the new hub. */
  Migrate: "Migrate",

  /** Set tags and desired properties on the new hub to the caller-supplied values. Use with empty objects to reset the twin. */
  Replace: "Replace",
}

/** Device twin configuration for reprovisioning with an explicit mode. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance is required to extend DeviceTwin with the mode discriminator while preserving the existing wire shape."
@added(Versions.v2026_11_02_preview)
model ReprovisionDeviceTwin extends DeviceTwin {
  /** How to populate the device twin on the new IoT Hub. */
  mode: DeviceTwinMode;
}

/** Request body for the reprovision device endpoint. */
@added(Versions.v2026_11_02_preview)
model ReprovisionDeviceRequest {
  /** The ETag of the device resource. Used to prevent concurrent modifications. */
  @header("If-Match")
  ifMatch?: string;

  /** The target IoT Hub endpoint (the new hub) to move the device to. */
  targetEndpoint: IotHubEndpoint;

  /** Optional authentication configuration. If omitted, the device's existing AuthenticationProfile is preserved. If supplied, a new AuthenticationProfile is created and the old one is deleted after success. */
  authentication?: AuthenticationProfileProperties;

  /** Optional device twin configuration controlling how the new hub's twin is populated. If omitted, the new hub starts with an empty twin. */
  deviceTwin?: ReprovisionDeviceTwin;

  /** Optional device UUID guard. If supplied and does not match the device's stored UUID, the request is rejected. */
  deviceUuid?: string;
}

// ──────────────────────────────────────────────
// Reprovision-device status monitor endpoint
// ──────────────────────────────────────────────

/** Status monitor for the long-running `:reprovision` action on a device in a namespace. */
@added(Versions.v2026_11_02_preview)
@parentResource(Namespace)
@resource("reprovisionDeviceResults")
model ReprovisionDeviceResultStatusMonitor
  is LongRunningOperationStatus<ProvisionDeviceResult>;

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
    Device
  >;

  /** Look up a device by its external identifier. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  getDeviceByExternalId is ResourceOperations.ResourceCollectionAction<
    Device,
    GetDeviceByExternalIdRequest,
    Device
  >;

  /** Query devices in a namespace using a query expression. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  query is ResourceOperations.ResourceCollectionAction<
    Device,
    QueryDevicesRequest,
    QueryDevicesResponse
  >;

  /** Count devices in a namespace that match an optional filter. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  queryCount is ResourceOperations.ResourceCollectionAction<
    Device,
    QueryCountRequest,
    QueryCountResponse
  >;

  /** Query the distinct values of a single device field within a namespace. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  queryDistinctValues is ResourceOperations.ResourceCollectionAction<
    Device,
    QueryDistinctValuesRequest,
    QueryDistinctValuesResponse
  >;

  /** Provision a device in a namespace. */
  @pollingOperation(ProvisionDeviceResults.get)
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  provision is ResourceOperations.LongRunningResourceCollectionAction<
    Device,
    ProvisionDeviceRequest,
    ProvisionDeviceResult,
    Azure.Core.Foundations.Error,
    LongRunningActionResponseHeadersTrait
  >;

  /** Reprovision an existing device to a new IoT Hub within the same namespace. */
  @pollingOperation(ReprovisionDeviceResults.get)
  @added(Versions.v2026_11_02_preview)
  reprovision is ResourceOperations.LongRunningResourceAction<
    Device,
    ReprovisionDeviceRequest,
    ProvisionDeviceResult,
    Azure.Core.Foundations.Error,
    LongRunningActionResponseHeadersTrait
  >;
}

/** Polling operations for the long-running `:provision` action on devices. */
@added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
@tag("Devices")
interface ProvisionDeviceResults {
  /** Get the result of a device-provisioning operation. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Intentional: keep this GET grouped with Devices in generated SDK clients."
  // Override the emitted operationId to surface this status monitor under
  // the `Devices` SDK client (matches the wire-side `Devices_Provision`
  // action that produces these results) rather than as a top-level
  // `ProvisionDeviceResults_Get` method.
  @operationId("Devices_GetProvisionDeviceResult")
  get is ResourceOperations.ResourceRead<
    ProvisionDeviceResultStatusMonitor,
    LongRunningStatusMonitorResponseHeadersTrait
  >;
}

/** Polling operations for the long-running `:reprovision` action on a device. */
@added(Versions.v2026_11_02_preview)
@tag("Devices")
interface ReprovisionDeviceResults {
  /** Get the result of a device-reprovisioning operation. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Intentional: keep this GET grouped with Devices in generated SDK clients."
  // Override the emitted operationId to surface this status monitor under
  // the `Devices` SDK client (matches the wire-side `Devices_Reprovision`
  // action that produces these results) rather than as a top-level
  // `ReprovisionDeviceResults_Get` method.
  @operationId("Devices_GetReprovisionDeviceResult")
  get is ResourceOperations.ResourceRead<
    ReprovisionDeviceResultStatusMonitor,
    LongRunningStatusMonitorResponseHeadersTrait
  >;
}
