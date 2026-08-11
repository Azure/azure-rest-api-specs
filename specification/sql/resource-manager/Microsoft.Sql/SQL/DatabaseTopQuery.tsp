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
 * A database top query, identified by query ID.
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
interface TopQueriesQueryText {
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
  listByQuery is ArmResourceActionSync<
    DatabaseTopQuery,
    void,
    ArmResponse<QueryTextResult>
  >;
}

@armResourceOperations(#{ omitTags: true })
interface TopQueryStatistics {
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
  listByQuery is ArmResourceActionSync<
    DatabaseTopQuery,
    void,
    ArmResponse<QueryStatisticsDatabaseListResult>
  >;
}

@@doc(DatabaseTopQuery.name, "The query ID.");
@@doc(
  DatabaseTopQuery.properties,
  "The database top query resource properties."
);
