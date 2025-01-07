import "./common.tsp";

using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("Network Interface Properties defines the properties of the resource.")
model NetworkInterfaceProperties {
  ...AnnotationResource;

  @doc("Physical Identifier of the network interface.")
  @visibility("read")
  physicalIdentifier?: string;

  @doc("The ARM resource id of the interface or compute server its connected to.")
  @visibility("read")
  connectedTo?: string;

  @doc("The Interface Type. Example: Management/Data")
  @visibility("read")
  interfaceType?: InterfaceType;

  @doc("IPv4Address of the interface.")
  @visibility("read")
  ipv4Address?: string;

  @doc("IPv6Address of the interface.")
  @visibility("read")
  ipv6Address?: string;

  @added(Versions.v2024_06_15_preview)
  @doc("Description of the interface.")
  description?: string;

  @added(Versions.v2024_06_15_preview)
  @doc("Additional description of the interface.")
  additionalDescription?: string;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("The NetworkInterfacePatch resource definition.")
model NetworkInterfacePatch {
  @doc("Network Interface Patch properties.")
  properties?: NetworkInterfacePatchProperties;
}

@doc("Network Interface Patch properties.")
model NetworkInterfacePatchProperties {
  ...AnnotationResource;

  @added(Versions.v2024_06_15_preview)
  @doc("Description of the interface.")
  description?: string;

  @added(Versions.v2024_06_15_preview)
  @doc("Additional description of the interface.")
  additionalDescription?: string;
}

@doc("The Interface Type. Example: Management/Data")
union InterfaceType {
  @doc("InterfaceType-Management")
  Management: "Management",

  @doc("InterfaceType-Data")
  Data: "Data",

  string,
}
