import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.EdgeOrder;
@doc("Specifies the properties or parameters for an order. Order is a grouping of one or more order items.")
model EdgeOrder is ProxyResource<OrderProperties> {
  @doc("The name of the order")
  @path
  @key("orderName")
  @segment("orders")
  name: string;
}

@armResourceOperations
interface EdgeOrders {
  @doc("Gets an order.")
  getOrderByName is ArmResourceRead<EdgeOrder>;
}
