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
// NOTE: DeviceProperties is aligned with the control plane NewDeviceProperties model
// in specification/deviceregistry/DeviceRegistry.Management/newDevices.tsp.
// Keep in sync when making changes.
// ──────────────────────────────────────────────

/** A device resource. */
@resource("devices")
@parentResource(Namespace)
model Device {
  ...ResourceMetadata;

  /** The name of the device. */
  @key("deviceName")
  @visibility(Lifecycle.Read)
  deviceName: string;

  /** The resource-specific properties for this device. */
  properties?: DeviceProperties;
}

/** Properties of a device resource. */
model DeviceProperties {
  /** Globally unique, immutable, non-reusable ID. */
  @visibility(Lifecycle.Read)
  uuid?: string;

  /** Contains metadata about how this device was discovered or provisioned. */
  @visibility(Lifecycle.Read)
  origin?: DeviceOrigin;

  /** Whether a discovered or created device has been accepted for use. */
  accepted?: DeviceAcceptedStatus;

  /** Indicates if the device is enabled or not. */
  enabled?: DeviceEnabledStatus;

  /** The Device ID provided by the customer. Also used by IoT Hub to hold the IoT Hub device ID. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  externalDeviceId?: string;

  /** Device manufacturer. */
  manufacturer?: string;

  /** Device model. */
  @encodedName("application/json", "model")
  deviceModel?: string;

  /** Device operating system. */
  operatingSystem?: string;

  /** Device operating system version. */
  operatingSystemVersion?: string;

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/** Contains metadata about how this device was discovered or provisioned. */
model DeviceOrigin {
  /** The type of origin. */
  type?: DeviceOriginType;

  /** The source identifier for the origin. */
  sourceId?: string;
}

/** The origin type of a device. */
union DeviceOriginType {
  string,

  /** Device originated from Azure IoT Operations. */
  AIO: "AIO",

  /** Device originated from Device Provisioning Service. */
  DPS: "DPS",

  /** Device originated from ARM. */
  ARM: "ARM",
}

/** Whether a device has been accepted for use. */
union DeviceAcceptedStatus {
  string,

  /** The device has been accepted. */
  Accepted: "Accepted",

  /** The device has not been accepted. */
  NotAccepted: "NotAccepted",
}

/** Whether a device is enabled or disabled. */
union DeviceEnabledStatus {
  string,

  /** The device is enabled. */
  Enabled: "Enabled",

  /** The device is disabled. */
  Disabled: "Disabled",
}

/** Response model for device lookup POST actions (excludes deviceName key). */
model DeviceResponse {
  ...ResourceMetadata;

  /** The resource-specific properties for this device. */
  properties?: DeviceProperties;
}

// ──────────────────────────────────────────────
// Device operation models
// ──────────────────────────────────────────────

/** Request body for looking up a device by its UUID. */
model GetDeviceByUuidRequest {
  /** The unique identifier of the device. */
  deviceUuid: string;

  /** Whether to include extended device information in the response. */
  @query
  expandInfo?: boolean;
}

/** Request body for looking up a device by its external identifier. */
model GetDeviceByExternalIdRequest {
  /** The external identifier of the device. */
  externalId: string;

  /** Whether to include extended device information in the response. */
  @query
  expandInfo?: boolean;
}

/** A reference to a group that a device belongs to. */
model GroupReference {
  /** The unique identifier of the group. */
  groupUuid: string;
}

/** Result of querying group memberships for a device. */
model GetGroupMembershipsResult {
  ...ResourceMetadata;

  /** The groups that this device belongs to. */
  groups: GroupReference[];
}

/** Request body for provisioning devices in a namespace. */
model ProvisionDevicesRequest {
  // TODO: Add device provisioning fields
}

/** Result of a device provisioning operation. */
model ProvisionDevicesResult {
  ...ResourceMetadata;
}

/** Request body for executing a direct method action on a device. */
model ExecuteActionRequest {
  // TODO: Add direct method invocation fields (method name, payload, timeout, etc.)
}

/** Result of executing a direct method action on a device. */
model ExecuteActionResult {
  ...ResourceMetadata;
}

// ──────────────────────────────────────────────
// Devices interface
// ──────────────────────────────────────────────

/** Operations on devices within a namespace. */
@tag("Devices")
interface Devices {
  /** Look up a device by its unique identifier. */
  getDeviceByUuid is ResourceOperations.ResourceCollectionAction<
    Device,
    GetDeviceByUuidRequest,
    DeviceResponse
  >;

  /** Look up a device by its external identifier. */
  getDeviceByExternalId is ResourceOperations.ResourceCollectionAction<
    Device,
    GetDeviceByExternalIdRequest,
    DeviceResponse
  >;

  /** Returns the groups that this device belongs to. */
  getGroupMemberships is ResourceOperations.ResourceAction<
    Device,
    {},
    GetGroupMembershipsResult
  >;

  /** Provision devices in a namespace. */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling operation will be added in a future version."
  provision is ResourceOperations.LongRunningResourceCollectionAction<
    Device,
    ProvisionDevicesRequest,
    ProvisionDevicesResult
  >;

  /** Invoke a direct method action on a device. */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling operation will be added in a future version."
  executeAction is ResourceOperations.LongRunningResourceAction<
    Device,
    ExecuteActionRequest,
    ExecuteActionResult
  >;
}
