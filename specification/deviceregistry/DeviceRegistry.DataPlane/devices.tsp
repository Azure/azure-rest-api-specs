import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "../common/deviceTypes.tsp";

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

  /** Certificate authority authentication. */
  CertificateAuthority: "CertificateAuthority",

  /** Self-signed X.509 certificate authentication. */
  SelfSignedX509Certificate: "SelfSignedX509Certificate",
}

/** Symmetric key authentication details. */
model SymmetricKeyCredentials {
  /** The primary symmetric key. */
  primaryKey: string;

  /** The secondary symmetric key. */
  secondaryKey: string;
}

/** Self-signed X.509 certificate thumbprints for device authentication. */
model SelfSignedThumbprints {
  /** Primary certificate thumbprint. */
  primaryThumbprint: string;

  /** Secondary certificate thumbprint. */
  secondaryThumbprint: string;
}

/** Operational authentication information for device provisioning. */
model DeviceProvisioningAuthentication {
  /** The authentication type. */
  type: DeviceProvisioningAuthenticationType;

  /** Symmetric key details. Required when type is SymmetricKey. */
  symmetricKey?: SymmetricKeyCredentials;

  /** Certificate authority credentials. Required when type is CertificateAuthority. */
  certificateAuthority?: CertificateAuthorityCredentials;

  /** Self-signed X.509 thumbprints. Required when type is SelfSignedX509Certificate. */
  selfSignedThumbprints?: SelfSignedThumbprints;
}

/** Certificate authority credentials for device provisioning. */
model CertificateAuthorityCredentials {
  /** ADR certificate policy resource ID. */
  adrCertificatePolicyResourceId: string;
}

/** IoT Hub endpoint target for device provisioning. */
model TargetEndpoint {
  /** Display name of the target endpoint. */
  name: string;

  /** IoT Hub service endpoint address (e.g. myhub.azure-devices.net). */
  address: string;
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
  targetEndpoint: TargetEndpoint;

  /** Operational authentication configuration. */
  authentication: DeviceProvisioningAuthentication;

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
  @pollingOperation(Operations.get)
  provision is ResourceOperations.LongRunningResourceCollectionAction<
    Device,
    ProvisionDeviceRequest,
    ProvisionDeviceResult
  >;

  /** Invoke a direct method action on a device. */
  @pollingOperation(Operations.get)
  executeAction is ResourceOperations.LongRunningResourceAction<
    Device,
    ExecuteActionRequest,
    ExecuteActionResult
  >;
}
