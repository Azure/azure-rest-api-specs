import "./common.tsp";

using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;
namespace Microsoft.ManagedNetworkFabric;

@doc("Network Bootstrap Device Properties defines the properties of the resource.")
model NetworkBootstrapDeviceProperties {
  ...AnnotationResource;
  ...NetworkBootstrapDevicePatchableProperties;

  @doc("Current version of the device as defined in SKU.")
  @visibility(Lifecycle.Read)
  version?: string;

  @doc("Network Bootstrap Device SKU name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkDeviceSku?: string;

  @doc("Associated Network Fabric Resource ID")
  @added(Versions.v2025_07_15)
  @visibility(Lifecycle.Read)
  networkFabricId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("Secondary Management IPv4 Address.")
  @visibility(Lifecycle.Read)
  secondaryManagementIpv4Address?: string;

  @doc("Dhcp server IPv4 Address.")
  @visibility(Lifecycle.Read)
  dhcpV4ServerIpAddress?: string;

  @doc("Primary Management IPv6 Address.")
  @visibility(Lifecycle.Read)
  primaryManagementIpv6Address?: string;

  @doc("Secondary Management IPv6 Address.")
  @visibility(Lifecycle.Read)
  secondaryManagementIpv6Address?: string;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Primary Management IPv4 Address.")
  @visibility(Lifecycle.Read)
  primaryManagementIpv4Address?: string;

  @doc("Administrative state of the resource.")
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;

  @doc("Configuration state of the resource.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("Operational state of networkBootstrapDevice indicating if the device is reachable and services are available.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2026_01_15_preview)
  operationalState?: OperationalState;

  @doc("Secret rotation status for the terminal server's secrets.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2026_01_15_preview)
  @Azure.ResourceManager.identifiers(#["secretType"])
  secretRotationStatus?: SecretRotationStatus[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending instead of spreading to avoid breaking changes in patch model"
@doc("The Network Bootstrap Device Patch Parameters defines the patch parameters of the resource.")
@added(Versions.v2025_07_15)
model NetworkBootstrapDevicePatch extends TagsUpdate {
  @doc("Network Bootstrap Device Patch properties.")
  properties?: NetworkBootstrapDevicePatchProperties;

  @doc("The managed service identities assigned to this resource.")
  identity?: ManagedServiceIdentityPatch;
}

@doc("Network Bootstrap Device updatable properties.")
model NetworkBootstrapDevicePatchableProperties {
  @doc("The host name of the device.")
  @minLength(1)
  hostName?: string;

  @doc("Serial number of the device. Format of serial Number - Make;Model;HardwareRevisionId;SerialNumber.")
  @minLength(1)
  serialNumber?: string;

  @doc("Control Plane Access Control List ARM resource IDs.")
  @added(Versions.v2026_01_15_preview)
  controlPlaneAcls?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>[];
}

@doc("Network Bootstrap Device Patch properties.")
model NetworkBootstrapDevicePatchProperties {
  ...AnnotationResource;
  ...NetworkBootstrapDevicePatchableProperties;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Response body for a ResyncPasswords request on a Network Bootstrap Device.")
model NetworkBootstrapDeviceResyncPasswordsResponse {
  ...OperationStatusResult;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("The current status of an refresh configuration async operation.")
model NetworkBootstrapDeviceRefreshConfigurationResponse {
  ...OperationStatusResult;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Network Bootstrap Device Administrative State Update Response.")
model NetworkBootstrapDeviceUpdateAdministrativeStateResponse {
  ...OperationStatusResult;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Network Bootstrap Device reboot Response.")
model NetworkBootstrapDeviceRebootResponse {
  ...OperationStatusResult;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Network Bootstrap Device upgrade Response.")
model NetworkBootstrapDeviceUpgradeResponse {
  ...OperationStatusResult;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Response body for a RunRoCommand request on a Network Bootstrap Device.")
@added(Versions.v2026_07_15_preview)
model NetworkBootstrapDeviceRunRoCommandResponse {
  ...OperationStatusResult;

  @doc("Network Bootstrap Device Run Ro Command Response properties.")
  properties?: NetworkBootstrapDeviceRoCommandResponseProperties;
}

@doc("Network Bootstrap Device Ro Command Response properties.")
@added(Versions.v2026_07_15_preview)
model NetworkBootstrapDeviceRoCommandResponseProperties {
  @doc("Gets the configuration state.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @doc("Predefined link containing Device RO Command output.")
  outputUrl?: url;

  @doc("Device RO command Response limited to 4000 characters.")
  deviceConfigurationPreview?: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Response body for a RunRwCommand request on a Network Bootstrap Device.")
@added(Versions.v2026_07_15_preview)
model NetworkBootstrapDeviceRunRwCommandResponse {
  ...OperationStatusResult;

  @doc("Network Bootstrap Device Run Rw Command Response properties.")
  properties?: NetworkBootstrapDeviceRwCommandResponseProperties;
}

@doc("Network Bootstrap Device Rw Command Response properties.")
@added(Versions.v2026_07_15_preview)
model NetworkBootstrapDeviceRwCommandResponseProperties {
  @doc("Gets the configuration state.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @doc("Predefined link containing Device Rw Command output.")
  outputUrl?: url;
}
