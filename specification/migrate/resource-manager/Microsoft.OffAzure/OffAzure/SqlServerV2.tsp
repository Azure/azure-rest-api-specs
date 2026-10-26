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
 * Class representing the web model of SQL Server.
 */
@parentResource(SqlSite)
model SqlServerV2 is Azure.ResourceManager.ProxyResource<SqlServerProperties> {
  ...ResourceNameParameter<
    Resource = SqlServerV2,
    KeyName = "sqlServerName",
    SegmentName = "sqlServers"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface SqlServerV2s {
  /**
   * Gets the sql server.
   */
  @tag("SqlServersController")
  get is ArmResourceRead<SqlServerV2>;

  /**
   * Updates the sql server tags.
   */
  @tag("SqlServersController")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<SqlServerV2, PatchModel = SqlServerV2Update>;

  /**
   * Gets the sql servers.
   */
  @tag("SqlServersController")
  listBySqlSite is ArmResourceListByParent<
    SqlServerV2,
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

@@doc(SqlServerV2.name, "SQL server name.");
@@doc(
  SqlServerV2.properties,
  "The resource-specific properties for this resource."
);
