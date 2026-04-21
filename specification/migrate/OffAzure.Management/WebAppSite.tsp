import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MasterSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * WebApp site web model.
 */
@parentResource(MasterSite)
model WebAppSite is Azure.ResourceManager.ProxyResource<WebAppSiteProperties> {
  ...ResourceNameParameter<
    Resource = WebAppSite,
    KeyName = "webAppSiteName",
    SegmentName = "webAppSites"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface WebAppSites {
  /**
   * Method to get a site.
   */
  @tag("WebAppSitesController")
  get is ArmResourceRead<WebAppSite>;

  /**
   * Method to create a WebApp site.
   */
  @tag("WebAppSitesController")
  create is ArmResourceCreateOrReplaceSync<WebAppSite>;

  /**
   * Method to update an existing site.
   */
  @tag("WebAppSitesController")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<WebAppSite, PatchModel = WebAppSiteUpdate>;

  /**
   * Deletes the WebApp site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("WebAppSitesController")
  delete is ArmResourceDeleteWithoutOkAsync<
    WebAppSite,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Method to get all sites.
   */
  @tag("WebAppSitesController")
  listByMasterSite is ArmResourceListByParent<WebAppSite>;

  /**
   * MMethod to get error summary from web app  site.
   */
  @tag("WebAppSitesController")
  errorSummary is ArmResourceActionSync<
    WebAppSite,
    ErrorSummaryRequest,
    ArmResponse<SiteErrorSummary>
  >;

  /**
   * Method to generate report containing web app inventory.
   */
  @tag("WebAppSitesController")
  exportInventory is ArmResourceActionAsync<
    WebAppSite,
    ExportWebAppsRequest,
    ArmResponse<unknown>
  >;

  /**
   * Method to refresh a site.
   */
  @tag("WebAppSitesController")
  refresh is ArmResourceActionAsync<
    WebAppSite,
    ProxySiteRefreshBody,
    ArmResponse<unknown>
  >;

  /**
   * Method to get site usage/summary.
   */
  @tag("WebAppSitesController")
  summary is ArmResourceActionSync<
    WebAppSite,
    void,
    ArmResponse<WebAppSiteUsage>
  >;

  /**
   * Method to update properties for web applications.
   *             in a site.
   */
  @tag("WebAppPropertiesController")
  updateProperties is ArmResourceActionAsync<
    WebAppSite,
    WebAppPropertiesCollection,
    ArmResponse<unknown>
  >;

  /**
   * Method to get all IIS web applications.
   */
  @tag("WebApplicationsController")
  @list
  @get
  @action("webApplications")
  listByWebAppSite is ArmResourceActionSync<
    WebAppSite,
    void,
    ArmResponse<ResourceListResult<WebApplication>>,
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

  /**
   * Method to get all web servers.
   */
  @tag("WebServersController")
  @list
  @get
  @action("webServers")
  webServersControllerListByWebAppSite is ArmResourceActionSync<
    WebAppSite,
    void,
    ArmResponse<ResourceListResult<WebServer>>,
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

@@doc(WebAppSite.name, "Web app site name.");
@@doc(WebAppSite.properties,
  "The resource-specific properties for this resource."
);
