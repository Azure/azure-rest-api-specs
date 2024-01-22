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

namespace Microsoft.EdgeOrder;
/**
 * Specifies the properties or parameters for an order. Order is a grouping of one or more order items.
 */
model OrderResource is ProxyResource<OrderProperties> {
  /**
   * The name of the order
   */
  @path
  @key("orderName")
  @segment("orders")
  name: string;
}

@armResourceOperations
interface OrderResources {
  /**
   * Gets an order.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GetOrderByName")
  getOrderByName is ArmResourceRead<OrderResource>;
}
