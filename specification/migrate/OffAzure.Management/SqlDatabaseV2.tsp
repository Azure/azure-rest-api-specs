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

@armResourceOperations
interface SqlDatabaseV2s {
  /**
   * Gets the sql Database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlDatabasesController_Get")
  get is ArmResourceRead<SqlDatabaseV2>;

  /**
   * Gets the sql Databases.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlDatabasesController_ListBySqlSite")
  listBySqlSite is ArmResourceListByParent<
    SqlDatabaseV2,
    Parameters = {
      /**
       * filter query
       */
      @query("filter")
      filter?: string;

      /**
       * page size  query
       */
      @query("top")
      top?: string;

      /**
       * Optional parameter for continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;

      /**
       * Total count of machines in the given site.
       */
      @query("totalRecordCount")
      totalRecordCount?: int32;
    }
  >;
}

@@doc(SqlDatabaseV2.name, "SQL Database name.");
@@doc(SqlDatabaseV2.properties,
  "The resource-specific properties for this resource."
);
