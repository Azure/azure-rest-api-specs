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
 * A database top query, identified by query id.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2026_08_01_preview)
@Azure.ResourceManager.Legacy.feature(Features.DatabaseQueries)
@parentResource(Database)
model DatabaseTopQuery
  is Azure.ResourceManager.ProxyResource<DatabaseTopQueryProperties> {
  ...ResourceNameParameter<
    Resource = DatabaseTopQuery,
    KeyName = "topQueryName",
    SegmentName = "topQueries",
    NamePattern = "^[0-9]*$"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface DatabaseTopQueries {
  /**
   * Get query text.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2026_08_01_preview)
  @Azure.ResourceManager.Legacy.feature(Features.DatabaseQueries)
  @tag("TopQueriesQueryText")
  @list
  @get
  @action("queryText")
  queryText is ArmResourceActionSync<
    DatabaseTopQuery,
    void,
    ArmResponse<QueryTextResult>
  >;

  /**
   * Get query statistics.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2026_08_01_preview)
  @Azure.ResourceManager.Legacy.feature(Features.DatabaseQueries)
  @tag("TopQueryStatistics")
  @list
  @get
  @action("statistics")
  statistics is ArmResourceActionSync<
    DatabaseTopQuery,
    void,
    ArmResponse<QueryStatisticsDatabaseListResult>
  >;
}

@@doc(DatabaseTopQuery.name, "Placeholder for query ID.");
@@doc(DatabaseTopQuery.properties, "Resource properties.");
