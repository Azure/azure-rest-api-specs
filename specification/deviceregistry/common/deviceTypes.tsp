namespace Microsoft.DeviceRegistry;

/** Common device properties shared across data-plane and control-plane. */
model DevicePropertiesBase {
  /** Globally unique, immutable, non-reusable ID. */
  @visibility(Lifecycle.Read)
  uuid?: string;

  /** The Device ID provided by the customer. Also used by IoT Hub to hold the IoT Hub device ID. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  externalDeviceId?: string;

  /** Device manufacturer. */
  manufacturer?: string;

  /** Device model. */
  `model`?: string;

  /** The software revision for this device. */
  softwareRevision?: string;
}
