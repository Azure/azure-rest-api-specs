import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * Class representing the web model of SQL Database.
 */
@parentResource(SqlSite)
model SqlDatabaseV2
  is Azure.ResourceManager.ProxyResource<SqlDatabasePropertiesV2> {
  ...ResourceNameParameter<
    Resource = SqlDatabaseV2,
    KeyName = "sqlDatabaseName",
    SegmentName = "sqlDatabases"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface SqlDatabaseV2s {
  /**
   * Gets the sql Database.
   */
  @tag("SqlDatabasesController")
  get is ArmResourceRead<SqlDatabaseV2>;

  /**
   * Gets the sql Databases.
   */
  @tag("SqlDatabasesController")
  listBySqlSite is ArmResourceListByParent<
    SqlDatabaseV2,
    Parameters = {
      /**
       * filter query
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listBySqlSite.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * page size  query
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listBySqlSite.top retains the top query parameter; preserve wire compatibility."
      @query("top")
      top?: string;

      /**
       * Optional parameter for continuation token.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listBySqlSite.continuationToken retains the continuationToken query parameter; preserve wire compatibility."
      @query("continuationToken")
      continuationToken?: string;

      /**
       * Total count of machines in the given site.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listBySqlSite.totalRecordCount retains the totalRecordCount query parameter; preserve wire compatibility."
      @query("totalRecordCount")
      totalRecordCount?: int32;
    }
  >;
}

@@doc(SqlDatabaseV2.name, "SQL Database name.");
@@doc(
  SqlDatabaseV2.properties,
  "The resource-specific properties for this resource."
);
