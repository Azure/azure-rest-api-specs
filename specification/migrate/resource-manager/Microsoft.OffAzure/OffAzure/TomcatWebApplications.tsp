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
  @tag("TomcatWebApplicationsController")
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    TomcatWebApplications,
    PatchModel = Record<unknown>
  >;

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
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByWebAppSite.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * page size  query
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByWebAppSite.top retains the top query parameter; preserve wire compatibility."
      @query("top")
      top?: string;

      /**
       * Optional parameter for continuation token.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByWebAppSite.continuationToken retains the continuationToken query parameter; preserve wire compatibility."
      @query("continuationToken")
      continuationToken?: string;

      /**
       * Total count of machines in the given site.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByWebAppSite.totalRecordCount retains the totalRecordCount query parameter; preserve wire compatibility."
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
