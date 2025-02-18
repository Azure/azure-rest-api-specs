import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MysqlSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MySQLDiscovery;
/**
 * The MysqlServer resource definition.
 */
@parentResource(MysqlSite)
model MysqlServer
  is Azure.ResourceManager.ProxyResource<MysqlServerProperties, false> {
  ...ResourceNameParameter<
    Resource = MysqlServer,
    KeyName = "serverName",
    SegmentName = "MySQLServers",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;

  /**
   * Resource tags
   */
  @OpenAPI.extension("x-ms-identifiers", ["key", "value"])
  tags?: Tag[];
}

@armResourceOperations
interface MysqlServers {
  /**
   * Gets the MysqlServers resource.
   */
  get is ArmResourceRead<MysqlServer>;

  /**
   * Puts the MysqlServers resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<MysqlServer>;

  /**
   * Patch the MysqlServers resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<
    MysqlServer,
    PatchModel = MysqlServerResourcePatch
  >;

  /**
   * Deletes the MysqlServers resource.
   */
  delete is ArmResourceDeleteSync<MysqlServer>;

  /**
   * Lists the MysqlServers resource in MysqlSites.
   */
  listBySite is ArmResourceListByParent<
    MysqlServer,
    Response = ArmResponse<MysqlServerList>
  >;
}

@@maxLength(MysqlServer.name, 63);
@@minLength(MysqlServer.name, 3);
@@doc(MysqlServer.name, "The name of Server");
@@doc(MysqlServer.properties, "Resource properties.");
@@doc(MysqlServers.createOrUpdate::parameters.resource,
  "The machines to add to the assessment"
);
@@doc(MysqlServers.update::parameters.properties, "Clouds patch payload.");
