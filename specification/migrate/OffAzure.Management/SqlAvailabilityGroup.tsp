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
 * Class representing the web model of SQL Availability Group.
 */
@parentResource(SqlSite)
model SqlAvailabilityGroup
  is Azure.ResourceManager.ProxyResource<SqlAvailabilityGroupProperties> {
  ...ResourceNameParameter<
    Resource = SqlAvailabilityGroup,
    KeyName = "sqlAvailabilityGroupName",
    SegmentName = "sqlAvailabilityGroups"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface SqlAvailabilityGroups {
  /**
   * Gets the sql availability group.
   */
  @tag("SqlAvailabilityGroupsController")
  get is ArmResourceRead<SqlAvailabilityGroup>;

  /**
   * Gets the sql availability groups.
   */
  @tag("SqlAvailabilityGroupsController")
  listBySqlSite is ArmResourceListByParent<
    SqlAvailabilityGroup,
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

@@doc(SqlAvailabilityGroup.name, "SQL availability group name.");
@@doc(SqlAvailabilityGroup.properties,
  "The resource-specific properties for this resource."
);
