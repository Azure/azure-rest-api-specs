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

@armResourceOperations(#{ omitTags: true })
interface DiscoverySiteDataSources {
  /**
   * Method to get a Web app data source in site.
   */
  @tag("WebAppDiscoverySiteDataSourcesController")
  get is ArmResourceRead<DiscoverySiteDataSource>;

  /**
   * Method to create or update a Web app data source in site.
   */
  @tag("WebAppDiscoverySiteDataSourcesController")
  create is ArmResourceCreateOrReplaceAsync<
    DiscoverySiteDataSource,
    LroHeaders = ArmLroLocationHeader<FinalResult = DiscoverySiteDataSource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Method to delete a Web app data source in site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("WebAppDiscoverySiteDataSourcesController")
  delete is ArmResourceDeleteWithoutOkAsync<
    DiscoverySiteDataSource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Method to get all Web app data sources in site.
   */
  @tag("WebAppDiscoverySiteDataSourcesController")
  listByWebAppSite is ArmResourceListByParent<DiscoverySiteDataSource>;
}

@@doc(DiscoverySiteDataSource.name, "Data Source ARM name.");
@@doc(DiscoverySiteDataSource.properties,
  "The resource-specific properties for this resource."
);
