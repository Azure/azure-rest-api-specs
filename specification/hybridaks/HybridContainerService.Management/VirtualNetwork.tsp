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
#suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
#suppress "@azure-tools/typespec-azure-resource-manager/resource-name" "Initial suppression to prevent breaking change"
model virtualNetwork
  is Azure.ResourceManager.TrackedResource<VirtualNetworkProperties> {
  ...ResourceNameParameter<
    Resource = virtualNetwork,
    KeyName = "virtualNetworkName",
    SegmentName = "virtualNetworks",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;

  /**
   * Extended location pointing to the underlying infrastructure
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: VirtualNetworkExtendedLocation;
}

@armResourceOperations
interface VirtualNetworks {
  /**
   * Gets the specified virtual network resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("virtualNetworks_Retrieve")
  retrieve is ArmResourceRead<virtualNetwork>;

  /**
   * Creates or updates the virtual network resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("virtualNetworks_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<virtualNetwork>;

  /**
   * Patches the virtual network resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "for backward compatibility"
  @operationId("virtualNetworks_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    virtualNetwork,
    PatchModel = VirtualNetworksPatch,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = virtualNetwork> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the specified virtual network resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("virtualNetworks_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    virtualNetwork,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists the virtual networks in the specified resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("virtualNetworks_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    virtualNetwork,
    Response = ArmResponse<virtualNetworksListResult>
  >;

  /**
   * Lists the virtual networks in the specified subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("virtualNetworks_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    virtualNetwork,
    Response = ArmResponse<virtualNetworksListResult>
  >;
}

@@maxLength(virtualNetwork.name, 64);
@@minLength(virtualNetwork.name, 3);
@@doc(virtualNetwork.name, "Parameter for the name of the virtual network");
@@doc(virtualNetwork.properties, "Properties of the virtual network resource");
@@doc(VirtualNetworks.createOrUpdate::parameters.resource,
  "Virtual Network resource definition"
);
@@doc(VirtualNetworks.update::parameters.properties,
  "Virtual Network resource patch definition"
);
