import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * The order details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(DataBoxEdgeDevice)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(OrderProperties)
model Order extends ProxyResourceBase {
  @key("order")
  @segment("orders")
  @visibility("read")
  name: string;

  /**
   * It specify the order api version.
   */
  @visibility("read")
  kind?: string;

  /**
   * The order properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: OrderProperties;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Order>;

  /**
   * Deletes the order related to the device.
   */
  delete is ArmResourceDeleteAsync<Order>;

  /**
   * Lists all the orders related to a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Orders_ListByDataBoxEdgeDevice")
  listByDataBoxEdgeDevice is ArmResourceListByParent<Order>;

  /**
   * Gets the DCAccess Code
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Orders_ListDCAccessCode")
  listDCAccessCode is ArmResourceActionSync<Order, void, DCAccessCode>;
}

@@projectedName(Orders.createOrUpdate::parameters.resource, "json", "order");
@@extension(Orders.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "order"
);
@@doc(Orders.createOrUpdate::parameters.resource,
  "The order to be created or updated."
);
