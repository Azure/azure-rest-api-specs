import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServerSiteResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * A machine resource belonging to a site resource.
 */
@parentResource(ServerSiteResource)
model Server is Azure.ResourceManager.ProxyResource<ServerProperties> {
  ...ResourceNameParameter<
    Resource = Server,
    KeyName = "machineName",
    SegmentName = "machines"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface Servers {
  /**
   * Get a Server
   */
  @tag("ServersController")
  getMachine is ArmResourceRead<Server>;

  /**
   * Update a Server machine
   */
  @tag("ServersController")
  @patch(#{ implicitOptionality: false })
  updateMachine is ArmCustomPatchSync<Server, PatchModel = ServerUpdate>;

  /**
   * Delete a Server
   */
  @tag("ServersController")
  deleteMachine is ArmResourceDeleteSync<Server>;

  /**
   * Get all machines in a site.
   */
  @tag("ServersController")
  listByServerSiteResource is ArmResourceListByParent<
    Server,
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

@@doc(Server.name, " A server machine name");
@@doc(Server.properties, "The resource-specific properties for this resource.");
