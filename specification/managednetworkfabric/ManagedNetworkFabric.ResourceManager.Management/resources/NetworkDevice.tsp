import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network Device resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@Azure.ResourceManager.Private.armResourceInternal(NetworkDeviceProperties)
@includeInapplicableMetadataInPayload(false)
model NetworkDevice extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Name of the Network Device.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkDeviceName")
  @segment("networkDevices")
  @visibility("read")
  name: string;

  /** The NetworkDevice properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  properties: NetworkDeviceProperties;
}

@armResourceOperations
interface NetworkDevices {
  /**
   * Gets the Network Device resource details.
   */
  get is ArmResourceRead<NetworkDevice>;

  /**
   * Create a Network Device resource
   */
  create is ArmResourceCreateOrReplaceAsync<NetworkDevice>;

  /**
   * Update certain properties of the Network Device resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<NetworkDevice, NetworkDevicePatchParameters>;

  /**
   * Delete the Network Device resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NetworkDevice>;

  /**
   * List all the Network Device resources in a given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<NetworkDevice>;

  /**
   * List all the Network Device resources in a given subscription.
   */
  listBySubscription is ArmListBySubscription<NetworkDevice>;

  /**
   * Reboot the Network Device.
   */
  reboot is ArmResourceActionAsync<
    NetworkDevice,
    RebootProperties,
    CommonPostActionResponseForStateUpdate
  >;

  /**
   * Refreshes the configuration the Network Device.
   */
  refreshConfiguration is ArmResourceActionAsync<
    NetworkDevice,
    void,
    CommonPostActionResponseForStateUpdate
  >;

  /**
   * Updates the Administrative state of the Network Device.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkDevice,
    UpdateDeviceAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  /**
   * Upgrades the version of the Network Device.
   */
  upgrade is ArmResourceActionAsync<
    NetworkDevice,
    UpdateVersion,
    CommonPostActionResponseForStateUpdate
  >;

  /**
   * Run the RO Command on the Network Device.
   */
  runRoCommand is ArmResourceActionAsync<
    NetworkDevice,
    DeviceRoCommand,
    CommonPostActionResponseForDeviceROCommands
  >;

  /**
   * Run the RW Command on the Network Device.
   */
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
@@doc(NetworkDevices.runRwCommand::parameters.body, "Request the command.");
