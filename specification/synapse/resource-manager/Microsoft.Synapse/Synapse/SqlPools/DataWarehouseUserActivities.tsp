import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace SqlPools;
/**
 * User activities of a data warehouse
 */
@parentResource(SqlPool)
model DataWarehouseUserActivities
  is Azure.ResourceManager.ProxyResource<DataWarehouseUserActivitiesProperties> {
  ...ResourceNameParameter<
    Resource = DataWarehouseUserActivities,
    KeyName = "dataWarehouseUserActivityName",
    SegmentName = "dataWarehouseUserActivities",
    NamePattern = "",
    Type = DataWarehouseUserActivityName
  >;
}

alias DataWarehouseUserActivitiesOps = Azure.ResourceManager.Legacy.LegacyOperations<
  SqlPoolParentParameters,
  {
    /** The activity name of the Sql pool. */
    @segment("dataWarehouseUserActivities")
    @key
    @path
    dataWarehouseUserActivityName: DataWarehouseUserActivityName;
  }
>;

@armResourceOperations
interface SqlPoolDataWarehouseUserActivities {
  /**
   * Gets the user activities of a SQL pool which includes running and suspended queries
   */
  get is DataWarehouseUserActivitiesOps.Read<DataWarehouseUserActivities>;
}

@@doc(DataWarehouseUserActivities.name, "The activity name of the Sql pool. ");
@@doc(DataWarehouseUserActivities.properties, "Resource properties.");
