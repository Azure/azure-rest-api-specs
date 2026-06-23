import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "./devices.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Device capability resource
// ──────────────────────────────────────────────

/**
 * A device capability resource represents the device's connection to a service such as IoT Hub
 * or Device Update. It stores settings for the connection, including whether the service is
 * enabled for the device and the authentication profile the device uses to communicate
 * with the service.
 */
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

  /** IoT Hub's authentication profile. */
  authenticationProfileResourceId: string;

  /** The IoT Hub's endpoint. */
  endpoint: IotHubEndpoint;
}

/** The device capabilities properties for an update capability. */
model UpdateDeviceCapabilityProperties extends DeviceCapabilityProperties {
  /** Discriminator for Update capability. */
  capabilityType: CapabilityType.Update;

  /** Update's authentication profile. */
  authenticationProfileResourceId: string;
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

  /** Device Update connection. */
  Update: "Update",
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
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  createOrReplace is ResourceOperations.LongRunningResourceCreateOrReplace<DeviceCapability>;

  /** Get a device capability. */
  get is ResourceOperations.ResourceRead<DeviceCapability>;

  /** Update a device capability. */
  @pollingOperation(Operations.get)
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  update is ResourceOperations.LongRunningResourceCreateOrUpdate<DeviceCapability>;

  /** Delete a device capability. This is a long-running operation that tears down any provider-side resources (e.g. IoT Hub device registration) before removing the capability document. */
  @pollingOperation(Operations.get)
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  delete is ResourceOperations.LongRunningResourceDelete<DeviceCapability>;

  /** List capabilities for a device. */
  list is ResourceOperations.ResourceList<DeviceCapability>;

  /** Look up a capability by its unique identifier. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  getCapabilityByUuid is ResourceOperations.ResourceCollectionAction<
    DeviceCapability,
    GetCapabilityByUuidRequest,
    DeviceCapability
  >;
}
