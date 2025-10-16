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
  properties: NetworkDeviceProperties;
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
  reboot is ArmResourceActionAsync<
    NetworkDevice,
    RebootProperties,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Refreshes the configuration the Network Device.")
  refreshConfiguration is ArmResourceActionAsync<
    NetworkDevice,
    void,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Updates the Administrative state of the Network Device.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkDevice,
    UpdateDeviceAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Upgrades the version of the Network Device.")
  upgrade is ArmResourceActionAsync<
    NetworkDevice,
    UpdateVersion,
    CommonPostActionResponseForStateUpdate
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
  runRwCommand is ArmResourceActionAsync<
    NetworkDevice,
    DeviceRwCommand,
    CommonPostActionResponseForDeviceRWCommands
  >;
}

@@doc(NetworkDevices.create::parameters.resource, "Request payload.");
@@doc(NetworkDevices.update::parameters.properties,
  "Network Device properties to update."
);
@@doc(NetworkDevices.reboot::parameters.body, "Request payload.");
@@doc(NetworkDevices.updateAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(NetworkDevices.upgrade::parameters.body, "Request payload.");
@@doc(NetworkDevices.runRoCommand::parameters.body, "Request the command.");
@@doc(NetworkDevices.runRoCommandDeprecated::parameters.body,
  "Request the command."
);
@@doc(NetworkDevices.runRwCommand::parameters.body, "Request the command.");
