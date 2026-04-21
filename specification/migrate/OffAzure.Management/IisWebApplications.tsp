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
model IisWebApplications
  is Azure.ResourceManager.ProxyResource<IisWebApplicationProperties> {
  ...ResourceNameParameter<
    Resource = IisWebApplications,
    KeyName = "webApplicationName",
    SegmentName = "iisWebApplications"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface IisWebApplicationsController {
  /**
   * Method to get an IIS web application.
   */
  @tag("IisWebApplicationsController")
  get is ArmResourceRead<IisWebApplications>;

  /**
   * Method to update tags on IIS web application.
   */
  @patch(#{ implicitOptionality: false })
  @tag("IisWebApplicationsController")
  update is ArmCustomPatchSync<
    IisWebApplications,
    PatchModel = IisWebApplicationsUpdate
  >;

  /**
   * Method to get all IIS web application.
   */
  @tag("IisWebApplicationsController")
  listByWebAppSite is ArmResourceListByParent<
    IisWebApplications,
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

@@doc(IisWebApplications.name, "Web application name.");
@@doc(IisWebApplications.properties,
  "The resource-specific properties for this resource."
);
