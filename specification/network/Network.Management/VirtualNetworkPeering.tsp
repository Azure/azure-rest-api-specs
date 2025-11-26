import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Peerings in a virtual network resource.
 */
@parentResource(VirtualNetwork)
model VirtualNetworkPeering
  is Azure.ResourceManager.ProxyResource<VirtualNetworkPeeringPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = VirtualNetworkPeering,
    KeyName = "virtualNetworkPeeringName",
    SegmentName = "virtualNetworkPeerings",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface VirtualNetworkPeerings {
  /**
   * Gets the specified virtual network peering.
   */
  get is ArmResourceRead<VirtualNetworkPeering, Error = CloudError>;

  /**
   * Creates or updates a peering in the specified virtual network.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualNetworkPeering,
    Parameters = {
      /**
       * Parameter indicates the intention to sync the peering with the current address space on the remote vNet after it's updated.
       */
      @query("syncRemoteAddressSpace")
      syncRemoteAddressSpace?: SyncRemoteAddressSpace;
    },
    Error = CloudError
  >;

  /**
   * Deletes the specified virtual network peering.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetworkPeering,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all virtual network peerings in a virtual network.
   */
  list is ArmResourceListByParent<VirtualNetworkPeering, Error = CloudError>;
}

@@doc(VirtualNetworkPeering.name, "The name of the virtual network peering.");
@@doc(VirtualNetworkPeering.properties,
  "Properties of the virtual network peering."
);
@@doc(VirtualNetworkPeerings.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update virtual network peering operation."
);
