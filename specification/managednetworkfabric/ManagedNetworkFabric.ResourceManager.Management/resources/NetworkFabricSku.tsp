import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network Fabric SKU resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@subscriptionResource
@includeInapplicableMetadataInPayload(false)
model NetworkFabricSku extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Name of the Network Fabric SKU.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkFabricSkuName")
  @segment("networkFabricSkus")
  @visibility("read")
  name: string;

  /** The Network Fabric Sku properties */
  properties: NetworkFabricSkuProperties;
}

@armResourceOperations
interface NetworkFabricSkus {
  /**
   * Implements Network Fabric SKU GET method.
   */
  get is ArmResourceRead<NetworkFabricSku>;

  /**
   * Implements Network Fabric SKUs list by subscription GET method.
   */
  listBySubscription is ArmResourceListByParent<NetworkFabricSku>;
}
