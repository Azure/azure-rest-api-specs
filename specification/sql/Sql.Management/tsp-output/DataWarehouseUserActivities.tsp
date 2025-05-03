import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * User activities of a data warehouse
 */
@parentResource(Database)
model DataWarehouseUserActivities
  is ProxyResource<DataWarehouseUserActivitiesProperties> {
  /**
   * The activity name of the data warehouse.
   */
  @path
  @key("dataWarehouseUserActivityName")
  @segment("dataWarehouseUserActivities")
  name: DataWarehouseUserActivityName;
}

@armResourceOperations
@projectedName("client", "DataWarehouseUserActivities")
interface DataWarehouseUserActivitiesOperationGroup {
  /**
   * Gets the user activities of a data warehouse which includes running and suspended queries
   */
  get is ArmResourceRead<DataWarehouseUserActivities>;

  /**
   * List the user activities of a data warehouse which includes running and suspended queries
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataWarehouseUserActivities_ListByDatabase")
  listByDatabase is ArmResourceListByParent<DataWarehouseUserActivities>;
}
