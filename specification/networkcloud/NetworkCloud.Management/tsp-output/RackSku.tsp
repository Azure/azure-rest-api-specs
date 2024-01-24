import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * RackSku represents the SKU information of the rack.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@subscriptionResource
@Azure.ResourceManager.Private.armResourceInternal(RackSkuProperties)
@includeInapplicableMetadataInPayload(false)
model RackSku extends ProxyResourceBase {
  /**
   * The name of the rack SKU.
   */
  @path
  @key("rackSkuName")
  @segment("rackSkus")
  name: string;

  /**
   * The list of the resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: RackSkuProperties;
}

@armResourceOperations
interface RackSkus {
  /**
   * Get the properties of the provided rack SKU.
   */
  get is ArmResourceRead<RackSku>;

  /**
   * Get a list of rack SKUs in the provided subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RackSkus_ListBySubscription")
  listBySubscription is ArmResourceListByParent<RackSku>;
}
