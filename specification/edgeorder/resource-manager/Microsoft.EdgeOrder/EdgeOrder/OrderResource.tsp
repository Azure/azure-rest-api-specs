import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EdgeOrder;
/**
 * Specifies the properties or parameters for an order. Order is a grouping of one or more order items.
 */
@parentResource(ResourceGroupLocationResource)
model OrderResource
  is Azure.ResourceManager.ProxyResource<OrderProperties, false> {
  ...ResourceNameParameter<
    Resource = OrderResource,
    KeyName = "orderName",
    SegmentName = "orders",
    NamePattern = ""
  >;
}

@armResourceOperations
interface OrderResources {
  /**
   * Get an order.
   */
  get is ArmResourceRead<OrderResource>;
}

@@doc(OrderResource.name, "The name of the order.");
@@doc(OrderResource.properties, "Order properties.");
