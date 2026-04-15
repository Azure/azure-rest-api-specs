namespace Microsoft.DeviceRegistry;

/** The type of origin for a device. */
union DeviceOriginType {
  string,

  /** Device originated from Azure IoT Operations. */
  AIO: "AIO",

  /** Device originated from Device Provisioning Service. */
  DPS: "DPS",

  /** Device originated from ARM. */
  ARM: "ARM",

  /** Device originated from IoTHub. */
  IoTHub: "IoTHub",
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

/** Contains metadata about how a device was discovered or provisioned. */
model DeviceOrigin {
  /** The type of origin. */
  type?: DeviceOriginType;

  /** The source identifier for the origin. */
  sourceId?: string;
}

/** Common device properties shared across data-plane and control-plane. */
model DevicePropertiesBase {
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
  `model`?: string;

  /** Device operating system. */
  operatingSystem?: string;

  /** Device operating system version. */
  operatingSystemVersion?: string;
}
