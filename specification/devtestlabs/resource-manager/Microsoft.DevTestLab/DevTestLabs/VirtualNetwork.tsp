import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A virtual network.
 */
@parentResource(Lab)
model VirtualNetwork
  is Azure.ResourceManager.ProxyResource<VirtualNetworkProperties, false> {
  ...ResourceNameParameter<
    Resource = VirtualNetwork,
    KeyName = "virtualnetworkName",
    SegmentName = "virtualnetworks",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface VirtualNetworks {
  /**
   * Get virtual network.
   */
  get is ArmResourceRead<
    VirtualNetwork,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($expand=externalSubnets)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing virtual network. This operation can take a while to complete.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualNetwork,
    LroHeaders = ArmLroLocationHeader<FinalResult = VirtualNetwork> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of virtual networks. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    VirtualNetwork,
    PatchModel = VirtualNetworkFragment
  >;

  /**
   * Delete virtual network. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetwork,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List virtual networks in a given lab.
   */
  list is ArmResourceListByParent<
    VirtualNetwork,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($expand=externalSubnets)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<VirtualNetworkList>
  >;
}

@@doc(VirtualNetwork.name, "The name of the virtual network.");
@@doc(VirtualNetwork.properties, "The properties of the resource.");
@@doc(VirtualNetworks.createOrUpdate::parameters.resource,
  "A virtual network."
);
@@doc(VirtualNetworks.update::parameters.properties, "A virtual network.");
