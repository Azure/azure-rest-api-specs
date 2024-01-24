import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A virtual network.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Lab)
@Azure.ResourceManager.Private.armResourceInternal(VirtualNetworkProperties)
@includeInapplicableMetadataInPayload(false)
model VirtualNetwork extends Resource {
  /**
   * The name of the virtual network.
   */
  @path
  @key("name")
  @segment("virtualnetworks")
  name: string;

  /**
   * The properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: VirtualNetworkProperties;
}

@armResourceOperations
interface VirtualNetworks {
  /**
   * Get virtual network.
   */
  get is ArmResourceRead<
    VirtualNetwork,
    {
      ...BaseParameters<VirtualNetwork>;

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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VirtualNetwork>;

  /**
   * Allows modifying tags of virtual networks. All other properties will be ignored.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<VirtualNetwork, VirtualNetworkFragment>;

  /**
   * Delete virtual network. This operation can take a while to complete.
   */
  delete is ArmResourceDeleteAsync<VirtualNetwork>;

  /**
   * List virtual networks in a given lab.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VirtualNetworks_List")
  list is ArmResourceListByParent<
    VirtualNetwork,
    {
      ...BaseParameters<VirtualNetwork>;

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
    }
  >;
}

@@projectedName(VirtualNetworks.createOrUpdate::parameters.resource,
  "json",
  "virtualNetwork"
);
@@extension(VirtualNetworks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "virtualNetwork"
);
@@doc(VirtualNetworks.createOrUpdate::parameters.resource,
  "A virtual network."
);
@@projectedName(VirtualNetworks.update::parameters.properties,
  "json",
  "virtualNetwork"
);
@@extension(VirtualNetworks.update::parameters.properties,
  "x-ms-client-name",
  "virtualNetwork"
);
@@doc(VirtualNetworks.update::parameters.properties, "A virtual network.");
