import "./models-shared.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.IoT.DeviceUpdate;

/** Group details. */
@resource("management/groups")
model Group {
  /**
   * Group identity. This is created from the value of the ADUGroup tag in the Iot
   * Hub's device/module twin or $default for devices with no tag.
   */
  @key
  @path
  @visibility("read")
  groupId: string;

  /** Group type. */
  groupType: GroupType;

  /** Date and time when the update was created. */
  createdDateTime: string;

  /** The number of devices in the group. */
  deviceCount?: int32;

  /** The count of subgroups with new updates available. */
  subgroupsWithNewUpdatesAvailableCount?: int32;

  /** The count of subgroups with updates in progress. */
  subgroupsWithUpdatesInProgressCount?: int32;

  /** The count of subgroups with devices on the latest update. */
  subgroupsWithOnLatestUpdateCount?: int32;

  /** The active deployment Ids for the group */
  deployments?: string[];
}

/** Group type */
enum GroupType {
  /** IoT Hub tag based group, all devices in the group share an ADUGroup tag value. */
  IoTHubTag,

  /** Default group for untagged devices. */
  DefaultNoTag,
}

/**
 * Device class subgroup details. A device class subgroup is a subset of devices
 * in a group that share the same device class id.
 */
@resource("deviceClassSubgroups")
@parentResource(Group)
model DeviceClassSubgroup {
  /**
   * Device class subgroup identity. This is generated from the model Id and the
   * compat properties reported by the device update agent in the Device Update PnP
   * interface in IoT Hub. It is a hex-encoded SHA1 hash.
   */
  @key
  @path
  @visibility("read")
  deviceClassId: string;

  /** Group identity. */
  groupId: string;

  /** Date and time when the device class subgroup was created. */
  createdDateTime: string;

  /** The number of devices in the device class subgroup. */
  deviceCount?: int32;

  /** The active deployment Id for the device class subgroup. */
  deploymentId?: string;
}

/** The list of updatable devices for a device class subgroup. */
model DeviceClassSubgroupUpdatableDevicesList
  is Azure.Core.Page<DeviceClassSubgroupUpdatableDevices>;

/** Device class subgroup, update information, and the number of devices for which the update is applicable. */
model DeviceClassSubgroupUpdatableDevices {
  /** The group Id */
  groupId: string;

  /** The device class subgroup's device class Id */
  deviceClassId: string;

  /** Update information. */
  update: UpdateInfo;

  /** Total number of devices for which the update is applicable. */
  deviceCount: int32;
}

/**
 * Device class subgroups filter. Filters device class subgroups based on device
 * class compat property names and values
 */
model DeviceClassSubgroupFilter {
  /**
   * The name of the compat property to use in the filter. E.g.
   * compatProperties/manufacturer
   */
  compatPropertyName?: string;

  /** The value the compat property to use in the filter. E.g. Contoso */
  compatPropertyValue?: string;
}

/** Groups order by. */
model GroupOrderBy {
  /** The group Id. */
  groupId?: string;

  /** The group device count. */
  deviceCount?: string;

  /** The group created date. */
  createdDate?: string;

  /** The number of subgroups with new updates available */
  subgroupsWithNewUpdatesAvailableCount?: string;

  /** The number of subgroups with updates in progress */
  subgroupsWithUpdatesInProgressCount?: string;

  /** The number of subgroups with devices on the latest update */
  subgroupsOnLatestUpdateCount?: string;
}
