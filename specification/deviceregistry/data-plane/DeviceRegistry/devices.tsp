import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Device resource
// ──────────────────────────────────────────────

/** A device resource. */
@resource("devices")
@parentResource(Namespace)
model Device {
  /** The name of the device. */
  @key("deviceName")
  @visibility(Lifecycle.Read)
  deviceName: string;

  // TODO: Add device fields (name, state, capabilities, credentials, etc.)
}

// ──────────────────────────────────────────────
// Device operation models
// ──────────────────────────────────────────────

/** Request body for looking up a device by its UUID. */
model GetDeviceByUuidRequest {
  /** The unique identifier of the device. */
  deviceUuid: string;
}

/** Request body for querying enqueued C2D messages for a device. */
@added(Versions.v2026_11_02_preview)
model GetEnqueuedMessagesRequest {
  /** The name of the device. */
  deviceName: string;
}

/** Result of querying enqueued C2D messages for a device. */
model GetEnqueuedMessagesResult {
  /** The number of cloud-to-device messages currently queued for the device. */
  enqueuedMessageCount: int32;
}

/** The connectivity status of a device. */
union ConnectivityStatus {
  string,

  /** The device is connected. */
  Connected: "Connected",

  /** The device is disconnected. */
  Disconnected: "Disconnected",

  /** The connectivity status of the device is unknown. */
  Unknown: "Unknown",
}

/** Request body for querying the connectivity status of a device. */
@added(Versions.v2026_11_02_preview)
model GetConnectivityStatusRequest {
  /** The name of the device. */
  deviceName: string;
}

/** Result of querying the connectivity status of a device. */
model GetConnectivityStatusResult {
  /** The connectivity status of the device. */
  connectivityStatus: ConnectivityStatus;
}

/** Request body for looking up a device by its external identifier. */
@added(Versions.v2026_11_02_preview)
model GetDeviceByExternalIdRequest {
  /** The external identifier of the device. */
  externalId: string;
}

/** A reference to a group that a device belongs to. */
@added(Versions.v2026_11_02_preview)
model GroupReference {
  /** The unique identifier of the group. */
  groupUuid: string;
}

/** Result of querying group memberships for a device. */
@added(Versions.v2026_11_02_preview)
model GetGroupMembershipsResult {
  /** The groups that this device belongs to. */
  groups: GroupReference[];
}

/** Request body for querying group memberships of a device. */
@added(Versions.v2026_11_02_preview)
model GetGroupMembershipsRequest {
  /** The unique identifier of the device. */
  deviceUuid: string;
}

/** Request body for looking up a device capability by its UUID. */
@added(Versions.v2026_11_02_preview)
model GetDeviceCapabilityByUuidRequest {
  /** The unique identifier of the device. */
  deviceUuid: string;

  /** The unique identifier of the device capability. */
  capabilityUuid: string;
}

/** Request body for bulk importing devices into a namespace. */
@added(Versions.v2026_11_02_preview)
model ImportDevicesRequest {
  // TODO: Add device import fields (device resource, state, capabilities, credentials, etc.)
}

/** Result of a bulk device import operation. */
@added(Versions.v2026_11_02_preview)
model ImportDevicesResult {
  // TODO: Add import result fields
}

/** Request body for bulk updating devices in a namespace. */
@added(Versions.v2026_11_02_preview)
model UpdateDevicesRequest {
  // TODO: Add device update fields (device UUID, resource, state, capabilities, credentials, etc.)
}

/** Result of a bulk device update operation. */
@added(Versions.v2026_11_02_preview)
model UpdateDevicesResult {
  // TODO: Add update result fields
}

/** Result of a bulk device export operation. */
@added(Versions.v2026_11_02_preview)
model ExportDevicesResult {
  // TODO: Add export result fields (device resource, state, twin properties, capabilities, credentials, etc.)
}

