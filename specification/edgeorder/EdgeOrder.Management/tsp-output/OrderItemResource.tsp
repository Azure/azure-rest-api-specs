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
@doc("Represents order item contract")
model OrderItemResource is TrackedResource<OrderItemProperties> {
  @doc("The name of the order item")
  @path
  @key("orderItemName")
  @segment("orderItems")
  name: string;
}

@armResourceOperations
interface OrderItemResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets an order item.")
  @operationId("GetOrderItemByName")
  getOrderItemByName is ArmResourceRead<
    OrderItemResource,
    {
      ...BaseParameters<OrderItemResource>;

      @doc("$expand is supported on device details, forward shipping details and reverse shipping details parameters. Each of these can be provided as a comma separated list. Device Details for order item provides details on the devices of the product, Forward and Reverse Shipping details provide forward and reverse shipping details respectively.")
      @query("$expand")
      $expand?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates an order item. Existing order item cannot be updated with this api and should instead be updated with the Update order item API.")
  @operationId("CreateOrderItem")
  createOrderItem is ArmResourceCreateOrUpdateAsync<OrderItemResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the properties of an existing order item.")
  @operationId("UpdateOrderItem")
  updateOrderItem is ArmCustomPatchAsync<
    OrderItemResource,
    OrderItemUpdateParameter,
    {
      ...BaseParameters<OrderItemResource>;

      @doc("Defines the If-Match condition. The patch will be performed only if the ETag of the order on the server matches this value.")
      @header
      `If-Match`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an order item.")
  @operationId("DeleteOrderItemByName")
  deleteOrderItemByName is ArmResourceDeleteAsync<OrderItemResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists order item at resource group level.")
  @operationId("ListOrderItemsAtResourceGroupLevel")
  listOrderItemsAtResourceGroupLevel is ArmResourceListByParent<
    OrderItemResource,
    {
      ...BaseParameters<OrderItemResource>;

      @doc("$filter is supported to filter based on order id. Filter supports only equals operation.")
      @query("$filter")
      $filter?: string;

      @doc("$expand is supported on device details, forward shipping details and reverse shipping details parameters. Each of these can be provided as a comma separated list. Device Details for order item provides details on the devices of the product, Forward and Reverse Shipping details provide forward and reverse shipping details respectively.")
      @query("$expand")
      $expand?: string;

      @doc("$skipToken is supported on Get list of order items, which provides the next page in the list of order items.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists order item at subscription level.")
  @operationId("ListOrderItemsAtSubscriptionLevel")
  listOrderItemsAtSubscriptionLevel is ArmListBySubscription<OrderItemResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Cancel order item.")
  @operationId("CancelOrderItem")
  cancelOrderItem is ArmResourceActionSync<
    OrderItemResource,
    CancellationReason,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Return order item.")
  @operationId("ReturnOrderItem")
  returnOrderItem is ArmResourceActionAsync<
    OrderItemResource,
    ReturnOrderItemDetails,
    void
  >;
}

@@projectedName(OrderItemResources.createOrderItem::parameters.resource,
  "json",
  "orderItemResource"
);
@@extension(OrderItemResources.createOrderItem::parameters.resource,
  "x-ms-client-name",
  "orderItemResource"
);
@@doc(OrderItemResources.createOrderItem::parameters.resource,
  "Order item details from request body."
);
@@projectedName(OrderItemResources.updateOrderItem::parameters.properties,
  "json",
  "orderItemUpdateParameter"
);
@@extension(OrderItemResources.updateOrderItem::parameters.properties,
  "x-ms-client-name",
  "orderItemUpdateParameter"
);
@@doc(OrderItemResources.updateOrderItem::parameters.properties,
  "order item update parameters from request body."
);
@@projectedName(OrderItemResources.cancelOrderItem::parameters.body,
  "json",
  "cancellationReason"
);
@@extension(OrderItemResources.cancelOrderItem::parameters.body,
  "x-ms-client-name",
  "cancellationReason"
);
@@doc(OrderItemResources.cancelOrderItem::parameters.body,
  "Reason for cancellation."
);
@@projectedName(OrderItemResources.returnOrderItem::parameters.body,
  "json",
  "returnOrderItemDetails"
);
@@extension(OrderItemResources.returnOrderItem::parameters.body,
  "x-ms-client-name",
  "returnOrderItemDetails"
);
@@doc(OrderItemResources.returnOrderItem::parameters.body,
  "Return order item CurrentStatus."
);
