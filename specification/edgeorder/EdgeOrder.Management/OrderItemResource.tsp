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
 * Represents order item resource.
 */
model OrderItemResource
  is Azure.ResourceManager.TrackedResource<OrderItemProperties, false> {
  ...ResourceNameParameter<
    Resource = OrderItemResource,
    KeyName = "orderItemName",
    SegmentName = "orderItems",
    NamePattern = "^[A-Za-z0-9][-A-Za-z0-9]*[A-Za-z0-9]$|^[A-Za-z0-9]$"
  >;

  /**
   * Msi identity of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ResourceIdentity;
}

@armResourceOperations
interface OrderItemResources {
  /**
   * Get an order item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OrderItems_Get")
  get is ArmResourceRead<
    OrderItemResource,
    Parameters = {
      /**
       * $expand is supported on parent device details, device details, forward shipping details and reverse shipping details parameters. Each of these can be provided as a comma separated list. Parent Device Details for order item provides details on the devices of the product, Device Details for order item provides details on the devices of the child configurations of the product, Forward and Reverse Shipping details provide forward and reverse shipping details respectively.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create an order item. Existing order item cannot be updated with this api and should instead be updated with the Update order item
   * API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("OrderItems_Create")
  create is ArmResourceCreateOrReplaceAsync<
    OrderItemResource,
    Response = ArmResourceUpdatedResponse<OrderItemResource> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update the properties of an existing order item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("OrderItems_Update")
  update is ArmCustomPatchAsync<
    OrderItemResource,
    PatchModel = OrderItemUpdateParameter,
    Parameters = {
      /**
       * Defines the If-Match condition. The patch will be performed only if the ETag of the order on the server matches this value.
       */
      @header("If-Match")
      `If-Match`?: string;
    }
  >;

  /**
   * Delete an order item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OrderItems_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<OrderItemResource>;

  /**
   * List order items at resource group level.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OrderItems_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    OrderItemResource,
    Parameters = {
      /**
       * $filter is supported to filter based on order id and order Item Type. Filter supports only equals operation.
       */
      @query("$filter")
      $filter?: string;

      /**
       * $expand is supported on parent device details, device details, forward shipping details and reverse shipping details parameters. Each of these can be provided as a comma separated list. Parent Device Details for order item provides details on the devices of the product, Device Details for order item provides details on the devices of the child configurations of the product, Forward and Reverse Shipping details provide forward and reverse shipping details respectively.
       */
      @query("$expand")
      $expand?: string;

      /**
       * $skipToken is supported on Get list of order items, which provides the next page in the list of order items.
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * $top is supported on fetching list of resources. $top=10 means that the first 10 items in the list will be returned to the API caller.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ArmResponse<OrderItemResourceList>
  >;

  /**
   * List order items at subscription level.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OrderItems_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    OrderItemResource,
    Parameters = {
      /**
       * $filter is supported to filter based on order id and order Item Type. Filter supports only equals operation.
       */
      @query("$filter")
      $filter?: string;

      /**
       * $expand is supported on parent device details, device details, forward shipping details and reverse shipping details parameters. Each of these can be provided as a comma separated list. Parent Device Details for order item provides details on the devices of the product, Device Details for order item provides details on the devices of the child configurations of the product, Forward and Reverse Shipping details provide forward and reverse shipping details respectively.
       */
      @query("$expand")
      $expand?: string;

      /**
       * $skipToken is supported on Get list of order items, which provides the next page in the list of order items.
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * $top is supported on fetching list of resources. $top=10 means that the first 10 items in the list will be returned to the API caller.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ArmResponse<OrderItemResourceList>
  >;

  /**
   * Cancel order item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OrderItems_Cancel")
  cancel is ArmResourceActionSync<
    OrderItemResource,
    CancellationReason,
    OkResponse | NoContentResponse
  >;

  /**
   * Return order item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OrderItems_Return")
  @action("return")
  returnOrderItem is ArmResourceActionAsync<
    OrderItemResource,
    ReturnOrderItemDetails,
    OkResponse
  >;
}

@@maxLength(OrderItemResource.name, 63);
@@minLength(OrderItemResource.name, 3);
@@doc(OrderItemResource.name, "The name of the order item.");
@@doc(OrderItemResource.properties, "Order item properties.");
@@doc(OrderItemResources.create::parameters.resource,
  "Order item details from request body."
);
@@doc(OrderItemResources.update::parameters.properties,
  "Order item update parameters from request body."
);
@@doc(OrderItemResources.cancel::parameters.body, "Reason for cancellation.");
@@doc(OrderItemResources.returnOrderItem::parameters.body,
  "Return order item details."
);
