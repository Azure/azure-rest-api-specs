import "../models/common.tsp";
import "../models/NetworkDeviceSku.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The NetworkDeviceSku resource definition.")
@subscriptionResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkDeviceSku extends Azure.ResourceManager.Foundations.ProxyResource {
  @doc("Name of the Network Device SKU.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkDeviceSkuName")
  @segment("networkDeviceSkus")
  @visibility(Lifecycle.Read)
  name: string;

  /** The NetworkDeviceSku properties */
  properties: NetworkDeviceSkuProperties;
}

@armResourceOperations
interface NetworkDeviceSkus {
  @doc("Get a Network Device SKU details.")
  get is ArmResourceRead<NetworkDeviceSku>;

  @doc("List Network Device SKUs for the given subscription.")
  listBySubscription is ArmResourceListByParent<NetworkDeviceSku>;
}