/** Request body for querying devices. */
@added(Versions.v2026_11_02_preview)
model QueryDevicesRequest {
  // TODO: Add query parameters (filter, projection, etc.)
}

/** Result of a device query operation. */
@added(Versions.v2026_11_02_preview)
model QueryDevicesResult {
  // TODO: Add query result fields
}

/** Request body for executing a direct method action on a device. */
@added(Versions.v2026_11_02_preview)
model ExecuteActionRequest {
  // TODO: Add direct method invocation fields (method name, payload, timeout, etc.)
}

/** Result of executing a direct method action on a device. */
@added(Versions.v2026_11_02_preview)
model ExecuteActionResult {
  // TODO: Add direct method result fields (status, payload, etc.)
}

// ──────────────────────────────────────────────
// Devices interface
// ──────────────────────────────────────────────

/** Operations on devices within a namespace. */
@tag("Devices")
interface Devices {
  // ── Public operations (2026-11-01-preview) ──

  /** Look up a device by its unique identifier. */
  getDeviceByUuid is ResourceOperations.ResourceCollectionAction<
    Device,
    GetDeviceByUuidRequest,
    Device
  >;

  // ── Internal operations (2026-11-02-preview) ──

  /** Get the number of C2D messages currently queued for a device. */
  @added(Versions.v2026_11_02_preview)
  getEnqueuedMessages is ResourceOperations.ResourceCollectionAction<
    Device,
    GetEnqueuedMessagesRequest,
    GetEnqueuedMessagesResult
  >;

  /** Get the status of device connectivity in Hub. */
  @added(Versions.v2026_11_02_preview)
  getConnectivityStatus is ResourceOperations.ResourceCollectionAction<
    Device,
    GetConnectivityStatusRequest,
    GetConnectivityStatusResult
  >;

  /** Bulk import devices into a namespace. Used by DPS during provisioning. */
  @added(Versions.v2026_11_02_preview)
  importDevices is ResourceOperations.LongRunningResourceCollectionAction<
    Device,
    ImportDevicesRequest,
    ImportDevicesResult
  >;

  /** Bulk update devices in a namespace. Used by DPS during reprovisioning. */
  @added(Versions.v2026_11_02_preview)
  updateDevices is ResourceOperations.LongRunningResourceCollectionAction<
    Device,
    UpdateDevicesRequest,
    UpdateDevicesResult
  >;

  /** Bulk export all device details from a namespace. */
  @added(Versions.v2026_11_02_preview)
  exportDevices is ResourceOperations.LongRunningResourceCollectionAction<
    Device,
    {},
    ExportDevicesResult
  >;

  /** Look up a device by its external identifier. */
  @added(Versions.v2026_11_02_preview)
  getDeviceByExternalId is ResourceOperations.ResourceCollectionAction<
    Device,
    GetDeviceByExternalIdRequest,
    Device
  >;

  /** Returns the groups that this device belongs to. */
  @added(Versions.v2026_11_02_preview)
  getGroupMemberships is ResourceOperations.ResourceCollectionAction<
    Device,
    GetGroupMembershipsRequest,
    GetGroupMembershipsResult
  >;

  /** Get a device capability by its unique identifier. */
  @added(Versions.v2026_11_02_preview)
  getDeviceCapabilityByUuid is ResourceOperations.ResourceCollectionAction<
    Device,
    GetDeviceCapabilityByUuidRequest,
    DeviceCapability
  >;

  /** Query devices in a namespace. */
  @added(Versions.v2026_11_02_preview)
  queryDevices is ResourceOperations.ResourceCollectionAction<
    Device,
    QueryDevicesRequest,
    QueryDevicesResult
  >;

  /** Invoke a direct method action on a device. */
  @added(Versions.v2026_11_02_preview)
  executeAction is ResourceOperations.LongRunningResourceCollectionAction<
    Device,
    ExecuteActionRequest,
    ExecuteActionResult
  >;
}
