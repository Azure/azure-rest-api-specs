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

namespace Microsoft.Synapse;
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

@armResourceOperations
interface SqlPoolDataWarehouseUserActivities {
  /**
   * Gets the user activities of a SQL pool which includes running and suspended queries
   */
  get is ArmResourceRead<DataWarehouseUserActivities>;
}

@@doc(DataWarehouseUserActivities.name, "The activity name of the Sql pool. ");
@@doc(DataWarehouseUserActivities.properties, "Resource properties.");
