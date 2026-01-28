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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@parentResource(VirtualNetwork)
@Http.Private.includeInapplicableMetadataInPayload(false)
model VirtualNetworkPeering extends SubResourceModel {
  properties?: VirtualNetworkPeeringPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("virtualNetworkPeeringName")
  @segment("virtualNetworkPeerings")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@@doc(VirtualNetworkPeering.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
