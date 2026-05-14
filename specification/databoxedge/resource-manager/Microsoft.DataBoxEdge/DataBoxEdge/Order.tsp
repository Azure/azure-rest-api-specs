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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  kind?: string;
}

@armResourceOperations
interface Orders {
  /**
   * Gets a specific order by name.
   */
  @summary("Gets a specific order by name.")
  get is ArmResourceRead<Order, Error = CloudError>;

  /**
   * Creates or updates an order.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates or updates an order.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Order,
    Response = ArmResourceUpdatedResponse<Order> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Order> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;

  /**
   * Deletes the order related to the device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes the order related to the device.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Order,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all the orders related to a Data Box Edge/Data Box Gateway device.
   */
  @summary("Lists all the orders related to a Data Box Edge/Data Box Gateway device.")
  listByDataBoxEdgeDevice is ArmResourceListByParent<
    Order,
    Response = ArmResponse<OrderList>,
    Error = CloudError
  >;

  /**
   * Gets the DCAccess Code
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the DCAccess Code")
  listDCAccessCode is ArmResourceActionSync<
    Order,
    void,
    ArmResponse<DCAccessCode>,
    Error = CloudError
  >;
}

@@doc(Order.name, "");
@@doc(Order.properties, "The order properties.");
@@doc(Orders.createOrUpdate::parameters.resource,
  "The order to be created or updated."
);
