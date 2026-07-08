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
using TypeSpec.Versioning;

namespace Microsoft.Sql;
/**
 * A top resource consuming query on a database.
 */
@added(Versions.v2025_08_01_preview)
@parentResource(Database)
model TopQueriesDatabase
  is Azure.ResourceManager.ProxyResource<TopQueriesDatabaseProperties> {
  ...ResourceNameParameter<
    Resource = TopQueriesDatabase,
    KeyName = "topQueryName",
    SegmentName = "topQueries",
    NamePattern = "^[0-9]*$"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface TopQueriesOperations {
  /**
   * Get top resource consuming queries of a database
   */
  @tag("TopQueries")
  @added(Versions.v2025_08_01_preview)
  listByDatabase is ArmResourceListByParent<
    TopQueriesDatabase,
    Response = TopQueriesDatabaseListResult,
    Parameters = {
      /**
       * Start time for observed period.
       */
      @query("observationStartTime")
      observationStartTime?: string;

      /**
       * End time for observed period.
       */
      @query("observationEndTime")
      observationEndTime?: string;

      /**
       * The time step to be used to summarize the metric values. Default value is PT1H
       */
      @query("intervalType")
      intervalType?: QueryTimeGrainType;

      /**
       * How many 'top queries' to return. Default is 5.
       */
      @query("numberOfTopQueries")
      numberOfTopQueries?: int32;

      /**
       * Aggregation function to be used, default value is 'sum'
       */
      @query("aggregationFunction")
      aggregationFunction?: AggregationFunctionType;

      /**
       * Metric to be used for ranking top queries. Default is 'cpu'
       */
      @query("observedMetric")
      observedMetric?: MetricType;

      /**
       * Execution type of top queries.
       */
      @query("executionType")
      executionType?: ExecutionType;
    }
  >;
}

@armResourceOperations(#{ omitTags: true })
interface TopQueriesQueryText {
  /**
   * Get query text.
   */
  @tag("TopQueriesQueryText")
  @list
  @get
  @action("queryText")
  @added(Versions.v2025_08_01_preview)
  listByQuery is ArmResourceActionSync<
    TopQueriesDatabase,
    void,
    ArmResponse<QueryTextResult>
  >;
}

@armResourceOperations(#{ omitTags: true })
interface TopQueryStatistics {
  /**
   * Get query statistics.
   */
  @tag("TopQueryStatistics")
  @list
  @get
  @action("statistics")
  @added(Versions.v2025_08_01_preview)
  listByQuery is ArmResourceActionSync<
    TopQueriesDatabase,
    void,
    ArmResponse<QueryStatisticsDatabaseListResult>,
    Parameters = {
      /**
       * Start time for observed period.
       */
      @query("observationStartTime")
      observationStartTime?: string;

      /**
       * End time for observed period.
       */
      @query("observationEndTime")
      observationEndTime?: string;

      /**
       * The time step to be used to summarize the metric values. Default value is PT1H
       */
      @query("intervalType")
      intervalType?: QueryTimeGrainType;
    }
  >;
}

@@doc(TopQueriesDatabase.name, "Placeholder for query ID");
@@doc(TopQueriesDatabase.properties, "Resource properties.");
