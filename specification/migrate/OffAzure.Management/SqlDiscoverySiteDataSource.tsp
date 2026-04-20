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

@armResourceOperations
interface SqlDiscoverySiteDataSources {
  /**
   * Get a SqlDiscoverySiteDataSource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlDiscoverySiteDataSourceController_Get")
  get is ArmResourceRead<SqlDiscoverySiteDataSource>;

  /**
   * Create a SqlDiscoverySiteDataSource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlDiscoverySiteDataSourceController_Create")
  create is ArmResourceCreateOrReplaceAsync<
    SqlDiscoverySiteDataSource,
    LroHeaders = ArmLroLocationHeader<FinalResult = SqlDiscoverySiteDataSource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a SqlDiscoverySiteDataSource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlDiscoverySiteDataSourceController_Delete")
  delete is ArmResourceDeleteSync<SqlDiscoverySiteDataSource>;

  /**
   * List SqlDiscoverySiteDataSource resources by SqlSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlDiscoverySiteDataSourceController_ListBySqlSite")
  listBySqlSite is ArmResourceListByParent<SqlDiscoverySiteDataSource>;
}

@@doc(SqlDiscoverySiteDataSource.name, "SQL Discovery site data source name.");
@@doc(SqlDiscoverySiteDataSource.properties,
  "The resource-specific properties for this resource."
);
