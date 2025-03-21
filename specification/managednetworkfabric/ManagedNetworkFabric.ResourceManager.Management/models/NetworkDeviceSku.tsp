import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

@doc("Network Device SKU Properties defines the properties of the resource.")
model NetworkDeviceSkuProperties {
  @doc("Model of the network device.")
  `model`: string;

  @doc("Manufacturer of the network device.")
  manufacturer?: string;

  @doc("List of supported version details of network device.")
  @Azure.ResourceManager.identifiers(#["version"])
  supportedVersions?: SupportedVersionProperties[];

  @doc("Available roles for the network device.")
  supportedRoleTypes?: NetworkDeviceRoleName[];

  @doc("List of network device interfaces.")
  @Azure.ResourceManager.identifiers(#["identifier"])
  interfaces?: DeviceInterfaceProperties[];

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Supported version details of the network device.")
model SupportedVersionProperties {
  @doc("Operating system and firmware combined versions.")
  version?: string;

  @doc("Operating system version.")
  vendorOsVersion?: string;

  @doc("Firmware version.")
  vendorFirmwareVersion?: string;

  @doc("If true newly provisioned Fabric will use this device version by default to bootstrap the network devices for the first time.")
  isDefault?: BooleanEnumProperty;
}

@doc("Network device interface properties.")
model DeviceInterfaceProperties {
  @doc("Interface identifier. Example: HundredGigE0/0.")
  identifier?: string;

  @doc("Interface type.")
  interfaceType?: string;

  @doc("List of supported connector types.")
  @Azure.ResourceManager.identifiers(#["connectorType"])
  supportedConnectorTypes?: SupportedConnectorProperties[];
}

@doc("Supported connector properties.")
model SupportedConnectorProperties {
  @doc("Type of connector used. Example: Optical.")
  connectorType?: string;

  @doc("Maximum speed of the connector in Mbps.")
  maxSpeedInMbps?: int32;
}

@doc("Available roles for the network device.")
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
