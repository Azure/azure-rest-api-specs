namespace Microsoft.DeviceRegistry;

/** Whether a device is enabled or disabled. */
union DeviceEnabledStatus {
  string,

  /** The device is enabled. */
  Enabled: "Enabled",

  /** The device is disabled. */
  Disabled: "Disabled",
}

/** Common device properties shared across data-plane and control-plane. */
model DevicePropertiesBase {
  /** Globally unique, immutable, non-reusable ID. */
  @visibility(Lifecycle.Read)
  uuid?: string;

  /** Indicates if the device is enabled or not. */
  enabled?: DeviceEnabledStatus;

  /** The Device ID provided by the customer. Also used by IoT Hub to hold the IoT Hub device ID. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  externalDeviceId?: string;

  /** Device manufacturer. */
  manufacturer?: string;

  /** Device model. */
  `model`?: string;

  /** Device operating system. */
  operatingSystem?: string;

  /** Device operating system version. */
  operatingSystemVersion?: string;
}
