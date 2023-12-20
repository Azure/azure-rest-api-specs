import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataBoxEdge;
@doc("The order details.")
@parentResource(DataBoxEdgeDevice)
@singleton("default")
model DataBoxEdgeOrder is ProxyResource<OrderProperties> {
  @key("default")
  @segment("orders")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataBoxEdgeOrders {
  @doc("Gets a specific order by name.")
  get is ArmResourceRead<DataBoxEdgeOrder>;
  @doc("Creates or updates an order.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataBoxEdgeOrder>;
  @doc("Deletes the order related to the device.")
  delete is ArmResourceDeleteAsync<DataBoxEdgeOrder>;
  @doc("Lists all the orders related to a Data Box Edge/Data Box Gateway device.")
  listByDataBoxEdgeDevice is ArmResourceListByParent<DataBoxEdgeOrder>;
  @doc("Gets the DCAccess Code")
  listDCAccessCode is ArmResourceActionSync<
    DataBoxEdgeOrder,
    void,
    DCAccessCode
  >;
}
