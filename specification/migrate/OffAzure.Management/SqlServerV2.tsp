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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("SqlServersController")
  @operationId("SqlServersController_Get")
  get is ArmResourceRead<SqlServerV2>;

  /**
   * Updates the sql server tags.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("SqlServersController")
  @operationId("SqlServersController_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<SqlServerV2, PatchModel = SqlServerV2Update>;

  /**
   * Gets the sql servers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("SqlServersController")
  @operationId("SqlServersController_ListBySqlSite")
  listBySqlSite is ArmResourceListByParent<
    SqlServerV2,
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

@@doc(SqlServerV2.name, "SQL server name.");
@@doc(SqlServerV2.properties,
  "The resource-specific properties for this resource."
);
