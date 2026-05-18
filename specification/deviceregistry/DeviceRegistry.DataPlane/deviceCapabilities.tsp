import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "./devices.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Device capability resource
// NOTE: DeviceCapabilityProperties is aligned with the control plane capability models.
// Keep in sync when making changes.
// ──────────────────────────────────────────────

/** A device capability resource. */
@resource("capabilities")
@parentResource(Device)
model DeviceCapability {
  ...DataPlaneResourceBase;

  /** The resource-specific properties for this capability. */
  properties?: DeviceCapabilityProperties;
}

@@key(DeviceCapability.name, "capabilityName");

/** Properties of a device capability resource. */
@discriminator("capabilityType")
model DeviceCapabilityProperties {
  /** The type of this device capability resource. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  capabilityType: CapabilityType;

  /** The name given to the capability provider on the namespace resource. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  capabilityProvider: string;

  /** The provisioning status of this capability. */
  @visibility(Lifecycle.Read)
  provisioningState?: CapabilityProvisioningState;

  /** Whether a capability is enabled or disabled. */
  activationState: DeviceCapabilityActivationState;
}

/** Whether a capability is enabled or disabled. */
union DeviceCapabilityActivationState {
  string,

  /** The capability is enabled. */
  Enabled: "Enabled",

  /** The capability is disabled. */
  Disabled: "Disabled",
}

/** The authentication type for IoT Hub. */
union IotHubAuthenticationType {
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

/** Certificate authority credentials for device provisioning. */
model CertificateAuthorityCredentials {
  /** ADR certificate policy resource ID. */
  adrCertificatePolicyResourceId: string;
}

/** Operational authentication information for device provisioning. */
model IotHubAuthentication {
  /** The authentication type. */
  type: IotHubAuthenticationType;

  /** Symmetric key details. Required when type is SymmetricKey. */
  symmetricKey?: SymmetricKeyCredentials;

  /** Certificate authority credentials. Required when type is CertificateAuthority. */
  certificateAuthority?: CertificateAuthorityCredentials;

  /** Self-signed X.509 thumbprints. Required when type is SelfSignedX509Certificate. */
  selfSignedThumbprints?: SelfSignedThumbprints;
}

/** IoT Hub endpoint target for device provisioning. */
model IotHubEndpoint {
  /** Display name of the target endpoint. */
  name: string;

  /** IoT Hub service endpoint address (e.g. myhub.azure-devices.net). */
  address: string;
}

/** The device capability properties for an IoTHub capability */
model IotHubDeviceCapabilityProperties extends DeviceCapabilityProperties {
  /** Discriminator for IoT Hub capability. */
  capabilityType: CapabilityType.IoTHub;

  /** IoT Hub's authentication information. */
  authentication: IotHubAuthentication;

  /** The IoT Hub's endpoint. */
  endpoint: IotHubEndpoint;
}

/** The provisioning state of a device capability. */
union CapabilityProvisioningState {
  string,

  /** The capability is being linked. */
  Linking: "Linking",

  /** The capability has been successfully provisioned. */
  Succeeded: "Succeeded",

  /** The capability provisioning has failed. */
  Failed: "Failed",

  /** The capability is being deleted. */
  Deleting: "Deleting",

  /** The capability has been deleted. */
  Deleted: "Deleted",
}

/** The type of a device capability. */
union CapabilityType {
  string,

  /** IoT Hub connection. */
  IoTHub: "IoTHub",
}

/** Error information for provisioning failures. */
model ProvisioningError {
  /** The error code. */
  code?: string;

  /** The error message. */
  message?: string;

  /** The error target. */
  target?: string;
}

// ──────────────────────────────────────────────
// DeviceCapabilities operation models
// ──────────────────────────────────────────────

/** Request for looking up a capability by its UUID. */
model GetCapabilityByUuidRequest {
  /** The unique identifier of the capability. */
  @query
  capabilityUuid: string;
}

// ──────────────────────────────────────────────
// DeviceCapabilities interface
// ──────────────────────────────────────────────

/** CRUD operations on device capabilities. */
@tag("Device Capabilities")
interface DeviceCapabilities {
  /** Create or replace a device capability. */
  @pollingOperation(Operations.get)
  createOrReplace is ResourceOperations.LongRunningResourceCreateOrReplace<DeviceCapability>;

  /** Get a device capability. */
  get is ResourceOperations.ResourceRead<DeviceCapability>;

  /** Update a device capability. */
  update is ResourceOperations.ResourceCreateOrUpdate<DeviceCapability>;

  /** Delete a device capability. This is a long-running operation that tears down any provider-side resources (e.g. IoT Hub device registration) before removing the capability document. */
  @pollingOperation(Operations.get)
  delete is ResourceOperations.LongRunningResourceDelete<DeviceCapability>;

  /** List capabilities for a device. */
  list is ResourceOperations.ResourceList<DeviceCapability>;

  /** Look up a capability by its unique identifier. */
  getCapabilityByUuid is ResourceOperations.ResourceCollectionAction<
    DeviceCapability,
    GetCapabilityByUuidRequest,
    DeviceCapability
  >;
}
