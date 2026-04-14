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
  ...DataPlaneResourceBase;

  /** The resource-specific properties for this device. */
  properties?: DeviceProperties;
}

@@key(Device.name, "deviceName");

/** Properties of a device resource. */
model DeviceProperties {
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
  ...DataPlaneResourceBase;

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
  ...DataPlaneResourceBase;

  /** The groups that this device belongs to. */
  groups: GroupReference[];
}

/** The authentication type for device provisioning. */
union DeviceProvisioningAuthenticationType {
  string,

  /** Symmetric key authentication. */
  SymmetricKey: "SymmetricKey",

  /** X.509 certificate authentication. */
  X509Certificate: "X509Certificate",

  /** Self-signed X.509 certificate authentication. */
  SelfSignedX509Certificate: "SelfSignedX509Certificate",
}

/** Symmetric key credentials for device provisioning. */
model SymmetricKeyCredentials {
  /** The primary symmetric key. */
  primaryKey: string;

  /** The secondary symmetric key. */
  secondaryKey: string;
}

/** Self-signed certificate thumbprints for device provisioning. */
model SelfSignedThumbprints {
  /** The primary self-signed certificate thumbprint. */
  primaryThumbprint: string;

  /** The secondary self-signed certificate thumbprint. */
  secondaryThumbprint: string;
}

/** Authentication configuration for device provisioning. */
model DeviceProvisioningAuthentication {
  /** The operational authentication type. */
  type: DeviceProvisioningAuthenticationType;

  /** Symmetric key credentials. Required when type is SymmetricKey. */
  symmetricKey?: SymmetricKeyCredentials;

  /** The certificate authority identifier. Required when type is X509Certificate. */
  certificateAuthority?: string;

  /** Self-signed certificate thumbprints. Required when type is SelfSignedX509Certificate. */
  selfSignedThumbprints?: SelfSignedThumbprints;
}

/** Desired properties for the device twin. */
model DeviceTwinDesiredProperties {
  /** The desired properties to set on the device twin. */
  desired?: Record<string>;
}

/** Initial device twin configuration for provisioning. */
model DeviceTwin {
  /** Tags to set on the device twin. */
  tags?: Record<string>;

  /** The device twin properties. */
  properties?: DeviceTwinDesiredProperties;
}

/** Request body for provisioning devices in a namespace. */
model ProvisionDevicesRequest {
  /** The ID to use as the IoT Hub device identity. This must be the External Device ID. */
  externalDeviceId: string;

  /** The service endpoint identifier as returned by the GetNamespace API. */
  serviceEndpoint: string;

  /** The authentication configuration for the device. */
  authentication: DeviceProvisioningAuthentication;

  /** Optional initial device twin properties to set during provisioning. */
  deviceTwin?: DeviceTwin;
}

/** Result of a device provisioning operation. */
model ProvisionDevicesResult {
  ...DataPlaneResourceBase;
}

/** Request body for executing a direct method action on a device. */
model ExecuteActionRequest {
  // TODO: Add direct method invocation fields (method name, payload, timeout, etc.)
}

/** Result of executing a direct method action on a device. */
model ExecuteActionResult {
  ...DataPlaneResourceBase;
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
