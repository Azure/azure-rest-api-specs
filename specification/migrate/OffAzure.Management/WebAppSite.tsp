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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("WebAppSitesController")
  @operationId("WebAppSitesController_Get")
  get is ArmResourceRead<WebAppSite>;

  /**
   * Method to create a WebApp site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("WebAppSitesController")
  @operationId("WebAppSitesController_Create")
  create is ArmResourceCreateOrReplaceSync<WebAppSite>;

  /**
   * Method to update an existing site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("WebAppSitesController")
  @operationId("WebAppSitesController_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<WebAppSite, PatchModel = WebAppSiteUpdate>;

  /**
   * Deletes the WebApp site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("WebAppSitesController")
  @operationId("WebAppSitesController_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    WebAppSite,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Method to get all sites.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("WebAppSitesController")
  @operationId("WebAppSitesController_ListByMasterSite")
  listByMasterSite is ArmResourceListByParent<WebAppSite>;

  /**
   * MMethod to get error summary from web app  site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("WebAppSitesController")
  @operationId("WebAppSitesController_ErrorSummary")
  errorSummary is ArmResourceActionSync<
    WebAppSite,
    ErrorSummaryRequest,
    ArmResponse<SiteErrorSummary>
  >;

  /**
   * Method to generate report containing web app inventory.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("WebAppSitesController")
  @operationId("WebAppSitesController_ExportInventory")
  exportInventory is ArmResourceActionAsync<
    WebAppSite,
    ExportWebAppsRequest,
    ArmResponse<unknown>
  >;

  /**
   * Method to refresh a site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("WebAppSitesController")
  @operationId("WebAppSitesController_Refresh")
  refresh is ArmResourceActionAsync<
    WebAppSite,
    ProxySiteRefreshBody,
    ArmResponse<unknown>
  >;

  /**
   * Method to get site usage/summary.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("WebAppSitesController")
  @operationId("WebAppSitesController_Summary")
  summary is ArmResourceActionSync<
    WebAppSite,
    void,
    ArmResponse<WebAppSiteUsage>
  >;

  /**
   * Method to update properties for web applications.
   *             in a site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("WebAppPropertiesController")
  @operationId("WebAppPropertiesController_UpdateProperties")
  updateProperties is ArmResourceActionAsync<
    WebAppSite,
    WebAppPropertiesCollection,
    ArmResponse<unknown>
  >;

  /**
   * Method to get all IIS web applications.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("WebApplicationsController")
  @operationId("WebApplicationsController_ListByWebAppSite")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("WebServersController")
  @operationId("WebServersController_ListByWebAppSite")
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
