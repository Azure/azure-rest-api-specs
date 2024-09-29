import "../models/common.tsp";
import "./NetworkDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * Defines the NetworkInterface resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@parentResource(NetworkDevice)
@Azure.ResourceManager.Private.armResourceInternal(NetworkInterfaceProperties)
@includeInapplicableMetadataInPayload(false)
model NetworkInterface extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Name of the Network Interface.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkInterfaceName")
  @segment("networkInterfaces")
  @visibility("read")
  name: string;

  /** The NetworkInterface properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  properties: NetworkInterfaceProperties;
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
  @parameterVisibility
  update is ArmCustomPatchAsync<NetworkInterface, NetworkInterfacePatch>;

  /**
   * Delete the Network Interface resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NetworkInterface>;

  /**
   * List all the Network Interface resources in a given resource group.
   */
  listByNetworkDevice is ArmResourceListByParent<NetworkInterface>;

  /**
   * Update the admin state of the Network Interface.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkInterface,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
}

@@doc(NetworkInterfaces.create::parameters.resource, "Request payload.");
@@doc(NetworkInterfaces.update::parameters.properties,
  "NetworkInterface properties to update. Only tags are supported."
);
@@doc(NetworkInterfaces.updateAdministrativeState::parameters.body,
  "Request payload."
);
