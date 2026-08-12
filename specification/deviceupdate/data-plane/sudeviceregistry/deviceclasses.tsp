import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core;

namespace DeviceRegistrySoftwareUpdateClient;

/** Properties that identify a device class. */
model DeviceClassProperties {
  /**
   * Free-form compatibility properties (e.g. manufacturer, model) used to match
   * devices. This object can be thought of as a set of key-value pairs where the key
   * is the name of the compatibility property and the value is the value of the
   * compatibility property. There will always be at least 1 compat property. At most
   * 5 entries are allowed.
   */
  compatProperties: Record<string>;

  /** The agent profile that devices in this class implement. */
  @minValue(0)
  agentProfile: int32;
}

/** The best compatible update for a device class. */
model BestCompatibleUpdate {
  /** The identifier of the best-available compatible update. */
  updateId: UpdateId;
}

/**
 * A device class groups devices that share compatibility properties and agent
 * profile, allowing the service to determine the best compatible update for them.
 */
model DeviceClass {
  /**
   * Identifier derived from deviceClassProperties encoded as a 16-character
   * lowercase hexadecimal string.
   */
  @pattern("^[0-9a-f]{16}$")
  @minLength(16)
  @maxLength(16)
  @visibility(Lifecycle.Read)
  deviceClassId: string;

  /** The properties that identify this device class. */
  @visibility(Lifecycle.Read)
  deviceClassProperties: DeviceClassProperties;

  /** The best compatible update for the devices in this class, if any. */
  @visibility(Lifecycle.Read)
  bestCompatibleUpdate?: BestCompatibleUpdate;
}

/** The list of device classes. */
model DeviceClassesList is Azure.Core.Page<DeviceClass>;

@tag("DeviceClasses")
interface DeviceClasses {
  /**
   * Gets a list of device classes.
   */
  @route("/management/deviceClasses")
  @get
  @list
  list is ServiceOperation<{}, DeviceClassesList>;

  /**
   * Gets the properties of a device class.
   */
  @route("/management/deviceClasses/{deviceClassId}")
  @get
  getDeviceClass is ServiceOperation<
    {
      ...DeviceClassIdParameter;
    },
    DeviceClass
  >;

  /**
   * Deletes a device class.
   */
  @route("/management/deviceClasses/{deviceClassId}")
  @delete
  delete is ServiceOperation<
    {
      ...DeviceClassIdParameter;
    },
    void
  >;
}
