import "../models/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
@doc("The Network Fabric SKU resource definition.")
@subscriptionResource
model NetworkFabricSku
  is Azure.ResourceManager.ProxyResource<NetworkFabricSkuProperties, false> {
  @doc("Name of the Network Fabric SKU.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkFabricSkuName")
  @segment("networkFabricSkus")
  @visibility(Lifecycle.Read)
  name: string;
}

@@doc(NetworkFabricSku.properties, "The Network Fabric SKU properties.");
@armResourceOperations
interface NetworkFabricSkus {
  @doc("Implements Network Fabric SKU GET method.")
  get is ArmResourceRead<NetworkFabricSku>;

  @doc("Implements Network Fabric SKUs list by subscription GET method.")
  listBySubscription is ArmResourceListByParent<
    NetworkFabricSku,
    Response = NetworkFabricSkusListResult
  >;
}
