import "./common.tsp";

using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending instead of spreading to avoid breaking changes in patch model"
@doc("Network Interface Properties defines the properties of the resource.")
model NetworkInterfaceProperties extends AnnotationResource {
  @doc("Physical Identifier of the network interface.")
  @visibility(Lifecycle.Read)
  physicalIdentifier?: string;

  @doc("The ARM resource id of the interface or compute server its connected to.")
  @visibility(Lifecycle.Read)
  connectedTo?: string;

  @doc("The Interface Type. Example: Management/Data")
  @visibility(Lifecycle.Read)
  interfaceType?: InterfaceType;

  @doc("IPv4Address of the interface.")
  @visibility(Lifecycle.Read)
  ipv4Address?: string;

  @doc("IPv6Address of the interface.")
  @visibility(Lifecycle.Read)
  ipv6Address?: string;

  @added(Versions.v2024_06_15_preview)
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "description")
  @doc("Description of the interface.")
  descriptionDeprecated?: string;

  @added(Versions.v2025_07_15)
  @doc("Description of the interface.")
  @visibility(Lifecycle.Read)
  description?: string;

  @added(Versions.v2024_06_15_preview)
  @doc("Additional description of the interface.")
  additionalDescription?: string;

  @doc("Details of the last operation performed on the resource")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_06_15_preview)
  lastOperation?: LastOperationProperties;

  @doc("Associated Network Fabric Resource ID")
  @added(Versions.v2025_07_15)
  @visibility(Lifecycle.Read)
  networkFabricId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;

  @added(Versions.v2025_07_15)
  @doc("Configuration state of the resource.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;
}

@doc("The NetworkInterfacePatch resource definition.")
model NetworkInterfacePatch {
  @doc("Network Interface Patch properties.")
  properties?: NetworkInterfacePatchProperties;

  @added(Versions.v2025_07_15)
  @doc("The managed service identities assigned to this resource.")
  identity?: ManagedServiceIdentityPatch;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending instead of spreading to avoid breaking changes in patch model"
@doc("Network Interface Patch properties.")
model NetworkInterfacePatchProperties extends AnnotationResource {
  @added(Versions.v2024_06_15_preview)
  @removed(Versions.v2025_07_15)
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
