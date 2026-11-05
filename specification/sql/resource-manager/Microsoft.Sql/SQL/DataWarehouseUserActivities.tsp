import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * User activities of a data warehouse
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Database)
@Azure.ResourceManager.Legacy.feature(Features.DataWarehouseUserActivities)
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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
@Azure.ResourceManager.Legacy.feature(Features.DataWarehouseUserActivities)
interface DataWarehouseUserActivitiesOperationGroup {
  /**
   * Gets the user activities of a data warehouse which includes running and suspended queries
   */
  @tag("DataWarehouseUserActivities")
  get is ArmResourceRead<DataWarehouseUserActivities>;

  /**
   * List the user activities of a data warehouse which includes running and suspended queries
   */
  @tag("DataWarehouseUserActivities")
  listByDatabase is ArmResourceListByParent<DataWarehouseUserActivities>;
}

@@doc(
  DataWarehouseUserActivities.name,
  "The activity name of the data warehouse. "
);
@@doc(DataWarehouseUserActivities.properties, "Resource properties.");
