import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WebAppSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * Web app data source web model.
 */
@parentResource(WebAppSite)
model DiscoverySiteDataSource
  is Azure.ResourceManager.ProxyResource<DiscoverySiteDataSourceProperties> {
  ...ResourceNameParameter<
    Resource = DiscoverySiteDataSource,
    KeyName = "discoverySiteDataSourceName",
    SegmentName = "discoverySiteDataSources"
  >;
}

@armResourceOperations
interface DiscoverySiteDataSources {
  /**
   * Method to get a Web app data source in site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebAppDiscoverySiteDataSourcesController_Get")
  get is ArmResourceRead<DiscoverySiteDataSource>;

  /**
   * Method to create or update a Web app data source in site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebAppDiscoverySiteDataSourcesController_Create")
  create is ArmResourceCreateOrReplaceAsync<
    DiscoverySiteDataSource,
    LroHeaders = ArmLroLocationHeader<FinalResult = DiscoverySiteDataSource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Method to delete a Web app data source in site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebAppDiscoverySiteDataSourcesController_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    DiscoverySiteDataSource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Method to get all Web app data sources in site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebAppDiscoverySiteDataSourcesController_ListByWebAppSite")
  listByWebAppSite is ArmResourceListByParent<DiscoverySiteDataSource>;
}

@@doc(DiscoverySiteDataSource.name, "Data Source ARM name.");
@@doc(DiscoverySiteDataSource.properties,
  "The resource-specific properties for this resource."
);
