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
@subscriptionResource
model RackSku is ProxyResource<RackSkuProperties> {
  /**
   * The name of the rack SKU.
   */
  @path
  @key("rackSkuName")
  @segment("rackSkus")
  name: string;
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
