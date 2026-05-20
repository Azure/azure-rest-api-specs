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
model TomcatWebServers
  is Azure.ResourceManager.ProxyResource<TomcatWebServerProperties> {
  ...ResourceNameParameter<
    Resource = TomcatWebServers,
    KeyName = "webServerName",
    SegmentName = "tomcatWebServers"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface TomcatWebServersController {
  /**
   * Method to get an Tomcat web server.
   */
  @tag("TomcatWebServersController")
  get is ArmResourceRead<TomcatWebServers>;

  /**
   * Method to get all Tomcat web servers.
   */
  @tag("TomcatWebServersController")
  listByWebAppSite is ArmResourceListByParent<
    TomcatWebServers,
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

@@doc(TomcatWebServers.name, "Web server name.");
@@doc(TomcatWebServers.properties,
  "The resource-specific properties for this resource."
);
