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
 * Web application REST Resource.
 */
@parentResource(WebAppSite)
model TomcatWebApplications
  is Azure.ResourceManager.ProxyResource<TomcatWebApplicationProperties> {
  ...ResourceNameParameter<
    Resource = TomcatWebApplications,
    KeyName = "webApplicationName",
    SegmentName = "tomcatWebApplications"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface TomcatWebApplicationsController {
  /**
   * Method to get an Tomcat web application.
   */
  @tag("TomcatWebApplicationsController")
  get is ArmResourceRead<TomcatWebApplications>;

  /**
   * Updates the Tomcat web application tags.
   */
  // Workaround for "Cannot pass in unknown to patch template"(https://github.com/Azure/typespec-azure/issues/4360)
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("TomcatWebApplicationsController")
  @patch
  update(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...Azure.ResourceManager.Legacy.Provider,

    /** Site name. */
    @path
    @segment("masterSites")
    @key("siteName")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    siteName: string,

    /** Web app site name. */
    @path
    @segment("webAppSites")
    @key("webAppSiteName")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    webAppSiteName: string,

    /** Web application name. */
    @path
    @segment("tomcatWebApplications")
    @key("webApplicationName")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    webApplicationName: string,

    /** Patch request body. */
    @body
    body: unknown,
  ): TomcatWebApplications | ErrorResponse;

  /**
   * Method to get all Tomcat web application.
   */
  @tag("TomcatWebApplicationsController")
  listByWebAppSite is ArmResourceListByParent<
    TomcatWebApplications,
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

@@doc(TomcatWebApplications.name, "Web application name.");
@@doc(
  TomcatWebApplications.properties,
  "The resource-specific properties for this resource."
);
