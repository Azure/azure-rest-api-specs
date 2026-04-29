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

  /** The error information for why linking failed. */
  @visibility(Lifecycle.Read)
  provisioningError?: ProvisioningError;
}

/** The device capability properties for an IoTHub capability */
model IotHubDeviceCapabilityProperties extends DeviceCapabilityProperties {
  /** Discriminator for IoT Hub capability. */
  capabilityType: CapabilityType.IoTHub;
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
