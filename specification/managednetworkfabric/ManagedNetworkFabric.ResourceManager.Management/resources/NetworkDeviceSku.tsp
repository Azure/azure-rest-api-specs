import "../models/common.tsp";
import "../models/NetworkDeviceSku.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
@doc("The NetworkDeviceSku resource definition.")
@subscriptionResource
model NetworkDeviceSku
  is Azure.ResourceManager.ProxyResource<NetworkDeviceSkuProperties, false> {
  @doc("Name of the Network Device SKU.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkDeviceSkuName")
  @segment("networkDeviceSkus")
  @visibility(Lifecycle.Read)
  name: string;
}

@@doc(NetworkDeviceSku.properties, "The Network Device SKU properties.");
@armResourceOperations
interface NetworkDeviceSkus {
  @doc("Get a Network Device SKU details.")
  get is ArmResourceRead<NetworkDeviceSku>;

  @doc("List Network Device SKUs for the given subscription.")
  listBySubscription is ArmResourceListByParent<
    NetworkDeviceSku,
    Response = NetworkDeviceSkusListResult
  >;
}
