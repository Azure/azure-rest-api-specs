import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.EdgeOrder;
@doc("Represents order item contract")
model EdgeOrderItem is TrackedResource<OrderItemProperties> {
  @doc("The name of the order item")
  @path
  @key("orderItemName")
  @segment("orderItems")
  name: string;
}

@armResourceOperations
interface EdgeOrderItems {
  @doc("Gets an order item.")
  getOrderItemByName is ArmResourceRead<
    EdgeOrderItem,
    {
      ...BaseParameters<EdgeOrderItem>;

      @doc("$expand is supported on device details, forward shipping details and reverse shipping details parameters. Each of these can be provided as a comma separated list. Device Details for order item provides details on the devices of the product, Forward and Reverse Shipping details provide forward and reverse shipping details respectively.")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Creates an order item. Existing order item cannot be updated with this api and should instead be updated with the Update order item API.")
  createOrderItem is ArmResourceCreateOrUpdateAsync<EdgeOrderItem>;
  @doc("Updates the properties of an existing order item.")
  updateOrderItem is ArmResourcePatchAsync<
    EdgeOrderItem,
    OrderItemProperties,
    {
      ...BaseParameters<EdgeOrderItem>;

      @doc("Defines the If-Match condition. The patch will be performed only if the ETag of the order on the server matches this value.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes an order item.")
  deleteOrderItemByName is ArmResourceDeleteAsync<EdgeOrderItem>;
  @doc("Lists order item at resource group level.")
  listOrderItemsAtResourceGroupLevel is ArmResourceListByParent<
    EdgeOrderItem,
    {
      ...BaseParameters<EdgeOrderItem>;

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
  @doc("Lists order item at subscription level.")
  listOrderItemsAtSubscriptionLevel is ArmListBySubscription<EdgeOrderItem>;
  @doc("Cancel order item.")
  cancelOrderItem is ArmResourceActionSync<
    EdgeOrderItem,
    CancellationReason,
    void
  >;
  @doc("Return order item.")
  returnOrderItem is ArmResourceActionAsync<
    EdgeOrderItem,
    ReturnOrderItemDetails,
    void
  >;
}
