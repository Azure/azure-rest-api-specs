import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * Network Device Properties defines the properties of the resource.
 */
model NetworkDeviceProperties {
  ...AnnotationResource;

  /**
   * The host name of the device.
   */
  @minLength(1)
  hostName?: string;

  /**
   * Serial number of the device. Format of serial Number - Make;Model;HardwareRevisionId;SerialNumber.
   */
  @minLength(1)
  serialNumber: string;

  /**
   * Current version of the device as defined in SKU.
   */
  @visibility("read")
  version?: string;

  /**
   * Network Device SKU name.
   */
  @visibility("read", "create")
  networkDeviceSku?: string;

  /**
   * NetworkDeviceRole is the device role: Example: CE | ToR.
   */
  @visibility("read")
  networkDeviceRole?: NetworkDeviceRole;

  /**
   * Reference to network rack resource id.
   */
  @visibility("read")
  networkRackId?: string;

  /**
   * Management IPv4 Address.
   */
  @visibility("read")
  managementIpv4Address?: string;

  /**
   * Management IPv6 Address.
   */
  @visibility("read")
  managementIpv6Address?: string;

  /**
   * Configuration state of the resource.
   */
  @visibility("read")
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility("read")
  administrativeState?: AdministrativeState;
}

/**
 * The Network Device Patch Parameters defines the patch parameters of the resource.
 */
model NetworkDevicePatchParameters {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...TagsUpdate;

  /**
   * Network Device Patch properties.
   */
  properties?: NetworkDevicePatchParametersProperties;
}

/**
 * Network Device Patch properties.
 */
model NetworkDevicePatchParametersProperties {
  ...AnnotationResource;

  /**
   * The host name of the device.
   */
  @minLength(1)
  hostName?: string;

  /**
   * Serial number of the device. Format of serial Number - Make;Model;HardwareRevisionId;SerialNumber.
   */
  @minLength(1)
  serialNumber?: string;
}

/**
 * Reboot properties.
 */
model RebootProperties {
  /**
   * Type of reboot to be performed. Example: GracefulRebootWithZTP
   */
  rebootType?: RebootType;
}

/**
 * Update the administrative state on list of resources.
 */
model UpdateDeviceAdministrativeState {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...EnableDisableOnResources;

  /**
   * Administrative state.
   */
  state?: DeviceAdministrativeState;
}

/**
 * NetworkDeviceRole is the device role: Example: CE | ToR.
 */
union NetworkDeviceRole {
  @doc("NetworkDeviceRole-CE(Customer Edge)")
  CE: "CE",

  @doc("NetworkDeviceRole-ToR(top of rack)")
  ToR: "ToR",

  @doc("NetworkDeviceRole-NPB(Network Packet Broker)")
  NPB: "NPB",

  @doc("NetworkDeviceRole-TS(Terminal Server)")
  TS: "TS",

  @doc("NetworkDeviceRole-Management")
  Management: "Management",

  string,
}

/**
 * Type of reboot to be performed. Example: GracefulRebootWithZTP
 */
union RebootType {
  @doc("RebootType GracefulRebootWithZTP")
  GracefulRebootWithZTP: "GracefulRebootWithZTP",

  @doc("RebootType GracefulRebootWithoutZTP")
  GracefulRebootWithoutZTP: "GracefulRebootWithoutZTP",

  @doc("RebootType UngracefulRebootWithZTP")
  UngracefulRebootWithZTP: "UngracefulRebootWithZTP",

  @doc("RebootType UngracefulRebootWithoutZTP")
  UngracefulRebootWithoutZTP: "UngracefulRebootWithoutZTP",

  string,
}

/**
 * Administrative state.
 */
union DeviceAdministrativeState {
  @doc("Device AdministrativeState-RMA")
  RMA: "RMA",

  @doc("Device AdministrativeState-Resync")
  Resync: "Resync",

  @doc("Device AdministrativeState-GracefulQuarantine")
  GracefulQuarantine: "GracefulQuarantine",

  @doc("Device AdministrativeState-Quarantine")
  Quarantine: "Quarantine",

  @doc("Device AdministrativeState-UnderMaintenance")
  UnderMaintenance: "UnderMaintenance",

  @doc("Device AdministrativeState-Enable")
  Enable: "Enable",

  string,
}
