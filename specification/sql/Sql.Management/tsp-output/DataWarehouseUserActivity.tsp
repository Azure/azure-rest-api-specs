import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("User activities of a data warehouse")
@parentResource(SqlDatabase)
model DataWarehouseUserActivity
  is ProxyResource<DataWarehouseUserActivitiesProperties> {
  @doc("The activity name of the data warehouse. ")
  @path
  @key("dataWarehouseUserActivityName")
  @segment("dataWarehouseUserActivities")
  name: DataWarehouseUserActivityName;
}

@armResourceOperations
interface DataWarehouseUserActivities {
  @doc("Gets the user activities of a data warehouse which includes running and suspended queries")
  get is ArmResourceRead<DataWarehouseUserActivity>;
  @doc("List the user activities of a data warehouse which includes running and suspended queries")
  listByDatabase is ArmResourceListByParent<DataWarehouseUserActivity>;
}
