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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model VirtualNetwork extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("virtualnetworks")
  name: string;

  properties: VirtualNetworkProperties;
}

@armResourceOperations
interface VirtualNetworkOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = VirtualNetwork,
        KeyName = "name",
        SegmentName = "virtualnetworks",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface VirtualNetworks {
  /**
   * Get virtual network.
   */
  get is VirtualNetworkOps.Read<
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
  createOrUpdate is VirtualNetworkOps.CreateOrUpdateAsync<
    VirtualNetwork,
    LroHeaders = ArmLroLocationHeader<FinalResult = VirtualNetwork> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of virtual networks. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is VirtualNetworkOps.CustomPatchSync<
    VirtualNetwork,
    PatchModel = VirtualNetworkFragment
  >;

  /**
   * Delete virtual network. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is VirtualNetworkOps.DeleteWithoutOkAsync<
    VirtualNetwork,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List virtual networks in a given lab.
   */
  list is VirtualNetworkOps.List<
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
