import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network Device resource definition.
 */
model NetworkDevice
  is Azure.ResourceManager.TrackedResource<NetworkDeviceProperties, false> {
  ...ResourceNameParameter<
    Resource = NetworkDevice,
    KeyName = "networkDeviceName",
    SegmentName = "networkDevices",
    NamePattern = ""
  >;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NetworkDevice,
    PatchModel = NetworkDevicePatchParameters
  >;

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
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;

  /**
   * Refreshes the configuration the Network Device.
   */
  refreshConfiguration is ArmResourceActionAsync<
    NetworkDevice,
    void,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;

  /**
   * Updates the Administrative state of the Network Device.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkDevice,
    UpdateDeviceAdministrativeState,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;

  /**
   * Upgrades the version of the Network Device.
   */
  upgrade is ArmResourceActionAsync<
    NetworkDevice,
    UpdateVersion,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;
}

@@doc(NetworkDevice.name, "Name of the Network Device.");
@@doc(NetworkDevice.properties, "Resource properties.");
@@doc(NetworkDevices.create::parameters.resource, "Request payload.");
@@doc(NetworkDevices.update::parameters.properties,
  "Network Device properties to update."
);
@@doc(NetworkDevices.reboot::parameters.body, "Request payload.");
@@doc(NetworkDevices.updateAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(NetworkDevices.upgrade::parameters.body, "Request payload.");
