import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * Network Device SKU Properties defines the properties of the resource.
 */
model NetworkDeviceSkuProperties {
  /**
   * Model of the network device.
   */
  `model`: string;

  /**
   * Manufacturer of the network device.
   */
  manufacturer?: string;

  /**
   * List of supported version details of network device.
   */
  @OpenAPI.extension("x-ms-identifiers", ["version"])
  supportedVersions?: SupportedVersionProperties[];

  /**
   * Available roles for the network device.
   */
  supportedRoleTypes?: NetworkDeviceRoleName[];

  /**
   * List of network device interfaces.
   */
  @OpenAPI.extension("x-ms-identifiers", ["identifier"])
  interfaces?: DeviceInterfaceProperties[];

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Supported version details of the network device.
 */
model SupportedVersionProperties {
  /**
   * Operating system and firmware combined versions.
   */
  version?: string;

  /**
   * Operating system version.
   */
  vendorOsVersion?: string;

  /**
   * Firmware version.
   */
  vendorFirmwareVersion?: string;

  /**
   * If true newly provisioned Fabric will use this device version by default to bootstrap the network devices for the first time.
   */
  isDefault?: BooleanEnumProperty;
}

/**
 * Network device interface properties.
 */
model DeviceInterfaceProperties {
  /**
   * Interface identifier. Example: HundredGigE0/0.
   */
  identifier?: string;

  /**
   * Interface type.
   */
  interfaceType?: string;

  /**
   * List of supported connector types.
   */
  @OpenAPI.extension("x-ms-identifiers", ["connectorType"])
  supportedConnectorTypes?: SupportedConnectorProperties[];
}

/**
 * Supported connector properties.
 */
model SupportedConnectorProperties {
  /**
   * Type of connector used. Example: Optical.
   */
  connectorType?: string;

  /**
   * Maximum speed of the connector in Mbps.
   */
  maxSpeedInMbps?: int32;
}

/**
 * Available roles for the network device.
 */
union NetworkDeviceRoleName {
  @doc("NetworkDeviceRoleName-CE(Customer Edge)")
  CE: "CE",

  @doc("NetworkDeviceRoleName-ToR(top of rack)")
  ToR: "ToR",

  @doc("NetworkDeviceRoleName-NPB(Network Packet Broker)")
  NPB: "NPB",

  @doc("NetworkDeviceRoleName-TS(Terminal Server)")
  TS: "TS",

  @doc("NetworkDeviceRoleName-Management")
  Management: "Management",

  string,
}
