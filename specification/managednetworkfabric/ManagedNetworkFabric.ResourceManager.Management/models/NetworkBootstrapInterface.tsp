import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

@doc("Network Bootstrap Interface Properties defines the properties of the resource.")
model NetworkBootstrapInterfaceProperties {
  ...AnnotationResource;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;

  @doc("Configuration state of the resource.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("Physical identifier of the device.")
  @visibility(Lifecycle.Read)
  physicalIdentifier?: string;

  @doc("Connected to information of the device.")
  @visibility(Lifecycle.Read)
  connectedTo?: string;

  @doc("Type of the interface.")
  @visibility(Lifecycle.Read)
  interfaceType?: InterfaceType;

  @doc("Description of the interface.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("Additional description of the interface.")
  additionalDescription?: string;

  @doc("IPv4Address of the interface.")
  @visibility(Lifecycle.Read)
  ipv4Address?: string;

  @doc("IPv6Address of the interface.")
  @visibility(Lifecycle.Read)
  ipv6Address?: string;

  @doc("Serial number of the interface. Format of serial Number - Make;Model;HardwareRevisionId;SerialNumber.")
  @minLength(1)
  serialNumber?: string;
}

@doc("The NetworkBootstrapInterfacePatch resource definition.")
model NetworkBootstrapInterfacePatch {
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @doc("Network Bootstrap Interface Patch properties.")
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: NetworkBootstrapInterfacePatchProperties;
}

@doc("Network Bootstrap Interface Patch properties.")
model NetworkBootstrapInterfacePatchProperties {
  ...AnnotationResource;

  @doc("Serial number of the interface. Format of serial Number - Make;Model;HardwareRevisionId;SerialNumber.")
  @minLength(1)
  serialNumber?: string;

  @doc("Additional description of the interface.")
  additionalDescription?: string;
}
