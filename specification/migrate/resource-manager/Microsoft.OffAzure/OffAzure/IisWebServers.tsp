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
 * Web server REST Resource.
 */
@parentResource(WebAppSite)
model IisWebServers
  is Azure.ResourceManager.ProxyResource<IisWebServerProperties> {
  ...ResourceNameParameter<
    Resource = IisWebServers,
    KeyName = "webServerName",
    SegmentName = "iisWebServers"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface IisWebServersController {
  /**
   * Method to get an IIS web server.
   */
  @tag("IisWebServersController")
  get is ArmResourceRead<IisWebServers>;

  /**
   * Method to get all IIS web servers.
   */
  @tag("IisWebServersController")
  listByWebAppSite is ArmResourceListByParent<
    IisWebServers,
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

@@doc(IisWebServers.name, "Web server name.");
@@doc(
  IisWebServers.properties,
  "The resource-specific properties for this resource."
);
