import "./common.tsp";

using TypeSpec.Versioning;
namespace Microsoft.ManagedNetworkFabric;

@doc("Network Device Properties defines the properties of the resource.")
model NetworkDeviceProperties {
  ...AnnotationResource;

  @doc("The host name of the device.")
  @minLength(1)
  hostName?: string;

  @doc("Serial number of the device. Format of serial Number - Make;Model;HardwareRevisionId;SerialNumber.")
  @minLength(1)
  serialNumber: string;

  @doc("Current version of the device as defined in SKU.")
  @visibility(Lifecycle.Read)
  version?: string;

  @doc("Network Device SKU name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkDeviceSku?: string;

  @doc("NetworkDeviceRole is the device role: Example: CE | ToR.")
  @visibility(Lifecycle.Read)
  networkDeviceRole?: NetworkDeviceRole;

  @doc("Reference to network rack resource id.")
  @visibility(Lifecycle.Read)
  networkRackId?: string;

  @doc("Management IPv4 Address.")
  @visibility(Lifecycle.Read)
  managementIpv4Address?: string;

  @doc("Management IPv6 Address.")
  @visibility(Lifecycle.Read)
  managementIpv6Address?: string;

  @doc("User configured read-write configuration applied on the network devices.")
  @added(Versions.v2024_06_15_preview)
  @visibility(Lifecycle.Read)
  rwDeviceConfig?: string;

  @doc("Details of the last operation performed on the resource")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_06_15_preview)
  lastOperation?: LastOperationProperties;

  @doc("Configuration state of the resource.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

@doc("The Network Device Patch Parameters defines the patch parameters of the resource.")
model NetworkDevicePatchParameters {
  ...TagsUpdate;

  @doc("Network Device Patch properties.")
  properties?: NetworkDevicePatchParametersProperties;
}

@doc("Network Device Patch properties.")
model NetworkDevicePatchParametersProperties {
  ...AnnotationResource;

  @doc("The host name of the device.")
  @minLength(1)
  hostName?: string;

  @doc("Serial number of the device. Format of serial Number - Make;Model;HardwareRevisionId;SerialNumber.")
  @minLength(1)
  serialNumber?: string;
}

@doc("Reboot properties.")
model RebootProperties {
  @doc("Type of reboot to be performed. Example: GracefulRebootWithZTP")
  rebootType?: RebootType;
}

@doc("Update the administrative state on list of resources.")
model UpdateDeviceAdministrativeState {
  ...EnableDisableOnResources;

  @doc("Administrative state.")
  state?: DeviceAdministrativeState;
}

@doc("NetworkDeviceRole is the device role: Example: CE | ToR.")
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

@doc("Type of reboot to be performed. Example: GracefulRebootWithZTP")
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

@doc("Administrative state.")
union DeviceAdministrativeState {
  @doc("Device AdministrativeState-RMA")
  RMA: "RMA",

  @added(Versions.v2024_06_15_preview)
  @doc("Device AdministrativeState-RMA(Return Material Authorization) Ungraceful")
  UngracefulRMA: "UngracefulRMA",

  @doc("Device AdministrativeState-Resync")
  Resync: "Resync",

  @doc("Device AdministrativeState-GracefulQuarantine")
  GracefulQuarantine: "GracefulQuarantine",

  @added(Versions.v2024_06_15_preview)
  @doc("Device AdministrativeState-UngracefulQuarantine")
  UngracefulQuarantine: "UngracefulQuarantine",

  @doc("Device AdministrativeState-Quarantine")
  Quarantine: "Quarantine",

  @doc("Device AdministrativeState-UnderMaintenance")
  UnderMaintenance: "UnderMaintenance",

  @doc("Device AdministrativeState-Enable")
  Enable: "Enable",

  @added(Versions.v2024_06_15_preview)
  @doc("Device AdministrativeState-Disable")
  Disable: "Disable",

  string,
}
