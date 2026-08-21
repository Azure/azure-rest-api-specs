namespace Microsoft.DeviceRegistry;

/** Represents the enablement state of a device. */
union RegistryDeviceEnablementState {
  string,

  /** The device is enabled. */
  Enabled: "Enabled",

  /** The device is disabled. All PUT/PATCH/POST APIs on the child resources will be blocked. */
  Disabled: "Disabled",
}

/** Common device properties shared across data-plane and control-plane. */
model RegistryDevicePropertiesBase {
  /** Whether the device is enabled or disabled. A disabled device cannot send messages, be updated, or reprovision. */
  enablementState: RegistryDeviceEnablementState;

  /** Globally unique, immutable, non-reusable ID. */
  @visibility(Lifecycle.Read)
  uuid?: string;

  /** A Device ID provided by the customer. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  externalDeviceId?: string;

  /** Device manufacturer. */
  manufacturer?: string;

  /** Device model. */
  `model`?: string;

  /** Device hardware revision. */
  hardwareRevision?: string;

  /** Device software revision. */
  softwareRevision?: string;
}
