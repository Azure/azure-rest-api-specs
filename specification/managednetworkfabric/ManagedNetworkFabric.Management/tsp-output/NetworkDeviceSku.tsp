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

namespace Microsoft.ManagedNetworkFabric;
/**
 * The NetworkDeviceSku resource definition.
 */
@subscriptionResource
model NetworkDeviceSku is ProxyResource<NetworkDeviceSkuProperties> {
  /**
   * Name of the Network Device SKU.
   */
  @path
  @key("networkDeviceSkuName")
  @segment("networkDeviceSkus")
  name: string;
}

@armResourceOperations
interface NetworkDeviceSkus {
  /**
   * Get a Network Device SKU details.
   */
  get is ArmResourceRead<NetworkDeviceSku>;

  /**
   * List Network Device SKUs for the given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkDeviceSkus_ListBySubscription")
  listBySubscription is ArmResourceListByParent<NetworkDeviceSku>;
}
