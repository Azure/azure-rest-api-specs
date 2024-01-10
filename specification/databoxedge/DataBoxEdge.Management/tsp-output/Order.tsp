import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataBoxEdge;
@doc("The order details.")
@singleton("default")
@parentResource(DataBoxEdgeDevice)
model Order is ProxyResource<OrderProperties> {
  @key("order")
  @segment("orders")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Orders {
  @doc("Gets a specific order by name.")
  get is ArmResourceRead<Order>;

  @doc("Creates or updates an order.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Order>;

  @doc("Deletes the order related to the device.")
  delete is ArmResourceDeleteAsync<Order>;

  @doc("Lists all the orders related to a Data Box Edge/Data Box Gateway device.")
  listByDataBoxEdgeDevice is ArmResourceListByParent<Order>;

  @doc("Gets the DCAccess Code")
  listDCAccessCode is ArmResourceActionSync<Order, void, DCAccessCode>;
}
