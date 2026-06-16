import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Database query.
 */
@parentResource(ManagedDatabase)
model ManagedInstanceQuery
  is Azure.ResourceManager.ProxyResource<QueryProperties> {
  ...ResourceNameParameter<
    Resource = ManagedInstanceQuery,
    KeyName = "queryId",
    SegmentName = "queries",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ManagedInstanceQueries {
  /**
   * Get query by query id.
   */
  @tag("ManagedDatabaseQueries")
  get is ArmResourceRead<ManagedInstanceQuery>;

  /**
   * Get query execution statistics by query id.
   */
  @tag("ManagedDatabaseQueries")
  @list
  @get
  @action("statistics")
  listByQuery is ArmResourceActionSync<
    ManagedInstanceQuery,
    void,
    ArmResponse<ManagedInstanceQueryStatistics>,
    Parameters = {
      /**
       * Start time for observed period.
       */
      @query("startTime")
      startTime?: string;

      /**
       * End time for observed period.
       */
      @query("endTime")
      endTime?: string;

      /**
       * The time step to be used to summarize the metric values.
       */
      @query("interval")
      interval?: QueryTimeGrainType;
    }
  >;
}

@@doc(ManagedInstanceQuery.name, "");
@@doc(ManagedInstanceQuery.properties, "Resource properties.");
