import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The Network Fabric SKU resource definition.")
@subscriptionResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkFabricSku extends Azure.ResourceManager.Foundations.ProxyResource {
  @doc("Name of the Network Fabric SKU.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkFabricSkuName")
  @segment("networkFabricSkus")
  @visibility(Lifecycle.Read)
  name: string;

  /** The Network Fabric Sku properties */
  properties: NetworkFabricSkuProperties;
}

@armResourceOperations
interface NetworkFabricSkus {
  @doc("Implements Network Fabric SKU GET method.")
  get is ArmResourceRead<NetworkFabricSku>;

  @doc("Implements Network Fabric SKUs list by subscription GET method.")
  listBySubscription is ArmResourceListByParent<NetworkFabricSku>;
}
