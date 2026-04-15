import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "../../common/deviceTypes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Device resource
// Shared types (DeviceOriginType, DeviceAcceptedStatus, DeviceEnabledStatus) are defined
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
