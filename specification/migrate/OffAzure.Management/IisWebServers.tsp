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

@armResourceOperations
interface IisWebServersController {
  /**
   * Method to get an IIS web server.
   */
  get is ArmResourceRead<IisWebServers>;

  /**
   * Method to get all IIS web servers.
   */
  listByWebAppSite is ArmResourceListByParent<
    IisWebServers,
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

@@doc(IisWebServers.name, "Web server name.");
@@doc(IisWebServers.properties,
  "The resource-specific properties for this resource."
);
