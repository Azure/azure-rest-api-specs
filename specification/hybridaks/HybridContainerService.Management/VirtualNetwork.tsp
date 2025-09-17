import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridContainerService;
/**
 * The Virtual Network resource definition.
 */
model VirtualNetwork is TrackedResource<VirtualNetworkProperties> {
  /**
   * Parameter for the name of the virtual network
   */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  @path
  @key("virtualNetworkName")
  @segment("virtualNetworks")
  @visibility(Lifecycle.Read)
  name: string;

  /**
   * Extended location pointing to the underlying infrastructure
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Well-known envelope property"
  extendedLocation?: VirtualNetworkExtendedLocation;
}

@armResourceOperations
interface VirtualNetworks {
  /**
   * Gets the specified virtual network resource
   */
  get is ArmResourceRead<VirtualNetwork>;

  /**
   * Creates or updates the virtual network resource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VirtualNetwork>;

  /**
   * Patches the virtual network resource
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<VirtualNetwork, VirtualNetworksPatch>;

  /**
   * Deletes the specified virtual network resource
   */
  delete is ArmResourceDeleteWithoutOkAsync<VirtualNetwork>;

  /**
   * Lists the virtual networks in the specified resource group
   */
  listByResourceGroup is ArmResourceListByParent<VirtualNetwork>;

  /**
   * Lists the virtual networks in the specified subscription
   */
  listBySubscription is ArmListBySubscription<VirtualNetwork>;
}

@@doc(VirtualNetworks.createOrUpdate::parameters.resource,
  "Virtual Network resource definition"
);
@@doc(VirtualNetworks.update::parameters.properties,
  "Virtual Network resource patch definition"
);
