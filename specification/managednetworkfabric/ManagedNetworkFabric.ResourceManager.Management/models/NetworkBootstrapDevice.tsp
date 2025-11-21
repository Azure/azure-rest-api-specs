import "./common.tsp";

using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;
namespace Microsoft.ManagedNetworkFabric;

@doc("Network Bootstrap Device Properties defines the properties of the resource.")
model NetworkBootstrapDeviceProperties {
  ...AnnotationResource;

  @doc("The host name of the device.")
  @minLength(1)
  hostName?: string;

  @doc("Serial number of the device. Format of serial Number - Make;Model;HardwareRevisionId;SerialNumber.")
  @minLength(1)
  serialNumber?: string;

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
}

@doc("The Network Bootstrap Device Patch Parameters defines the patch parameters of the resource.")
@added(Versions.v2025_07_15)
model NetworkBootstrapDevicePatch {
  ...TagsUpdate;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @doc("Network Bootstrap Device Patch properties.")
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: NetworkBootstrapDevicePatchProperties;

  @doc("The managed service identities assigned to this resource.")
  identity?: ManagedServiceIdentityPatch;
}

@doc("Network Bootstrap Device Patch properties.")
model NetworkBootstrapDevicePatchProperties {
  ...AnnotationResource;

  @doc("The host name of the device.")
  @minLength(1)
  hostName?: string;

  @doc("Serial number of the device. Format of serial Number - Make;Model;HardwareRevisionId;SerialNumber.")
  @minLength(1)
  serialNumber?: string;
}

@doc("Response body for a ResyncPasswords request on a Network Bootstrap Device.")
model NetworkBootstrapDeviceResyncPasswordsResponse {
  ...OperationStatusResult;
}

@doc("The current status of an refresh configuration async operation.")
model NetworkBootstrapDeviceRefreshConfigurationResponse {
  ...OperationStatusResult;
}

@doc("Network Bootstrap Device Administrative State Update Response.")
model NetworkBootstrapDeviceUpdateAdministrativeStateResponse {
  ...OperationStatusResult;
}

@doc("Network Bootstrap Device reboot Response.")
model NetworkBootstrapDeviceRebootResponse {
  ...OperationStatusResult;
}

@doc("Network Bootstrap Device upgrade Response.")
model NetworkBootstrapDeviceUpgradeResponse {
  ...OperationStatusResult;
}
