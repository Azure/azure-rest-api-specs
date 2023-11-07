import "./models-shared.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.IoT.DeviceUpdate;

/** Device class metadata. */
@resource("management/deviceClasses")
model DeviceClass {
  /**
   * The device class identifier. This is generated from the model Id and the compat
   * properties reported by the device update agent in the Device Update PnP
   * interface in IoT Hub. It is a hex-encoded SHA1 hash.
   */
  @key
  @path
  @visibility("read")
  deviceClassId: string;

  /**
   * The device class friendly name. This can be updated by callers after the device
   * class has been automatically created.
   */
  @visibility("read", "update")
  friendlyName?: string;

  /** The device class properties that are used to calculate the device class Id */
  @visibility("read")
  deviceClassProperties: DeviceClassProperties;

  /** Update that is the highest version compatible with this device class. */
  @visibility("read")
  bestCompatibleUpdate?: UpdateInfo;
}

/** The device class properties that are used to calculate the device class Id */
model DeviceClassProperties {
  /** The Device Update agent contract model. */
  contractModel?: ContractModel;

  /**
   * The compat properties of the device class. This object can be thought of as a
   * set of key-value pairs where the key is the name of the compatibility property
   * and the value is the value of the compatibility property. There will always be
   * at least 1 compat property
   */
  compatProperties: Record<string>;
}

/** The Device Update agent contract model. */
model ContractModel {
  /**
   * The Device Update agent contract model Id of the device class. This is also
   * used to calculate the device class Id.
   */
  id: string;

  /**
   * The Device Update agent contract model name of the device class. Intended to be
   * a more readable form of the contract model Id.
   */
  name: string;
}

/** Device Class JSON Merge Patch request body */
model PatchBody {
  /**
   * The device class friendly name. Friendly name can be 1-100 characters,
   * alphanumeric, dot, and dash.
   */
  friendlyName: string;
}

/** Device class filter. Filters device classes based on device class friendly name */
model DeviceClassFilter {
  /** The friendly name of the device class to use in the filter */
  friendlyName?: string;
}
