/** Describes the schema of the Azure IoT Hub events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after the existing service swagger."
namespace Microsoft.EventGrid.SystemEvents;

/** Schema of the Data property of an EventGridEvent for a device life cycle event (DeviceCreated, DeviceDeleted). */
model DeviceLifeCycleEventProperties {
  /** The unique identifier of the device. This case-sensitive string can be up to 128 characters long, and supports ASCII 7-bit alphanumeric characters plus the following special characters: - : . + % _ &#35; * ? ! ( ) , = `@` ; $ '. */
  deviceId?: string;

  /** Name of the IoT Hub where the device was created or deleted. */
  hubName?: string;

  /** Information about the device twin, which is the cloud representation of application device metadata. */
  twin?: DeviceTwinInfo;
}

/** Metadata information for the properties JSON document. */
model DeviceTwinMetadata {
  /** The ISO8601 timestamp of the last time the properties were updated. */
  lastUpdated?: string;
}

/** A portion of the properties that can be written only by the application back-end, and read by the device. */
model DeviceTwinProperties {
  /** Metadata information for the properties JSON document. */
  metadata?: DeviceTwinMetadata;

  /** Version of device twin properties. */
  version?: float32;
}

//THIS IS WHAT IS CAUSING THE ISSUE
/** Information about the device twin, which is the cloud representation of application device metadata. */
model DeviceTwinInfo {
  /** Authentication type used for this device: either SAS, SelfSigned, or CertificateAuthority. */
  authenticationType?: string;

  /** Count of cloud to device messages sent to this device. */
  cloudToDeviceMessageCount?: float32;

  /** Whether the device is connected or disconnected. */
  connectionState?: string;

  /** The unique identifier of the device twin. */
  deviceId?: string;

  /** A piece of information that describes the content of the device twin. Each etag is guaranteed to be unique per device twin. */
  etag?: string;

  /** The ISO8601 timestamp of the last activity. */
  lastActivityTime?: string;

  //TODO: something here needs to change

  /** Properties JSON element. */
  properties?: DeviceTwinInfoProperties;

  /** Whether the device twin is enabled or disabled. */
  status?: string;

  /** The ISO8601 timestamp of the last device twin status update. */
  statusUpdateTime?: string;

  /** An integer that is incremented by one each time the device twin is updated. */
  version?: float32;

  //TODO: also here

  /** The thumbprint is a unique value for the x509 certificate, commonly used to find a particular certificate in a certificate store. The thumbprint is dynamically generated using the SHA1 algorithm, and does not physically exist in the certificate. */
  x509Thumbprint?: DeviceTwinInfoX509Thumbprint;
}

/** Schema of the Data property of an EventGridEvent for a device connection state event (DeviceConnected, DeviceDisconnected). */
model DeviceConnectionStateEventProperties {
  /** The unique identifier of the device. This case-sensitive string can be up to 128 characters long, and supports ASCII 7-bit alphanumeric characters plus the following special characters: - : . + % _ &#35; * ? ! ( ) , = `@` ; $ '. */
  deviceId?: string;

  /** The unique identifier of the module. This case-sensitive string can be up to 128 characters long, and supports ASCII 7-bit alphanumeric characters plus the following special characters: - : . + % _ &#35; * ? ! ( ) , = `@` ; $ '. */
  moduleId?: string;

  /** Name of the IoT Hub where the device was created or deleted. */
  hubName?: string;

  /** Information about the device connection state event. */
  deviceConnectionStateEventInfo?: DeviceConnectionStateEventInfo;
}

/** Schema of the Data property of an EventGridEvent for a device telemetry event (DeviceTelemetry). */
model DeviceTelemetryEventProperties {
  /** The content of the message from the device. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "The type of body is object"
  body?: Record<unknown>;

  /** Application properties are user-defined strings that can be added to the message. These fields are optional. */
  properties?: Record<string>;

  /** System properties help identify contents and source of the messages. */
  systemProperties?: Record<string>;
}

/** Information about the device connection state event. */
model DeviceConnectionStateEventInfo {
  /** Sequence number is string representation of a hexadecimal number. string compare can be used to identify the larger number because both in ASCII and HEX numbers come after alphabets. If you are converting the string to hex, then the number is a 256 bit number. */
  sequenceNumber?: string;
}

/** Event data for Microsoft.Devices.DeviceCreated event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model IotHubDeviceCreatedEventData extends DeviceLifeCycleEventProperties {}

/** Event data for Microsoft.Devices.DeviceDeleted event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model IotHubDeviceDeletedEventData extends DeviceLifeCycleEventProperties {}

/** Event data for Microsoft.Devices.DeviceConnected event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model IotHubDeviceConnectedEventData
  extends DeviceConnectionStateEventProperties {}

/** Event data for Microsoft.Devices.DeviceDisconnected event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model IotHubDeviceDisconnectedEventData
  extends DeviceConnectionStateEventProperties {}

/** Event data for Microsoft.Devices.DeviceTelemetry event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model IotHubDeviceTelemetryEventData extends DeviceTelemetryEventProperties {}

/** The thumbprint is a unique value for the x509 certificate, commonly used to find a particular certificate in a certificate store. The thumbprint is dynamically generated using the SHA1 algorithm, and does not physically exist in the certificate. */
model DeviceTwinInfoX509Thumbprint {
  /** Primary thumbprint for the x509 certificate. */
  primaryThumbprint?: string;

  /** Secondary thumbprint for the x509 certificate. */
  secondaryThumbprint?: string;
}

/** Properties JSON element. */
model DeviceTwinInfoProperties {
  /** A portion of the properties that can be written only by the application back-end, and read by the device. */
  desired?: DeviceTwinProperties;

  /** A portion of the properties that can be written only by the device, and read by the application back-end. */
  reported?: DeviceTwinProperties;
}
