import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * Defines the NetworkInterface resource.
 */
@parentResource(NetworkDevice)
model NetworkInterface
  is Azure.ResourceManager.ProxyResource<NetworkInterfaceProperties, false> {
  ...ResourceNameParameter<
    Resource = NetworkInterface,
    KeyName = "networkInterfaceName",
    SegmentName = "networkInterfaces",
    NamePattern = ""
  >;
}

@armResourceOperations
interface NetworkInterfaces {
  /**
   * Get the Network Interface resource details.
   */
  get is ArmResourceRead<NetworkInterface>;

  /**
   * Create a Network Interface resource.
   */
  create is ArmResourceCreateOrReplaceAsync<NetworkInterface>;

  /**
   * Update certain properties of the Network Interface resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NetworkInterface,
    PatchModel = NetworkInterfacePatch
  >;

  /**
   * Delete the Network Interface resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NetworkInterface>;

  /**
   * List all the Network Interface resources in a given resource group.
   */
  listByNetworkDevice is ArmResourceListByParent<
    NetworkInterface,
    Response = ArmResponse<NetworkInterfacesList>
  >;

  /**
   * Update the admin state of the Network Interface.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkInterface,
    UpdateAdministrativeState,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;
}

@@doc(NetworkInterface.name, "Name of the Network Interface.");
@@doc(NetworkInterface.properties, "Resource properties.");
@@doc(NetworkInterfaces.create::parameters.resource, "Request payload.");
@@doc(NetworkInterfaces.update::parameters.properties,
  "NetworkInterface properties to update. Only tags are supported."
);
@@doc(NetworkInterfaces.updateAdministrativeState::parameters.body,
  "Request payload."
);
