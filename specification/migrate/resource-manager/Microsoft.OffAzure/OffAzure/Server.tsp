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
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByServerSiteResource.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * page size  query
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByServerSiteResource.top retains the top query parameter; preserve wire compatibility."
      @query("top")
      top?: string;

      /**
       * Optional parameter for continuation token.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByServerSiteResource.continuationToken retains the continuationToken query parameter; preserve wire compatibility."
      @query("continuationToken")
      continuationToken?: string;

      /**
       * Total count of machines in the given site.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByServerSiteResource.totalRecordCount retains the totalRecordCount query parameter; preserve wire compatibility."
      @query("totalRecordCount")
      totalRecordCount?: int32;
    }
  >;
}

@@doc(Server.name, " A server machine name");
@@doc(Server.properties, "The resource-specific properties for this resource.");
