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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @tag("TomcatWebApplicationsController")
  update is ArmCustomPatchSync<
    TomcatWebApplications,
    PatchModel = {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body body: unknown;
    }
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
@@doc(TomcatWebApplications.properties,
  "The resource-specific properties for this resource."
);
