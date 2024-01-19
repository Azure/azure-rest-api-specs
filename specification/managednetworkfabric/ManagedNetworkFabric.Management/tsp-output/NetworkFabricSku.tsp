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
@doc("The Network Fabric SKU resource definition.")
@subscriptionResource
model NetworkFabricSku is ProxyResource<NetworkFabricSkuProperties> {
  @doc("Name of the Network Fabric SKU.")
  @path
  @key("networkFabricSkuName")
  @segment("networkFabricSkus")
  name: string;
}

@armResourceOperations
interface NetworkFabricSkus {
  @doc("Implements Network Fabric SKU GET method.")
  get is ArmResourceRead<NetworkFabricSku>;

  @doc("Implements Network Fabric SKUs list by subscription GET method.")
  listBySubscription is ArmResourceListByParent<NetworkFabricSku>;
}
