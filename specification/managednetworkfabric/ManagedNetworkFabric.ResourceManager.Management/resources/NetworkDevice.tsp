import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The Network Device resource definition.")
@Azure.ResourceManager.Private.armResourceInternal(NetworkDeviceProperties)
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkDevice extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Network Device.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkDeviceName")
  @segment("networkDevices")
  @visibility(Lifecycle.Read)
  name: string;

  /** The NetworkDevice properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "properties")
  propertiesDeprecated: NetworkDeviceProperties;

  /** The NetworkDevice properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @added(Versions.v2025_07_15)
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties: NetworkDeviceProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @added(Versions.v2025_07_15)
  @doc("The managed service identities assigned to this resource.")
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;
}

@armResourceOperations
interface NetworkDevices {
  @doc("Gets the Network Device resource details.")
  get is ArmResourceRead<NetworkDevice>;

  @doc("Create a Network Device resource")
  create is ArmResourceCreateOrReplaceAsync<NetworkDevice>;

  @doc("Update certain properties of the Network Device resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<NetworkDevice, NetworkDevicePatchParameters>;

  @doc("Delete the Network Device resource.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkDevice>;

  @doc("List all the Network Device resources in a given resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkDevice>;

  @doc("List all the Network Device resources in a given subscription.")
  listBySubscription is ArmListBySubscription<NetworkDevice>;

  @doc("Reboot the Network Device.")
  @action("reboot")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "reboot")
  @sharedRoute
  rebootDeprecated is ArmResourceActionAsync<
    NetworkDevice,
    RebootProperties,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Reboot the Network Device.")
  @action("reboot")
  @added(Versions.v2025_07_15)
  @sharedRoute
  reboot is ArmResourceActionAsync<
    NetworkDevice,
    RebootProperties,
    Foundations.OperationStatusResult
  >;

  @doc("Refreshes the configuration the Network Device.")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "refreshConfiguration")
  @sharedRoute
  @action("refreshConfiguration")
  refreshConfigurationDeprecated is ArmResourceActionAsync<
    NetworkDevice,
    void,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Refreshes the configuration the Network Device.")
  @added(Versions.v2025_07_15)
  @sharedRoute
  @action("refreshConfiguration")
  refreshConfiguration is ArmResourceActionAsync<
    NetworkDevice,
    void,
    NetworkDeviceRefreshConfigurationResponse
  >;

  @doc("Updates the Administrative state of the Network Device.")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "updateAdministrativeState")
  @sharedRoute
  @action("updateAdministrativeState")
  updateAdministrativeStateDeprecated is ArmResourceActionAsync<
    NetworkDevice,
    UpdateDeviceAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Updates the Administrative state of the Network Device.")
  @added(Versions.v2025_07_15)
  @sharedRoute
  @action("updateAdministrativeState")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkDevice,
    UpdateDeviceAdministrativeState,
    NetworkDeviceUpdateAdministrativeStateResponse
  >;

  @doc("Upgrades the version of the Network Device.")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "upgrade")
  @sharedRoute
  @action("upgrade")
  upgradeDeprecated is ArmResourceActionAsync<
    NetworkDevice,
    UpdateVersion,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Upgrades the version of the Network Device.")
  @added(Versions.v2025_07_15)
  @sharedRoute
  @action("upgrade")
  upgrade is ArmResourceActionAsync<
    NetworkDevice,
    NetworkDeviceUpgradeRequest,
    NetworkDeviceUpgradeResponse
  >;

  @doc("Run the RO Command on the Network Device.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "runRoCommand")
  @sharedRoute
  @action("runRoCommand")
  runRoCommandDeprecated is ArmResourceActionAsync<
    NetworkDevice,
    DeviceRoCommand,
    CommonPostActionResponseForDeviceROCommandsDeprecated
  >;

  @doc("Run the RO Command on the Network Device.")
  @added(Versions.v2024_06_15_preview)
  @sharedRoute
  @action("runRoCommand")
  runRoCommand is ArmResourceActionAsync<
    NetworkDevice,
    DeviceRoCommand,
    CommonPostActionResponseForDeviceROCommandsOperationStatusResult
  >;

  @doc("Run the RW Command on the Network Device.")
  @action("runRwCommand")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "runRwCommand")
  @sharedRoute
  runRwCommandDeprecated is ArmResourceActionAsync<
    NetworkDevice,
    DeviceRwCommand,
    CommonPostActionResponseForDeviceRWCommands
  >;

  @doc("Run the RW Command on the Network Device.")
  @action("runRwCommand")
  @added(Versions.v2025_07_15)
  @sharedRoute
  runRwCommand is ArmResourceActionAsync<
    NetworkDevice,
    DeviceRwCommand,
    NetworkDeviceRunRwCommandResponse
  >;

  @summary("Resync the latest passwords to the Network Device.")
  @doc("Updates the Network Device to use the latest passwords. Does not generate new passwords. Allows network devices missed during a previous password rotation to be brought back into sync.")
  @added(Versions.v2025_07_15)
  resyncPasswords is ArmResourceActionAsync<
    NetworkDevice,
    void,
    NetworkDeviceResyncPasswordsResponse
  >;

  @summary("Resync the latest certificates to the Network Device.")
  @doc("Updates the Network Device to use the latest certificates. Does not generate new certificates. Allows network devices missed during a previous certificate rotation to be brought back into sync.")
  @added(Versions.v2025_07_15)
  resyncCertificates is ArmResourceActionAsync<
    NetworkDevice,
    void,
    NetworkFabricResyncCertificatesResponse
  >;
}

@@doc(NetworkDevices.create::parameters.resource, "Request payload.");
@@doc(NetworkDevices.update::parameters.properties,
  "Network Device properties to update."
);
@@doc(NetworkDevices.rebootDeprecated::parameters.body, "Request payload.");
@@doc(NetworkDevices.reboot::parameters.body, "Request payload.");
@@doc(NetworkDevices.updateAdministrativeStateDeprecated::parameters.body,
  "Request payload."
);
@@doc(NetworkDevices.updateAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(NetworkDevices.upgradeDeprecated::parameters.body, "Request payload.");
@@doc(NetworkDevices.upgrade::parameters.body, "Request payload.");
@@doc(NetworkDevices.runRoCommand::parameters.body, "Request the command.");
@@doc(NetworkDevices.runRoCommandDeprecated::parameters.body,
  "Request the command."
);
@@doc(NetworkDevices.runRwCommandDeprecated::parameters.body,
  "Request the command."
);
@@doc(NetworkDevices.runRwCommand::parameters.body, "Request the command.");
