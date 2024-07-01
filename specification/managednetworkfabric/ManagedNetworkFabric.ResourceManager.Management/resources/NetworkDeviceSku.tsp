import "../models/common.tsp";
import "../models/NetworkDeviceSku.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The NetworkDeviceSku resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@subscriptionResource
@includeInapplicableMetadataInPayload(false)
model NetworkDeviceSku extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Name of the Network Device SKU.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkDeviceSkuName")
  @segment("networkDeviceSkus")
  @visibility("read")
  name: string;

  /** The NetworkDeviceSku properties */
  properties: NetworkDeviceSkuProperties;
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
  listBySubscription is ArmResourceListByParent<NetworkDeviceSku>;
}
