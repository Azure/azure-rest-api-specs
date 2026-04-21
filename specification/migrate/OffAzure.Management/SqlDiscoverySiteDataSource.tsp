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
 * A SQL discovery site data source resource.
 */
@parentResource(SqlSite)
model SqlDiscoverySiteDataSource
  is Azure.ResourceManager.ProxyResource<SqlDiscoverySiteDataSourceProperties> {
  ...ResourceNameParameter<
    Resource = SqlDiscoverySiteDataSource,
    KeyName = "discoverySiteDataSourceName",
    SegmentName = "discoverySiteDataSources"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface SqlDiscoverySiteDataSources {
  /**
   * Get a SqlDiscoverySiteDataSource
   */
  @tag("SqlDiscoverySiteDataSourceController")
  get is ArmResourceRead<SqlDiscoverySiteDataSource>;

  /**
   * Create a SqlDiscoverySiteDataSource
   */
  @tag("SqlDiscoverySiteDataSourceController")
  create is ArmResourceCreateOrReplaceAsync<
    SqlDiscoverySiteDataSource,
    LroHeaders = ArmLroLocationHeader<FinalResult = SqlDiscoverySiteDataSource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a SqlDiscoverySiteDataSource
   */
  @tag("SqlDiscoverySiteDataSourceController")
  delete is ArmResourceDeleteSync<SqlDiscoverySiteDataSource>;

  /**
   * List SqlDiscoverySiteDataSource resources by SqlSite
   */
  @tag("SqlDiscoverySiteDataSourceController")
  listBySqlSite is ArmResourceListByParent<SqlDiscoverySiteDataSource>;
}

@@doc(SqlDiscoverySiteDataSource.name, "SQL Discovery site data source name.");
@@doc(SqlDiscoverySiteDataSource.properties,
  "The resource-specific properties for this resource."
);
