import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetworkCloud;
@doc("RackSku represents the SKU information of the rack.")
@subscriptionResource
model NetworkCloudRackSku is ProxyResource<RackSkuProperties> {
  @doc("The name of the rack SKU.")
  @path
  @key("rackSkuName")
  @segment("rackSkus")
  name: string;
}

@armResourceOperations
interface NetworkCloudRackSkus {
  @doc("Get the properties of the provided rack SKU.")
  get is ArmResourceRead<NetworkCloudRackSku>;
  @doc("Get a list of rack SKUs in the provided subscription.")
  listBySubscription is ArmResourceListByParent<NetworkCloudRackSku>;
}
