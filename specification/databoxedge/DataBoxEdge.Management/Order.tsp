import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * The order details.
 */
@singleton("default")
@parentResource(DataBoxEdgeDevice)
model Order is Azure.ResourceManager.ProxyResource<OrderProperties> {
  ...ResourceNameParameter<
    Resource = Order,
    KeyName = "order",
    SegmentName = "orders",
    NamePattern = ""
  >;

  /**
   * It specify the order api version.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  kind?: string;
}

@armResourceOperations
interface Orders {
  /**
   * Gets a specific order by name.
   */
  get is ArmResourceRead<Order>;

  /**
   * Creates or updates an order.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Order,
    Response = ArmResourceUpdatedResponse<Order> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = Order> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the order related to the device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Order,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the orders related to a Data Box Edge/Data Box Gateway device.
   */
  listByDataBoxEdgeDevice is ArmResourceListByParent<
    Order,
    Response = ArmResponse<OrderList>
  >;

  /**
   * Gets the DCAccess Code
   */
  listDCAccessCode is ArmResourceActionSync<
    Order,
    void,
    ArmResponse<DCAccessCode>
  >;
}

@@doc(Order.name, "");
@@doc(Order.properties, "The order properties.");
@@doc(Orders.createOrUpdate::parameters.resource,
  "The order to be created or updated."
);
