import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.EdgeOrder;
@doc("Specifies the properties or parameters for an order. Order is a grouping of one or more order items.")
model OrderResource is ProxyResource<OrderProperties> {
  @doc("The name of the order")
  @key("orderName")
  @segment("orders")
  name: string;
}

@armResourceOperations
@projectedName("client", "")
interface OrderResources_ {
  @doc("Gets an order.")
  getOrderByName is ArmResourceRead<OrderResource>;
}
